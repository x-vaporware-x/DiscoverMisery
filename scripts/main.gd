extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_cancel")):
		get_tree().quit()
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()
	if(Input.is_action_just_pressed("maximize")):
		OS.window_fullscreen = !OS.window_fullscreen
