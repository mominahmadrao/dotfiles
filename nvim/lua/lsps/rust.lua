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
  update_in_insert = true,       -- show diagnostics while typing
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- rust-analyzer config (OFFICIAL 0.11 WAY)

vim.lsp.config["rust_analyzer"] = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },

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
      local group = vim.api.nvim_create_augroup("RustFormat", { clear = false })
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

  -- rust-analyzer specific settings

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },

      --LIVE diagnostics while typing (unsaved buffer)
      check = {
        command = "check",   -- remove extraArgs; rust-analyzer adds message-format automatically
      },

      --HEAVY diagnostics on save
      checkOnSave = {
        enable = true,
        command = "clippy",
      },

      diagnostics = {
        enable = true,
        enableExperimental = true,  -- allow diagnostics for unsaved buffers
      },

      procMacro = {
        enable = true,
      },
    },
  },
}

-- Enable it

vim.lsp.enable("rust_analyzer")










-- -------------------------------------------------
-- -- Diagnostic UI (global, for all LSPs)
-- -------------------------------------------------
-- vim.diagnostic.config({
--   virtual_text = {
--     spacing = 2,
--     prefix = "●",
--     severity = { min = vim.diagnostic.severity.WARN },
--   },
--   signs = {
--     severity = { min = vim.diagnostic.severity.WARN },
--   },
--   underline = {
--     severity = { min = vim.diagnostic.severity.WARN },
--   },
--   update_in_insert = true,
--   severity_sort = true,
--   float = {
--     border = "rounded",
--     source = "always",
--   },
-- })

-- -------------------------------------------------
-- -- rust-analyzer config (OFFICIAL 0.11 WAY)
-- -------------------------------------------------
-- vim.lsp.config["rust_analyzer"] = {
--   -- Command to start the language server
--   cmd = { "rust-analyzer" },

--   -- Filetypes it should attach to
--   filetypes = { "rust" },

--   -- Project root detection (0.11 style)
--   root_markers = { "Cargo.toml", ".git" },

--   -------------------------------------------------
--   -- Optional: capabilities (for nvim-cmp)
--   -------------------------------------------------
--   capabilities = (function()
--     local caps = vim.lsp.protocol.make_client_capabilities()
--     pcall(function()
--       caps = require("cmp_nvim_lsp").default_capabilities(caps)
--     end)
--     return caps
--   end)(),

--   -------------------------------------------------
--   -- Called when server attaches to a buffer
--   -------------------------------------------------
--   on_attach = function(client, bufnr)
--     -- Format on save
--     if client.server_capabilities.documentFormattingProvider then
--       local group = vim.api.nvim_create_augroup("RustFormat", { clear = false })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = group,
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({ async = false })
--         end,
--       })
--     end

--     -- Show diagnostics on hover (normal + insert)
--     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--       buffer = bufnr,
--       callback = function()
--         vim.diagnostic.open_float(nil, { focus = false })
--       end,
--     })
--   end,

--   -------------------------------------------------
--   -- rust-analyzer specific settings
--   -------------------------------------------------
--   settings = {
--   ["rust-analyzer"] = {
--     cargo = {
--       allFeatures = true,
--     },

--     -- live cargo check while typing
--     check = {
--       command = "check",
--     },

--     -- clippy on save
--     checkOnSave = {
--       enable = true,
--       command = "clippy",
--     },

--     diagnostics = {
--       enable = true,
--       enableExperimental = true,  -- allow unsaved buffer diagnostics
--     },

--     procMacro = {
--       enable = true,
--     },
--   },
--   }

-- } 

-- -------------------------------------------------
-- -- Enable it (this is REQUIRED)
-- -------------------------------------------------
-- vim.lsp.enable("rust_analyzer")
