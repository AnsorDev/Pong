class_name GameManager extends Node

@onready var _score_ui: Score = %ScoreUI
@onready var _menu_ui: Menu = %MenuUI
@onready var _players: Node2D = %Players
@onready var _player1_goal_area: Area2D = %Player1_GoalArea
@onready var _player2_goal_area: Area2D = %Player2_GoalArea

var ball: Ball

var player1_score := 0
var player2_score := 0

func _ready() -> void:	
	_player1_goal_area.body_entered.connect(func(body_that_entered: Node2D) -> void:
		if body_that_entered is RigidBody2D:
			player1_score += 1
			_score_ui.player1_score_label.text = str(player1_score)	
			
			_spawn_ball()
	)
	
	_player2_goal_area.body_entered.connect(func(body_that_entered: Node2D) -> void:
		if body_that_entered is RigidBody2D:
			player2_score += 1
			_score_ui.player2_score_label.text = str(player2_score)	
			
			_spawn_ball()
	)
	
	_players.modulate.a = 0.0


func _process(_delta: float) -> void:
	# spawns the first ball after the menu button press
	if _menu_ui.start_game:
		# makes the players visible 
		var tween := create_tween()
		tween.tween_property(_players, "modulate:a", 1.0, 0.1)

		_spawn_ball()
		_menu_ui.start_game = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func _spawn_ball() -> void:
	if ball != null: 
		await ball._audio_stream_player.finished
		ball.queue_free()
	
	await get_tree().create_timer(0.5).timeout
	ball = preload("res://scenes/ball.tscn").instantiate()
	get_tree().current_scene.call_deferred("add_child", ball)
