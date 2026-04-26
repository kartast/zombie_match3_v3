# PROTOTYPE - NOT FOR PRODUCTION
# Question: Does reactive infection spread produce satisfying clutch moments?
# Date: 2026-04-25
extends Control

var _board: Control
var _hud: Control
var _moves_label: Label
var _goal_label: Label
var _infected_label: Label
var _status_label: Label
var _spread_slider: HSlider
var _spread_value_label: Label
var _seed_slider: HSlider
var _seed_value_label: Label
var _reset_button: Button
var _log_label: Label

func _ready() -> void:
	_build_ui()
	_board.board_updated.connect(_refresh_hud)
	_board.match_made.connect(_on_match_made)
	_board.infection_spread.connect(_on_infection_spread)
	_board.infection_purged.connect(_on_infection_purged)
	_refresh_hud()

func _build_ui() -> void:
	var root_vbox := VBoxContainer.new()
	root_vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root_vbox.add_theme_constant_override("separation", 4)
	add_child(root_vbox)

	# Title bar
	var title := Label.new()
	title.text = "INFECTION SPREAD PROTOTYPE — Graveyard Shift"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 48)
	root_vbox.add_child(title)

	# In-game rules panel
	var help_panel := PanelContainer.new()
	root_vbox.add_child(help_panel)
	var help := Label.new()
	help.text = "GOAL: Collect 20 RED 🧠 brains by matching 3+ in a row/column.    MOVES: 20.\n" + \
		"INFECTION: ☠ = permanent seed (cannot be eliminated). 🧟 = spread infection (clearable).\n" + \
		"Each turn after your move, every ☠ infects up to 'Spread rate' uninfected neighbors.\n" + \
		"TO CONTAIN: match infected (🧟 or ☠) tiles — the match clears the infection AND scores normally.\n" + \
		"You CANNOT permanently kill seeds — only contain them. Win by hitting the 🧠 goal in time."
	help.add_theme_font_size_override("font_size", 36)
	help_panel.add_child(help)

	# HUD row
	var hud_hbox := HBoxContainer.new()
	hud_hbox.add_theme_constant_override("separation", 20)
	root_vbox.add_child(hud_hbox)

	_moves_label = _make_hud_label("Moves: 20")
	_goal_label = _make_hud_label("🧠 Goal: 0 / 20")
	_infected_label = _make_hud_label("🧟 Infected: 0")
	_status_label = _make_hud_label("")
	_status_label.add_theme_color_override("font_color", Color(1, 0.4, 0.4))
	hud_hbox.add_child(_moves_label)
	hud_hbox.add_child(_goal_label)
	hud_hbox.add_child(_infected_label)
	hud_hbox.add_child(_status_label)

	# Board container (centered)
	var board_container := CenterContainer.new()
	board_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	board_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	root_vbox.add_child(board_container)

	var board_bg := PanelContainer.new()
	board_container.add_child(board_bg)

	_board = Control.new()
	_board.set_script(load("res://Board.gd"))
	_board.custom_minimum_size = Vector2(640, 640)
	_board.size = Vector2(640, 640)
	board_bg.add_child(_board)

	# Tuning panel
	var tuning_panel := PanelContainer.new()
	root_vbox.add_child(tuning_panel)

	var tuning_vbox := VBoxContainer.new()
	tuning_panel.add_child(tuning_vbox)

	var tuning_title := Label.new()
	tuning_title.text = "TUNING PARAMETERS"
	tuning_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tuning_vbox.add_child(tuning_title)

	var spread_row := HBoxContainer.new()
	tuning_vbox.add_child(spread_row)
	var spread_lbl := Label.new()
	spread_lbl.text = "Spread rate (cells/turn/seed):"
	spread_lbl.custom_minimum_size = Vector2(220, 0)
	spread_row.add_child(spread_lbl)
	_spread_slider = HSlider.new()
	_spread_slider.min_value = 0
	_spread_slider.max_value = 4
	_spread_slider.step = 1
	_spread_slider.value = 1
	_spread_slider.custom_minimum_size = Vector2(200, 0)
	_spread_slider.value_changed.connect(_on_slider_changed)
	spread_row.add_child(_spread_slider)
	_spread_value_label = Label.new()
	_spread_value_label.text = "1"
	_spread_value_label.custom_minimum_size = Vector2(30, 0)
	spread_row.add_child(_spread_value_label)

	var seed_row := HBoxContainer.new()
	tuning_vbox.add_child(seed_row)
	var seed_lbl := Label.new()
	seed_lbl.text = "Starting infection seeds:"
	seed_lbl.custom_minimum_size = Vector2(220, 0)
	seed_row.add_child(seed_lbl)
	_seed_slider = HSlider.new()
	_seed_slider.min_value = 1
	_seed_slider.max_value = 5
	_seed_slider.step = 1
	_seed_slider.value = 2
	_seed_slider.custom_minimum_size = Vector2(200, 0)
	_seed_slider.value_changed.connect(_on_slider_changed)
	seed_row.add_child(_seed_slider)
	_seed_value_label = Label.new()
	_seed_value_label.text = "2"
	_seed_value_label.custom_minimum_size = Vector2(30, 0)
	seed_row.add_child(_seed_value_label)

	_reset_button = Button.new()
	_reset_button.text = "RESET WITH THESE PARAMETERS"
	_reset_button.pressed.connect(_on_reset)
	tuning_vbox.add_child(_reset_button)

	# Event log
	var log_title := Label.new()
	log_title.text = "Event log:"
	root_vbox.add_child(log_title)
	_log_label = Label.new()
	_log_label.text = ""
	_log_label.add_theme_font_size_override("font_size", 36)
	root_vbox.add_child(_log_label)

func _make_hud_label(text: String) -> Label:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", 54)
	return lbl

func _refresh_hud() -> void:
	_moves_label.text = "Moves: %d" % _board.moves_left
	_goal_label.text = "🧠 Goal: %d / %d" % [_board.goal_collected, _board.goal_target]
	_infected_label.text = "🧟 Infected: %d" % _board.count_infected()

	if _board.goal_collected >= _board.goal_target:
		_status_label.text = "✅ WIN! (%d moves left)" % _board.moves_left
	elif _board.moves_left <= 0:
		_status_label.text = "💀 LOSE — %d tiles short" % (_board.goal_target - _board.goal_collected)
	elif _board.moves_left <= 5:
		_status_label.text = "⚠ CLUTCH ZONE"
	else:
		_status_label.text = ""

func _on_match_made(count: int, _positions: Array) -> void:
	_log("[Match] %d tiles cleared" % count)

func _on_infection_spread(positions: Array) -> void:
	_log("[Spread] +%d infected cells (total: %d)" % [positions.size(), _board.count_infected()])

func _on_infection_purged(count: int) -> void:
	_log("[Purge] -%d infection cleared by your match!" % count)

func _on_slider_changed(_value: float) -> void:
	_spread_value_label.text = str(int(_spread_slider.value))
	_seed_value_label.text = str(int(_seed_slider.value))

func _on_reset() -> void:
	_board.reset(int(_spread_slider.value), int(_seed_slider.value))
	_status_label.text = ""
	_log_label.text = ""
	_log("[Reset] spread=%d seeds=%d" % [int(_spread_slider.value), int(_seed_slider.value)])
	_refresh_hud()

var _log_lines: Array = []
func _log(msg: String) -> void:
	_log_lines.append(msg)
	if _log_lines.size() > 8:
		_log_lines = _log_lines.slice(_log_lines.size() - 8)
	_log_label.text = "\n".join(_log_lines)
