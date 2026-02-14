extends RigidBody3D

@export var health := 100

func take_damage(damage: int, source: int):
	var next_health = health - damage
	var players: Array[Node] = get_tree().get_nodes_in_group('Players')
	var player_index = players.find_custom(func(item): return item.name == str(source))

	if next_health == 0:
		players[player_index].register_hit.rpc(true)
		queue_free()
	else:
		players[player_index].register_hit.rpc()
		health = next_health
