extends Control

@export var main_menu_scene : PackedScene
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn");
	pass # Replace with function body.


func _on_skins_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/skins.tscn");
	pass # Replace with function body.



func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn");
	pass # Replace with function body.

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn");
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit();
	pass # Replace with function body.
