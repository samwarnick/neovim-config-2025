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
		layout = { layout = {position = "right"}},
		follow_files = true,
		auto_close = false
        }
      }
    }
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
  }
}
}
