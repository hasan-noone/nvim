return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Load necessary modules
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Mason setup
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- LSP servers to install
		local lsp_servers = {
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"graphql",
			"emmet_ls",
			"prismals",
			"pyright",
			"clangd",
            "marksman",
		}

		mason_lspconfig.setup({
			ensure_installed = lsp_servers,
		})

		-- Tools to install
		local tools = {
			"prettier",
			"stylua",
			"isort",
			"black",
			"clang-format",
		}

		mason_tool_installer.setup({
			ensure_installed = tools,
			automatic_installation = true,
		})

		-- Auto format and set tab width to 4 spaces
		local format_files = {
			"javascript",
			"typescript",
			"html",
			"css",
			"json",
			"yaml",
			"markdown",
			"graphql",
			"liquid",
			"lua",
			"python",
			"cpp",
			"c",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = format_files,
			callback = function()
				-- Set tab width to 4 spaces for consistent formatting
				vim.bo.tabstop = 4
				vim.bo.shiftwidth = 4
				vim.bo.softtabstop = 4
				vim.bo.expandtab = true
			end,
		})
	end,
}
