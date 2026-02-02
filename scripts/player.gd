extends StaticBody2D

@export var speed := 500.0

@onready var _mesh_instance_2d: MeshInstance2D = %MeshInstance2D
@onready var _game_manager: GameManager = %GameManager
@onready var _menu_ui: Menu = %MenuUI

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_in_group("Player_1"):
		if Input.is_action_pressed("move_up"):
			global_position.y -= speed * delta
		elif Input.is_action_pressed("move_down"):
			global_position.y += speed * delta
	if is_in_group("Player_2"):
		# 1 Player mode
		if _menu_ui.is_1_player:
			if _game_manager.ball != null:
				# Steering Behaviour: AI controlled second player
				var desired_position := _game_manager.ball.global_position.y - global_position.y
				var steering_force := randf_range(9.5, 12.5)
				global_position.y += desired_position * delta * steering_force
		# 2 Players mode
		else:
			if Input.is_action_pressed("move_up_alt"):
				global_position.y -= speed * delta
			elif Input.is_action_pressed("move_down_alt"):
				global_position.y += speed * delta
		
	# prevents the player from moving out of viewport
	var viewport_size := get_viewport_rect().size
	var player_height := _mesh_instance_2d.scale.y
	global_position.y = clamp(global_position.y, player_height/2.0, viewport_size.y - player_height/2.0)

	
