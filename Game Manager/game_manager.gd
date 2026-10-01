extends Node

signal GameStart
signal UpdateScore
signal GameOver

# GM需要维护的游戏状态
var score := 0

func _ready() -> void:
	# 监听UpdateScore、GameOver
	UpdateScore.connect(update_score)
	GameOver.connect(on_game_over)

func update_score():
	score += 1

func on_game_over():
	score = 0
