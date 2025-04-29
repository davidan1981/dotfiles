-- disable netrw (vim's built-in file browser)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- my own key mapping
vim.keymap.set('n', ',f', ':NvimTreeToggle<CR>')
vim.keymap.set('n', ',q', ':q!<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jwj', '<Esc>:w<CR>')
vim.keymap.set('n', 'tl', ':tabn<CR>')
vim.keymap.set('n', 'th', ':tabp<CR>')

return {
  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
}
