return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          cmd = { "/home/momin/go/bin/gopls" }, -- use your system gopls
          settings = {
            gopls = {
              gofumpt = true, -- stricter gofmt formatting
            },
          },
        },
      },
      setup = {
        gopls = function(_, opts)
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup(opts)

          -- Auto format Go files on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end,
      },
    },
  },
}
