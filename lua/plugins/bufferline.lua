-- bufferline.nvim: 頂端 Buffer 標籤列
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      diagnostics = "nvim_lsp",          -- 顯示 LSP 診斷資訊
      show_buffer_icons = true,          -- 始終顯示圖示
      offsets = {
        {
          filetype = "NvimTree",         -- 為檔案樹預留空間
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}