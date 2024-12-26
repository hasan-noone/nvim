return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        -- Configure null-ls with formatters
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
                    args = { "--tab-width", "4", "--use-tabs", "false" }, -- Use 4 spaces
                }),

                -- Lua
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-width", "4", "--indent-type", "Spaces" }, -- Use 4 spaces
                }),

                -- Python
                null_ls.builtins.formatting.isort.with({
                    extra_args = { "--profile", "black", "--line-length", "88" }, -- Use 4 spaces (black-compatible)
                }),
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length", "88" }, -- Use 4 spaces
                }),

                -- Go
                null_ls.builtins.formatting.gofumpt.with({
                    extra_args = { "-extra" }, -- Use 4 spaces (default for Go)
                }),

                -- C/C++
                null_ls.builtins.formatting.clang_format.with({
                    filetypes = { "cpp", "c" }, -- Apply to .cpp and .c files
                    extra_args = { "--style", "{BasedOnStyle: google, IndentWidth: 4}" }, -- Use 4 spaces
                }),
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
