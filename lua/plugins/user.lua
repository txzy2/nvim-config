-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp", -- Ensure cmp is a dependency
    },
    config = function() require("codeium").setup {} end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup {
        overrides = {
          -- Делаем названия функций курсивом
          ["@function"] = { italic = true, bold = true },
          ["@function.builtin"] = { italic = true, bold = true },
          ["@method"] = { italic = true, bold = true },
          ["@constructor"] = { italic = true, bold = true },

          -- Также можно сделать курсивом другие элементы
          ["@parameter"] = { italic = true, bold = true },
          ["@comment"] = { italic = true, bold = true },
          ["@keyword"] = { italic = true, bold = true },
        },
      }

      -- Устанавливаем цветовую схему
      -- vim.cmd.colorscheme "gruvbox"
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    config = function() require("mason").setup() end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "eslint", "intelephense" },
      automatic_installation = true,
      -- ЯВНО отключаем обработчик для rust_analyzer
      handlers = {
        ["rust_analyzer"] = function() end, -- Пустая функция = отключаем
      },
    },

    config = function()
      require("mason-lspconfig").setup_handlers {
        -- Обработчик для intelephense
        ["intelephense"] = function() require("lspconfig").intelephense.setup {} end,
      }
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    -- ВАЖНО: Загружаем ПЕРЕД mason-lspconfig
    priority = 1000,
    init = function()
      -- Блокируем стандартную LSP конфигурацию ДО загрузки
      local lspconfig = require "lspconfig"
      if lspconfig.rust_analyzer then lspconfig.rust_analyzer.setup = function() end end
    end,
    config = function()
      local mason_bin_path = vim.fn.stdpath "data" .. "/mason/bin/rust-analyzer"

      vim.g.rustaceanvim = {
        server = {
          cmd = { mason_bin_path },
          standalone = true,
          on_attach = function(client, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function() vim.lsp.buf.format { bufnr = bufnr } end,
            })
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = { allFeatures = true },
            },
          },
        },
        tools = {
          hover_actions = { auto_focus = true },
        },
      }
    end,
  },

  -- ОСТАЛЬНЫЕ ПЛАГИНЫ ДОЛЖНЫ БЫТЬ ПОСЛЕ rustaceanvim
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function() require("dapui").setup() end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function() require("crates").setup() end,
  },

  -- В конфигурации LSP для intelephense
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          on_attach = function(client, bufnr)
            -- Отключаем format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                -- Не вызываем vim.lsp.buf.format()
                -- Просто ничего не делаем
              end,
            })
          end,
        },
      },
    },
  },
}
