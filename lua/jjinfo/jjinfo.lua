local M = {}

local jj_info_cache = ''

-- returns the jj change info
function M.get_jj_info()
  return jj_info_cache
end

local cmd =
  [[jj log --revisions @ --no-graph --ignore-working-copy --color=never --limit 1 --template 'separate(" ", change_id.shortest(4), bookmarks.map(|r| r.name()).join(" "))']]

local function update_jj_change_id()
  local handle = io.popen(cmd .. ' 2>/dev/null') -- redirects stderr to dev/null
  if handle then
    local result = handle:read('*a')
    handle:close()
    if result and result ~= '' then
      jj_info_cache = ' ' .. result
    else
      jj_info_cache = ''
    end
  end
end

---@class Config
---@field include_bookmarks boolean

---@type Config
local default_config = {
  include_bookmarks = false,
}

---@param user_opts Config
local function config_from_user_opts(user_opts)
  local config = user_opts and vim.tbl_deep_extend('force', default_config, user_opts) or default_config
  return config
end

function M.setup(user_opts)
  local config = config_from_user_opts(user_opts)
  if config['include_bookmark'] then
    cmd =
      [[jj log --revisions @ --no-graph --ignore-working-copy --color=never --limit 1 --template 'separate(" ", change_id.shortest(4), bookmarks.map(|r| r.name()).join(" "))']]
  else
    cmd =
      [[jj log --revisions @ --no-graph --ignore-working-copy --color=never --limit 1 --template 'change_id.shortest(4)']]
  end
  -- update jj change id of BufEnter as different Buffer may be on different repos
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = update_jj_change_id,
  })
end

return M
