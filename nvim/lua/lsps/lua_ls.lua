-- -------------------------------------------------
-- Diagnostic UI (global, for all LSPs)
-- -------------------------------------------------
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
  update_in_insert = true,       -- live diagnostics while typing
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- -------------------------------------------------
-- lua-language-server config (OFFICIAL 0.11 WAY)
-- -------------------------------------------------

vim.lsp.config["lua_ls"] = {
  -- Command to start the language server
  cmd = { "lua-language-server" },

  -- Filetypes it should attach to
  filetypes = { "lua" },

  -- Root detection
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".git",
  },

  -------------------------------------------------
  -- Capabilities (for nvim-cmp autocomplete)
  -------------------------------------------------
  capabilities = (function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    return caps
  end)(),

  -------------------------------------------------
  -- Called when server attaches to a buffer
  -------------------------------------------------
  on_attach = function(client, bufnr)

    -- Format on save (Lua formatter via lua_ls)
    if client.server_capabilities.documentFormattingProvider then
      local group = vim.api.nvim_create_augroup("LuaFormat", { clear = false })
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

  -------------------------------------------------
  -- lua-language-server specific settings
  -------------------------------------------------
  settings = {
    Lua = {
      runtime = {
        -- Neovim uses LuaJIT
        version = "LuaJIT",
      },

      diagnostics = {
        enable = true,
        -- Recognize Neovim globals
        globals = { "vim" },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },

      telemetry = {
        enable = false,
      },

      completion = {
        callSnippet = "Replace", -- better function completion
      },
    },
  },
}

-- -------------------------------------------------
-- Enable it (REQUIRED)
-- -------------------------------------------------
vim.lsp.enable("lua_ls")
