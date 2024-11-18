return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
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
				"gopls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"clang-format", -- C/C++ formatter
				"gofumpt", -- Go formatter
			},
			automatic_installation = true,
		})

		-- Format on save and ensure tab width of 4 spaces
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
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
				"go",
				"cpp",
				"c",
			},
			callback = function()
				-- Ensure tab size is set to 4 spaces
				vim.bo.tabstop = 4
				vim.bo.shiftwidth = 4
				vim.bo.softtabstop = 4
				vim.bo.expandtab = true -- Use spaces instead of tabs

				-- Format options for specific tools
				if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
					vim.cmd(
						[[autocmd FileType javascript,typescript setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]]
					)
				elseif vim.bo.filetype == "lua" then
					vim.cmd([[autocmd FileType lua setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]])
				elseif vim.bo.filetype == "python" then
					vim.cmd([[autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]])
				elseif vim.bo.filetype == "go" then
					vim.cmd([[autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]])
				elseif vim.bo.filetype == "cpp" or vim.bo.filetype == "c" then
					vim.cmd([[autocmd FileType cpp,c setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab]])
				end
			end,
		})
	end,
}
