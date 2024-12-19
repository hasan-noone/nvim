return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Load necessary modules
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Setup diagnostic signs
		local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
		for type, icon in pairs(signs) do
			vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type, numhl = "" })
		end

		-- LSP Attach keybindings
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Setup common keymaps
				local bindings = {
					{ "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
					{ "gD", vim.lsp.buf.declaration, "Go to declaration" },
					{ "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
					{ "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
					{ "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
					{ "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
					{ "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
					{ "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
					{ "<leader>d", vim.diagnostic.open_float, "Show line diagnostics" },
					{ "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
					{ "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
					{
						"K",
						vim.lsp.buf.hover,
						"Show documentation for what is under cursor",
					},
					{ "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
				}

				-- Assign the keymaps
				for _, binding in ipairs(bindings) do
					opts.desc = binding[3]
					keymap.set("n", binding[1], binding[2], opts)
				end
			end,
		})

		-- Setup mason LSP server handlers
		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,

			-- Example of a server with custom setup
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					},
				})
			end,
		})
	end,
}
