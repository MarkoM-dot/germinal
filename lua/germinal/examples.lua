local M = {}

---@return string
M.journal_path = function ()
  return "/journal/" .. os.date("%Y/%b") .. "/"
end

---@return string
M.day_filename = function ()
  return os.date("%d") .. ".md"
end

---@return string[]
M.journal_prepend_lines = function ()
  return {
  "# " .. os.date("%A %d %b %Y"),
  ""
  }
end

---@return string
M.meeting_path = function ()
  return "/meetings/" .. os.date("%Y/%b") .. "/"
end


---@return string[]
M.meeting_prepend_lines = function ()
  return {
  "# " .. os.date("%A %d %b %Y"),
  "",
  "## " .. os.date("%A %d %b %Y %H:%M"),
  }
end

---@return string[]
M.meeting_append_lines = function ()
  return {
  "## " .. os.date("%A %d %b %Y %H:%M"),
  ""
  }
end

return M
