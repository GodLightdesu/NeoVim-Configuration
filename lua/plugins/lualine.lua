-- 美觀的狀態列
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- 呼叫 setup 並設定 lualine 的外觀參數
		require("lualine").setup({
			options = {
				-- 若有安裝 nerdfont，顯示檔案圖示
				icons_enabled = true,
				-- 設定主題為 tomorrow_night（沒有與 kanagawa_paper 相符的lualine 主題）
				theme = "tomorrow_night",
				-- 使用分隔符將欄位區隔開
				component_separators = { left = "", right = "" },
				-- 使用三角分隔區塊
				section_separators = { left = "", right = "" },
				-- 在指定檔案類型中停用 statusline 與 winbar
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				-- 不在 NvimTree 視窗上啟用 lualine 的 focus
				ignore_focus = { "NvimTree" },
				-- 在中間分割 lualine 區域
				always_divide_middle = true,
				-- 關閉全域狀態列（僅在需要時啟用）
				globalstatus = false,
				-- 每 1000 毫秒更新一次顯示
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			-- Setup what each lualine section will contain
			-- 設定各區段內容（左側為 a，右側為 z）
			sections = {
				-- 在 a 區顯示目前的編輯模式
				lualine_a = { "mode" },
				-- 在 b 區顯示 git 分支、差異與診斷資訊
				lualine_b = { "branch", "diff", "diagnostics" },
				-- 在 c 區顯示檔名
				lualine_c = { "filename" },
				-- 在 x 區顯示檔案編碼、格式與檔案類型
				lualine_x = { "encoding", "fileformat", "filetype" },
				-- 在 y 區顯示目前在檔案中的進度
				lualine_y = { "progress" },
				-- 在 z 區顯示游標的精確位置
				lualine_z = { "location" },
			},
			-- Setup what each section will contain in inactive buffers
			inactive_sections = {
				-- 在非啟用視窗中，a 與 b 區留空
				lualine_a = {},
				lualine_b = {},
				-- 在 c 區顯示檔名
				lualine_c = { "filename" },
				-- 在 x 區顯示游標位置
				lualine_x = { "location" },
				-- 在 y 與 z 區留空
				lualine_y = {},
				lualine_z = {},
			},
			-- 使用預設設定作為 tabline、winbar、inactive winbar 與 extensions
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}

