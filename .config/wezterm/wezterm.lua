local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local palette = require("lua/rose-pine").palette()

local config = {
	colors = colors,
	font = wezterm.font_with_fallback({ "SF Mono", "Symbols Nerd Font" }),
	font_size = 13,
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font_with_fallback({
				{
					family = "SF Mono",
					weight = "Bold",
				},
				"Symbols Nerd Font",
			}),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "SF Mono",
				weight = "Bold",
				style = "Italic",
			}),
		},
		{
			italic = true,
			font = wezterm.font({
				family = "SF Mono",
				weight = "Regular",
				style = "Italic",
			}),
		},
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_frame = {
		font = wezterm.font("SF Mono"),
	},
	command_palette_bg_color = palette.surface,
	command_palette_fg_color = palette.subtle,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	native_macos_fullscreen_mode = false,
	cursor_thickness = "250%",
}

return config
