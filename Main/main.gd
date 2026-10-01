extends Node2D

var pipes_scene := preload("res://Pipes/pipes.tscn")

# 管道随机生成的幅度
const GAP = 180

@onready var bird := $Bird
@onready var pipes_group := $PipesGroup
@onready var spawn_point := $SpawnPoint
@onready var timer := $Timer
@onready var top_edge := $TopEdge
@onready var bottom_edge := $BottomEdge

func _ready() -> void:
	GameManager.GameStart.connect(on_game_start)
	GameManager.GameOver.connect(on_game_over)
	top_edge.body_entered.connect(on_edge_body_entered)
	bottom_edge.body_entered.connect(on_edge_body_entered)
	timer.timeout.connect(on_timer_timeout)

func on_game_start():
	timer.start()
	new_pipes()
	
func on_game_over():
	timer.stop()
	reset_game()
	
func on_edge_body_entered(body):
	if body.is_in_group("bird"):
		GameManager.GameOver.emit()
		
func on_timer_timeout():
	new_pipes()
	
func new_pipes():
	var pipes = pipes_scene.instantiate()
	var pos_y = spawn_point.position.y + randf_range(-GAP, GAP)
	pipes.position = Vector2(spawn_point.position.x, pos_y)
	pipes_group.add_child(pipes)
	
func reset_game():
	# 归位bird
	bird.position = Vector2(160, 300)
	# 清空管道
	for pipe in pipes_group.get_children():
		pipe.queue_free()
