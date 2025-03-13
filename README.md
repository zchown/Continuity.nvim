# Continuity.nvim

Continuity.nvim is a Neovim plugin that automatically saves and restores your sessions, along with custom options tracking. It helps maintain your editing context by persisting session and option data across restarts.

## Features

- **Automatic Session Saving:** Saves your current session on exit (and optionally on save).
- **Options Tracking:** Stores user-defined options to maintain your Neovim environment.
- **Custom Commands:** Easily delete, start, stop, or manually save sessions.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim) as your plugin manager, add the following to your lazy configuration:

```lua
{
  "zchown/continuity.nvim",
  config = function()
    require("continuity").setup({
      save_on_exit = true,
      save_on_save = false,
      save_options = true,
      session_dir = os.getenv("HOME") .. "/.vim/session/",
      current_dir = string.gsub(vim.loop.cwd(), "/", "_"),
      tracking = { "vim.g.copilot_enabled", },
    })
  end
}

