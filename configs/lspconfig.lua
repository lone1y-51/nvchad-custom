local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "gopls", "pylsp","jsonls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function (client, bufnr)
        on_attach(client, bufnr)
        print(client)

          client.server_capabilities.document_formatting = true
          client.server_capabilities.document_range_formatting = true

          if client.server_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
           end
      end,

    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
