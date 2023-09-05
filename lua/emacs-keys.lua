local setup = function()
  local silent = {silent = true}
  local function split_mode(mode)
    local t = {}
    for i = 1, #mode do
      table.insert(t, string.sub(mode, i, i))
    end
    return t
  end
  local function km(mode, key, cmd, opt)
    return {
      mode = split_mode(mode),
      key = key,
      cmd = cmd,
      opt = opt or silent
    }
  end
  keymaps = {
    -- Remove ctrl x keybinding
    km('nicv', '<C-x>', '<Nop>'),
    -- Cancel
    km('cv', '<C-g>', '<Esc>'),
    km('i', '<C-g>', ''),
    -- Cursor Move
    km('niv', '<M-m>', '<C-o>^'),
    km('niv', '<C-a>', '<Home>'),
    km('niv', '<C-e>', '<End>'),
    km('niv', '<C-b>', '<Left>'),
    km('niv', '<M-b>', '<C-o>b'),
    km('niv', '<C-f>', '<Right>'),
    km('niv', '<M-f>', '<C-o>w'),
    km('niv', '<C-n>', '<Down>'),
    km('niv', '<C-p>', '<Up>'),
    km('i', '<C-v>', '<C-o><C-d>'),
    km('v', '<C-v>', '<C-d>'),
    km('i', '<M-v>', '<C-o><C-u>'),
    km('v', '<M-v>', '<C-u>'),
    -- Jump
    km('niv', '<M-g>', '<C-o>:', {}),
    km('niv', '<M-<>', '<C-o>gg'),
    km('niv', '<M->>', '<C-o>G'),
    -- Delete
    km('iv', '<C-d>', '<Del>'),
    km('iv', '<M-d>', '<C-o>dw'),
    km('iv', '<C-h>', '<C-o>db'),
    km('i', '<C-k>', function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()
      if #line <= col then
        return "<C-o>gJ"
      else
        return "<C-o>d$"
      end
    end, {silent = true, expr = true}),
    km('v', '<C-k>', 'd'),
    km('v', '<BS>', '<Del>'),
    km('iv', '<M-^>', '<C-o>k<C-o>J<C-o>a'),
    -- Copy / Paste
    km('v', '<C-w>', 'd'),
    km('v', '<M-w>', 'y'),
    km('niv', '<C-y>', ' <BS><C-o>p'),
    -- Selection
    km('i', '<C-space>', '<C-o>v'),
    km('v', '<C-space>', '<Esc>'),
    km('i', '<C-@>', '<C-o>v'),
    km('v', '<C-@>', '<Esc>'),
    -- Undo / Redo
    km('niv', '<C-x>u', '<C-o>u', silent),
    km('niv', '<C-/>', '<C-o>u', silent),
    km('niv', '<C-_>', '<C-o>u', silent),
    km('niv', '<C-?>', '<C-r>', silent),
    -- Search
    km('i', '<C-s>', '<C-o>/', {}),
    km('v', '<C-s>', '<C-o>:/', {}),
    -- Window split
    km('niv', '<C-x>1', '<cmd>only<cr>'),
    km('niv', '<C-x>2', '<C-w>s'),
    km('niv', '<C-x>3', '<C-w>v'),
    km('niv', '<C-x>o', '<C-w><C-w>'),
    -- Command
    km('niv', '<M-x>', '<C-o>:'),
    -- Files
    km('niv', '<C-x><C-s>', '<cmd>w<cr>'),
    km('niv', '<C-x><C-b>', '<cmd>buffers<cr>'),
    km('niv', '<C-x><C-f>', '<C-o>:e '),
    km('niv', '<C-x><C-w>', '<C-o>:w '),
    km('niv', '<C-x>b', '<C-o>:b '),
    km('niv', '<C-x><C-c>', '<cmd>:q<cr>'),
  }
  for _, v in ipairs(keymaps) do
    vim.keymap.set(v.mode, v.key, v.cmd, v.opt)
  end
end

return {
  setup = setup,
}
