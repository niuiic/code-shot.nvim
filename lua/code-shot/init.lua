local M = {}

---@class code-shot.Context
---@field file_path string
---@field file_type string
---@field selected_area omega.Area
---@field selection string

---@param run fun(context: code-shot.Context)
function M.shot(run)
	---@type code-shot.Context
	local context = {
		file_path = vim.api.nvim_buf_get_name(0) or "",
		file_type = vim.bo.filetype,
		selected_area = require("omega").get_selected_area(),
		selection = vim.fn.join(require("omega").get_selection() or {}, require("omega").get_line_ending(0)),
	}

	run(context)
end

return M
