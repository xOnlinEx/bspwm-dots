local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 20,
	right = 20,
	top = 10,
	bottom = 20,
}
-- Cursor
config.default_cursor_style = "BlinkingBlock"
-- decay-decayce theme
config.colors = {
	indexed = {[16] = "#ecd3a0", [17] = "#cbced3"},

	scrollbar_thumb = "#1c1e27",
	split = "#151720",

	visual_bell = "#1c1e27",

	-- nightbuild only
	compose_cursor = "#ecd3a0",

	-- Theme Colors (Decay)
	foreground = "#b6beca",
	background = "#0d0f18",
	cursor_bg = "#cbced3",
	cursor_border = "#d0d3d8",
	cursor_fg = "#151720",
	selection_bg = "#575268",
	selection_fg = "#D9E0EE",

	ansi = {"#1c252c", "#dd6777", "#90ceaa", "#ecd3a0", "#86aaec", "#c296eb","#93cee9", "#cbced3"},
	brights = {"#1c1e27", "#e26c7c", "#95d3af", "#f1d8a5", "#8baff1", "#c79bf0", "#89d3ee", "#d0d3d8"},
}
return config
