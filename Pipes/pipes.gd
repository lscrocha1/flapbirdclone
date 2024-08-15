extends StaticBody2D
 
class_name Pipes

const DEFAULT_SPEED = 250
const DEAD_ZONE_POSITION = -1500

func _process(delta):
	position.x -= DEFAULT_SPEED * delta
	
	if position.x <= DEAD_ZONE_POSITION:
		queue_free()

func removePipe() -> void:
	queue_free()
