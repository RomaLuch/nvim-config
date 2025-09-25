-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

require('nvim-web-devicons').setup {
    default = true; -- Включить иконки по умолчанию
}

require("nvim-tree").setup()

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true
})

require('lualine').setup()

-- Подключение lspconfig
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

local jdtlsKeyMap = require("configs.jdtlsKeyMap")
-- Кастомная настройка jdtls
if not configs.jdtls then
  configs.jdtls = {
    default_config = {
      cmd = {
        os.getenv("JDTLS_HOME") .. "/bin/jdtls",
	'-data',
	'/tmp/jdtls'
      },
      filetypes = { 'java' },
      root_dir = lspconfig.util.root_pattern('pom.xml', 'build.gradle', '.git'),
      settings = {},
      on_attach = function(client, bufnr)
        jdtlsKeyMap.setup(bufnr)
      end,
    }
  }
end

-- Запуск jdtls

lspconfig.jdtls.setup {}

require('configs.cmp')
require("configs.luasnip")
