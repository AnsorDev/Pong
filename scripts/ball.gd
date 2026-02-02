class_name Ball extends RigidBody2D

@export var speed := 500.0

@onready var _area_2d: Area2D = %Area2D
@onready var _audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

const RIGHT = true
const LEFT = false

func _ready() -> void:
	
	# Ball hitting Player
	_area_2d.body_entered.connect(func(body_that_entered: Node2D) -> void:
		_audio_stream_player.stream = preload("res://sounds_ping_pong_8bit/ping_pong_8bit_plop.ogg")
		_audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
		_audio_stream_player.play()
		
		# moves ball faster after each hit with player8
		if body_that_entered.is_in_group("Players"):
			speed += 100
			speed = clampf(speed, 500.0, 2000.0)
			if body_that_entered.is_in_group("Player_1"):
				linear_velocity = ball_direction(RIGHT) * speed
			elif body_that_entered.is_in_group("Player_2"):
				linear_velocity = ball_direction(LEFT) * speed
	)
	
	# Ball entering Goal Area
	_area_2d.area_entered.connect(func(_area_that_entered: Area2D) -> void:
		_audio_stream_player.stream = preload("res://sounds_ping_pong_8bit/ping_pong_8bit_beeep.ogg")
		_audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
		_audio_stream_player.play()
	)
	
	# Movement and direction at the begining
	var random_direction := RIGHT if randi() % 2 else LEFT
	linear_velocity = ball_direction(random_direction) * speed

## calculates the direction the ball will move to
## depending on is_direction_right either will face the right side or the left
func ball_direction(is_direction_right: bool) -> Vector2:
	if is_direction_right == true:
		return Vector2.RIGHT.rotated(randf_range(deg_to_rad(-45), deg_to_rad(45)))
	else:
		return Vector2.RIGHT.rotated(randf_range(deg_to_rad(135), deg_to_rad(225)))
	
