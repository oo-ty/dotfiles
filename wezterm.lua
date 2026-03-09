local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Detect the active screen resolution and adjust terminal settings accordingly
wezterm.on("gui-startup", function(cmd)
	local active_screen = wezterm.gui.screens().active
	local width = active_screen.width
	local height = active_screen.height

	local cols, rows, font_size, window_width, window_height

	if width >= 3840 then
		-- 4K (3840x2160 and above)
		font_size = 14.0
		cols = 200
		rows = 60
		window_width = math.floor(width * 0.75)
		window_height = math.floor(height * 0.75)
	elseif width >= 2560 then
		-- 1440p / QHD (2560x1440)
		font_size = 12.0
		cols = 160
		rows = 50
		window_width = math.floor(width * 0.70)
		window_height = math.floor(height * 0.70)
	elseif width >= 1920 then
		-- 1080p / Full HD (1920x1080)
		font_size = 11.0
		cols = 140
		rows = 40
		window_width = math.floor(width * 0.65)
		window_height = math.floor(height * 0.65)
	else
		-- Lower resolutions (e.g. 1366x768, 1280x720)
		font_size = 10.0
		cols = 120
		rows = 35
		window_width = math.floor(width * 0.80)
		window_height = math.floor(height * 0.80)
	end

	-- Calculate DPI scale factor for HiDPI displays
	local dpi = active_screen.effective_dpi or 96
	if dpi > 144 then
		font_size = font_size + 1.0
	end

	config.font_size = font_size
	config.initial_cols = cols
	config.initial_rows = rows

	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():set_inner_size(window_width, window_height)

	-- Center the window on the active screen
	local x = active_screen.x + math.floor((width - window_width) / 2)
	local y = active_screen.y + math.floor((height - window_height) / 2)
	window:gui_window():set_position(x, y)
end)

-- General settings
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.color_scheme = "Catppuccin Mocha"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 8,
	right = 8,
	top = 8,
	bottom = 8,
}
config.window_background_opacity = 1.0
config.bold_brightens_ansi_colors = "BrightAndBold"
config.scrollback_lines = 10000
config.default_prog = { "wsl.exe", "~", "-d", "Ubuntu-24.04", "bash", "-li" }

-- Boost foreground contrast while keeping Catppuccin Mocha base
config.colors = {
	foreground = "#D9E0EE",
	cursor_fg = "#1E1E2E",
	cursor_bg = "#F5E0DC",
}

return config
