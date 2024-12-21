local M = {}

local lsp = require('warcraft-api.lsp')
local data = require('warcraft-api.data')
local util = require('warcraft-api.util')

function M.run_command(opts)
  local arg = opts.args

  if arg == "enable" then
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
