extends Node2D

class_name PipeSpawner

const pipes = preload("res://Pipes/pipes.tscn")

func spawn_pipes():
	var spawned_pipes = pipes.instantiate()
	get_parent().add_child(spawned_pipes)
	
func _on_timer_timeout():
	spawn_pipes()
