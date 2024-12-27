--@class warcraft-api.Data
local M = {}

local Path = require('plenary.path')
local Job = require('plenary.job')
local util = require('warcraft-api.util')

M.setup = function()
  M._data_directory = Path:new(string.format("%s/warcraft-api", vim.fn.stdpath("data")))
  M._api_directory = Path:new(string.format("%s/ketho-wow-api", M._data_directory.filename))
  M.annotations = Path:new(string.format("%s/Annotations", M._api_directory.filename))
end

M.ensure_installed = function()
  local dir = M._data_directory
  if not dir:exists() then
    dir:mkdir()
    M.download()
  end
end

--@param opts? table<string, boolean>
M.download = function(opts)
  opts = opts or {}
  if M._api_directory:exists() and not opts.update then
    return
  elseif opts.update then
    vim.fn.delete(M._api_directory.filename, "rf")
  end

  local target_url = "https://github.com/Ketho/vscode-wow-api"
  local sync_timeout = 30000

  Job:new({
    command = "git",
    args = { "clone", target_url, M._api_directory.filename },
    enable_recording = true,
    on_start = function()
      util.notify({
        message = "Downloading the latest version of the WoW API..."
      })
    end,
    on_exit = function(_, value)
      vim.schedule(function()
        if value == 0 then
          util.notify({ message = "Complete!" })
        else
          util.notify({
            message = "Error downloading latest version of the WoW API bindings."
          })
        end
      end)
    end
  }):sync(sync_timeout)
end

return M
