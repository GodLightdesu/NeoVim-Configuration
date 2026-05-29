-- configuration goes here
local configuration = {
  ---@type string
  arg = "leetcode.nvim",

  ---@type lc.lang
  lang = "java",

  cn = { -- leetcode.cn
    enabled = false, ---@type boolean
    translator = true, ---@type boolean
    translate_problems = true, ---@type boolean
  },
}

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = configuration,
  config = function(_, opts)
    require("leetcode").setup(opts)
    local map = vim.keymap.set
    map("n", "<leader>Lm", "<cmd>Leet<CR>",         { desc = "[L]eet [M]enu" })
    map("n", "<leader>Lr", "<cmd>Leet run<CR>",     { desc = "[L]eet [R]un" })
    map("n", "<leader>Ls", "<cmd>Leet submit<CR>",  { desc = "[L]eet [S]ubmit" })
    map("n", "<leader>Ld", "<cmd>Leet desc<CR>",    { desc = "[L]eet toggle [d]escription" })
    map("n", "<leader>Ll", "<cmd>Leet list<CR>",    { desc = "[L]eet [l]ist problems" })
    map("n", "<leader>Li", "<cmd>Leet info<CR>",    { desc = "[L]eet [I]nfo " })
    map("n", "<leader>Lh", "<cmd>Leet hints<CR>",   { desc = "[L]eet [H]ints" })
    map("n", "<leader>Lt", "<cmd>Leet test<CR>",    { desc = "[L]eet [T]est" })
    map("n", "<leader>Lc", "<cmd>Leet console<CR>", { desc = "[L]eet [C]onsole" })
    map("n", "<leader>LL", "<cmd>Leet lang<CR>",    { desc = "[L]eet [L]ang" })
    map("n", "<leader>LD", "<cmd>Leet daily<CR>",   { desc = "[L]eet [D]aily" })
    map("n", "<leader>Lx", "<cmd>Leet reset<CR>",   { desc = "[L]eet [R]eset" })
    map("n", "<leader>Le", "<cmd>Leet exit<CR>",    { desc = "[L]eet [E]xit" })
  end,
}