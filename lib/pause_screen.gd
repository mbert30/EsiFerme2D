extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_get_pause()
	
func _get_pause():
	if Input.is_action_just_released("player_pause"):
		if self.visible == false:
			self.show()
			get_tree().paused = true
		else: 
			self.hide()
			get_tree().paused = false

func _on_button_resume_pressed():
	self.hide()
	get_tree().paused = false

func _on_button_save_pressed():
	get_tree().quit()
