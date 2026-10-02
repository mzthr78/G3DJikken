extends Node3D
class_name rollaball

var collectible_scene = load("res://rollaball/collectible.tscn")

@onready var TimeLabel: Label = $Control/Label2
@onready var CountLabel: Label = $Control/Label4
@onready var ClearLabel: Label = $Control/Label5

var count = 8
var radius = 3
@onready var start_time = Time.get_unix_time_from_system()

var isPaused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ClearLabel.visible = false
	CountLabel.text = str(count)
	
	for i in range(8):
		var collectible: Area3D = collectible_scene.instantiate()
		var angle = deg_to_rad(int(360.0 / count) * i)
		collectible.position = Vector3(0, 0.5, 0) + Vector3(cos(angle), 0, sin(angle)) * radius
		#collectible.look_at(Vector3(0, 0.5, 0)) # これは効かない
		collectible.connect("collected", _on_collected)
		
		add_child(collectible)
		
	#self.connect("collected", _on_collected)
func _process(delta: float) -> void:
	if isPaused: return
	TimeLabel.text = "%.5f" % (Time.get_unix_time_from_system() - start_time)
	
func _input(event: InputEvent) -> void:
	# 録画用に追加
	if event.is_action_pressed("ui_cancel"):
		isPaused = !isPaused
		
func _on_collected():
	count -= 1
	CountLabel.text = str(count)
	
	if count <= 0:
		ClearLabel.visible = true
		get_tree().paused = true
