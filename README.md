# code-shot.nvim

**_To use version v1.0.0, set branch to v1._**

Take a picture of the code.

Similar features to [silicon.nvim](https://github.com/krivahtoo/silicon.nvim), keep simple, keep reliable.

[More neovim plugins](https://github.com/niuiic/awesome-neovim-plugins)

## Dependencies

- [silicon](https://github.com/Aloxaf/silicon)
- [niuiic/omega.nvim](https://github.com/niuiic/omega.nvim)

## Showcase

- Shot whole file

<img src="https://github.com/niuiic/assets/blob/main/code-shot.nvim/shot-whole.gif" />

- Shot selection

<img src="https://github.com/niuiic/assets/blob/main/code-shot.nvim/shot-range.gif" />

## Usage

- types

```lua
---@class code-shot.Context
---@field file_path string
---@field file_type string
---@field selected_area omega.Area
---@field selection string

---@class omega.Area
---@field start_lnum number
---@field start_col number
---@field end_lnum number
---@field end_col number
```

- shot file to clipboard

```lua
local function shot_file_to_clipboard()
	require("code-shot").shot(function(context)
		vim.system(
			{
				"silicon",
				"--to-clipboard",
				context.file_path,
			},
			nil,
			function(result)
				if result.code == 0 then
					vim.notify("Shot code successfully", vim.log.levels.INFO)
				else
					vim.notify("Shot code failed", vim.log.levels.ERROR)
				end
			end
		)
	end)
end
```

- shot file to file

```lua
local function shot_file_to_file()
	require("code-shot").shot(function(context)
		vim.system(
			{
				"silicon",
				"-o",
				string.format("%s.png", os.date("%Y-%m-%d_%H:%M:%S")),
				context.file_path,
			},
			nil,
			function(result)
				if result.code == 0 then
					vim.notify("Shot code successfully", vim.log.levels.INFO)
				else
					vim.notify("Shot code failed", vim.log.levels.ERROR)
				end
			end
		)
	end)
end

```

- shot selection to clipboard

```lua
local function shot_selection_to_clipboard()
	require("code-shot").shot(function(context)
		vim.system({
			"silicon",
			"--to-clipboard",
			"--language",
			context.file_type,
		}, { stdin = context.selection }, function(result)
			if result.code == 0 then
				vim.notify("Shot code successfully", vim.log.levels.INFO)
			else
				vim.notify("Shot code failed", vim.log.levels.ERROR)
			end
		end)
	end)
end
```

- shot selection to file

```lua
local shot_selection_to_file = function()
	require("code-shot").shot(function(context)
		require("omega").to_normal_mode()

		vim.system({
			"silicon",
			"-o",
			string.format("%s.png", os.date("%Y-%m-%d_%H:%M:%S")),
			"--language",
			context.file_type,
		}, {
			stdin = context.selection,
		}, function(result)
			if result.code == 0 then
				vim.notify("Shot code successfully", vim.log.levels.INFO)
			else
				vim.notify("Shot code failed", vim.log.levels.ERROR)
			end
		end)
	end)
end
```
