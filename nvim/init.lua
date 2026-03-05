-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Disable backup and swap files which trigger constant rclone syncing
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Write directly to the file instead of a temporary "new" file
vim.opt.backupcopy = "yes"

vim.diagnostic.enable(false)
