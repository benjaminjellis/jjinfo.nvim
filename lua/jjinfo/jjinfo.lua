local M = {}

local jj_info_cache = ''

-- returns the jj change id
function M.get_jj_info()
  return jj_info_cache
end

local function update_jj_change_id()
  local cmd =
    [[jj log --revisions @ --no-graph --ignore-working-copy --color=never --limit 1 --template 'separate(" ", change_id.shortest(4), bookmarks.map(|r| r.name()).join(" "))']]
  local handle = io.popen(cmd)
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

M.init()({
  -- update jj change id of BufEnter as different Buffer may be on different repos
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = update_jj_change_id,
  }),
})

return M
