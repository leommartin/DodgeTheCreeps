extends RigidBody2D

# Exported variables for configuring speed ranges  
@export var min_speed: int # Minimum speed range.  
@export var max_speed: int # Maximum speed range.  
var mob_types = ["walk", "swim", "fly"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	# randi() % n obtains an integer between 0 and n - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
