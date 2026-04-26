# PROTOTYPE - NOT FOR PRODUCTION
# Question: Does reactive infection spread produce satisfying clutch moments?
# Date: 2026-04-25
extends Control

const GRID_SIZE := 8
const TILE_SIZE := 80
const TILE_TYPES := 6
const TARGET_TYPE := 0  # red tiles are the "goal" type

signal match_made(count: int, positions: Array)
signal infection_spread(new_positions: Array)
signal infection_purged(count: int)
signal board_updated

var _tiles: Array = []         # [row][col] -> Tile node
var _selected: Vector2i = Vector2i(-1, -1)
var _seed_positions: Array = []  # permanent seed cell coordinates that emit infection
const TileScript := preload("res://Tile.gd")

var spread_rate: int = 1       # neighbors each seed tries to infect per turn
var seed_count: int = 2        # number of seed positions

var goal_collected: int = 0
var goal_target: int = 20
var moves_left: int = 20

func _ready() -> void:
	custom_minimum_size = Vector2(GRID_SIZE * TILE_SIZE, GRID_SIZE * TILE_SIZE)
	_init_grid()
	_clear_initial_matches()
	_place_infection_seeds()

func _clear_initial_matches() -> void:
	# Re-roll any tiles that are part of an initial 3-match until the board is clean.
	# Avoid the cascade-with-delays since startup should be instant.
	var safety := 0
	while safety < 200:
		var matches := _find_all_matches()
		if matches.is_empty():
			break
		for pos in matches:
			var tile := _get_tile(pos.x, pos.y)
			tile.set_type(randi() % TILE_TYPES)
		safety += 1

func _init_grid() -> void:
	_tiles.clear()
	for row in GRID_SIZE:
		var row_arr := []
		for col in GRID_SIZE:
			var tile := Control.new()
			tile.set_script(TileScript)
			tile.position = Vector2(col * TILE_SIZE, row * TILE_SIZE)
			tile.custom_minimum_size = Vector2(TILE_SIZE, TILE_SIZE)
			tile.size = Vector2(TILE_SIZE, TILE_SIZE)
			tile.mouse_filter = Control.MOUSE_FILTER_STOP
			add_child(tile)
			tile.grid_pos = Vector2i(col, row)
			tile.set_type(randi() % TILE_TYPES)
			tile.gui_input.connect(_on_tile_input.bind(Vector2i(col, row)))
			row_arr.append(tile)
		_tiles.append(row_arr)

func _place_infection_seeds() -> void:
	# Clear any previous seed markers
	for row in GRID_SIZE:
		for col in GRID_SIZE:
			_get_tile(col, row).set_seed(false)
	_seed_positions.clear()
	var placed := 0
	while placed < seed_count:
		var r := randi() % GRID_SIZE
		var c := randi() % GRID_SIZE
		var pos := Vector2i(c, r)
		if pos in _seed_positions:
			continue
		_seed_positions.append(pos)
		var t := _get_tile(c, r)
		t.set_infected(true)
		t.set_seed(true)
		placed += 1

func _get_tile(col: int, row: int) -> Control:
	if col < 0 or col >= GRID_SIZE or row < 0 or row >= GRID_SIZE:
		return null
	return _tiles[row][col]

func _on_tile_input(event: InputEvent, pos: Vector2i) -> void:
	if not event is InputEventMouseButton:
		return
	var mb := event as InputEventMouseButton
	if not (mb.pressed and mb.button_index == MOUSE_BUTTON_LEFT):
		return
	if moves_left <= 0:
		return

	if _selected == Vector2i(-1, -1):
		_select(pos)
	else:
		if _is_adjacent(_selected, pos):
			_attempt_swap(_selected, pos)
			_selected = Vector2i(-1, -1)
		elif pos == _selected:
			_deselect()
		else:
			_deselect()
			_select(pos)

func _select(pos: Vector2i) -> void:
	_selected = pos
	_get_tile(pos.x, pos.y).set_selected(true)

func _deselect() -> void:
	if _selected != Vector2i(-1, -1):
		_get_tile(_selected.x, _selected.y).set_selected(false)
	_selected = Vector2i(-1, -1)

