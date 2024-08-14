extends CharacterBody2D

@onready var sprite = $Sprite2D as Sprite2D

const JUMP_VELOCITY = -400.0 as float
const FALL_ROTATION_DEGREE = 1.5 as float
const JUMP_ROTATION_DEGREE = -45 as int
const MAX_ROTATION_DEGREEE = 90 as int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float):
	velocity.y += gravity * delta
	
	# in godot the cartesian plane is inverted, 
	# Y positive is down, Y negative is up
	if velocity.y >= 0:
		sprite.rotation_degrees += 1.5
	
	if Input.is_action_just_pressed("ui_space_bar"):
		velocity.y = JUMP_VELOCITY
		sprite.rotation_degrees = JUMP_ROTATION_DEGREE
		
	if sprite.rotation_degrees > MAX_ROTATION_DEGREEE:
		sprite.rotation_degrees = MAX_ROTATION_DEGREEE
		
	move_and_slide()
