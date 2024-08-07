class_name GameOverScreen extends Control


@onready var retry_button: Button = $Panel/Retry
@onready var final_score: Label = $Panel/Score

func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	
func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func set_score(score: int) -> void:
	final_score.text = "SCORE: " + str(score)
