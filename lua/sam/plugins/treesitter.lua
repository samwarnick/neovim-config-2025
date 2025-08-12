return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {},
		},
		{
			"windwp/nvim-ts-autotag",
			opts = {},
		},
	},
	event = { "BufReadPre" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"lua",
				"vim",
				"vimdoc",
				"c",
				"query",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
