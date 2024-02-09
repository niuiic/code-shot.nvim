local static = require("code-shot.static")
local core = require("core")
local utils = require("code-shot.utils")

local shot = function()
	if vim.fn.executable("silicon") == 0 then
		vim.notify("silicon is not found", vim.log.levels.ERROR, {
			title = "Code Shot",
		})
		return
	end

	local source_file = vim.api.nvim_buf_get_name(0)
	local use_temp_source = false
	---@type {s_start: {row: number, col: number}, s_end: {row: number, col: number}} | nil
	local select_area

	if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
		use_temp_source = true
		select_area = utils.selected_area()
		source_file = utils.temp_file_path(source_file)
		local lines = vim.api.nvim_buf_get_lines(0, select_area.start_line - 1, select_area.end_line, false)
		vim.fn.writefile(lines, source_file)
	elseif not core.file.file_or_dir_exists(source_file) then
		use_temp_source = true
		source_file = utils.temp_file_path(source_file)
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		vim.fn.writefile(lines, source_file)
	end

	core.text.cancel_selection()

	local err = false
	local args = {}

	core.lua.list.each(static.config.options(select_area), function(option)
		table.insert(args, option)
	end)

	local output_path = static.config.output()

	core.lua.list.each({
		"--output",
		output_path,
		source_file,
	}, function(option)
		table.insert(args, option)
	end)

	core.job.spawn("silicon", args, {}, function()
		if not err then
			vim.notify("Code shot succeed, output to " .. output_path, vim.log.levels.INFO, {
				title = "Code Shot",
			})
		end
		if use_temp_source then
			vim.loop.fs_unlink(source_file)
		end
	end, function(_, data)
		err = true
		vim.notify("Code shot failed, error is " .. data, vim.log.levels.ERROR, {
			title = "Code Shot",
		})
	end, function() end)
end

local setup = function(new_config)
	static.config = vim.tbl_deep_extend("force", static.config, new_config or {})
end

return {
	shot = shot,
	setup = setup,
}
