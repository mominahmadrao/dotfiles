return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true, -- show errors while typing
        virtual_text = true,
      },
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              check = { command = "clippy" }, -- ✅ new format
            },
          },
        },
      },
      setup = {
        rust_analyzer = function(_, opts)
          local lspconfig = require("lspconfig")
          lspconfig.rust_analyzer.setup(opts)

          -- Auto format Rust files on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.rs",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      },
    },
  },
}
