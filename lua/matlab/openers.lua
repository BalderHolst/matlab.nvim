local M = {}

-- This module contains ways to open a buffer to matlab output. 
-- All opening function MUST return a tuple containing (output_window, output_buffer).

local default_split_width = 50
local default_split_height = 10

-- Utility function to set up output window.
M.setup_out_window = function (out_win)
    vim.api.nvim_win_set_option(out_win, "relativenumber", false)
    vim.api.nvim_win_set_option(out_win, "wrap", false)
end

M.split = function(height)
    local code_win = vim.api.nvim_get_current_win()
    vim.cmd("split")     -- spilt horizontally
    local out_win = vim.api.nvim_get_current_win()
    local out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(out_win, out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_height(out_win, height or default_split_height)         -- Sets the height
    M.setup_out_window(out_win)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return out_win, out_buf
end

M.splitdown = function(height)
    local out_win = vim.api.nvim_get_current_win()
    local code_buf = vim.api.nvim_get_current_buf()
    vim.cmd("split")     -- spilt horizontally
    local code_win = vim.api.nvim_get_current_win()
    local out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(code_win, code_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_buf(out_win, out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_height(out_win, height or default_split_height)         -- Sets the height
    M.setup_out_window(out_win)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return out_win, out_buf
end

M.vsplit = function(width)
    local code_win = vim.api.nvim_get_current_win()
    vim.cmd("vsplit")     -- spilt vertically
    local out_win = vim.api.nvim_get_current_win()
    local out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(out_win, out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_width(out_win, width or default_split_width)          -- Sets the width
    M.setup_out_window(out_win)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return out_win, out_buf
end

M.splitright = function(width)
    local out_win = vim.api.nvim_get_current_win()
    local code_buf = vim.api.nvim_get_current_buf()
    vim.cmd("vsplit")     -- spilt horizontally
    local code_win = vim.api.nvim_get_current_win()
    local out_buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(code_win, code_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_buf(out_win, out_buf)     -- sets the content op the split to be the new buffer
    vim.api.nvim_win_set_height(out_win, width or default_split_width)         -- Sets the height
    M.setup_out_window(out_win)
    vim.api.nvim_set_current_win(code_win)     -- put cursor back to the work buffer
    return out_win, out_buf
end

return M
