-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'LspAttach',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        preset = 'modern',
      }
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npx --yes yarn install',
  },

  { -- Render markdown inline in the buffer (headings, code blocks, tables, etc.)
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ft = { 'markdown' },
    opts = {},
  },

  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VimEnter',
    keys = {
      { '<A-,>', '<cmd>BufferPrevious<cr>', desc = 'Buffer: Previous' },
      { '<A-.>', '<cmd>BufferNext<cr>', desc = 'Buffer: Next' },
      { '<A-<>', '<cmd>BufferMovePrevious<cr>', desc = 'Buffer: Move left' },
      { '<A->>', '<cmd>BufferMoveNext<cr>', desc = 'Buffer: Move right' },
      { '<A-c>', '<cmd>BufferClose<cr>', desc = 'Buffer: Close' },
      { '<A-p>', '<cmd>BufferPin<cr>', desc = 'Buffer: Pin' },
      { '<A-1>', '<cmd>BufferGoto 1<cr>', desc = 'Buffer: Go to 1' },
      { '<A-2>', '<cmd>BufferGoto 2<cr>', desc = 'Buffer: Go to 2' },
      { '<A-3>', '<cmd>BufferGoto 3<cr>', desc = 'Buffer: Go to 3' },
      { '<A-4>', '<cmd>BufferGoto 4<cr>', desc = 'Buffer: Go to 4' },
      { '<A-5>', '<cmd>BufferGoto 5<cr>', desc = 'Buffer: Go to 5' },
    },
    opts = {},
  },

  { -- Fast navigation with labels
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },

  { -- Treesitter-based textobjects for functions, classes, arguments
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
      local select = require 'nvim-treesitter-textobjects.select'
      local move = require 'nvim-treesitter-textobjects.move'
      local swap = require 'nvim-treesitter-textobjects.swap'

      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      -- Select textobjects
      local select_maps = {
        ['af'] = { '@function.outer', 'Select around function' },
        ['if'] = { '@function.inner', 'Select inner function' },
        ['ac'] = { '@class.outer', 'Select around class' },
        ['ic'] = { '@class.inner', 'Select inner class' },
        ['aa'] = { '@parameter.outer', 'Select around argument' },
        ['ia'] = { '@parameter.inner', 'Select inner argument' },
      }
      for key, val in pairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, key, function() select.select_textobject(val[1]) end, { desc = val[2] })
      end

      -- Move to next/previous textobjects
      local move_maps = {
        [']m'] = { move.goto_next_start, '@function.outer', 'Next function start' },
        [']]'] = { move.goto_next_start, '@class.outer', 'Next class start' },
        [']a'] = { move.goto_next_start, '@parameter.inner', 'Next argument' },
        [']M'] = { move.goto_next_end, '@function.outer', 'Next function end' },
        [']['] = { move.goto_next_end, '@class.outer', 'Next class end' },
        ['[m'] = { move.goto_previous_start, '@function.outer', 'Previous function start' },
        ['[['] = { move.goto_previous_start, '@class.outer', 'Previous class start' },
        ['[a'] = { move.goto_previous_start, '@parameter.inner', 'Previous argument' },
        ['[M'] = { move.goto_previous_end, '@function.outer', 'Previous function end' },
        ['[]'] = { move.goto_previous_end, '@class.outer', 'Previous class end' },
      }
      for key, val in pairs(move_maps) do
        vim.keymap.set({ 'n', 'x', 'o' }, key, function() val[1](val[2]) end, { desc = val[3] })
      end

      -- Swap arguments
      vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end, { desc = 'Swap with next argument' })
      vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end, { desc = 'Swap with previous argument' })
    end,
  },

  { -- Better diagnostics list
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / References (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
    opts = {},
  },

  { -- Git client (magit-like interface)
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit: Open' },
      { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Neogit: Commit' },
      { '<leader>gp', '<cmd>Neogit pull<cr>', desc = 'Neogit: Pull' },
      { '<leader>gP', '<cmd>Neogit push<cr>', desc = 'Neogit: Push' },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}
