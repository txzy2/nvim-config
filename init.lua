-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Глобальные LSP keymaps для всех языков
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Перейти к определению (g d)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = bufnr, desc = "Go to definition" })

    -- Перейти к объявлению (g D)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, { buffer = bufnr, desc = "Go to declaration" })

    -- Показать реализацию (g i)
    vim.keymap.set(
      "n",
      "gi",
      function() vim.lsp.buf.implementation() end,
      { buffer = bufnr, desc = "Go to implementation" }
    )

    -- Найти references (g r)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { buffer = bufnr, desc = "Find references" })

    -- Показать документацию (K)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = bufnr, desc = "Show documentation" })

    -- Переименовать (space r n)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "Rename symbol" })

    -- Code actions (space c a)
    vim.keymap.set(
      "n",
      "<leader>ca",
      function() vim.lsp.buf.code_action() end,
      { buffer = bufnr, desc = "Code actions" }
    )

    -- Диагностика (space d)
    vim.keymap.set(
      "n",
      "<leader>d",
      function() vim.diagnostic.open_float() end,
      { buffer = bufnr, desc = "Show diagnostics" }
    )
  end,
})

vim.api.nvim_create_user_command("NoFormatPHP", function()
  vim.api.nvim_clear_autocmds {
    event = "BufWritePre",
    pattern = "*.php",
  }
  print "Format on save disabled for PHP"
end, {})

require "lazy_setup"
require "polish"
