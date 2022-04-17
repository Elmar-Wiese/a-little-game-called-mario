extends Sprite

onready var path_follow = get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var movement = 250

var move_direction = 0 # in degrees

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _process(delta):
	#var prepos = path_follow.get_global_position()
	#path_follow.set_offset(path_follow.get_offset() + movement * delta)
	#var pos = path_follow.get_global_position()
	#move_direction = (pos.angle_to_point(prepos) / 3.14) * 100

