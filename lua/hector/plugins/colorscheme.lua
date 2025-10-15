return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"bluz71/vim-nightfly-guicolors",
		lazy = true,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
	},
}
