--
return {
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			explorer = {
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
		},
	},
}
