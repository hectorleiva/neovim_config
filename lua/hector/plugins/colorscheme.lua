return {
	{
		"bluz71/vim-nightfly-guicolors",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme nightfly]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 999,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		priority = 998,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme cyberdream]])
		end,
	},
}
