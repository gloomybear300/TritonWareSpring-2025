extends Control

@export var main_menu_scene : PackedScene
@export var game_scene : PackedScene

func show_game_over(score: int):
	$CanvasLayer/ScoreLabel.text = "Score: %d" % score
	self.visible = true
	
func _on_retry_button_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_packed(main_menu_scene)
