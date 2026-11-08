require("oil").setup({
  columns = {
    "icon",
    -- "size",
    -- "mtime,"
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = false,
  watch_for_changes = true,
  view_options = {
    show_hidden = true,
  }
})
