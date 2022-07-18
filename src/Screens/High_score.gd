extends Label

onready var global = $"/root/Global"

func _process(_delta: float) -> void:
	text = "Highscore: " + str(global.high_score)
