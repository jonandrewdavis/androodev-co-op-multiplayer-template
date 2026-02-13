extends CanvasLayer

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit

@onready var button_join_tube: Button = %ButtonJoinTube
@onready var button_quit_tube: Button = %ButtonQuitTube
@onready var button_create_tube: Button = %ButtonCreateTube
@onready var input_session_id: LineEdit = %InputSessionId

const WORLD_FOREST = preload("uid://yubh30707eb7")
const PLAYER = preload("uid://dbcqeo103wau6")

func _ready() -> void:
	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())

	button_join_tube.pressed.connect(on_join_tube)
	button_quit_tube.pressed.connect(func(): get_tree().quit())
	button_create_tube.pressed.connect(on_tube_create)
	
	if OS.has_feature('server'):
		Network.start_server()
		add_world()
	
func on_join():
	Network.join_server()
	add_world()

func on_join_tube():
	Network.tube_join(input_session_id.text)
	add_world()

func on_tube_create():
	Network.tube_create()
	add_world()

func add_world():
	get_tree().current_scene.add_child(WORLD_FOREST.instantiate())
	hide()

func handle_tube_error(_code, _message):
	show()
