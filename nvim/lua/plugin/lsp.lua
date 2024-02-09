return {
    'VonHeikemen/lsp-zero.nvim',
    event = "BufEnter",
    branch = 'v2.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()

        local lsp = require('lsp-zero')
        lsp.preset('recommended')
        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({buffer = bufnr})
        end)
        lsp.setup()

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {"lua_ls"},
            handlers = {
                lsp.default_setup,
            },
        })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
        vim.keymap.set("n", "<leader>cc", vim.cmd.cclose)

        local cmp = require('cmp')

        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({select = false}),
                ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                ['<C-j>'] = cmp.mapping.scroll_docs(4),
            },
            window = {
                documentation = cmp.config.window.bordered(),
            }
        })
    end
}

