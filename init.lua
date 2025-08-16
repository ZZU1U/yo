-- My small nvim config --

-- Defaults
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.scrolloff = 10
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.signcolumn = 'yes'
vim.o.updatetime = 300
vim.o.timeoutlen = 1000
vim.o.swapfile = false
vim.o.encoding = 'utf-8'
vim.o.spell = true
vim.o.spelllang = 'en'
vim.o.winborder = 'rounded'
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('~/.config/nvim/undo')
vim.o.autochdir = true
vim.o.foldmethod = 'manual'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.cmd('syntax on')
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Some useful vim keybindings 
--- I am trying to keep defaults but some actions just don't have em
local map = vim.keymap.set
map('n', '<leader>bd', '<cmd>bdelete<cr>')
map('n', 'H', '<cmd>bprev<cr>')
map('n', 'L', '<cmd>bnext<cr>')
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')
map({ 'n', 'v' }, '<leader>c', '1z=')
map('n', '<leader>k', vim.diagnostic.open_float)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        map('n', '<leader>lR', vim.lsp.buf.rename, { buffer = ev.buf })
        map('n', '<leader>lr', vim.lsp.buf.references, { buffer = ev.buf })
        map('n', '<leader>la', vim.lsp.buf.code_action, { buffer = ev.buf })
        map('n', '<leader>li', vim.lsp.buf.implementation, { buffer = ev.buf })
        map('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = ev.buf })
        map('n', '<leader>lf', vim.lsp.buf.format, { buffer = ev.buf })
    end,
})
map('n', '<leader>tb', '<cmd>10split | terminal just build<cr>')
map('n', '<leader>tr', '<cmd>10split | terminal just run<cr>')

-- Plugins
vim.pack.add({
    -- 'https://github.com/m4xshen/hardtime.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/bluz71/vim-moonfly-colors',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/chomosuke/typst-preview.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/echasnovski/mini.comment',
    'https://github.com/echasnovski/mini.tabline',
    'https://github.com/echasnovski/mini.surround',
    'https://github.com/echasnovski/mini.completion',
    'https://github.com/echasnovski/mini.pairs',
    'https://github.com/echasnovski/mini-git',
    'https://github.com/echasnovski/mini.diff',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/duckdm/neowarrior.nvim'
})

require 'mini.comment'.setup()
require 'mini.completion'.setup()
require 'mini.tabline'.setup()
require 'mini.pairs'.setup()
require 'mini.surround'.setup()
require 'mini.git'.setup()

require 'oil'.setup()
map('n', '<leader>o', '<cmd>Oil<cr>')

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true)
            }
        }
    }
})
vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'pyright', 'tinymist', 'clangd' })

-- Theme setup
vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTransparent = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2
vim.cmd [[colorscheme moonfly]]
vim.cmd [[hi statusline guibg=NONE ]]
vim.cmd [[hi MiniTablineCurrent guibg=NONE guifg=#FF005D]]
vim.cmd [[hi MiniTablineHidden guibg=NONE]]
vim.cmd [[hi MiniTablineVisible guibg=NONE]]
vim.cmd [[hi MiniTablineModifiedCurrent guibg=NONE guifg=#FF005D]]
vim.cmd [[hi MiniTablineModifiedHidden guibg=NONE guifg=#E9B607]]
vim.cmd [[hi MiniTablineModifiedVisible guibg=NONE guifg=#E9B607]]

-- Pretty simple Diff
local diff = require 'mini.diff'
diff.setup()
map('n', '<leader>vd', diff.toggle_overlay);
map('n', '<leader>vD', diff.toggle);

-- Telescope searches
require 'telescope'.setup()
local builtin = require 'telescope.builtin'
map('n', '<leader>sf', builtin.find_files)
map('n', '<leader>sg', builtin.live_grep)
map('n', '<leader>sb', builtin.buffers)
map('n', '<leader>sh', builtin.help_tags)

-- Just some tool
local nw = require 'neowarrior'
nw.setup({})
map("n", "<leader>ot", nw.open_right)

-- Tree sitter parsers
require 'nvim-treesitter.configs'.setup({
    ensure_installed = { 'svelte', 'typescript', 'javascript', 'typst' },
    highlight = { enable = true }
})

-- Preview for typst documents
require 'typst-preview'.setup({
    dependencies_bin = {
        ['tinymist'] = '/etc/profiles/per-user/dudu/bin/tinymist',
        ['websocat'] = nil
    },
})

-- Snippets
require('luasnip').setup({ enable_autosnippets = true })
require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets/' })

local ls = require('luasnip')
map('i', '<C-e>', function() ls.expand_or_jump(1) end, { silent = true })
-- map({ 'i', 's' }, '<C-J>', function() ls.jump(1) end, { silent = true })
-- map({ 'i', 's' }, '<C-K>', function() ls.jump(-1) end, { silent = true })
