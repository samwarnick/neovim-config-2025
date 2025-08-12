return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = package.loaded.gitsigns
				local keymap = vim.keymap

				keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
				keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
				keymap.set("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
				keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "Blame line" })
				keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
			end,
		})
	end,
}
