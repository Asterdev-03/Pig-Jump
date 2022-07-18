extends Node2D

var game_over: = false
var score: = 0
var screen_size: = Vector2.ZERO
var player_pos: = Vector2.ZERO
var death_line_pos: = Vector2.ZERO

var high_score: = 0 setget set_high_score

const FILE_PATH = "user://score.data"

func _ready() -> void:
	load_high_score()

func init():
	screen_size = get_viewport_rect().size
	player_pos = Vector2(screen_size.x/2,screen_size.y - 50)
	death_line_pos = Vector2(screen_size.x/2,screen_size.y * 1.5)
	game_over = false
	score = 0

func load_high_score():
	var file = File.new()
	if not file.file_exists(FILE_PATH):
		return
	file.open(FILE_PATH,file.READ)
	high_score = file.get_var()
	file.close()

func save_high_score():
	var file = File.new()
	file.open(FILE_PATH,file.WRITE)
	file.store_var(high_score)
	file.close()

func set_high_score(value):
	high_score = value
	save_high_score()


