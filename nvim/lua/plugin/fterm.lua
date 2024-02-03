return {
    "numToStr/FTerm.nvim",
    config = function()
        vim.keymap.set('n', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<A-t>', '<CMD>lua require("FTerm").toggle()<CR>')
    end
}
