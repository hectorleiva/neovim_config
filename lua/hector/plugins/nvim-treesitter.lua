-- nvim-treesitter `main` branch (rewrite for Neovim 0.11+).
-- The old `.configs.setup{ highlight, indent, ensure_installed, ... }` API is gone.
-- Parsers are installed explicitly; highlighting/indent are started per-buffer via autocmd.
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local parsers = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"prisma",
				"query",
				"svelte",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			require("nvim-treesitter").install(parsers)

			local filetypes_with_treesitter = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"lua",
				"markdown",
				"prisma",
				"query",
				"svelte",
				"typescript",
				"typescriptreact",
				"vim",
				"help",
				"yaml",
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes_with_treesitter,
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			})
		end,
	},
}
