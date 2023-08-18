local config = {
	output = function()
		local core = require("core")
		local buf_name = vim.api.nvim_buf_get_name(0)
		return core.file.name(buf_name) .. ".png"
	end,
	options = function(select_area)
		if not select_area then
			return {}
		end
		return {
			"--line-offset",
			select_area.s_start.row,
		}
	end,
}

return {
	config = config,
}
