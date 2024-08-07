class_name Game extends Node2D


@export var lives: int = 3

@onready var player: Player = $Player
@onready var enemy_spawner: EnemySpawner = $EnemySpawner
@onready var hud: HeadsUpDisplay = $UI/HUD
@onready var ui: CanvasLayer = $UI
@onready var player_hit_sound: AudioStreamPlayer = $PlayerHitSound
@onready var enemy_hit_sound: AudioStreamPlayer = $EnemyHitSound

var game_over_scene: PackedScene = preload('res://scenes/game_over_screen.tscn')
var score: int = 0

func _ready() -> void:
	player.damage_received.connect(_on_damage_received)
	enemy_spawner.enemy_spawned.connect(_on_enemy_spawned)
	enemy_spawner.path_enemy_spawned.connect(_on_path_enemy_spawned)
	_initialize_hud()

func _initialize_hud() -> void:
	hud.set_score(score)
	hud.set_lives(lives)

func _on_damage_received() -> void:
	lives -= 1
	player_hit_sound.play()
	
	hud.set_lives(lives)
	if is_game_over():
		game_over()

func is_game_over() -> bool:
	return lives <= 0

func game_over() -> void:
	player.die()
	
	await get_tree().create_timer(0.5).timeout
	
	var game_over_screen: GameOverScreen = game_over_scene.instantiate()
	ui.add_child(game_over_screen)
	game_over_screen.set_score(score)

func _on_enemy_spawned(enemy: Enemy) -> void:
	add_child(enemy)
	enemy.died.connect(_on_enemy_death)
	
func _on_path_enemy_spawned(path_enemy: PathEnemy) -> void:
	add_child(path_enemy)
	path_enemy.enemy.died.connect(_on_enemy_death)
	
func _on_enemy_death() -> void:
	score += 100
	enemy_hit_sound.play()
	hud.set_score(score)
