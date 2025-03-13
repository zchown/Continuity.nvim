local M = {}
local session = require("continuity.session")

local function no_args()
  return #vim.v.argv == 2
end

function M.setup(_config)
  vim.api.nvim_create_user_command("DeleteContinuity", function()
    session.delete_continuity()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command("StopContinuity", function()
    vim.g.continuitySaveOnExit = false
  end, { nargs = 0 })

  vim.api.nvim_create_user_command("StartContinuity", function()
    vim.g.continuitySaveOnExit = true
  end, { nargs = 0 })

  vim.api.nvim_create_user_command("SaveContinuity", function()
    session.save_continuity()
  end, { nargs = 0 })
end

return M

