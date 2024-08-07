class_name Player extends CharacterBody2D


signal damage_received

@export var speed: float = 300.0
@export var rocket_offset: Vector2 = Vector2(25.0, 0.0)
@export var rocket_scene: PackedScene = preload("res://scenes/rocket.tscn")

@onready var rocket_container: Node = $RocketContainer
@onready var shoot_sound: AudioStreamPlayer = $ShootSound

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		perform_action()

func perform_action() -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	var rocket: Rocket = rocket_scene.instantiate()
	rocket_container.add_child(rocket)
	shoot_sound.play()
	align_rocket(rocket)

func align_rocket(rocket: Rocket) -> void:
	rocket.global_position = global_position + rocket_offset

func _physics_process(delta) -> void:
	if Input.is_anything_pressed():
		perform_physics_action()

func perform_physics_action() -> void:
	apply_velocity()

func apply_velocity() -> void:
	velocity = Vector2(0.0, 0.0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
		
	move_and_slide()
	clamp_position()
	
	print_debug("player velocity: " + str(velocity))
	print_debug("player position: " + str(global_position))

func clamp_position() -> void:
	var RESOLUTION: Vector2 = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0.0, 0.0), RESOLUTION)
	
func take_damage() -> void:
	damage_received.emit()
	
func die() -> void:
	queue_free()
