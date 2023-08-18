local config = {
	output = function()
		local core = require("core")
		local buf_name = vim.api.nvim_buf_get_name(0)
		return core.file.name(buf_name) .. ".png"
	end,
	options = function()
		return {}
	end,
}

return {
	config = config,
}
