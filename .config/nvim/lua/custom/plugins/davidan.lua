-- disable netrw (vim's built-in file browser)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- my own key mapping
vim.keymap.set("n", ",f", ":NvimTreeToggle<CR>")
vim.keymap.set("n", ",q", ":q!<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jwj", "<Esc>:w<CR>")
vim.keymap.set("n", "tl", ":tabn<CR>")
vim.keymap.set("n", "th", ":tabp<CR>")
vim.keymap.set("n", ",g", "<C-w><C-w>", { desc = "Move focus to the next available window" })
vim.keymap.set("n", "zh", ":tabprevious<CR>", { desc = "Show the previous tab" })
vim.keymap.set("n", "zl", ":tabnext<CR>", { desc = "Show the next tab" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Get out of edit mode" })
vim.keymap.set("i", "jwj", "<Esc>:w<CR>", { desc = "Quick save" })

-- This will allow nvim to close the tab when you close a buffer but nvim-tree is open
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("quit")
		end
	end,
})

return {
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				actions = {
					open_file = {
						quit_on_open = false,
					},
				},
			})
		end,
	},
}
