-- clangd (C / C++)

vim.lsp.config["clangd"] = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--fallback-style=LLVM",
    "--header-insertion=never",
    "--query-driver=/usr/bin/clang*,/usr/bin/g++*,/usr/bin/gcc*",
  },

  filetypes = { "c", "cpp" },

  root_markers = { ".git" },

  -- nvim-cmp completion support
  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    return caps
  end)(),

  on_attach = function(_, bufnr)
    -- Show diagnostics automatically (normal + insert)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,
}

-- Enable clangd
vim.lsp.enable("clangd")
