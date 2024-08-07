class_name Rocket extends Area2D


@export var speed: float = 500.0

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleNotifier

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	visible_notifier.screen_exited.connect(_on_screen_exited)

func _on_screen_exited() -> void:
	print_debug("'Rocket' freed at: " + str(global_position))
	queue_free()

func _physics_process(delta: float) -> void:
	global_position.x += speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		queue_free()
		area.die()
	print_debug("'Rocket' area entered by " + area.name)
