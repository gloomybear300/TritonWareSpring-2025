extends Control

@export var skins_scene : PackedScene

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn");
	pass # Replace with function body.
