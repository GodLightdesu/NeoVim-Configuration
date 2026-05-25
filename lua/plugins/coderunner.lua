-- 一鍵執行程式碼
return {
  "CRAG666/code_runner.nvim",
  event = "BufReadPre", -- 打開檔案後才載入
  config = function()
    require("code_runner").setup({
      mode = "term",      -- 選擇在哪裡顯示執行結果
      focus = true,       -- 執行後自動聚焦到結果視窗
      startinsert = true, -- 在結果視窗啟動插入模式
      term = {
        position = "botright", 
        size = 8,
      },
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt"
        },
        c = {
          "cd $dir &&",
          "gcc $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt"
        },
        cpp = {
          "cd $dir &&",
          "g++ $fileName -o $fileNameWithoutExt &&",
          "$dir/$fileNameWithoutExt"
        },
        python = "python3 -u",
      },
    })

    -- 設定快捷鍵 (例如: <leader>r 代表 Run)
    vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run Code", noremap = true, silent = true })
  end,
}