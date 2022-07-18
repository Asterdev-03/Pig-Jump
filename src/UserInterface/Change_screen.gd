tool
extends Button

export(String,FILE) var next_scene_path: = ""

func _on_pressed() -> void:
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "Next scene path must be set for button to work" if next_scene_path == "" else ""
