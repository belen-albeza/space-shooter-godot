extends Container

signal restart

func show(score):
	modulate = '#00ffffff'
	$ScoreValue.text = "%d" % score

	visible = true
	$ShowAnim.play("Show")

func _on_RestartButton_pressed():
	emit_signal("restart")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and visible:
		emit_signal("restart")
