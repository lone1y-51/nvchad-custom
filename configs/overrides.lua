local M = {}

M.treesitter = {
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

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = false,
  },
  view = {
    width = 40,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.gitsigns = {
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
}

M.telescope = {
  defaults = {
      mappings = {
          i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
          }
      }
  }
}

M.cmp = function ()
    -- local lspkind = require('lspkind')
    local cmp = require('cmp')
      return {
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, { { name = 'buffer' },
               { name = 'path' }
            }),
          -- formatting = {
          --   format = lspkind.cmp_format({
          --     with_text = true,
          --     maxwidth = 50,
          --     before = function (entry, vim_item)
          --       vim_item.menu = "["..string.upper(entry.source.name).."]"
          --       return vim_item
          --     end
          --   })
          -- },
          mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                    local copilot_keys = vim.fn["copilot#Accept"]()
                    -- local copilot_keys = ''
                    if copilot_keys ~= "" and type(copilot_keys) == "string" then
                        vim.api.nvim_feedkeys(copilot_keys, "i", true)
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(
                            vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                            ""
                        )
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
          }
  }
end

M.uiplugin = {
  statusline = {
      separator_style = "round",
      overriden_modules = function()
          local st_modules = require "nvchad_ui.statusline.modules"
          local fn = vim.fn
          local sep_style = vim.g.statusline_sep_style
          local separators = (type(sep_style) == "table" and sep_style)
          or require("nvchad_ui.icons").statusline_separators[sep_style]
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

return M
