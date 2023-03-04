local Terminal = require('toggleterm.terminal').Terminal
require("toggleterm").setup{
    autochdir = true,
    start_in_insert = true,
    direction = "vertical",
    auto_scroll = true,
}

function RunFile()
    local current_filename = vim.api.nvim_buf_get_name(0)
        local commands = {
        ['rust'] = 'cargo run',
        ['python'] = 'python ' .. current_filename,
    }
    return commands[vim.bo.filetype]
end

vim.cmd[[command! -count=1 TermCodeRun lua require'toggleterm'.exec(RunFile(), <count>, 40)]]

vim.cmd[[command! -count=2 TermGitAdd lua require'toggleterm'.exec("git add .", <count>, 40)]]
vim.cmd[[command! -count=2 TermGitCommit lua require'toggleterm'.exec("git commit", <count>, 40)]]

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm size=40<cr>")
vim.keymap.set("n","<leader>r",  "<cmd>TermCodeRun<cr>")
vim.keymap.set("n","<leader>ff",  "<cmd>TermCodeFormat<cr>")

-- git shortcuts
vim.keymap.set("n","<leader>ga", "<cmd>TermGitAdd<cr>")
vim.keymap.set("n","<leader>gm", "<cmd>TermGitCommit<cr>")


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')