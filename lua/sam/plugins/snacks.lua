--
return {
	{
		"folke/snacks.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		---@type snacks.Config
		opts = {
			explorer = {
				enabled = true,
				replace_netrw = true,
			},
			picker = {
				sources = {
					explorer = {
						layout = { layout = { position = "right" } },
						follow_files = true,
						auto_close = false,
					},
				},
			},
			scroll = {},
			dashboard = {},
			indent = {},
			images = {},
			lazygit = {},
		},
		keys = {
			{
				"<leader>e",
				function()
					Snacks.explorer({ hidden = true, ignored = true })
				end,
				desc = "Explorer",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
			},
		},
	},
}
