extends KinematicBody2D

const MAX_SPEED: = 120
const GRAVITY: = 500
const THRUST: = -500

var velocity: = Vector2.ZERO
var hor_speed: = 10
var max_height = null
var start_pos = null

onready var global = $"/root/Global"
onready var player = $ObjectDetector
onready var sprite = $AnimatedSprite

func _ready() -> void:
	start_pos = player.global_position.y
	max_height = start_pos
	velocity = move_and_slide(Vector2(0,-1000))

func _process(_delta: float) -> void:
#Setting Score And Highscore
	max_height = min(max_height,player.global_position.y)
	global.score = -(max_height - start_pos)
	if global.score > global.high_score:
		global.set_high_score(global.score)

#2D Movement Input System
	var direction: = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x += hor_speed * direction
	velocity.x = min(velocity.x,MAX_SPEED) if direction > 0 else max(velocity.x,-MAX_SPEED)
	velocity.y += GRAVITY * _delta

#Play Animation
	if velocity.y < 0:
		sprite.play("Jump")
	else:
		sprite.play("Fall")
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

#Warp Around Screen Edges
	var pos = get_position()
	if pos.x > global.screen_size.x:
		pos.x = 0
	if pos.x < 0:
		pos.x = global.screen_size.x
	set_position(pos)

	velocity = move_and_slide(velocity)

func _on_area_entered(_area: Area2D) -> void:
	if _area.name == "TrapArea":
		global.game_over = true
		queue_free()

	if _area.global_position.y > max_height:
		velocity.y = THRUST


