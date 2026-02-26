-- 기본 설정
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.mapleader = " "

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- 모든 언어에서 2칸 강제 (filetype 설정 덮어쓰기)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.indentexpr = ""  -- 언어별 indent 규칙 무시
  end,
})

--enable clipboard
vim.opt.clipboard = "unnamedplus"
