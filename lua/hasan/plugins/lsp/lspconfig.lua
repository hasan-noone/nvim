return {
	"neovim/nvim-lspconfig", -- Plugin for configuring LSP servers
	event = { "BufReadPre", "BufNewFile" }, -- Load the plugin on these events
	dependencies = { -- List of dependent plugins
		"hrsh7th/cmp-nvim-lsp", -- Adds LSP capabilities to nvim-cmp
		{ "antosha417/nvim-lsp-file-operations", config = true }, -- Handles file operations for LSP
		{ "folke/neodev.nvim", opts = {} }, -- Neovim-specific Lua development tools
	},
	config = function()
		-- Load required modules
		local lspconfig = require("lspconfig") -- Main LSP configuration module
		local mason_lspconfig = require("mason-lspconfig") -- Integration between Mason and LSP
		local cmp_nvim_lsp = require("cmp_nvim_lsp") -- Adds LSP capabilities to nvim-cmp
		local keymap = vim.keymap -- Keymap utility for defining keybindings
		local capabilities = cmp_nvim_lsp.default_capabilities() -- Default LSP capabilities

		-- Setup diagnostic signs for errors, warnings, hints, and info
		for type, icon in pairs({ Error = "", Warn = "", Hint = "󰠠", Info = "" }) do
			vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
		end

		-- Automatically set up keybindings when an LSP server attaches to a buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}), -- Create a new autocommand group
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true } -- Options for keybindings

				-- Define keybindings for LSP functionality
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

				-- Assign the keybindings
				for _, binding in ipairs(bindings) do
					opts.desc = binding[3] -- Add a description for the keybinding
					keymap.set("n", binding[1], binding[2], opts) -- Set the keybinding in normal mode
				end
			end,
		})

		-- Configure LSP servers using Mason
		mason_lspconfig.setup_handlers({
			-- Default handler for setting up LSP servers
			function(server_name)
				lspconfig[server_name].setup({ capabilities = capabilities })
			end,

			-- Custom setup for the Lua LSP server
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } }, -- Allow `vim` as a global
							completion = { callSnippet = "Replace" }, -- Enable snippet completion
						},
					},
				})
			end,
		})
	end,
}
