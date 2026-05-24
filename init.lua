-- init.lua: Neovim 入口檔案
-- 載入核心設定和快捷鍵
require("config.options")
require("config.keymaps")

-- 自動安裝 lazy.nvim（如果不存在）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用穩定版
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim 配置選項
local opts = {
  change_detection = {
    -- 每次配置更改時不要通知
    notify = false,
  },
  checker = {
    -- 自動檢查軟體套件更新
    enabled = true,
    -- 每次有可用更新時不要發送大量通知
    notify = false,
  },
}

-- 載入 lua/plugins/ 目錄下的所有套件設定
require("lazy").setup("plugins", opts)