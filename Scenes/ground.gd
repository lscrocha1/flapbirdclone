extends Node2D

class_name Ground

signal bird_crashed

@export var speed = -150

@onready var spriteOne = $GroundOne/Sprite2D
@onready var spriteTwo = $GroundTwo/Sprite2D

func _ready():
	spriteTwo.global_position.x = spriteOne.global_position.x + spriteOne.texture.get_width()
	
func _process(delta):
	spriteOne.global_position.x += speed * delta
	spriteTwo.global_position.x += speed * delta
	
	# if sprite one is out of the screen, move it to the right side of sprite two
	
	if spriteOne.global_position.x < -spriteOne.texture.get_width():
		spriteOne.global_position.x = spriteTwo.global_position.x + spriteTwo.texture.get_width()
		
	# same as above, but for sprite two
	if spriteTwo.global_position.x < -spriteTwo.texture.get_width():
		spriteTwo.global_position.x = spriteOne.global_position.x + spriteOne.texture.get_width()


func _on_body_entered(body) -> void:
	bird_crashed.emit()
	stop()
	(body as Bird).stop()
	
func stop() -> void:
	speed = 0
