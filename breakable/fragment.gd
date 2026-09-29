extends RigidBody3D
class_name Fragment

var collision: CollisionShape3D
var lifetime = 0

func _init(source: MeshInstance3D) -> void:
	global_transform = source.global_transform
	# ここで　print(global_transform)　しても出力できない？
	
	collision = CollisionShape3D.new()
	collision.shape = source.mesh.create_convex_shape()
	add_child(collision)
	
	var mesh: MeshInstance3D = source.duplicate()
	mesh.transform = global_transform
	add_child(mesh)
	
func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
