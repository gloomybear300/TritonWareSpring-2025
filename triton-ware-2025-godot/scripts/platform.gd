extends StaticBody2D

const speed = -4

func _process(delta: float) -> void:
	position.x+=speed
