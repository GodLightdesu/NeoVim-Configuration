-- 強大的模糊搜尋工具
return {
{ -- Telescope
  "nvim-telescope/telescope.nvim", 
  version = "*", 
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- 可選但建議安裝（提供更快的 fzf 效能）
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    -- 使用望遠鏡內建功能
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap  -- <leader> 是空格鍵，這裡用於觸發搜尋功能
    -- 依檔名搜尋檔案
    keymap.set("n", "<leader>ff", builtin.find_files, {desc = "[F]ind [F]iles"})
    -- 依內容搜尋檔案
    keymap.set("n", "<leader>fg", builtin.live_grep, {desc = "[F]ind by [G]rep"})
    -- 搜尋游標下的單字 (跨檔案)
    keymap.set("n", "<leader>fw", builtin.grep_string, {desc = "[F]ind current [W]ord"})
    -- 搜尋當前檔案內容
    keymap.set("n", "<leader>f/", builtin.current_buffer_fuzzy_find, {desc = "[F]ind word in current file"})
    -- 搜尋診斷資訊
    keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
    -- 恢復上一次的搜尋
    keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]inder [R]esume" })
    -- 搜尋最近使用的檔案
    keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "[F]ind Recent Files (\".\" for repeat)" })
    -- 搜尋開啟的緩衝區
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind Existing [B]uffers" })

    -- 設置 Telescope 並加載 fzf 擴展，關閉模糊匹配（精確匹配模式）
    require("telescope").setup({
      -- 可選：全局默認設置（保留原樣）
      defaults = {
        -- 如果希望所有 picker 都使用 fzf 排序器且精確匹配，可以在這裡設置 sorter
        -- 但因為會通過擴展配置，所以 defaults 留空或保持原樣
      },
      -- 擴展配置
      extensions = {
        -- fzf 擴展：關閉模糊匹配，啟用精確匹配模式
        fzf = {
          fuzzy = false,                  -- 禁用模糊匹配，變成精確匹配模式
          case_mode = "smart_case",       -- 大小寫敏感模式（若查詢含大寫則區分大小寫）
          override_generic_sorter = true, -- 使用 fzf 排序器替代默認排序器
          override_file_sorter = true,    -- 使用 fzf 排序器替代默認文件排序器
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        }
      },
      -- 快捷鍵映射
      mappings = {
        i = {
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
        }
      }
    })

    -- 加載擴展
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end
},
{ -- telescope-ui-select 擴充
  "nvim-telescope/telescope-ui-select.nvim",
  event = "VeryLazy",
  config = function()
    -- 此擴展的配置已在上面的 telescope.setup 中完成，這裡留空或直接返回
    -- 但為了保持插件結構完整，我們保留這個條目，不需要額外操作
  end
}
}