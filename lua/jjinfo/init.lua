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
M.get_jjinfo_status = jjinfo.get_jjinfo_status
M.get_status_line = jjinfo.get_status_line
return M
