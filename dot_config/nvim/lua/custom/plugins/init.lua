-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npx --yes yarn install',
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
}
