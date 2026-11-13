/* Walker theme generated from the current Omarchy palette.
   The marked radius is replaced with Hyprland's decoration:rounding. */

@define-color window_bg_color {{ background }};
@define-color accent_bg_color {{ accent }};
@define-color theme_fg_color {{ foreground }};
@define-color muted_fg_color {{ light_foreground }};
@define-color error_bg_color {{ red }};
@define-color error_fg_color {{ background }};

* {
  all: unset;
  font-family: monospace;
  font-size: 14px;
}

.box-wrapper {
  background: @window_bg_color;
  border: 1px solid alpha(@theme_fg_color, 0.35);
  border-radius: 0px; /* omarchy-rounding */
  padding: 16px;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.38);
}

.search-container {
  border-bottom: 1px solid alpha(@theme_fg_color, 0.2);
  padding: 2px 4px 8px 4px;
}

.input {
  caret-color: @accent_bg_color;
  background: alpha(@theme_fg_color, 0.04);
  border-radius: 6px;
  padding: 9px 10px;
  color: @theme_fg_color;
  font-size: 16px;
}

.input placeholder {
  color: alpha(@theme_fg_color, 0.55);
}

.input selection {
  background: alpha(@accent_bg_color, 0.35);
}

.placeholder,
.elephant-hint {
  color: @muted_fg_color;
}

.list {
  color: @theme_fg_color;
}

.item-box {
  border-radius: 5px;
  padding: 8px 9px;
}

child:selected .item-box,
row:selected .item-box {
  background: alpha(@theme_fg_color, 0.08);
  border: 1px solid alpha(@accent_bg_color, 0.35);
}

child:selected .item-text,
row:selected .item-text {
  color: @accent_bg_color;
}

.item-subtext {
  color: @muted_fg_color;
  font-size: 11px;
}

.files .item-image {
  -gtk-icon-size: 20px;
}

.preview {
  border: 1px solid alpha(@accent_bg_color, 0.25);
  border-radius: 6px;
  padding: 8px;
  color: @theme_fg_color;
}

.keybinds {
  padding-top: 8px;
  border-top: 1px solid alpha(@theme_fg_color, 0.15);
  font-size: 11px;
  color: @muted_fg_color;
}

.keybind-bind {
  color: @theme_fg_color;
}

.error {
  padding: 8px;
  border-radius: 5px;
  background: @error_bg_color;
  color: @error_fg_color;
}
