extends CanvasLayer

@onready var tube_client: TubeClient = %TubeClient

@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit

@onready var button_join_tube: Button = %ButtonJoinTube
@onready var button_quit_tube: Button = %ButtonQuitTube
@onready var button_create_tube: Button = %ButtonCreateTube
@onready var input_session_id: LineEdit = %InputSessionId

const WORLD_FOREST = preload("uid://yubh30707eb7")
const PLAYER = preload("uid://dbcqeo103wau6")

func _ready() -> void:
	Network.tube_client = tube_client

	button_join.pressed.connect(on_join)
	button_quit.pressed.connect(func(): get_tree().quit())

	button_join_tube.pressed.connect(on_join_tube)
	button_quit_tube.pressed.connect(func(): get_tree().quit())
	button_create_tube.pressed.connect(on_tube_create)
	
	if OS.has_feature('server'):
		Network.start_server()
		add_world()
		hide()

func on_join():
	Network.join_server()
	add_world()
	hide()

func on_join_tube():
	Network.tube_join(input_session_id.text)
	add_world()
	hide()
	
func on_tube_create():
	Network.tube_create()
	add_world()
	hide()

func add_world():
	var new_world = WORLD_FOREST.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
	
func _exit_tree() -> void:
	tube_client.leave_session()
