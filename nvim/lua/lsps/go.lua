-- Diagnostic UI (global, for all LSPs)

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
  update_in_insert = true,  -- show diagnostics while typing
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- gopls config (Go Language Server)

vim.lsp.config["gopls"] = {
  cmd = { "gopls" },            -- make sure gopls is installed
  filetypes = { "go", "gomod" }, 
  root_markers = { "go.mod", ".git" },

  -- Optional: capabilities (for nvim-cmp)
  
  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    return caps
  end)(),

  -- Called when server attaches to a buffer
  
  on_attach = function(client, bufnr)

    -- Format on save
    
    if client.server_capabilities.documentFormattingProvider then
      local group = vim.api.nvim_create_augroup("GoFormat", { clear = false })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    -- Show diagnostics automatically (normal + insert)
    
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,

  -- gopls specific settings
  
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,   -- enable more checks like Clippy in Rust
      codelenses = {
        gc_details = true,
        test = true,
      },
    },
  },
}

-- Enable it
vim.lsp.enable("gopls")
