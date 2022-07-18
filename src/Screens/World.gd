extends Node2D

onready var global = $"/root/Global"
onready var container = $Scene_container
onready var player = $Player
onready var death_line =$DeathLine

onready var cloud_chunk = preload("res://src/Screens/CloudScene.tscn")
onready var end_scene = preload("res://src/Screens/End_screen.tscn")

var height = null
var spawn_pos: = Vector2.ZERO

const spawn_chunk: = 20

func _ready() -> void:
	init()
	for _i in range(spawn_chunk):
		spawn()

func _process(_delta: float) -> void:
	death_line.global_position.y = global.death_line_pos.y - global.score

	if death_line.global_position.y < spawn_pos.y - (spawn_chunk * height):
		for _i in range(int(spawn_chunk * 0.5)):
			spawn()

	if global.game_over:
		get_tree().change_scene_to(end_scene)

func init():
	global.init()
	player.set_position(global.player_pos)
	death_line.set_position(global.death_line_pos)
	height = -get_viewport_rect().size.y
	spawn_pos.y = height

func spawn():
#spawns a chunk of clouds
	var chunk = cloud_chunk.instance()
	chunk.position = spawn_pos
	container.add_child(chunk)
	spawn_pos.y += height