func _is_adjacent(a: Vector2i, b: Vector2i) -> bool:
	return abs(a.x - b.x) + abs(a.y - b.y) == 1

func _attempt_swap(a: Vector2i, b: Vector2i) -> void:
	_swap_tiles(a, b)
	# Check matches anywhere on the board after this swap
	var initial_matches := _find_all_matches()
	if initial_matches.is_empty():
		# Invalid swap — swap back, no move consumed
		_swap_tiles(a, b)
		return

	moves_left -= 1
	emit_signal("board_updated")  # update HUD immediately to show move consumed
	await _resolve_cascades()
	await get_tree().create_timer(0.25).timeout
	_apply_infection_spread()
	emit_signal("board_updated")

func _resolve_cascades() -> void:
	# Loop: find all matches, clear them, gravity + refill, repeat until no matches remain.
	var chain := 0
	while true:
		var matches := _find_all_matches()
		if matches.is_empty():
			break
		chain += 1
		_clear_matches(matches)
		emit_signal("match_made", matches.size(), matches)
		if _last_purged > 0:
			emit_signal("infection_purged", _last_purged)
		emit_signal("board_updated")
		await get_tree().create_timer(0.3).timeout
		_apply_gravity()
		_refill()
		_refresh_seed_markers()
		emit_signal("board_updated")
		await get_tree().create_timer(0.2).timeout

func _refresh_seed_markers() -> void:
	# Re-apply the seed flag to whatever tile currently sits at each permanent seed position.
	# Necessary because gravity + refill replace tiles but seeds are anchored to grid coordinates.
	for row in GRID_SIZE:
		for col in GRID_SIZE:
			_get_tile(col, row).set_seed(false)
	for pos in _seed_positions:
		var t := _get_tile(pos.x, pos.y)
		if t:
			t.set_seed(true)

func _find_all_matches() -> Array:
	var found: Dictionary = {}
	# Horizontal scan
	for row in GRID_SIZE:
		var col: int = 0
		while col < GRID_SIZE:
			var t := _get_tile(col, row)
			if t == null or t.modulate.a < 0.5:
				col += 1
				continue
			var run_type: int = t.tile_type
			var run_end: int = col
			while run_end < GRID_SIZE:
				var rt := _get_tile(run_end, row)
				if rt and rt.modulate.a > 0.5 and rt.tile_type == run_type:
					run_end += 1
				else:
					break
			if run_end - col >= 3:
				for c in range(col, run_end):
					found[Vector2i(c, row)] = true
			col = run_end if run_end > col else col + 1
	# Vertical scan
	for col in GRID_SIZE:
		var row: int = 0
		while row < GRID_SIZE:
			var t := _get_tile(col, row)
			if t == null or t.modulate.a < 0.5:
				row += 1
				continue
			var run_type: int = t.tile_type
			var run_end: int = row
			while run_end < GRID_SIZE:
				var rt := _get_tile(col, run_end)
				if rt and rt.modulate.a > 0.5 and rt.tile_type == run_type:
					run_end += 1
				else:
					break
			if run_end - row >= 3:
				for r in range(row, run_end):
					found[Vector2i(col, r)] = true
			row = run_end if run_end > row else row + 1
	return found.keys()

func _swap_tiles(a: Vector2i, b: Vector2i) -> void:
	var ta := _get_tile(a.x, a.y)
	var tb := _get_tile(b.x, b.y)
	var tmp_type: int = ta.tile_type
	var tmp_inf: bool = ta.infected
	ta.set_type(tb.tile_type)
	ta.set_infected(tb.infected)
	tb.set_type(tmp_type)
	tb.set_infected(tmp_inf)

