class_name EnemySpawner extends Node2D


signal enemy_spawned(enemy: Enemy)
signal path_enemy_spawned(path_enemy: PathEnemy)

@onready var spawn_positions_container: Node2D = $SpawnPositionsContainer
@onready var straight_spawn_timer: Timer = $StraightSpawnTimer
@onready var path_spawn_timer: Timer = $PathSpawnTimer

var enemy_scene: PackedScene = preload("res://scenes/enemy.tscn")
var path_enemy_scene: PackedScene = preload("res://scenes/path_enemy.tscn")

func _ready() -> void:
	straight_spawn_timer.timeout.connect(_on_straight_timer_timeout)
	path_spawn_timer.timeout.connect(_on_path_timer_timeout)

func _on_straight_timer_timeout() -> void:
	spawn_straight_enemy()

func _on_path_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_straight_enemy() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	
	var spawn_position: Marker2D = get_random_spawn_position()
	enemy.global_position = spawn_position.global_position
	
	enemy_spawned.emit(enemy)

func get_random_spawn_position() -> Marker2D:
	return spawn_positions_container.get_children().pick_random()

func spawn_path_enemy() -> void:
	var path_enemy: PathEnemy = path_enemy_scene.instantiate()
	path_enemy_spawned.emit(path_enemy)
