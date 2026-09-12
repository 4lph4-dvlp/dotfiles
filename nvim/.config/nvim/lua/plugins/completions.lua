return {
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" }
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require'cmp'
      local luasnip = require('luasnip')
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.filetype_extend("verilog", { "systemverilog" })

      cmp.setup({
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<Up>'] = cmp.config.disable,
          ['<Down>'] = cmp.config.disable,
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },
}
