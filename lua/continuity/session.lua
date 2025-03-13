local M = {}
local config

function M.setup(cfg)
  config = cfg
end

local function get_session_file()
  return config.session_dir .. config.current_dir
end

local function get_option_file()
  return config.session_dir .. config.current_dir .. "_options.lua"
end

function M.save_session()
  local session_file = get_session_file()
  vim.cmd("mksession! " .. session_file)
end

function M.save_options()
  local option_file = get_option_file()
  local file = io.open(option_file, "w")
  if file then
    for _, option in ipairs(config.tracking) do
      local value = loadstring("return " .. option)()
      file:write(option .. " = " .. tostring(value) .. "\n")
    end
    file:close()
  else
    print("Failed to save Continuity Options")
  end
end

function M.save_continuity()
  print("Saving session...")
  M.save_session()
  if config.save_options and #config.tracking > 0 then
    print("Saving options...")
    M.save_options()
  end
end

function M.load_session()
  local session_file = get_session_file()
  if vim.fn.filereadable(session_file) > 0 then
    vim.cmd("source " .. session_file)
  else
    print("Could not read session; creating a new session.")
    M.save_continuity()
  end
end

function M.load_options()
  local option_file = get_option_file()
  if vim.fn.filereadable(option_file) > 0 then
    vim.cmd("source " .. option_file)
  else
    print("Failed to read options file")
  end
end

function M.load_continuity()
  M.load_session()
  if config.save_options and #config.tracking > 0 then
    M.load_options()
  end
end

function M.delete_continuity()
  os.remove(get_session_file())
  os.remove(get_option_file())
end

return M

