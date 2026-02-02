class_name Menu extends Control

@onready var _1_player_button: Button = %"1_PlayerButton"
@onready var _2_players_button: Button = %"2_PlayersButton"
@onready var _exit_button: Button = %ExitButton
@onready var _audio_stream_player_music: AudioStreamPlayer = %AudioStreamPlayerMusic

var is_1_player: bool
var start_game := false

func _ready() -> void:
	get_tree().paused = true
	
	_1_player_button.pressed.connect(func() -> void:
		is_1_player = true
		menu_setup()
	)
	
	_2_players_button.pressed.connect(func() -> void:
		is_1_player = false
		menu_setup()
	)
	
	_exit_button.pressed.connect(func() -> void:
		get_tree().quit()
	)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_1):
			is_1_player = true
			menu_setup()
		elif Input.is_key_pressed(KEY_2):
			is_1_player = false
			menu_setup()
		elif Input.is_key_pressed(KEY_3):
			get_tree().quit()
	
func menu_setup() -> void:
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "modulate:a", 0.0, 0.9)
	tween.tween_property(_audio_stream_player_music, "volume_db", -50, 1.5)
	
	start_game = true
	
	await tween.finished
	get_tree().paused = false
	visible = false
	_audio_stream_player_music.playing = false
