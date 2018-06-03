extends Particles2D

func init(location):
	position = location
	restart()
	$Timer.start()

func _ready():
	$Timer.wait_time = lifetime

func _on_Timer_timeout():
	queue_free()
