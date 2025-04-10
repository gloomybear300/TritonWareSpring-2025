extends Node

@onready var point: Marker2D = $point
@onready var platform_scene = preload("res://platform.tscn")

@onready var wait: float = 2
var timer: float = wait

var platformError = 200

func _process(delta: float) -> void:
	timer-=delta
	if timer<=0:
		spawn()
		timer=wait*randf_range(0.5,1.5)
	
func spawn():
	var platform = platform_scene.instantiate()
	platform.global_position = point.global_position
	platform.global_position.y+=randf_range(-platformError,platformError)
	$/root/Game.add_child(platform)
