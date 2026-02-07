extends CanvasLayer

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit

const WORLD_FOREST = preload("uid://yubh30707eb7")
const PLAYER = preload("uid://dbcqeo103wau6")

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())

	if OS.has_feature('server'):
		Network.start_server()
		add_world()
		hide()

func on_join():
	Network.join_server()
	add_world()
	hide()

func add_world():
	var new_world = WORLD_FOREST.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
