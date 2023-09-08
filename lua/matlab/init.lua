local M = {}

-- Default configuration
M.config = {
    matlab_path = "matlab",
    splash = true,
    matlab_flags = {}
}

-- Overrides default configuration
M.setup = function (config)
    if config == nil then return end
    for k, v in pairs(config) do
        M.config[k] = v
    end
end

M.repl_job_id = nil
M.out_win, M.out_buf = nil, nil

local function start_REPL()
    if M.repl_job_id == nil then
        local dir = vim.fn.getcwd()
        local cmd = {
            M.config.matlab_path,
            "-nodesktop",
            "-sd " .. dir,
        }
        if not M.config.splash then
            table.insert(cmd, "-nosplash")
        end
        if type(M.config.matlab_flags) ~= "table" then
            error("ERROR: option `matlab_flags` should be a table.")
            return
        end
        for i, flag in pairs(M.config.matlab_flags) do
            print(i, flag)
            table.insert(cmd, flag)
        end
        M.repl_job_id = vim.fn.jobstart(cmd, {
            stout_buffered = true,
            on_stdout = function(_, data)
                if data then
                    if #data == 1 and data[1] == ">> " then
                        return
                    end

                    if data[1] == "" then
                        table.remove(data, 1)
                    end
                    vim.api.nvim_buf_set_lines(M.out_buf, -1, -1, false, data)
                end
            end,
            on_stderr = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(M.out_buf, -1, -1, false, data)
                end
            end,
            on_exit = function()
                print("Matlab stopped.")
            end
        })
    end
end

local function create_out_buffer()
    if M.out_win == nil or M.out_buf == nil then
        local code_win = vim.api.nvim_get_current_win()
        vim.cmd("vsplit") -- spilt vertically
        M.out_win = vim.api.nvim_get_current_win()
        M.out_buf = vim.api.nvim_create_buf(true, true)
        vim.api.nvim_win_set_buf(M.out_win, M.out_buf) -- sets the content op the split to be the new buffer
        vim.api.nvim_win_set_width(M.out_win, 70)      -- Sets the width
        vim.api.nvim_win_set_option(M.out_win, "relativenumber", false)
        vim.api.nvim_win_set_option(M.out_win, "wrap", false)
        vim.api.nvim_set_current_win(code_win) -- sætter curseren på coden igen
        return M.out_win, M.out_buf
    end
end

M.evaluate = function(input)
    create_out_buffer()
    start_REPL()
    vim.fn.chansend(M.repl_job_id, input .. "\n")
end

M.evaluate_current_file = function()
    local path = vim.fn.expand('%')
    M.evaluate_file(path)
end

M.evaluate_file = function(path)
    vim.cmd("w")
    local command = [[run("]] .. path .. [[")]]
    M.evaluate(command)
end

local function get_line(line_nr)
    return vim.api.nvim_buf_get_lines(0, line_nr - 1, line_nr, true)[1]
end

M.evaluate_lines = function(lines)
    for _, line in pairs(lines) do
        M.evaluate(line)
    end
end

M.evaluate_block = function()
    local curr_line_nr = vim.api.nvim_win_get_cursor(0)[1]

    local line_nr = curr_line_nr
    local line = get_line(line_nr)

    local title = nil

    while true do
        line = get_line(line_nr)
        if line_nr <= 0 then
            break
        end
        if string.match(line, [[%s*%%%%]]) then
            title = get_line(line_nr)
            line_nr = line_nr - 1
            break
        end
        line_nr = line_nr - 1
    end

    local block_start = line_nr

    line_nr = curr_line_nr + 1

    local line_count = vim.api.nvim_buf_line_count(0)

    while line_nr < line_count do
        line = get_line(line_nr)
        if string.match(line, [[%s*%%%%]]) then
            line_nr = line_nr - 1
            break
        end
        line_nr = line_nr + 1
    end

    local block_end = line_nr

    local lines = vim.api.nvim_buf_get_lines(0, block_start, block_end, false)

    if not title then
        title = vim.fn.expand("%")
    end

    create_out_buffer()
    vim.api.nvim_buf_set_lines(M.out_buf, 0, -1, false, { title })

    M.evaluate_lines(lines)
end

local function get_visual()
    local a_orig = vim.fn.getreg('a')
    vim.cmd([[silent! normal! "aygv]])
    local text = vim.fn.getreg('a')
    vim.fn.setreg('a', a_orig)
    return text
end

M.visual_evaluate = function()
    local text = get_visual()
    M.evaluate(text)
end

M.close = function()
    vim.api.nvim_buf_delete(M.out_buf, {}) -- deletes buffer (and its window)
    M.out_win, M.out_buf = nil, nil        -- unsets saved buffer and window id
    vim.fn.jobclose(M.repl_job_id)
    M.repl_job_id = nil
end

M.is_open = function()
    return M.repl_job_id ~= nil
end

M.open_variable_explorer = function()
    vim.fn.chansend(M.repl_job_id, "workspace\n")
end

return M
