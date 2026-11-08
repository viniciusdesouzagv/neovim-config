local neowiki = require("neowiki")

neowiki.setup({
  wiki_dirs = {
    { name = "Default", path = "~/wiki/" },
  },

  index_file = "README.md",
})

vim.keymap.set("n", "<leader>ww", function() neowiki.open_wiki() end, { desc = "Neowiki: Open Wiki" })
vim.keymap.set("n", "<leader>wf", function() neowiki.open_wiki_floating() end,
  { desc = "Neowiki: Open Wiki in a floating window" })
