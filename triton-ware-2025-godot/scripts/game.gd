extends Node2D  # Or Node2D depending on your scene

var round_time := 0.0
var round_active := false

func _ready():
	start_round()

func _process(delta):
	if round_active:
		round_time += delta
		#print("Time: ", round_time)  # For debugging

	if Input.is_action_just_pressed("game_over"):
		game_over()

func start_round():
	round_time = 0.0
	round_active = true
	print("Round started!")

func game_over():
	round_active = false
	GameState.final_time = round_time
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
