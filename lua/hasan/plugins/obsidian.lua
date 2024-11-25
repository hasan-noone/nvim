return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown", -- Load the plugin only for markdown files
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required dependency
	},
	opts = {
		dir = "/Users/mdnaumanatharhasan/Documents/obsidian/personal", -- Ensure this path exists
		completion = {
			nvim_cmp = true, -- Enable completion with nvim-cmp
		},
		ui = {
			enable = true, -- Enable additional UI features
		},
	},
	config = function(_, opts)
		local obsidian = require("obsidian")
		obsidian.setup(opts)
	end,
}
