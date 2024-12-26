return {
	"hrsh7th/nvim-cmp", -- Autocompletion plugin
	event = "InsertEnter", -- Load the plugin when entering insert mode
	dependencies = {
		"hrsh7th/cmp-buffer", -- Source for text in the current buffer
		"hrsh7th/cmp-path", -- Source for file system paths
		{
			"L3MON4D3/LuaSnip", -- Snippet engine
			version = "v2.*", -- Use the latest major release
			build = "make install_jsregexp", -- Optional: Install jsregexp for advanced features
		},
		"saadparwaiz1/cmp_luasnip", -- LuaSnip integration for autocompletion
		"rafamadriz/friendly-snippets", -- Collection of useful snippets
		"onsails/lspkind.nvim", -- Adds VS Code-like icons to the completion menu
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load VS Code-style snippets from plugins (e.g., friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Configure nvim-cmp
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect", -- Completion options
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Expand snippets using LuaSnip
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- Navigate to previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- Navigate to next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll up in the documentation
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll down in the documentation
				["<C-Space>"] = cmp.mapping.complete(), -- Trigger completion
				["<C-e>"] = cmp.mapping.abort(), -- Close completion menu
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm selection
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP-based completions
				{ name = "luasnip" }, -- Snippet completions
				{ name = "buffer" }, -- Completions from the current buffer
				{ name = "path" }, -- Completions for file system paths
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50, -- Limit the width of the completion menu
					ellipsis_char = "...", -- Use ellipsis for overflow
				}),
			},
		})
	end,
}
