extends Label

onready var global = $"/root/Global"

func _process(_delta: float) -> void:
	text = "Score: " + str(int(global.score))
