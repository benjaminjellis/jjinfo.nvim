local M = {}

local jjinfo = require('jjinfo.jjinfo')

-- TODO: setup
-- {
--  info = { id, bookmark } -- just jj id
--  TODO: some way to also providt the jj dsl template
--
--  }
--
-- }
M.setup = jjinfo.setup
M.get_jj_info = jjinfo.get_jj_info
return M
