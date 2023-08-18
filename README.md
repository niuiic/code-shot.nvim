# code-shot.nvim

Take a picture of the code.

Similar features to [silicon.nvim](https://github.com/krivahtoo/silicon.nvim), keep simple, keep reliable.

## Dependencies

- [silicon](https://github.com/Aloxaf/silicon)
- [niuiic/code.nvim](https://github.com/niuiic/code.nvim)

## Usage

Just call `require("code-shot").shot()`, work in both `n` and `v` mode.

- Shot whole file

- Shot selection

## Config

Default config here.

```lua
require("code-shot").setup({
	output = function()
		local core = require("core")
		local buf_name = vim.api.nvim_buf_get_name(0)
		return core.file.name(buf_name) .. ".png"
	end,
	options = function()
		return {}
	end,
})
```

Add any argument supported by silicon in `options`. For example, select a theme.

```lua
require("code-shot").setup({
	output = function()
		local core = require("core")
		local buf_name = vim.api.nvim_buf_get_name(0)
		return core.file.name(buf_name) .. ".png"
	end,
	options = function()
		return {
			"--theme",
			"DarkNeon",
		}
	end,
})
```