func _find_matches_at(pos: Vector2i) -> Array:
	var matched: Array = []
	var t := _get_tile(pos.x, pos.y)
	if t == null:
		return matched
	var type: int = t.tile_type

	# Horizontal run
	var h_run: Array = [pos]
	for dc in [-1, 1]:
		var c: int = pos.x + dc
		while c >= 0 and c < GRID_SIZE and _get_tile(c, pos.y).tile_type == type:
			h_run.append(Vector2i(c, pos.y))
			c += dc
	if h_run.size() >= 3:
		matched.append_array(h_run)

	# Vertical run
	var v_run: Array = [pos]
	for dr in [-1, 1]:
		var r: int = pos.y + dr
		while r >= 0 and r < GRID_SIZE and _get_tile(pos.x, r).tile_type == type:
			v_run.append(Vector2i(pos.x, r))
			r += dr
	if v_run.size() >= 3:
		matched.append_array(v_run)

	# Deduplicate
	var seen := {}
	var result := []
	for p in matched:
		if not seen.has(p):
			seen[p] = true
			result.append(p)
	return result

func _clear_matches(positions: Array) -> void:
	var infection_purged := 0
	for pos in positions:
		var tile := _get_tile(pos.x, pos.y)
		if tile.tile_type == TARGET_TYPE:
			goal_collected += 1
		if tile.infected:
			infection_purged += 1
		tile.set_type(randi() % TILE_TYPES)
		tile.set_infected(false)
		tile.modulate.a = 0.0
	if infection_purged > 0:
		_last_purged = infection_purged
	else:
		_last_purged = 0

var _last_purged: int = 0  # hidden until gravity refills

func _apply_gravity() -> void:
	for col in GRID_SIZE:
		# Collect non-empty slots bottom-to-top
		var bottom := GRID_SIZE - 1
		for row in range(GRID_SIZE - 1, -1, -1):
			var tile := _get_tile(col, row)
			if tile.modulate.a > 0.0:
				if bottom != row:
					var dst := _get_tile(col, bottom)
					dst.set_type(tile.tile_type)
					dst.set_infected(tile.infected)
					dst.modulate.a = 1.0
					tile.modulate.a = 0.0
				bottom -= 1

func _refill() -> void:
	for col in GRID_SIZE:
		for row in GRID_SIZE:
			var tile := _get_tile(col, row)
			if tile.modulate.a < 0.5:
				tile.set_type(randi() % TILE_TYPES)
				tile.set_infected(false)
				tile.modulate.a = 1.0

func _apply_infection_spread() -> void:
	# Source-only model: only the original seed positions emit infection.
	# Each turn, every seed:
	#   1. Re-infects itself if its tile was cleared by a match
	#   2. Tries to infect up to spread_rate uninfected cardinal neighbors
	# Newly-infected tiles do NOT themselves spread — they are static "infected" cells
	# until the player matches them away.
	var spread_positions: Array = []
	for seed_pos in _seed_positions:
		var seed_tile := _get_tile(seed_pos.x, seed_pos.y)
		if seed_tile == null:
			continue
		# Re-infect the seed cell if it's been cleared
		if not seed_tile.infected:
			seed_tile.set_infected(true)
			spread_positions.append(seed_pos)
		# Pick uninfected cardinal neighbors and infect up to spread_rate of them
		var dirs := [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)]
		dirs.shuffle()
		var infected_this_turn := 0
		for dir in dirs:
			if infected_this_turn >= spread_rate:
				break
			var neighbor: Vector2i = seed_pos + dir
			var nt := _get_tile(neighbor.x, neighbor.y)
			if nt and not nt.infected:
				nt.set_infected(true)
				spread_positions.append(neighbor)
				infected_this_turn += 1

	if not spread_positions.is_empty():
		emit_signal("infection_spread", spread_positions)

func count_infected() -> int:
	var n := 0
	for row in GRID_SIZE:
		for col in GRID_SIZE:
			if _get_tile(col, row).infected:
				n += 1
	return n

func reset(new_spread_rate: int, new_seed_count: int) -> void:
	spread_rate = new_spread_rate
	seed_count = new_seed_count
	goal_collected = 0
	moves_left = 20
	for row in GRID_SIZE:
		for col in GRID_SIZE:
			var tile := _get_tile(col, row)
			tile.set_type(randi() % TILE_TYPES)
			tile.set_infected(false)
			tile.modulate.a = 1.0
	_clear_initial_matches()
	_place_infection_seeds()
	_deselect()
	emit_signal("board_updated")
