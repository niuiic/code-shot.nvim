# code-shot.nvim

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

- shot file to clipboard

```lua
local function shot_file_to_clipboard()
	require("code-shot").shot(function(context)
		vim.system(
			{
				"silicon",
				"--to-clipboard",
				"--pad-horiz",
				"0",
				"--pad-vert",
				"0",
				"--no-round-corner",
				"--theme",
				"Coldark-Dark",
				"--no-line-number",
				"--no-window-controls",
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
		vim.system(
			{
				"silicon",
				"--to-clipboard",
				"--pad-horiz",
				"0",
				"--pad-vert",
				"0",
				"--no-round-corner",
				"--theme",
				"Coldark-Dark",
				"--no-line-number",
				"--no-window-controls",
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
