extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.make_current() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
