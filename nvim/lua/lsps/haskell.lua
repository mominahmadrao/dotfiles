-- Diagnostic UI (global, same as your Rust setup)

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Haskell LSP config (Neovim 0.11+ style)

vim.lsp.config["hls"] = {
  cmd = { "haskell-language-server-wrapper", "--lsp" },

  filetypes = { "haskell", "lhaskell", "cabal" },

  root_markers = {
    "hie.yaml",
    "stack.yaml",
    "cabal.project",
    "*.cabal",
    ".git",
  },

  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    return caps
  end)(),

  on_attach = function(client, bufnr)

    -- Format on save
    if client.server_capabilities.documentFormattingProvider then
      local group = vim.api.nvim_create_augroup("HaskellFormat", { clear = false })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    -- Show diagnostics automatically
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,

  settings = {
    haskell = {
      formattingProvider = "ormolu", -- or "fourmolu", "stylish-haskell"
      checkProject = true,
      checkParents = "CheckOnSave",
    },
  },
}

-- REQUIRED
vim.lsp.enable("hls")
