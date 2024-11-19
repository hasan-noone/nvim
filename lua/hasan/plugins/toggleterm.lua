return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<C-t>]], -- Customize this key binding
				direction = "float", -- Use floating window
			})
		end,
	},
}
