extends Node3D

@onready var spawn_container: Node3D = %SpawnContainer
@onready var timer_targets: Timer = %TimerTargets

const TARGET = preload("uid://uo1xep4bn61c")

func _ready() -> void:
	Global.forest = self
	Global.spawn_container = spawn_container
	
	timer_targets.timeout.connect(spawn_target)

func spawn_target():
	if is_multiplayer_authority() and spawn_container.get_child_count() < 10:
		var new_target = TARGET.instantiate()
		var rand_x = randf_range(-25.0, 25.0)
		var rand_z = randf_range(-25.0, 25.0)
		new_target.position = Vector3(rand_x, 1.0, rand_z)
		spawn_container.add_child(new_target, true)
