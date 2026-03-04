-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local set = vim.keymap.set

-- COPY: Ctrl+c in Visual mode copies to system clipboard
set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })

-- PASTE: Ctrl+v in Insert and Command modes (standard behavior)
-- This leaves Ctrl+v in Normal mode free for "Visual Block" mode
set("i", "<C-v>", "<C-R>+", { desc = "Paste from clipboard" })
set("c", "<C-v>", "<C-R>+", { desc = "Paste from clipboard" })

-- SELECT ALL: Ctrl+a (optional, very modern feel)
set({ "n", "i", "v" }, "<C-a>", "ggVG", { desc = "Select all" })

-- Remap ` (backtick) to ' (single quote) for jumping to marks
-- This makes ' behave like ` (jumps to exact line AND column)
vim.keymap.set("n", "'", "`", { desc = "Jump to mark (line and col)" })

-- Unmap the backtick so it doesn't conflict with your tmux prefix
vim.keymap.del("n", "`")
