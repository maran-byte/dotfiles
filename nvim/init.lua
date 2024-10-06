-- init.lua

-- Auto-install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Packer Plugins
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Dracula Theme
  use 'Mofiqul/dracula.nvim'

  -- File Explorer: NvimTree
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  -- Lualine for status bar
  use 'nvim-lualine/lualine.nvim'

  -- Autocompletion and LSP
  use 'neovim/nvim-lspconfig' -- Language Server Protocol configurations
  use 'hrsh7th/nvim-cmp' -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer completions
  use 'hrsh7th/cmp-path' -- Path completions
  use 'hrsh7th/cmp-cmdline' -- Command-line completions
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completions
  use 'L3MON4D3/LuaSnip' -- Snippet engine

  -- Treesitter for better syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  
  -- Telescope for fuzzy finding
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim' -- Required dependency for Telescope

  -- Git integration
  use 'tpope/vim-fugitive'

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General Settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.cursorline = true

-- Theme setup
vim.cmd [[colorscheme dracula]]

-- Lualine setup
require('lualine').setup {
  options = {
    theme = 'dracula',
    section_separators = '',
    component_separators = ''
  }
}

-- NvimTree setup
require('nvim-tree').setup {}

-- Autocompletion setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Treesitter setup for enhanced syntax highlighting
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- Install all maintained parsers
  highlight = { enable = true },
  indent = { enable = true }
}

-- Telescope setup
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git/"},
  }
}

