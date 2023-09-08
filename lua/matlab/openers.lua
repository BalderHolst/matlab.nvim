local M = {}

-- This module contains ways to open a buffer to matlab output. 
-- All opening function MUST return a tuple containing (output_window, output_buffer).

M.split = function()
    local code_win = vim.api.nvim_get_current_win()
    vim.cmd("split")     -- spilt horizontally
    M.out_win = vim.api.nvim_get_current_win()
    M.out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(M.out_win, M.out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_height(M.out_win, 10)         -- Sets the height
    vim.api.nvim_win_set_option(M.out_win, "relativenumber", false)
    vim.api.nvim_win_set_option(M.out_win, "wrap", false)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return M.out_win, M.out_buf
end

M.vsplit = function()
    local code_win = vim.api.nvim_get_current_win()
    vim.cmd("vsplit")     -- spilt vertically
    M.out_win = vim.api.nvim_get_current_win()
    M.out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(M.out_win, M.out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_width(M.out_win, 50)          -- Sets the width
    vim.api.nvim_win_set_option(M.out_win, "relativenumber", false)
    vim.api.nvim_win_set_option(M.out_win, "wrap", false)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return M.out_win, M.out_buf
end

return M
