local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },


  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    opts = overrides.telescope,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp(),
  },
  {
    "NvChad/ui",
    lazy = false,
  },
    {
      "NvChad/nvim-colorizer.lua",
      opts = {
            user_default_options = {
                names = false,
            }
        }
    },

  -- Install a plugin
  {
    "phaazon/hop.nvim",
    lazy = false,
    branch = "v1",
    config = function()
      require'hop'.setup()
    end,
  },
  {
    "onsails/lspkind-nvim",
    lazy = false,
  },
  -- {
  --   "fatih/vim-go",
  --   lazy = false,
  -- },
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "nsf/gocode",
    tag = "v.20150303",
    rtp = "vim",
    lazy = false,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  }

}

return plugins
