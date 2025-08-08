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
vim.o.scrolloff = 5
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
vim.o.spelllang = 'en,ru'
vim.o.winborder = 'rounded'
vim.o.undofile = true
vim.o.undodir = vim.fn.expand('~/.config/nvim/undo')
vim.cmd('syntax on')

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.keymap.set('n', 'L', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', 'H', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>lD', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = ev.buf })
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = ev.buf })
    end,
})

vim.keymap.set('n', '<leader>tb', '<cmd>10split | terminal just build<cr>', { desc = 'Run building job from justfile' })
vim.keymap.set('n', '<leader>tr', '<cmd>10split | terminal just run<cr>', { desc = 'Run launching job from justfile' })

vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/bluz71/vim-moonfly-colors',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/chomosuke/typst-preview.nvim',
    'https://github.com/echasnovski/mini.comment',
    'https://github.com/echasnovski/mini.pick',
    'https://github.com/echasnovski/mini.tabline',
    'https://github.com/echasnovski/mini.completion',
    'https://github.com/echasnovski/mini.pairs',
    'https://github.com/echasnovski/mini-git',
    'https://github.com/echasnovski/mini.cursorword',
    'https://github.com/echasnovski/mini.hipatterns',
})

require 'mini.tabline'.setup()
require 'mini.comment'.setup()
require 'mini.completion'.setup()
require 'mini.pairs'.setup()
require 'mini.git'.setup()
require 'mini.cursorword'.setup({delay=600})
require 'mini.hipatterns'.setup()

require 'oil'.setup()
vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Oil' })

vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'pyright', 'tinymist', 'clangd' })
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true)
            }
        }
    }
})

vim.g.moonflyCursorColor = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyTransparent = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2
vim.cmd [[colorscheme moonfly]]

local Pick = require 'mini.pick'
Pick.setup({})
vim.keymap.set('n', '<leader>sf', Pick.builtin.files)
vim.keymap.set('n', '<leader>sb', Pick.builtin.buffers)
vim.keymap.set('n', '<leader>sg', Pick.builtin.grep_live)

require 'nvim-treesitter.configs'.setup({
    ensure_installed = { 'svelte', 'typescript', 'javascript' },
    highlight = { enable = true }
})

require 'typst-preview'.setup({
    dependencies_bin = {
        ['tinymist'] = '/opt/homebrew/bin/tinymist',
        ['websocat'] = nil
    },
})
