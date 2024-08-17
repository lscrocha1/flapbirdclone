extends Node2D

class_name Pipes

signal bird_hit
signal point_scored

var _speed = 0

func set_speed(speed) -> void:
	_speed = speed

func _process(delta) -> void:
	position.x += _speed * delta

func _on_body_entered(_body) -> void:
	bird_hit.emit()
	
func _on_point_scored(_body) -> void:
	point_scored.emit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
