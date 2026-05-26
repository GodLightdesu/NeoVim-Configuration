-- 語法高亮與程式碼解析
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",     -- 使用 main 分支
  build = ":TSUpdate", -- 自動更新解析器
  lazy = false,        -- 新版本要求禁用懶加載
  -- 優化性能: 目前不寫 TypeScript
  -- dependencies = {
  --   -- 利用 treesitter 來理解程式碼結構，從而自動關閉 tsx 標籤。
  --   "windwp/nvim-ts-autotag"
  -- },
  config = function()
    -- 1. 定義你想要支援的語言
    local languages = {
      "vim", "vimdoc", "bash", "c", "cpp", "java",
      "python", "typescript", "javascript", "json",
      "markdown", "markdown_inline", "gitignore",
      "lua", "html", "tsx", "css", "rust",
    }

    -- 2. 安裝解析器 (解析器本身是必須的)
    require("nvim-treesitter").install(languages)

    -- 2.5 啟用自動閉合 / 重新命名 HTML / JSX 標籤
    -- require("nvim-ts-autotag").setup({
    --   opts = {
    --     enable_close = true,
    --     enable_rename = true,
    --     enable_close_on_slash = false,
    --   },
    -- })

    -- 3. 為每種語言自動啟用 Tree-sitter 高亮 (這是核心)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = languages,
      callback = function(args)
        -- auto 啟用高亮
        vim.treesitter.start(args.buf)
      end,
    })
  end,
}