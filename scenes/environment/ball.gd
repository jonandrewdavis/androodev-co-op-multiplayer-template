extends RigidBody3D

@onready var area_3d: Area3D = $Area3D

func _ready() -> void:
	area_3d.body_entered.connect(on_ball_hit)

func on_ball_hit(body: Node3D):
	if body.is_in_group('Players'):
		queue_free()
