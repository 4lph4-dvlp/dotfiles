return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      width = 32,
    }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.keymap.set('n', '<C-\\>', ':Neotree filesystem reveal left<CR>', {})
    vim.keymap.set('n', '<leader>\\', ':Neotree filesystem reveal left<CR>', {})
  end
}
