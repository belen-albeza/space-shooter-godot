extends Node2D

export (float) var SPAWN_PROBABILITY
export (float) var SPAWN_PROBABILITY_INCREMENT
export (PackedScene) var ENEMY

var screen_width
var score = 0
var spawn_rate
var is_game_over = false

func _ready():
	randomize()
	screen_width = get_viewport_rect().size.x
	$EnemySpawner.start()
	spawn_rate = SPAWN_PROBABILITY

func spawn_enemy():
	# get random coordinates
	var position = Vector2(rand_range(0, screen_width), -32)
	var enemy = ENEMY.instance()
	enemy.init(position)
	$Enemies.add_child(enemy)
	enemy.connect("kill", self, "_on_enemy_kill")

func _on_enemy_kill(enemy):
	score += enemy.SCORE_POINTS
	$HUD/Score/Value.text = "%d" % score

# ----------------
# signal callbacks
# ----------------

func _on_EnemySpawner_timeout():
	if randf() <= spawn_rate:
		spawn_enemy()
	if not is_game_over:
		spawn_rate += SPAWN_PROBABILITY_INCREMENT

func _on_Ship_kill():
	is_game_over = true
	$GameOverDelay.start()

func _on_GameOverDelay_timeout():
	$BackgroundMusic.stop()
	$GameOverHUD.show(score)

func _on_GameOverHUD_restart():
	get_tree().reload_current_scene()
