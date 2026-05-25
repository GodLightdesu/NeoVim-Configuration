-- 為不同層級的括號提供不同的顏色（基於 treesitter）
-- 依賴：nvim-treesitter（必須已安裝）
return {
  "HiPhish/rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- 使用全域變數來設定套件（不需要呼叫 setup 函數）
    vim.g.rainbow_delimiters = {
      -- 策略設定：指定套件的生效範圍
      -- '' 表示預設策略（全域）; vim 表示針對 vim 腳本使用更保守的本地策略
      strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
      },
      -- 查詢設定：指定每種語言使用哪個 treesitter 查詢檔案
      -- '' 表示預設查詢 "rainbow-delimiters"; lua 使用自訂的 "rainbow-blocks" 來支援區塊級括號
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      -- 優先級設定：數值越高，該語言的規則越優先（避免衝突）
      priority = {
        [''] = 110,
        lua = 210,
      },
      -- 顏色序列：按照括號嵌套層級依次循環使用這些顏色
      -- 這些高亮組需要你的主題支援
      highlight = {
        'RainbowDelimiterYellow',   -- 第1層（最外層）
        'RainbowDelimiterBlue',     -- 第2層
        'RainbowDelimiterOrange',   -- 第3層
        'RainbowDelimiterGreen',    -- 第4層
        'RainbowDelimiterViolet',   -- 第5層
        'RainbowDelimiterCyan',     -- 第6層（之後循環）
      },
    }
  end,
}