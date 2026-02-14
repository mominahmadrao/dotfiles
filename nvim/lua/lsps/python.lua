-- Diagnostic UI (global, same as your Haskell/Rust setup)
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = { severity = { min = vim.diagnostic.severity.WARN } },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Python LSP config (Pyright)
vim.lsp.config["pyright"] = {
  cmd = { "pyright-langserver", "--stdio" },

  filetypes = { "python" },

  root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },

  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    return caps
  end)(),

  on_attach = function(client, bufnr)

    -- Format on save (Black)
    if client.server_capabilities.documentFormattingProvider then
      local group = vim.api.nvim_create_augroup("PythonFormat", { clear = false })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    -- Show diagnostics automatically (hover)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict" for stricter checks
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- REQUIRED
vim.lsp.enable("pyright")
