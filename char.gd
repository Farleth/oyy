extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO


func _ready():
	hide()
	screen_size = get_viewport_rect().size


func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if direction.length() >= 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 12,screen_size.x -12)
	position.y = clamp(position.y, 18,screen_size.y -18)
	
	if direction.x != 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.flip_h = direction.x > 0 
		
	elif direction.x == 0:
		$AnimatedSprite.animation = "idle"
		
	elif direction.y !=0:
		$AnimatedSprite.animation = "idle"
	
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_Character_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
