extends Area2D

signal hit

# Script para adicionar movimento/animação do jogador e para detectar colisões.
@export var speed = 400 #How fast the player will move (pixels/sec).
var screen_size #Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready() -> void: # verificar este void
	screen_size = get_viewport_rect().size
	# hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # velocidade = (x: 0, y: 0)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
  
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta # delta = duração do frame anterior
	# limita os movimentos do jogador para que não saia da tela
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
		
func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	# Don't generate other signal hit.. set deferred do it in a security way
	$CollisionShape2D.set_deferred("disable", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	# Stop before change position of StartPosition to (240,250)
	
	
