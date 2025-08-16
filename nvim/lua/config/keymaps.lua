-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Save current file in Normal mode
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- Save current file in Insert mode
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file in insert mode" })

-- Save all open buffers in Normal mode (like VS Code "Save All")
vim.keymap.set("n", "<C-S-s>", ":wa<CR>", { desc = "Save all buffers" })

-- Save all open buffers in Insert mode
vim.keymap.set("i", "<C-S-s>", "<Esc>:wa<CR>a", { desc = "Save all buffers in insert mode" })
