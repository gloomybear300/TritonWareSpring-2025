extends CharacterBody2D

@onready var ray_cast_box: Area2D = $RayCastBox

var currentPlatform: Node2D = null

#Horizontal Movement
var grdAcceleration =50
var grdDeceleration = 20
var airAcceleration = 20
var airDeceleration = 5
var speed = 400

#Jumping
const gravity = 20
const maxFallSpeed = 1000
const jumpMaxHeight = -800
const JumpMinHeight = -150
const timeForFullJump = 0.2
var timeHeld = 0
const timeForCoyote = 0.1
var coyoteTimer = 1
var isFalling = false
var jumps=2

const downAcc = 50

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if isFalling:
		movement(airAcceleration,airDeceleration,delta)
	else:
		movement(grdAcceleration,grdDeceleration,delta)
	jump(delta)
	move_and_slide()
	

func movement(acceleration: float, deceleration: float, delta: float) -> void:
	var inDir=0
	#Gives -1 for left, 1 for right
	inDir = Input.get_axis("left","right")
	if inDir == 0:
		#Apply friction
		velocity.x = move_toward(velocity.x,0,deceleration)
	else:
		#Accelerate player
		velocity.x = move_toward(velocity.x,inDir*speed,acceleration)
	if currentPlatform:
		position.x+=currentPlatform.speed
		
func jump(delta):
	applyGravity(delta)
	# Handle positional state
	if is_on_floor():
		jumps=1
		isFalling = false
		coyoteTimer=0
	else:
		coyoteTimer+=delta	#Allows player to jump slightly after falling off platform
		if coyoteTimer>=timeForCoyote and jumps>0:
			jumps-=1
		isFalling=true
	#Handle Jumping
	if Input.is_action_pressed("jump") and jumps>0:
		timeHeld+=delta
		if timeHeld >= timeForFullJump:	#Jump is fully charged up
			timeHeld = timeForFullJump
	if Input.is_action_just_released("jump") and jumps>0:
		velocity.y = ((jumpMaxHeight-JumpMinHeight)*(timeHeld/timeForFullJump)+JumpMinHeight)
		jumps-=1
		isFalling=true
		timeHeld=0
		
	#Accelerate Down
	if Input.is_action_pressed("down") and isFalling:
		velocity.y+=downAcc
		
	#Clamp Fall Speed
	if velocity.y>maxFallSpeed:
		velocity.y=maxFallSpeed
		
		
func applyGravity(delta):
	velocity.y+=gravity
	
#Detecting Platform to Add Its Velocity
func _on_ray_cast_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ground"):
		currentPlatform = body

func _on_ray_cast_box_body_exited(body: Node2D) -> void:
	if currentPlatform==body:
		currentPlatform=null
