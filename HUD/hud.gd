extends CanvasLayer

@onready var score_label := $MarginContainer/VBoxContainer/ScoreLabel
@onready var message := $MarginContainer/VBoxContainer/Message
@onready var button := $MarginContainer/VBoxContainer/Button

func _ready() -> void:
	update_score()
	button.pressed.connect(on_button_pressed)
	GameManager.UpdateScore.connect(on_update_score)
	GameManager.GameOver.connect(on_game_over)

func update_score():
	score_label.text = "Score: %s" %str(GameManager.score)

func on_button_pressed():
	GameManager.GameStart.emit()
	button.hide()
	message.hide()
	
func on_update_score():
	update_score()
	
func on_game_over():
	update_score()
	message.text = "Game Over"
	message.show()
	button.show()
