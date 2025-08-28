return {
  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    config = function()
      require("codeium").setup {
        -- Отключаем встроенные подсказки, используем только cmp
        disable_bindings = true,
        config = {
          key_bindings = {
            accept = "<Tab>", -- Tab для принятия в cmp меню
            next = "<C-l>",
          },
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "codeium",
        priority = 1000,
      })

      -- Настройка Tab для cmp меню
      opts.mapping = opts.mapping or {}
      opts.mapping["<Tab>"] = function(fallback)
        if require("cmp").visible() then
          require("cmp").confirm { select = true }
        else
          fallback() -- Обычный Tab
        end
      end

      return opts
    end,
  },
}
