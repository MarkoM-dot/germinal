local M = {}

local uv = vim.loop

---@class Section
---@field filetype string
---@field path fun():string
---@field filename fun():string
---@field prepend_lines? fun():string[]
---@field append_lines? fun():string[]

---@class Config
---@field root_dir string
---@field sections table<string, Section> 
local defaults = {
  root_dir = uv.os_homedir() .. "/notes",
  menu_config = {
            relative="win",
            width=30,
            height=20,
            border="none",
            style="minimal",
            item_prefix = "-",
            cursorline = true,
            title = "Germinal"
  },
}

M.config = defaults

---@param opts Config
function M.set(opts)
  M.config = vim.tbl_deep_extend("force", vim.deepcopy(M.config), opts)

  if not vim.fn.isdirectory(M.config.root_dir) then
    vim.fn.mkdir(M.config.root_dir)
  end
end

return M
