local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "markdown", "go" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  -- golang
  b.formatting.gofmt.with {filetypes = {"go"}},
  b.formatting.goimports.with {filetypes = {"go"}},
  b.diagnostics.golangci_lint.with {filetypes = {"go"}},
  b.code_actions.refactoring.with {filetypes = {"go"}}
}

null_ls.setup {
  debug = true,
  sources = sources,
}
