local commands = require("germinal.commands")
local settings = require("germinal.settings")

local germinal = {}

---Returns a table of plugin commands filtered by arg lead
---@return string[]
local function subcommands (arg_lead, cmd_line, cursor_position)
  local filtered = {}
  for _, str in ipairs(vim.tbl_keys(settings.config.sections or {})) do
    if string.find(str, arg_lead) then
      table.insert(filtered, str)
    end
  end
  return filtered
end

vim.api.nvim_create_user_command(
  "Germinal",
  function(opts)
    local subcommand = opts.fargs[1]
    local sections = settings.config.sections
    if subcommand == nil then
      commands.enter_selection_window(sections, settings.config.menu_config)
      return
    end
    local section = sections[subcommand]
    if section == nil then
      error("Section was not found. Please add a section, in your sections table within your config.")
    end
    commands.generic_entry(section)
  end,
  { nargs = "*" , complete = subcommands }
)

---Sets plugin configuration or uses default settings
---@param opts Config
germinal.setup = function(opts)
  settings.set(opts)
end

return germinal
