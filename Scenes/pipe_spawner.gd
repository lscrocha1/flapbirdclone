extends Node2D

class_name PipeSpawner

signal bird_hit
signal point_scored

var pipes_scene = preload("res://Scenes/pipes.tscn")

@export var pipe_speed = -150

@onready var spawn_timer = $SpawnTimer

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()
	
func start_spawning_pipes() -> void:
	spawn_timer.start()
	print_debug("oi")

func spawn_pipes() -> void:
	var pipes = pipes_scene.instantiate() as Pipes
	add_child(pipes)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipes.position.x = viewport_rect.end.x

	var half_height = viewport_rect.size.y / 2
	pipes.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pipes.bird_hit.connect(on_bird_hit)
	pipes.point_scored.connect(on_point_scored)
	pipes.set_speed(pipe_speed)

func on_bird_hit() -> void:
	bird_hit.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is Pipes):
		(pipe as Pipes).set_speed(0)
	
func on_point_scored() -> void:
	point_scored.emit()
