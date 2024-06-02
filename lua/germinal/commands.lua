local settings = require("germinal.settings")
local ui = require("germinal.ui")

local M = {}

---Opens selection window and displays sections
---@param sections table<string, Section>
---@param menu_config table
M.enter_selection_window = function (sections, menu_config)
  local window = ui.new(vim.tbl_keys(sections), menu_config)
  window:display()
end

---Either creates a new journal entry or simply opens an
---existing journal entry.
---@param section Section
M.generic_entry = function (section)
  local path = settings.config.root_dir .. section.path()

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end

  local file = path .. section.filename()

  if vim.fn.filereadable(file) == 0 then
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(buf, file)
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_set_option_value("filetype", section.filetype, { buf = buf })
    if section.prepend_lines ~= nil then
      vim.api.nvim_buf_set_lines(buf, 0, 0, false, section.prepend_lines())
    end
  else
    vim.cmd.edit(file)
    local line_count = vim.api.nvim_buf_line_count(0)
    if section.append_lines ~= nil then
      vim.api.nvim_buf_set_lines(0, line_count, line_count, false, section.append_lines())
    end
    vim.api.nvim_win_set_cursor(0, {line_count, 0})
  end
end

return M
