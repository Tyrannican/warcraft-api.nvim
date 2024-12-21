vim.api.nvim_create_user_command("WarcraftApi", function(opts)
  require("warcraft-api.command").run_command(opts)
end, {
  nargs = 1,
  complete = function(args)
    local suggestions = { "enable", "disable", "update" }
    return vim.tbl_filter(function(s)
      return s:match("^" .. args)
    end, suggestions)
  end
})
