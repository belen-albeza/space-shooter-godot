extends Area2D

export (int) var MAX_SPEED_X
export (int) var MAX_SPEED_Y
export (PackedScene) var EXPLOSION

signal kill

const SCORE_POINTS = 5
var speed = Vector2()
var screen_height
var height

func init(location):
	position = location

func _ready():
	screen_height = get_viewport_rect().size.y
	height = $Sprite.get_texture().get_height()
	speed.x = rand_range(-MAX_SPEED_X, MAX_SPEED_X)
	speed.y = rand_range(MAX_SPEED_Y * 0.5, MAX_SPEED_Y)

func _process(delta):
	# movement
	position += speed * delta

	# destroy sprite when disappearing at the bottom part of the screen
	if position.y > screen_height + height:
		queue_free()

func _on_collision(area):
	if area.is_in_group("bullets"):
		spawn_explosion()
		emit_signal("kill", self)
		$Collision.disabled = true
		queue_free()

func spawn_explosion():
	var explosion = EXPLOSION.instance()
	explosion.init(position)
	get_parent().get_node("../Explosions").add_child(explosion)
