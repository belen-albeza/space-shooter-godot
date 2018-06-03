extends Container

export (PackedScene) var GoToScene

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		start_game()

func _on_StartButton_pressed():
	start_game()

func start_game():
	get_tree().change_scene_to(GoToScene)
