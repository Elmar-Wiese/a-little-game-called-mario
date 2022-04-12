extends Node2D

signal box_moved(from, to)

# adapted from https://kidscancode.org/godot_recipes/2d/grid_movement/

const TILE_SIZE: int = 64
const inputs = {
	"ui_right": Vector2.RIGHT, "ui_left": Vector2.LEFT, "ui_up": Vector2.UP, "ui_down": Vector2.DOWN
}

onready var movement_ray: RayCast2D = $MovementRaycast

onready var box_map: TileMap = get_tree().get_nodes_in_group("boxes")[0]
onready var box_id: int = box_map.tile_set.find_tile_by_name("Box")
onready var background_id: int = box_map.tile_set.find_tile_by_name("Background")


func _ready():
	self.position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE / 2


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			try_move(dir)


func try_move(dir):
	var direction: Vector2 = inputs[dir]
	movement_ray.cast_to = direction * TILE_SIZE
	movement_ray.force_raycast_update()
	if !movement_ray.is_colliding():
		force_move(dir)
	# Are we colliding with the box layer?
	if movement_ray.get_collider() == box_map:
		var tile_pos := box_map.world_to_map(self.position)
		tile_pos += direction * 1
		# Is there space behind the box?
		var intersections: Array = get_world_2d().get_direct_space_state().intersect_point(
			self.position + direction * TILE_SIZE * 2
		)
		for intersection in intersections:
			if intersection.collider is TileMap:
				return

		# There's space, move the box
		box_map.set_cellv(tile_pos, -1)
		box_map.set_cellv(tile_pos + direction * 1, box_id)
		# Move the player with the box
		force_move(dir)
		emit_signal("box_moved", tile_pos, tile_pos + direction * 1)


func force_move(dir):
	self.position += inputs[dir] * TILE_SIZE
