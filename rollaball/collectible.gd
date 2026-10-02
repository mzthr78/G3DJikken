extends Area3D

signal collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("body_entered", _on_body_entered.bind())
	
	look_at(Vector3(0, 0.5, 0))
	
func _on_body_entered(body: Node3D) -> void:
	if body.name != "Ball": return
	collected.emit()
	queue_free()
