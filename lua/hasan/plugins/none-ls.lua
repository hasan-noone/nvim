return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- JavaScript/TypeScript/Web
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"typescript",
						"javascriptreact",
						"typescriptreact",
						"svelte",
						"css",
						"html",
						"json",
						"yaml",
						"markdown",
						"graphql",
						"liquid",
					},
				}),

				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Python
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,

				-- Go
				null_ls.builtins.formatting.gofumpt,

				-- C/C++
				null_ls.builtins.formatting.clang_format,
			},
			-- Format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								timeout_ms = 1000,
								async = false,
							})
						end,
					})
				end
			end,
		})

		-- Format keybinding
		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			vim.lsp.buf.format({
				timeout_ms = 1000,
				async = false,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
