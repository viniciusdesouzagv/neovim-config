local zen = require("zen-mode")

vim.keymap.set('n', '<leader>r', function()
  zen.toggle({
    window = {
      width = .50,
      height = 1,
    },
    options = {
      number = false,
      relativenumber = false,
    },
    plugins = {
      twilight = { enabled = true }
    }
  })
end, { desc = "Zen-mode: Toggle zen mode" })
