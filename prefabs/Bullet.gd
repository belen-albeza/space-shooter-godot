extends Area2D

export (int) var SPEED

func init(location):
	position = location

func _ready():
	pass

func _process(delta):
	# move upwards
	position.y -= SPEED * delta

	# destroy sprite when going outside of the screen
	if position.y < 0:
		queue_free()
