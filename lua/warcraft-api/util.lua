local M = {}

function M.notify(opts)
  local level = opts.level or vim.log.levels.INFO
  local notify_fn = opts.once and vim.notify_once or vim.notify

  notify_fn(string.format("[WarcraftApi]: %s", opts.message), level, { title = "warcraft-api.nvim" })
end

return M
