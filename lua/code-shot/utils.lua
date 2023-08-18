local core = require("core")

local temp_file_path = function(source_file)
	local dir = core.file.dir(source_file)
	local name = core.file.name(source_file)
	local extension = core.file.extension(source_file)

	local prefix = "_"
	local temp_file = string.format("%s/%s%s.%s", dir, prefix, name, extension)

	while core.file.file_or_dir_exists(temp_file) do
		prefix = prefix .. "_"
		temp_file = string.format("%s/%s%s.%s", dir, prefix, name, extension)
	end

	return temp_file
end

return {
	temp_file_path = temp_file_path,
}
