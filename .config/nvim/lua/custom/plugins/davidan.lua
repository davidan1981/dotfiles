-- disable netrw (vim's built-in file browser)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- other settings
vim.opt.textwidth = 120
vim.opt.wrap = true

-- highlight the current line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#131323' })

-- my own key mapping
vim.keymap.set('n', ',f', ':NvimTreeToggle<CR>')
vim.keymap.set('n', ',g', '<C-w><C-w>', { desc = 'Move focus to the next available window' })
vim.keymap.set('n', ',q', ':q!<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', 'tl', ':tabn<CR>')
vim.keymap.set('n', 'th', ':tabp<CR>')
vim.keymap.set('n', 'zh', ':tabprevious<CR>', { desc = 'Show the previous tab' })
vim.keymap.set('n', 'zl', ':tabnext<CR>', { desc = 'Show the next tab' })
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Get out of edit mode' })
vim.keymap.set('i', 'jwj', '<Esc>:w<CR>', { desc = 'Quick save' })

-- This will allow nvim to close the tab when you close a buffer but nvim-tree is open
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function('winlayout', {})
    if layout[1] == 'leaf' and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree' and layout[3] == nil then
      vim.cmd 'quit'
    end
  end,
})

-- Create an autocommand group to manage your custom autocommands
local autocmd_group = vim.api.nvim_create_augroup('Custom auto-commands', { clear = true })

-- Create an autocmd that runs flake8 on Python files after saving
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.py' }, -- Apply to all files with a .py extension
  desc = 'Run flake8 after saving Python files', -- Description for the autocmd
  group = autocmd_group, -- Assign to the autocmd group
  callback = function()
    local file_name = vim.api.nvim_buf_get_name(0) -- Get the current buffer's file name
    vim.cmd(':! flake8 ' .. file_name) -- Execute flake8 on the saved file
  end,
})

-- Make sure new tab has nvim-tree open automatically
vim.api.nvim_create_autocmd('TabEnter', {
  group = vim.api.nvim_create_augroup('NvimTreeOpen', { clear = true }),
  callback = function()
    local nvim_tree = require 'nvim-tree.view'
    -- Check if nvim-tree is not already open
    if not nvim_tree.is_visible() then
      vim.cmd 'NvimTreeOpen'
    end
  end,
})

-- Remove trailing white space for python code
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.py' },
  command = [[%s/\s\+$//e]],
})

-- Fix the copilot window highlight issue
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'copilot',
  callback = function()
    vim.wo.winhighlight = 'CursorLine:CursorLine'
  end,
})

return {
  -- GitHub Copilot --
  {
    'github/copilot.vim',
  },
  -- GitHub Copilot Chat --
  {
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim', branch = 'master' },
      },
      build = 'make tiktoken',
      opts = {
        -- See Configuration section for options
      },
      keys = {
        { '<leader>cc', '<cmd>CopilotChat<cr>', mode = 'n', desc = 'Open Copilot Chat' },
        { '<leader>ce', '<cmd>CopilotChatExplain<cr>', mode = 'v', desc = 'Explain Code' },
        { '<leader>cC', '<cmd>CopilotChatPanel<cr>', desc = 'Open Copilot Chat Panel' },
        { '<leader>cr', '<cmd>CopilotChatRun<cr>', desc = 'Run last command in Copilot Chat' },
        { '<leader>ca', '<cmd>CopilotChatActAs<cr>', desc = 'Use Copilot Chat to act as...' },
      },
    },
  },
  -- Override mason-lspconfig from the init --
  -- To see the complete list, run :Mason --
  -- To see the error logs, run :MasonLog --
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'pyright',
          'ruby_lsp',
          'ts_ls',
          'java_language_server',
          'kotlin_language_server',
          'bashls',
          'html',
          'cssls',
          'jinja_lsp',
          'gopls',
        },
        automatic_installation = true,
      }
    end,
  },
  -- transparent window --
  {
    -- Run `:TransparentEnable`
    'xiyaowong/transparent.nvim',
    version = '*',
    lazy = false,
    config = function()
      require('transparent').setup {
        -- table: default groups
        groups = {
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'StatusLine',
          'StatusLineNC',
          'EndOfBuffer',
        },
        -- table: additional groups that should be cleared
        extra_groups = {
          'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
          'NvimTreeNormal', -- NvimTree
        },
        -- table: groups you don't want to clear
        exclude_groups = {},
        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
      }
    end,
  },
  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      }
    end,
  },
}
