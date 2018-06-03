extends Area2D

signal kill

export (int) var SPEED
export (PackedScene) var BULLET
export (PackedScene) var EXPLOSION

var screen_width

func _ready():
	screen_width = get_viewport_rect().size.x

func _process(delta):
	# get the ship direction according to player input
	var dir = 0
	if Input.is_action_pressed("ui_left"):
		dir = -1
	elif Input.is_action_pressed("ui_right"):
		dir = 1

	# shoot bullets
	if Input.is_action_just_pressed("ui_accept"):
		$SfxShoot.play()
		shoot_bullet($LeftCannon.global_position)
		shoot_bullet($RightCannon.global_position)

	position.x += dir * SPEED * delta
	position.x = clamp(position.x, 0, screen_width)

func _on_collision(area):
	# destroy ship when colliding against enemies
	$Collision.disabled = true
	spawn_explosion()
	emit_signal("kill")
	queue_free()

func shoot_bullet(position):
	var bullet = BULLET.instance()
	bullet.init(position)
	get_parent().get_node("Bullets").add_child(bullet)
	bullet.add_to_group("bullets")

func spawn_explosion():
	var explosion = EXPLOSION.instance()
	explosion.init(position)
	get_parent().get_node("Explosions").add_child(explosion)
