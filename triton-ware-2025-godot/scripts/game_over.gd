extends Control

@export var main_menu_scene : PackedScene
@export var game_scene : PackedScene

func _ready():
	show_game_over(GameState.final_time)

func show_game_over(score: float):  # Changed from int to float
	$CanvasLayer/ScoreLabel.text = "Time: %.2f seconds" % score
	self.visible = true

func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

	


func _on_main_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.
