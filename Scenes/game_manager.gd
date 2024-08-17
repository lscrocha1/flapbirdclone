extends Node2D

@onready var bird = $"../Bird"
@onready var pipe_spawner = $"../PipeSpawner"
@onready var ground = $"../Ground"
@onready var fade = $"../Fade"
@onready var ui = $"../UI"

var _points = 0

var _game_has_started = false

func _ready() -> void:
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_hit.connect(end_game)
	pipe_spawner.point_scored.connect(_on_point_scored)

func _process(delta) -> void:
	if Input.is_action_just_pressed("jump") and not _game_has_started:
		_game_has_started = true
		bird.start_game()
		pipe_spawner.start_spawning_pipes()

func _on_point_scored() -> void:
	_points += 1
	ui.update_points(_points)

func end_game() -> void:
	if fade != null:
		fade.play()
		
	ground.stop()
	bird.kill()
	pipe_spawner.stop()
	ui.on_game_over()
