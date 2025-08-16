-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Colors
config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = {
    "#214969", "#E52E2E", "#44FFB1", "#FFE073",
    "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7",
  },
  brights = {
    "#214969", "#E52E2E", "#44FFB1", "#FFE073",
    "#A277FF", "#a277ff", "#24EAF7", "#24EAF7",
  },
}

-- Font
config.font = wezterm.font("MesloLGS NF")
config.font_size = 13

-- Font rules for bold text
config.font_rules = {
  {
    intensity = "Bold",
    font = wezterm.font("MesloLGS NF", { weight = "Bold" }),
  },
}

config.initial_cols = 100
config.initial_rows = 30

-- Cursor
config.default_cursor_style = "SteadyBar"
config.cursor_blink_rate = 0

-- Tab bar
config.enable_tab_bar = false

-- Window padding
config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

-- Scrollback
config.scrollback_lines = 10000

-- Bell
config.audible_bell = "Disabled"

-- Window appearance
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7

return config
