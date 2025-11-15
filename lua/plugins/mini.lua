return { -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-mini/mini.files',
    version = '*',
    keys = {
      {
        '<leader>ee',
        function()
          require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (directory of current file)',
      },
      {
        '<leader>eE',
        function()
          require('mini.files').open(vim.uv.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
      },
      {
        '<leader>er',
        function()
          local MiniFiles = require 'mini.files'

          -- Projekt-Root ermitteln (Git / LSP / Marker / CWD)
          local function project_root()
            local uv = vim.uv or vim.loop
            local bufname = vim.api.nvim_buf_get_name(0)
            local start = (bufname ~= '' and vim.fs.dirname(bufname)) or uv.cwd()
            local markers = { '.git', 'package.json', 'pyproject.toml', 'Cargo.toml', 'go.mod' }

            -- 1) Git
            local git = vim.fs.find('.git', { path = start, upward = true })[1]
            if git then
              return vim.fs.dirname(git)
            end

            -- 2) LSP root_dir / workspace_folders
            for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
              local wf = client.config.workspace_folders
              if wf and wf[1] and wf[1].uri then
                return vim.uri_to_fname(wf[1].uri)
              end
              if client.config.root_dir then
                return client.config.root_dir
              end
            end

            -- 3) Marker
            local m = vim.fs.find(markers, { path = start, upward = true })[1]
            if m then
              return vim.fs.dirname(m)
            end

            -- 4) Fallback: CWD
            return uv.cwd()
          end

          MiniFiles.open(project_root(), true) -- true = Fokus auf Datei-Liste
        end,
        desc = 'Open mini.files (root).',
      },
    },
    config = function() end,
  },
}
