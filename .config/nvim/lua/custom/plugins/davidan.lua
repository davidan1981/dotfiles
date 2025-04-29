-- disable netrw (vim's built-in file browser)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- my own key mapping
vim.keymap.set("n", ",f", ":NvimTreeToggle<CR>")
vim.keymap.set("n", ",q", ":q!<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jwj", "<Esc>:w<CR>")
vim.keymap.set("n", "tl", ":tabn<CR>")
vim.keymap.set("n", "th", ":tabp<CR>")

-- plugins --
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("nvim-tree/nvim-tree.lua")

vim.call("plug#end")

return {}
