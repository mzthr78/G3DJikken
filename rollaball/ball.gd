extends RigidBody3D

var direction = Vector3.FORWARD
var smooth_speed = 2.5

@onready var marker: Marker3D = $Marker3D

var speed = 3
var force_factor = 0.01

func _ready() -> void:
	marker.top_level = true

#func _physics_process(delta: float) -> void:
func _physics_process(_delta: float) -> void:
	marker.global_transform.origin = global_transform.origin
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var force = Vector3(input_dir.x, 0, input_dir.y) * force_factor
	
	if input_dir:
		apply_impulse(force * speed, position)
