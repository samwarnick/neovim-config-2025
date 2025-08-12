vim.g.mapleader = " "

local keymap = vim.keymap

-- keymap.set("n", "<C-d>", "<C-d>zz")
-- keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Navigate panes
keymap.set("n", "<C-j>", "<C-w>j", {})
keymap.set("n", "<C-k>", "<C-w>k", {})
keymap.set("n", "<C-h>", "<C-w>h", {})
keymap.set("n", "<C-l>", "<C-w>l", {})
