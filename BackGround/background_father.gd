extends ParallaxBackground

const SPEED = -150

func _process(delta: float) -> void:
	scroll_offset.x += SPEED * delta
