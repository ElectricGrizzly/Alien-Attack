class_name PathEnemy extends Path2D


@onready var path_follow: PathFollow2D = $PathFollow
@onready var enemy: Enemy = $PathFollow/Enemy

func _ready() -> void:
	path_follow.set_progress_ratio(1)
	enemy.speed = 0
	
func _process(delta) -> void:
	path_follow.progress_ratio -= 0.25 * delta
	if is_path_end():
		queue_free()
	
func is_path_end() -> bool:
	return path_follow.progress_ratio <= 0
