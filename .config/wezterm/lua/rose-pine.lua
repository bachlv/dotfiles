-- rose-pine
-- Copyright (c) 2022 rose-pine

-- repository: https://github.com/neapsix/wezterm
-- license: MIT

local M = {}

local palette = {
	base = "#191724",
	surface = "#1f1d2e",
	overlay = "#26233a",
	muted = "#6e6a86",
	text = "#e0def4",
	love = "#eb6f92",
	gold = "#f6c177",
	rose = "#ebbcba",
	pine = "#31748f",
	foam = "#9ccfd8",
	iris = "#c4a7e7",
	highlight_low = "#21202e",
	highlight_med = "#403d52",
	highlight_high = "#524f67",
	subtle = "#908caa",
}

function M.palette()
	return palette
end

local active_tab = {
	bg_color = palette.overlay,
	fg_color = palette.text,
}

local inactive_tab = {
	bg_color = palette.base,
	fg_color = palette.muted,
}

function M.colors()
	return {
		foreground = palette.text,
		background = palette.base,
		cursor_bg = palette.subtle,
		cursor_border = palette.text,
		cursor_fg = palette.base,
		selection_bg = palette.highlight_med,
		-- selection_fg = palette.text,

		ansi = {
			palette.overlay,
			palette.love,
			palette.foam,
			palette.gold,
			palette.pine,
			palette.iris,
			palette.rose,
			palette.text,
		},

		brights = {
			palette.muted,
			palette.love,
			palette.foam,
			palette.gold,
			palette.pine,
			palette.iris,
			palette.rose,
			palette.text,
		},

		tab_bar = {
			background = palette.base,
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = active_tab,
			new_tab = inactive_tab,
			new_tab_hover = active_tab,
			inactive_tab_edge = palette.muted, -- (Fancy tab bar only)
		},
	}
end

function M.window_frame() -- (Fancy tab bar only)
	return {
		active_titlebar_bg = palette.base,
		inactive_titlebar_bg = palette.base,
	}
end

return M
