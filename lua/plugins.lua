return require('packer').startup(function()
  -- Packer can manage itself
  use {
    'wbthomason/packer.nvim',
    opt = false
  }

  -- Make neovim impatient
  use 'lewis6991/impatient.nvim'

  -- Go
  use 'fatih/vim-go'

  -- General
  use 'junegunn/vim-easy-align'
  use 'junegunn/fzf.vim'
  use 'tpope/vim-sensible'


  -- Completion and linting
  use {
    'neovim/nvim-lspconfig',
    'folke/trouble.nvim'
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      'lukas-reineke/cmp-under-comparator',
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    event = 'InsertEnter *',
  }

  -- Unicode
  use 'chrisbra/unicode.vim'

  -- Editor
  use 'editorconfig/editorconfig-vim'
  use 'nathanaelkane/vim-indent-guides'
  use 'raimondi/delimitmate'
  use 'scrooloose/syntastic'
  use 'thiagoalessio/rainbow_levels.vim'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'wellle/targets.vim'
  use 'preservim/nerdtree'
  use 'ctrlpvim/ctrlp.vim'
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-fugitive'
  use 'mhinz/vim-signify'
  use 'ggreer/the_silver_searcher'
  use 'dense-analysis/ale'
  use 'ap/vim-buftabline'
end)
