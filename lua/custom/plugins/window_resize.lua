local M = {}

function M.smart_resize(direction)
  local screen_w = vim.o.columns
  local screen_h = vim.o.lines
  local winnr = vim.api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo(winnr)[1]
  local delta = math.floor((direction == 'left' or direction == 'right') and screen_w or screen_h * 0.25)

  local cmd = ''
  if direction == 'up' then
    if wininfo.winrow > 1 then
      cmd = 'resize -' .. delta
    else
      cmd = 'resize +' .. delta
    end
  elseif direction == 'down' then
    if wininfo.winrow + wininfo.height < screen_h then
      cmd = 'resize +' .. delta
    else
      cmd = 'resize -' .. delta
    end
  elseif direction == 'left' then
    if wininfo.wincol > 1 then
      cmd = 'vertical resize -' .. delta
    else
      cmd = 'vertical resize +' .. delta
    end
  elseif direction == 'right' then
    if wininfo.wincol + wininfo.width < screen_w then
      cmd = 'vertical resize +' .. delta
    else
      cmd = 'vertical resize -' .. delta
    end
  end

  vim.cmd(cmd)
end

return M
