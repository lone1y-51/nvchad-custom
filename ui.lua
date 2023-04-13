local fn = vim.fn

local M = {}
M.statusline = {
      separator_style = "round",
      overriden_modules = function()
          local st_modules = require "nvchad_ui.statusline.default"
          --
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

              return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. ""
          end;


          -- return st_modules;
          return {
            mode = function ()
               return st_modules.mode()
            end
          }
      end
 }

return M
