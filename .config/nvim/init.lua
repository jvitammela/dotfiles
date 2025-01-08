-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.g.coq_settings = {
        auto_start = 'shut-up',
        -- Your COQ settings here
        clients = {
          lsp = {
            enabled = true,
          },
          tree_sitter = {
            enabled = true,
            weight_adjust = 1.0
          },
          tabnine = {
            enabled = false,
          },
          snippets = {
            user_path = '/home/mte90/.config/nvim/lua/coq-user-snippets',
            weight_adjust = 2
          },
    },
}

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
      {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", tag = "v0.9.2"},
      {"neovim/nvim-lspconfig", tag = "v0.1.8"},
      {"ms-jpq/coq_nvim"},
      -- kusinven vitun javascript paskakasa
      --{"neoclide/coc.nvim", branch = "release" },
      {"sheerun/vim-polyglot", tag = "v4.17.1"},
      ----{"williamboman/mason.nvim", tag = "v1.10.0"},
      ----{"williamboman/mason-lspconfig.nvim", tag = "v1.30.0"}
      --
      { "ms-jpq/coq_nvim", branch = "coq" },
      -- 9000+ Snippets
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
      -- Need to **configure separately**
      { 'ms-jpq/coq.thirdparty', branch = "3p" },
      { "EdenEast/nightfox.nvim" } -- lazy
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})



require'coq'

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  --ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "yaml", "awk", "json", "passwd", "python", "terraform", "xml" },
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "awk", "json", "python", "terraform", "xml" },
  --ensure_installed = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript", "yaml" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

--require'lspconfig'.terraform_lsp.setup{}
--
--require('lspconfig').yamlls.setup {
--  ... -- other configuration for setup {}
--  settings = {
--    yaml = {
--      ... -- other settings. note this overrides the lspconfig defaults.
--      schemas = {
--        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
--        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
--        ["/path/from/root/of/project"] = "/.github/workflows/*",
--      },
--    },
--  }
--}

require'lspconfig'.ansiblels.setup{}
--require'lspconfig'.pyls.setup{}
--require'lspconfig'.pylsp.setup{}
--

require'nightfox'

vim.cmd("colorscheme carbonfox")
