-- 重啟 LSP 並重置當前診斷
local function restart_lsp(msg)
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.INFO)
    vim.cmd("lsp restart")
    vim.diagnostic.reset(nil, 0)
  end)
end

-- C/C++ CMake 專案整合
return {
  "Civitasv/cmake-tools.nvim",
  ft = { "c", "cpp", "cmake" },
  cmd = {
    "CMakeGenerate", "CMakeBuild", "CMakeClean",
    "CMakeRunCurrentFile", "CMakeQuickRun", "CMakeDebugCurrentFile",
  },
  keys = {
    { "<leader>Cg", function()
        -- CMake 產生建置系統後自動重啟 LSP，讓 clangd 讀取最新的 compile_commands.json
        require("cmake-tools").generate({}, function()
          restart_lsp("CMake Generated! Restarting LSP...")
        end)
      end, desc = "CMake Generate & Refresh LSP" },
    { "<leader>Cb", "<cmd>CMakeBuild<CR>", desc = "CMake Build" },
    { "<leader>CB", "<cmd>CMakeBuild!<CR>", desc = "CMake Clean Build" },
    { "<leader>Cc", "<cmd>CMakeClean<CR>", desc = "CMake Clean" },
    { "<leader>Ct", "<cmd>CMakeSelectBuildType<CR>", desc = "CMake Select Build Type" },
    { "<leader>Cr", "<cmd>CMakeRunCurrentFile<CR>", desc = "CMake Run Current File" },
    { "<leader>Cq", "<cmd>CMakeQuickRun<CR>", desc = "CMake Quick Run" },
    { "<leader>Cd", "<cmd>CMakeDebugCurrentFile<CR>", desc = "CMake Debug Current File" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    local build_directory = function()
      -- 用 build type 分開 Debug / Release 的建置目錄
      return "out/${variant:buildType}"
    end

    require("cmake-tools").setup({
      cmake_build_directory = build_directory,

      -- 讓專案根目錄永遠有一份 compile_commands.json，clangd 才能穩定找到
      cmake_compile_commands_options = {
        action = "copy", -- 直接複製到專案根目錄，保持一份最新的 compile_commands.json
        target = vim.fn.getcwd, -- 注意：此設定在 cmake-tools 中規範必須為目錄路徑或回傳目錄路徑的 function
      },

      -- 預設在產生建置系統時輸出 compile_commands.json，方便 clangd / LSP 使用
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_executor = {
        -- configure / build 這類命令用 quickfix 顯示輸出，方便檢查錯誤
        name = "quickfix",
        opts = {
          show = "always",
          position = "belowright",
          size = 10,
          encoding = "utf-8",
          auto_close_when_success = true,
        },
      },
      cmake_runner = {
        -- 執行目標程式時使用終端機，適合互動式輸入與觀察輸出
        name = "terminal",
        opts = {
          name = "Runner Terminal",
          prefix_name = "[CMakeTools]: ",
          split_direction = "horizontal",
          split_size = 11,
          single_terminal_per_instance = true,
          single_terminal_per_tab = true,
          keep_terminal_static_location = true,
          auto_resize = true,
          start_insert = false,
          focus = false,
          do_not_add_newline = false,
          use_shell_alias = false,
        },
      },
    })
  end,
}