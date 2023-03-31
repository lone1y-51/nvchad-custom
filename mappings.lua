---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["Tab"] = ""
  }
}

M.general = {
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
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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
  },
}

-- more keybinds!

return M
