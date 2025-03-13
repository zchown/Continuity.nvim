local M = {}
local session = require("continuity.session")

local function no_args()
  return #vim.v.argv == 2
end

function M.setup(config)
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("save-continuity", { clear = true }),
    callback = function()
      if no_args() and config.save_on_exit then
        session.save_continuity()
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("load-continuity", { clear = true }),
    callback = function()
      if no_args() then
        session.load_continuity()
        print("Continuity Loaded")
      end
    end,
  })

  if config.save_on_save then
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("save-session", { clear = true }),
      pattern = "*",
      callback = function()
        if no_args() and config.save_on_exit then
          session.save_continuity()
        end
      end,
    })
  end
end

return M

