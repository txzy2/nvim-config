-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "astrodark",

    highlights = {
      init = { -- Глобальные настройки для всех тем
        -- Treesitter highlights для функций и методов - ЛАВАНДОВЫЙ
        ["@function"] = { italic = true, fg = "#b48ead" }, -- Лавандовый
        ["@function.builtin"] = { italic = true, fg = "#a3be8c" }, -- Зеленый для встроенных
        ["@method"] = { italic = true, fg = "#b48ead" }, -- Лавандовый
        ["@constructor"] = { italic = true, bold = true, fg = "#ebcb8b" }, -- Желтый для конструкторов

        -- LSP semantic tokens
        ["@lsp.type.function"] = { italic = true, fg = "#b48ead" }, -- Лавандовый
        ["@lsp.type.method"] = { italic = true, fg = "#b48ead" }, -- Лавандовый
        ["@lsp.type.class"] = { bold = true, fg = "#8fbcbb" }, -- Бирюзовый для классов
        ["@lsp.type.interface"] = { italic = true, fg = "#d08770" }, -- Оранжевый для интерфейсов

        -- Ключевые слова и параметры
        ["@keyword"] = { italic = true, fg = "#81a1c1" }, -- Синий
        ["@parameter"] = { italic = true, fg = "#d08770" }, -- Оранжевый
        ["@comment"] = { italic = true, fg = "#5a637d" }, -- Серый

        -- Переменные и константы
        ["@variable"] = { bold = true, fg = "#88c0d0" }, -- Нежно-мятный 🔥
        ["@constant"] = { bold = true, fg = "#8fbcbb" }, -- Бирюзовый
        ["@constant.builtin"] = { bold = true, italic = true, fg = "#bf616a" }, -- Красный
      },

      astrodark = { -- Специфичные настройки для astrodark
        -- Можно переопределить цвета вместе со стилями
        -- ["@function"] = { italic = true, fg = "#ffd700" },
        -- ["@method"] = { italic = true, fg = "#50fa7b" },
      },
    },

    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
