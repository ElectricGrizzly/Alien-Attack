class_name HeadsUpDisplay extends Control


@onready var current_score: Label = $Score
@onready var lives_remaining: Label = $LivesRemaining

func set_score(score: int) -> void:
	current_score.text = str(score)

func set_lives(lives: int) -> void:
	lives_remaining.text = str(lives)
