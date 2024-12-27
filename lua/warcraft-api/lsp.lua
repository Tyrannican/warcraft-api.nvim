--@class warcraft-api.Lsp
local M = {}

local data = require('warcraft-api.data')
local util = require('warcraft-api.util')

--@type table<number,number>
M.lsp_clients = {}

--@type table<number, table>
M.cached_lsp_settings = {}

--@param client vim.lsp.Client
M.attach = function(client)
  if M.lsp_clients[client.id] then
    return
  end

  M.lsp_clients[client.id] = client.id
  M.cached_lsp_settings[client.id] = client.settings or {}
end

--@param client vim.lsp.Client
M.add_api_bindings = function(client)
  local path = data.annotations
  local settings = vim.deepcopy(client.settings or {})
  local library = vim.tbl_get(settings, "Lua", "workspace", "library") or {}

  if not vim.tbl_contains(library, path.filename) then
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
end

--@param client vim.lsp.Client
M.update_buffers = function(client)
  local buffers = vim.api.nvim_list_bufs()

  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.lsp.buf_is_attached(bufnr, client.id) then
      vim.api.nvim_set_current_buf(bufnr)
      vim.cmd("write")
      vim.cmd("edit")
    end
  end
end

M.enable_api = function()
  for _, client in ipairs(vim.lsp.get_clients({ name = "lua_ls" })) do
    M.add_api_bindings(client)
    M.update(client)
    M.update_buffers(client)
  end

  util.notify({ message = "Enabled Warcraft API" })
end

M.disable_api = function()
  for _, client in ipairs(vim.lsp.get_clients({ name = "lua_ls" })) do
    client.settings = M.cached_lsp_settings[client.id]
    M.update(client)
    M.update_buffers(client)
  end

  util.notify({ message = "Disabled Warcraft API" })
end

--@param client vim.lsp.Client
M.update = function(client)
  client.notify("workspace/didChangeConfiguration", {
    settings = client.settings
  })
end

return M
