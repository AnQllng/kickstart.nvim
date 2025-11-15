require('lazy').setup {
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  { import = 'plugins' },
  -- {
  -- ui = {
  -- -- If you are using a Nerd Font: set icons to an empty table which will use the
  -- -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
  -- icons = vim.g.have_nerd_font and {} or {
  -- cmd = '⌘',
  -- config = '🛠',
  -- event = '📅',
  -- ft = '📂',
  -- init = '⚙',
  -- keys = '🗝',
  -- plugin = '🔌',
  -- runtime = '💻',
  -- require = '🌙',
  -- source = '📄',
  -- start = '🚀',
  -- task = '📌',
  -- lazy = '💤 ',
  -- },
  -- },
  -- },
}
