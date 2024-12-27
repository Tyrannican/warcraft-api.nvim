--@class warcraft-api.Command
local M = {}

local data = require('warcraft-api.data')
local util = require('warcraft-api.util')
local lsp = require('warcraft-api.lsp')

--@param opts string[]
M.run_command = function(opts)
  local arg = opts.args

  if arg == "enable" then
    data.ensure_installed()
    lsp.enable_api()
  elseif arg == "disable" then
    lsp.disable_api()
  elseif arg == "update" then
    data.download({ update = true })
  else
    util.notify({
      message = string.format("Unknown command: %s", arg),
      level = vim.log.levels.ERROR
    })
  end
end

return M
