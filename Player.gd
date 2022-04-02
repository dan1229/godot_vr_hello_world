extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
export var jump_impulse = 20

onready var camera = $Pivot/Camera

var velocity = Vector3.ZERO

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	# normalize direction
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
		
	# fall
	velocity.y -= fall_acceleration * delta

	# Moving the character
	velocity = move_and_slide_with_snap(velocity, Vector3.UP)
	
