-- <leader> is a space now
local map = vim.keymap.set
local cmd = vim.cmd

-- unmaps
map({ "n" }, "gg", "")
map({ "n", "v" }, "yy", "")
map({ "n", "v" }, "dd", "")
map({ "v" }, "d", "")

-- mappings that require me to unlearn muscle memory
map({ "n", "v" }, "gl", "gg", { desc = "Go to beginning of file" })
map({ "n" }, "dl", "dd", { desc = "Delete line" })
map({ "n", "v" }, "yl", "yy", { desc = "Yank line" })

-- <leader>q to close buffer
map("n", "<leader>q", ":bd<CR>", { desc = "Close buffer and write" })
map("n", "<leader>Q", ":wq<CR>", { desc = "Close window and write" })

-- Better word navigation
map("n", "<leader>l", "$", { desc = "Jump to end of line" })
map("n", "<leader>h", "0", { desc = "Jump to beginning of line" })

-- Exit with kk
map("i", "kk", "<ESC>", { desc = "Exit insert mode" })

-- Buffer navigation
map("n", "<leader>bn", ":bn<CR>", { desc = "Jump to next buffer" })
map("n", "<leader>bb", ":bp<CR>", { desc = "Jump to previous buffer" })

-- Split navigation
-- May or may not use cuz its finnicky as hell
map("n", "<leader>sh", "<C-w>h", { desc = "Switch window left" })
map("n", "<leader>sj", "<C-w>j", { desc = "Switch window right" })
map("n", "<leader>sk", "<C-w>k", { desc = "Switch window up" })
map("n", "<leader>sl", "<C-w>l", { desc = "Switch window down" })

-- Scroll
map("n", "<C-s>", "<C-u>", { desc = "Scroll up" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>pf", builtin.find_files, { desc = "Open Telescope to find files" })
map("n", "<leader>pg", builtin.live_grep, { desc = "Open Telescope to do live grep" })
map("n", "<leader>pb", builtin.buffers, { desc = "Open Telescope to list buffers" })
map("n", "<leader>ph", builtin.help_tags, { desc = "Open Telescope to show help" })
map("n", "<leader>po", builtin.oldfiles, { desc = "Open Telescope to list recent files" })
map("n", "<leader>cm", builtin.git_commits, { desc = "Open Telescope to list git commits" })

-- Oil
map("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil buffer" }) -- open/close

-- LSP
map(
  "n",
  "<leader>gm",
  function() require("conform").format { lsp_fallback = true } end,
  { desc = "General Format file" }
)
map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })

-- Global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic loclist" })

-- Terminal
map("n", "tt", function()
  local height = math.floor(vim.o.lines / 2)
  cmd("belowright split | resize " .. height .. " | terminal fish")
end, { desc = "Terminal: vertical split", noremap = true, silent = true })

map("n", "tb", ":term<CR>", { desc = "Terminal: new buffer", noremap = true, silent = true })

-- Insert current file name (no extension, hyphens removed, words capitalized) at cursor
local function insert_file_title()
  local name = vim.fn.expand "%:t:r" -- tail (file name) with extension removed
  if name == "" then
    vim.notify("Buffer has no file name", vim.log.levels.WARN)
    return
  end

  -- Split on hyphens, capitalize the first letter of each word, join with no separator
  local words = {}
  for word in name:gmatch "[^-]+" do
    table.insert(words, (word:gsub("^%l", string.upper)))
  end
  local result = table.concat(words, " ")

  vim.api.nvim_put({ result }, "c", false, true)
end

map("n", "<leader>fn", insert_file_title, { desc = "Insert file name as PascalCase" })

-- Set the current line as a markdown heading; the count is the level (2hl -> ##)
local function set_heading()
  local level = vim.v.count1
  local line = vim.api.nvim_get_current_line()

  -- Strip any existing heading markers so repeated use changes the level
  local text = line:gsub("^#+%s*", "")
  local new_line = string.rep("#", level) .. " " .. text
  vim.api.nvim_set_current_line(new_line)

  -- Keep the cursor on the same character
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_win_set_cursor(0, { row, math.max(0, col + #new_line - #line) })
end

map("n", "hl", set_heading, { desc = "Set markdown heading level" })

