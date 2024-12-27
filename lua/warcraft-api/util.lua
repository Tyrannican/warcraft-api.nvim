--@class warcraft-api.Util
local M = {}

--@class warcraft-api.NotifyOptions
local notify_options = {
  message = "",
  level = 0
}

--@param opts warcraft-api.NotifyOptions
M.notify = function(opts)
  local level = opts.level or vim.log.levels.INFO
  local notify_fn = opts.once and vim.notify_once or vim.notify

  notify_fn(string.format("[WarcraftApi]: %s", opts.message), level, { title = "warcraft-api.nvim" })
end

return M
