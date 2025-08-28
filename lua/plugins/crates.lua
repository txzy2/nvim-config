return {
  {
    "saecki/crates.nvim",
    ft = "toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"

      -- Добавляем crates source для TOML файлов
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources or {}, {
        { name = "crates", filetypes = { "toml" } },
      }))

      return opts
    end,
  },
}
