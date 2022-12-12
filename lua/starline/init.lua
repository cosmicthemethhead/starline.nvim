M = { }

local mod_mode = require("starline.modules.mode")

M.refresh = function()
  return table.concat {
    "%#Statusline#",
    mod_mode.mode(),
  }
end

local starline_ag = vim.api.nvim_create_augroup("Starline", { clear = false })
vim.api.nvim_create_autocmd({"WinEnter ", "BufEnter"}, {
  group = starline_ag, pattern = "*",
  command = "setlocal statusline=%!v:lua.M.refresh()"
})
