require('custom')

local M = {}

M.ui = {
  theme = "radium",
    changed_themes = {
        radium = {
            base_30 = {
                black = "#000000"
            },
            base_16 = {
                base00 = "#000000"
            }
        },
    },
}

M.plugins = {
    ["phaazon/hop.nvim"] = {
            branch = "v1",
            config = function()
                require'hop'.setup()
            end
        },
    ["onsails/lspkind-nvim"] = {},
    ["fatih/vim-go"] = {},
    ["nsf/gocode"] = {
        tag = "v.20150303",
        rtp = "vim",
    },
    ["neovim/nvim-lspconfig"] = {
     config = function()
      require "plugins.configs.lspconfig"
      local attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      local lspconfig = require "lspconfig"
      local servers = { "gopls", "pylsp","jsonls"}
      local on_attach = function (client, bufnr)
          attach(client, bufnr)

          client.server_capabilities.document_range_formatting = true

          if client.server_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
           end
        end

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end
     end,
    },
    ["NvChad/ui"] = {
      override_options = {
            statusline = {
                separator_style = "round",
                overriden_modules = function()
                    local st_modules = require "nvchad_ui.statusline.modules"
                    local fn = vim.fn
                    local sep_style = vim.g.statusline_sep_style
                    local separators = (type(sep_style) == "table" and sep_style)
                    or require("nvchad_ui.icons").statusline_separators[sep_style]
                    local sep_l = separators["left"]
                    local sep_r = separators["right"]

                    st_modules.fileInfo = function()
                        local icon = "  "
                        local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%:."

                        if filename ~= "Empty " then
                            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

                            if devicons_present then
                                local ft_icon = devicons.get_icon(filename)
                                icon = (ft_icon ~= nil and " " .. ft_icon) or ""
                            end

                            filename = " " .. filename .. " "
                        end

                        return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. sep_r
                    end;


                    return st_modules;
                end
           },
      }
        },
        ["lewis6991/gitsigns.nvim"] = {
      override_options = {
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 10,
            ignore_whitespace = false,
          },
          current_line_blame_formatter_opts = {
            relative_time = false
          },
        },
      },
        ["nvim-telescope/telescope.nvim"] = {
          override_options = {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        }
                    }
                }
            }
      },
      ["hrsh7th/nvim-cmp"] =  {
      override_options = function()
        local lspkind = require('lspkind')
        local cmp = require('cmp')
          return {
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
              }, { { name = 'buffer' },
                   { name = 'path' }
                }),
              formatting = {
                format = lspkind.cmp_format({
                  with_text = true,
                  maxwidth = 50,
                  before = function (entry, vim_item)
                    vim_item.menu = "["..string.upper(entry.source.name).."]"
                    return vim_item
                  end
                })
              },
              mapping = {
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
              }
      }
      end,
    },
      ["nvim-treesitter/nvim-treesitter"] = {
      override_options = {
          ensure_installed = {"vim", "lua", "go", "gomod", "gowork", "python","json","json5","markdown"},
          -- 启用代码高亮功能
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
          },
          -- 启用增量选择
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<CR>',
              node_incremental = '<CR>',
              node_decremental = '<BS>',
              scope_incremental = '<TAB>',
            }
          },
          -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
          indent = {
            enable = true
          }
      }
      },

    ["lukas-reineke/indent-blankline.nvim"] = {
         disable = true
    },
    ["nvim-telescope/telescope-ui-select.nvim"] = {
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
    ["stevearc/dressing.nvim"] = {}
}

M.mappings = {
  common = {
   i = {
     ["fd"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
   },
   v = {
     ["fd"] = { "<ESC>", "escape visual mode" , opts = { nowait = true }},

    ["<leader>;"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
   },
   t = {
        -- toggle in terminal mode
        ["<F12"] = {
          function()
            require("nvterm.terminal").toggle "float"
          end,
          "toggle floating term",
        },
    },
   n = {
    ["<leader>/"] = {"<cmd> Telescope live_grep <CR>", ""},
    ["<leader>rn"] = {"<cmd>lua vim.lsp.buf.rename()<CR>",""},
    ["<leader>gc"] = {"<cmd>:GoCoverageToggle<CR>",""},
   ['gd'] = {'<cmd>lua vim.lsp.buf.definition()<CR>',""},
   ['gh'] = {'<cmd>lua vim.lsp.buf.hover()<CR>', ""},
   ['gD'] = {'<cmd>lua vim.lsp.buf.declaration()<CR>', ""},
   ['gi'] = {'<cmd>lua vim.lsp.buf.implementation()<CR>', ""},
   ['gr'] = {'<cmd>lua vim.lsp.buf.references()<CR>', ""}, 
   ['gp'] = {'<cmd>lua vim.diagnostic.goto_prev()<CR>', ""},
   ['gn'] = {'<cmd>lua vim.diagnostic.goto_next()<CR>', ""},
   ["<leader>jw"] = {"<cmd> :HopWord<CR>", ""},
    ["<leader>;"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
    ["<leader>h"] = {"<C-w>h", ""},
    ["<leader>j"] = {"<C-w>j", ""},
    ["<leader>k"] = {"<C-w>k", ""},
    ["<leader>l"] = {"<C-w>l", ""},
    ["<F12>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
   }
  }
}

return M
