local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end, { desc = "Harpoon: Add buffer to list" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = "Harpoon: Show buffers" })

vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: Switch to 1st buffer" })
vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: Switch to 2nd buffer" })
vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: Switch to 3rd buffer" })
vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: Switch to 4th buffer" })

vim.keymap.set("n", "<C-b>", function() harpoon:list():prev() end, { desc = "Harpoon: Jump to previous buffer in list" }
)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "Harpoon: Jump to next buffer in list" }
)
