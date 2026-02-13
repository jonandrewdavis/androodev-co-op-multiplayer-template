extends Node

var username: String

var forest: Node3D
var spawn_container: Node3D

const BALL = preload("uid://c1yny3sauy8yu")

@rpc("any_peer", 'call_local')
func shoot_ball(pos: Vector3, dir: Vector3, force: float):
	var new_ball: RigidBody3D = BALL.instantiate()
	new_ball.position = pos + Vector3(0.0, 1.5, 0.0) + (dir * 1.2)
	spawn_container.add_child(new_ball, true)
	new_ball.apply_central_impulse(dir * force)
