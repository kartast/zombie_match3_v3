# PROTOTYPE - NOT FOR PRODUCTION
# Question: Does reactive infection spread produce satisfying clutch moments?
# Date: 2026-04-25
extends Control

const TILE_COLORS := [
	Color(0.9, 0.3, 0.3),   # red/brain
	Color(0.3, 0.8, 0.4),   # green/slime
	Color(0.3, 0.5, 0.9),   # blue/eyeball
	Color(0.9, 0.8, 0.2),   # yellow/bone
	Color(0.7, 0.3, 0.9),   # purple/gravestone
	Color(0.9, 0.6, 0.2),   # orange/bandages
]

const INFECTION_OVERLAY := Color(0.1, 0.05, 0.15, 0.75)
const SELECTED_BORDER := Color(1.0, 1.0, 1.0, 1.0)

var tile_type: int = 0
var infected: bool = false
var is_seed: bool = false
var selected: bool = false
var grid_pos: Vector2i

var _bg: ColorRect
var _infection_overlay: ColorRect
var _label: Label
var _border: Panel

func _ready() -> void:
	custom_minimum_size = Vector2(80, 80)
	mouse_filter = Control.MOUSE_FILTER_STOP

	_bg = ColorRect.new()
	_bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_bg)

	_infection_overlay = ColorRect.new()
	_infection_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_infection_overlay.color = INFECTION_OVERLAY
	_infection_overlay.visible = false
	_infection_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_infection_overlay)

	_label = Label.new()
	_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label.add_theme_font_size_override("font_size", 32)
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_label)

	_border = Panel.new()
	_border.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_border.visible = false
	_border.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.draw_center = false
	style.border_width_left = 3
	style.border_width_right = 3
	style.border_width_top = 3
	style.border_width_bottom = 3
	style.border_color = SELECTED_BORDER
	_border.add_theme_stylebox_override("panel", style)
	add_child(_border)

	refresh()

func set_type(t: int) -> void:
	tile_type = t
	refresh()

func set_infected(v: bool) -> void:
	infected = v
	refresh()

func set_seed(v: bool) -> void:
	is_seed = v
	refresh()

func set_selected(v: bool) -> void:
	selected = v
	_border.visible = v

func refresh() -> void:
	if _bg == null:
		return
	_bg.color = TILE_COLORS[tile_type]
	_infection_overlay.visible = infected
	const EMOJI := ["🧠", "🟢", "👁", "🦴", "🪦", "🩹"]
	var infection_marker := ""
	if is_seed:
		infection_marker = "\n☠"  # permanent seed
	elif infected:
		infection_marker = "\n🧟"  # spread infection (clearable)
	_label.text = EMOJI[tile_type] + infection_marker
