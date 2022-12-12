Starline = { }

local mod_mode = require("starline.modules.mode")
local refresh_ignore = {"NvimTree"}

Starline.refresh = function()
  return table.concat {
    "%#Statusline#",
    mod_mode.mode(),
  }
end

local should_refresh = function()
  for _, v in pairs(refresh_ignore) do
    if vim.bo.filetype == v then
      vim.cmd("setlocal statusline=Dissabled")
      return
    end
  end

  vim.cmd("setlocal statusline=%!v:lua.Starline.refresh()")
end

local starline_ag = vim.api.nvim_create_augroup("Starline", { clear = false })
vim.api.nvim_create_autocmd("BufEnter", {
  group = starline_ag, pattern = "*",
  callback = function()
    should_refresh();
  end
})
