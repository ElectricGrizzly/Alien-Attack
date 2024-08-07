class_name Enemy extends Area2D


signal died

@export var speed: float = 200.0

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleNotifier

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	visible_notifier.screen_exited.connect(_on_screen_exited)

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		body.take_damage()
		die()

func _on_screen_exited() -> void:
	print_debug("'Enemy' freed at: " + str(global_position))
	queue_free()

func _physics_process(delta: float) -> void:
	global_position.x += -speed * delta

func die() -> void:
	died.emit()
	queue_free()
