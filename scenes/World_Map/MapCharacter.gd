extends CollisionShape2D


onready var path_follow : PathFollow2D = get_parent().get_node("lvl1Tolvl2Path/PathFollow2Dlvl1") 

var movement = 32 # pixels / sec

var move_direction = 0 # in degrees
#var rectangle : RectangleShape2D =  self.shape

var playerSize : Vector2 =  self.shape.get_extents();

#var rectangle_self : RectangleShape2D = (RectangleShape2D) self.Shape

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var pathLength = path_follow.get_parent().get_curve().get_baked_length();
	
	#this just moves the node itself
	var pos : Vector2
	if path_follow.get_unit_offset() < 1.0:
		var prepos = path_follow.get_global_position()
		var new_offset = path_follow.get_offset() + movement * delta
		# isn't needed if loop is turned off.
		#if(new_offset > pathLength):
		#	new_offset = pathLength
		path_follow.set_offset(new_offset)
		pos = path_follow.get_global_position()
		move_direction = (pos.angle_to_point(prepos) / 3.14) * 100
	
	#set pos actual collissionshape and 
	if pos:
		setPosCharacter(pos)
	



func setPosCharacter(pos:Vector2):
	pos.x = pos.x - playerSize.x;
	pos.y = pos.y - playerSize.y;
	self.position = pos
