-- ~/.config/nvim/lua/plugins/configs/fugitive.lua
-- This is loaded via M.configs in custom.lua, so it's a plain script,
-- not a lazy.nvim spec. The plugin itself is declared in custom.lua.

local map = function(lhs, rhs, desc, mode)
  vim.keymap.set(mode or "n", lhs, rhs, { silent = true, desc = desc })
end

map("<leader>gs", "<cmd>Git<cr>", "Git status")
map("<leader>gc", "<cmd>Git commit<cr>", "Git commit")
map("<leader>gp", "<cmd>Git push<cr>", "Git push")
map("<leader>gP", "<cmd>Git pull --rebase<cr>", "Git pull (rebase)")
map("<leader>gb", "<cmd>Git blame<cr>", "Git blame")
map("<leader>gd", "<cmd>Gvdiffsplit<cr>", "Git diff (vertical split)")
map("<leader>gl", "<cmd>Git log --oneline<cr>", "Git log")
map("<leader>gh", "<cmd>Gclog %<cr>", "File history (quickfix)")
map("<leader>gw", "<cmd>Gwrite<cr>", "Git add current file")
map("<leader>gr", "<cmd>Gread<cr>", "Git checkout current file")

local group = vim.api.nvim_create_augroup("FugitiveCustom", { clear = true })

-- Press `q` to close fugitive's status/blame/log buffers
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "fugitive", "fugitiveblame", "git" },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close" })
  end,
})

-- Hide line numbers in the fugitive status window
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "fugitive",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
