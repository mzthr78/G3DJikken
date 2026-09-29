extends Node3D

@export var speed: float = 3
@export var min_lifetime: float = .6
@export var max_lifetime: float = .8

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		explode()

func explode():
	var parent = get_parent()
	queue_free()
	
	for child in $cube_breakable.get_children():
		if child is MeshInstance3D:
			var fragment: Fragment = Fragment.new(child)
			parent.add_child(fragment)
			
			fragment.linear_velocity = Vector3(fragment.global_transform.origin - $Marker3D.global_transform.origin).normalized() * speed
			fragment.lifetime = randf_range(min_lifetime, max_lifetime)
