extends CharacterBody2D

class_name Bird

@export var gravity = 900.0
@export var jump_force = -300
@export var rotation_speed = 2

@onready var animation_player = $AnimationPlayer

var _max_speed = 400
var _should_process_input = true

var _game_started = false

func start_game() -> void:
	_game_started = true

func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta) -> void:
	if not _game_started:
		return
		
	if Input.is_action_just_pressed("jump") and _should_process_input:	
		animation_player.play("flap_wings")
		_jump()
		
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, _max_speed)
	
	move_and_collide(velocity * delta)
	
	_rotate()

func _jump() -> void:
	velocity.y = jump_force
	rotation = deg_to_rad(-30)

func _rotate() -> void:
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func kill() -> void:
	_should_process_input = false

func stop() -> void:
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
