
-- BASIC OPTIONS

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8

-- LAZY.NVIM (PLUGIN MANAGER)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", 
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugin (Theme installation) 

require("lazy").setup({

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  { 
    "dracula/vim", 
    name = "dracula", 
    lazy = false, 
    priority = 1000 
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "wave", -- "wave" | "dragon" | "lotus"
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    config = function()
      vim.g.VM_leader = "\\"
    end,
  },
  -- NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", 
    },
    lazy = false,
  },
  --  Lua Line Status Bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,  -- optional: load on startup
  },

  -- LSP auto completion plugin
  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",   -- LSP completion source
    "hrsh7th/cmp-buffer",    -- words from current buffer
    "hrsh7th/cmp-path",      -- file paths completion
  },
}


})

-- LuaLine Plugin 
require("lualine").setup({
  options = {
    theme = "auto",        -- automatically matches your colorscheme
    section_separators = "", -- optional, no separators
    component_separators = "", -- optional, no separators
  },
})


-- Default Theme

-- vim.cmd("colorscheme dracula")
vim.cmd("colorscheme cyberdream")


-- BASIC KEYBINDS
vim.g.mapleader = " "

-- Save
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Use system clipboard for all yank, delete, change, and paste
vim.opt.clipboard = "unnamedplus"

-- Optional: highlight text on yank (nice visual feedback)
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})


-- Nvim-Cmp config
local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})


-- LSP config

-- Lua
require("lsps.lua_ls")
-- Python--
require("lsps.python")
-- Rust
require("lsps.rust")
-- Go
require("lsps.go")
-- Zig
require("lsps.zig")
-- clangd
require("lsps.clangd")
-- Typescript
require("lsps.ts")
-- Haskell--
require("lsps.haskell")