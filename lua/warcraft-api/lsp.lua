local M = {}

local data = require('warcraft-api.data')
local util = require('warcraft-api.util')

function M.setup()
end

function M.load_client()
  local client = vim.lsp.get_clients({ name = "lua_ls" })[1]
  if not client then
    util.notify({
      once = true,
      level = vim.log.levels.WARN,
      message = "LuaLS LSP not detected!",
    })
    return
  end

  M.client = client
end

function M.cache_lsp_settings()
  if not M.client then
    return
  end

  M.cached_settings = M.client.settings or {}
end

function M.enable_api()
  M.load_client()
  if not M.client then
    return
  end

  data.ensure_installed()
  M.cache_lsp_settings()

  local client = M.client
  local path = data.annotations
  local settings = vim.deepcopy(client.settings or {})
  local library = vim.tbl_get(settings, "Lua", "workspace", "library") or {}

  if not vim.tbl_contains(library, path) then
    table.insert(library, path.filename)
  end

  settings = vim.tbl_deep_extend("force", settings, {
    Lua = {
      runtime = {
        version = "Lua 5.1"
      },
      workspace = {
        checkThirdParty = false,
        library = library
      }
    }
  })

  if not vim.deep_equal(client.settings, settings) then
    client.settings = settings
  end

  M.update()
  util.notify({ message = "Enabled Api" })
end

function M.disable_api()
  local client = M.client
  if not client then
    return
  end

  client.settings = M.cached_settings
  M.update()
  util.notify({ message = "Disabled Api" })
end

function M.update()
  local client = M.client
  if not client then
    return
  end

  client.notify("workspace/didChangeConfiguration", {
    settings = client.settings
  })

  -- Reload all open Lua buffers to refresh the workspace
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype == "lua" then
      vim.lsp.buf_detach_client(bufnr, client.id)
      vim.lsp.buf_attach_client(bufnr, client.id)
    end
  end
end

return M
