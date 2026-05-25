-- 設定 LSP 客戶端
return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",      -- 打開檔案後才載入
  dependencies = {
    "williamboman/mason-lspconfig.nvim",  -- 確保 mason 已載入
    "hrsh7th/cmp-nvim-lsp",               -- 為了 capabilities（維持原始 nvim-cmp 依賴）
  },
  config = function()
    -- ========== Neovim LSP 診斷顯示設定 ==========
    vim.diagnostic.config({
      signs = { text = { error = "●", warn = "●", info = "●", hint = "●" } },
      virtual_text = { prefix = "●", spacing = 4, source = "if_many" },
      underline = true,
      severity_sort = true,
      update_in_insert = true,
    })

    -- ========== 波浪線高亮 ==========
    vim.cmd.highlight("DiagnosticUnderlineError", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineWarn", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineInfo", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineHint", "gui=undercurl")

    -- ========== LSP 通用能力 (使用 nvim-cmp 的 lsp 來源) ==========
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local project_root = vim.fn.getcwd()

    -- ========== 自動設定其他透過 Mason 安裝的伺服器 ==========
    for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
      local server_config = { capabilities = capabilities }
      if server == "jdtls" then  else
          goto continue   -- 跳過 jdtls，由 nvim-jdtls 單獨處理
      end
      if server == "clangd" then
        server_config.cmd = {
          "clangd",
          "--background-index",
          "--compile-commands-dir=" .. project_root,
        }
      end

      vim.lsp.config(server, server_config)
      vim.lsp.enable(server)
      ::continue::
    end

    -- ========== 通用 LSP 快捷鍵 ==========
    local keymap = vim.keymap
    -- 設定 Vim 快速鍵: 顯示遊標下程式碼的懸停文件。
    keymap.set("n", "<leader>ch", function() require("pretty_hover").hover() end, { desc = "[C]ode [H]over Documentation" })
    
    -- 設定 Vim 快速鍵: 跳轉到遊標下程式碼的定義位置。
    keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
    
    -- 設定 Vim 快速鍵: 在普通模式和視覺模式下顯示代碼診斷的操作建議。
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
    
    -- 設定 Vim 快速鍵: 顯示游標下程式碼的參考 (references)
    keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
    
    -- 設定 Vim 快速鍵: 顯示游標下程式碼的實作 (implementations)
    keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
    
    -- 設定 Vim 快速鍵: 重新命名游標下的符號
    keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
    
    -- 設定 Vim 快速鍵: 跳至專案中該程式碼/物件被宣告的位置（宣告處）
    keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
    
    -- 設定 Vim 快速鍵: 格式化當前文件
    keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "[C]ode [F]ormat" })

    -- 診斷與格式化
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
    keymap.set("n", "[ d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
    keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
    
  end
}