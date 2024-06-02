local SelectionWindow = {}
SelectionWindow.__index = SelectionWindow

function SelectionWindow.new(sections, config)
  local self = setmetatable({}, SelectionWindow)
  -- TODO: get config from settings make it optional
  self.state = sections
  self.config = config
  self.ui = vim.api.nvim_list_uis()[1]
  return self
end

---@return string[]
function SelectionWindow:_get_menu_items()
  local menu_items = {}
  for index, item in ipairs(self.state) do
    menu_items[index] = self.config.item_prefix .. " " .. item
  end
  return menu_items
end

---@return string[]
function SelectionWindow:_get_title()
  return {
    self.config.title,
    "",
    "Press [Enter] to enter section",
    "[q] to leave",
    "",
  }
end

---@return string[]
function SelectionWindow:get_text()
  local text = self:_get_title()
  for _, v in ipairs(self:_get_menu_items()) do
    table.insert(text, v)
  end
  return text
end

---@param text string[]
function SelectionWindow:_create_window(text)
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, text)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
  return bufnr
end

---Strong candidate for refactoring and settings maps
---in config
---@param bufnr number
function SelectionWindow:_set_keymaps(bufnr, win_id)
  local keymap_enter = "<CR>"
  local keymap_close = "q"
  local enter_cmd = [[:lua print("hey")<CR>]]

  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    keymap_enter,
    enter_cmd,
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    keymap_close,
    ":close<CR>",
    {
      noremap = true,
      silent = true,
    }
  )
end

---@param bufnr number
---@param enter boolean
---@param opts table
---@return number
function SelectionWindow:_show_window(bufnr, enter, opts)
  local win_id = vim.api.nvim_open_win(bufnr, enter, {
    relative="win",
    row=(self.ui.height / 2) - (opts.height / 2),
    col=(self.ui.width / 2) - (opts.width / 2),
    width=opts.width,
    height=opts.height,
    border="none",
    style="minimal",
  })
  vim.api.nvim_win_set_option(win_id, "cursorline", opts.cursorline)
  return win_id
end

---@return nil
function SelectionWindow:display()
  local bufnr = self:_create_window(self:get_text())
  local win_id = self:_show_window(bufnr, true, self.config)
  self:_set_keymaps(bufnr, win_id)
  return nil
end

return SelectionWindow
