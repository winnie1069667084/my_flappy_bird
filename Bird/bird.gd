extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const GRAVITY = 1500

@export var max_speed := 700.0
@onready var fly_sound := $FlySound
@onready var score_sound := $ScoreSound
@onready var cpu_particles_2d := $CPUParticles2D

const WING = preload("res://Assets/wing.wav")
const POINT = preload("res://Assets/point.wav")
const HIT = preload("res://Assets/hit.wav")

var is_dead = true
var rot_degrees := 0.0

func _ready() -> void:
	GameManager.GameStart.connect(on_game_start)
	GameManager.UpdateScore.connect(on_update_score)
	GameManager.GameOver.connect(on_game_over)

func _physics_process(delta: float) -> void:
	if not is_dead:
		velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("fly"):
			velocity.y = JUMP_VELOCITY
			fly_sound.stream = WING
			fly_sound.play()
	
		# 限制最终速度和角度
		velocity.y = clampf(velocity.y, -max_speed, max_speed)
		rot_degrees = clampf(30 * velocity.y / max_speed, -30, 30)
		rotation_degrees = rot_degrees
		
		move_and_slide()

func on_game_start():
	is_dead = false
	# 开启飞行残影
	cpu_particles_2d.emitting = true

func on_update_score():
	score_sound.stream = POINT
	score_sound.play()
	
func on_game_over():
	rotation = 0
	fly_sound.stream = HIT
	fly_sound.play()
	cpu_particles_2d.emitting = false
	is_dead = true
