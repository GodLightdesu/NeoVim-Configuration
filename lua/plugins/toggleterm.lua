-- toggleterm.nvim: 終端機管理套件
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- 按下 Ctrl + \ 來開啟/關閉終端機
      direction = "float", -- 浮動視窗，也可以設定 "horizontal", "vertical"
      float_opts = {
        border = "curved", -- 浮動視窗的邊框樣式
      },
    })
  end,
}