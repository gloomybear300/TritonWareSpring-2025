extends CharacterBody2D

@onready var ray_cast_box: Area2D = $RayCastBox

var currentPlatform: Node2D = null

# Horizontal Movement
var grdAcceleration = 100    # Increased acceleration on ground
var grdDeceleration = 30     # Increased deceleration on ground
var airAcceleration = 40     # Increased acceleration in air
var airDeceleration = 15     # Increased deceleration in air
var speed = 600              # Increased speed (faster horizontal movement)

# Jumping
const gravity = 100           # Increased gravity (falling speed increased)
const maxFallSpeed = 2000    # Increased max fall speed
const jumpMaxHeight = -1200  # Maximum jump height
const jumpMinHeight = -200   # Minimum jump height
const timeForFullJump = 0.4 
var timeHeld = 0
var jumps = 2
var isJumping = false        # To track if the jump has been initiated

const downAcc = 75           # Increased downward acceleration when pressing down

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		# Reset jump when touching the ground
		jumps = 1
		isJumping = false
	if isJumping:
		movement(airAcceleration, airDeceleration, delta)
	else:
		movement(grdAcceleration, grdDeceleration, delta)
	jump(delta)
	#print(velocity.y)
	move_and_slide()

func movement(acceleration: float, deceleration: float, delta: float) -> void:
	var inDir = 0
	inDir = Input.get_axis("left", "right")
	if inDir == 0:
		# Apply friction
		velocity.x = move_toward(velocity.x, 0, deceleration)
	else:
		# Accelerate player
		velocity.x = move_toward(velocity.x, inDir * speed, acceleration)
	if currentPlatform:
		position.x += currentPlatform.speed
		
func jump(delta):
	applyGravity(delta)
	
	# Handle Jumping: Jump is only activated when the player presses the jump button
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = jumpMaxHeight
		isJumping = true
		jumps = 0
		timeHeld = 0  # Reset timeHeld when the jump starts
	
	if isJumping:
		# While jumping, control jump height
		if Input.is_action_pressed("jump"):
			# Allow additional control over height by modifying the jump velocity
			#velocity.y = move_toward(velocity.y, jumpMaxHeight, -(gravity * delta))
			timeHeld += delta
			#if (timeHeld > 0.2):
				#timeHeld = 0.2; # Clamp timeHeld to maxTime
			#
			velocity.y -= lerp(100,0, timeHeld / timeForFullJump)
			print(timeHeld / 20)
		elif Input.is_action_just_released("jump"):
			# After releasing the jump button, let gravity take over
			isJumping = false

	# Clamp Fall Speed
	if velocity.y > maxFallSpeed:
		velocity.y = maxFallSpeed

	# Allow downward acceleration if "down" is pressed
	if Input.is_action_pressed("down") and is_on_floor() == false:
		velocity.y += downAcc

func applyGravity(delta):
	velocity.y += gravity

# Detecting Platform to Add Its Velocity
func _on_ray_cast_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ground"):
		currentPlatform = body

func _on_ray_cast_box_body_exited(body: Node2D) -> void:
	if currentPlatform == body:
		currentPlatform = null
