extends Node2D

const SPEED = -150

@onready var pipe_bottom := $pipe_bottom
@onready var pipe_top := $pipe_top
@onready var coin := $Coin
@onready var visible_on_screen_notifier_2d := $VisibleOnScreenNotifier2D
@onready var animation_player := $Coin/AnimationPlayer

func _ready() -> void:
	# 当bird进入管道区域时触发
	pipe_bottom.body_entered.connect(on_pipe_body_entered)
	pipe_top.body_entered.connect(on_pipe_body_entered)
	# 当bird进入coin区域时触发
	coin.body_entered.connect(on_coin_body_enterd)
	# 当管道离开屏幕区域时触发
	visible_on_screen_notifier_2d.screen_exited.connect(on_screen_exited)
	
func _process(delta: float) -> void:
	position.x += SPEED * delta
	
func on_pipe_body_entered(body):
	if body.is_in_group("bird") and not body.is_dead:
		GameManager.GameOver.emit()

func on_coin_body_enterd(body):
	if body.is_in_group("bird"):
		GameManager.UpdateScore.emit()
		animation_player.play("coin")
		await animation_player.animation_finished
		coin.queue_free()
	
func on_screen_exited():
	queue_free()
