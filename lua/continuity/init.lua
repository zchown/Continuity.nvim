local M = {}

-- Default configuration
M.config = {
  save_on_exit = vim.g.continuitySaveOnExit or true,
  save_on_save = vim.g.continuitySaveOnSave or false,
  save_options = vim.g.continuitySaveOptions or true,
  session_dir = vim.g.continuitySessionDir or (os.getenv("HOME") .. "/.vim/session/"),
  current_dir = vim.g.continuityCurrentDir or string.gsub(vim.loop.cwd(), "/", "_"),
  tracking = vim.g.ContinuityTracking or {},
}

-- Load submodules
M.session = require("continuity.session")
M.commands = require("continuity.commands")
M.autocmds = require("continuity.autocmds")

function M.setup(user_config)
  if user_config then
    M.config = vim.tbl_extend("force", M.config, user_config)
  end
  M.session.setup(M.config)
  M.commands.setup(M.config)
  M.autocmds.setup(M.config)
end

return M

