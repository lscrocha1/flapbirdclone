extends CharacterBody2D

@onready var _sprite = $Sprite2D as Sprite2D

const _JUMP_VELOCITY = -400.0 as float
const _FALL_ROTATION_DEGREE = 1.5 as float
const _JUMP_ROTATION_DEGREE = -45 as int
const _MAX_ROTATION_DEGREEE = 90 as int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta

	# in godot the cartesian plane is inverted, 
	# Y positive is down, Y negative is up
	if velocity.y >= 0:
		_sprite.rotation_degrees += 1.5
	
	if Input.is_action_just_pressed("ui_space_bar"):
		velocity.y = _JUMP_VELOCITY
		_sprite.rotation_degrees = _JUMP_ROTATION_DEGREE
		
	if _sprite.rotation_degrees > _MAX_ROTATION_DEGREEE:
		_sprite.rotation_degrees = _MAX_ROTATION_DEGREEE
		
	move_and_slide()
