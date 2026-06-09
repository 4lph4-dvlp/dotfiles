return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- eslint_d는 none-ls-extras에서 로드되므로 수동 등록을 그대로 유지합니다.
          require("none-ls.diagnostics.eslint_d"),
        },
      })

      -- 🔹 Mason으로 설치한 포맷터/린터를 자동으로 none-ls에 등록
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "prettier", "black", "isort" },
        automatic_installation = true,
        handlers = {}, -- 빈 객체 전달 시 설치된 모든 도구를 자동으로 none-ls에 등록합니다.
      })

      vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
    end,
  },
}
