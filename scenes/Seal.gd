extends CharacterBody2D
class_name Seal

@export var gravity = 500.0
var direction = 1
var start_position = 0
var walking_distance = 50
@export var speed = 20
@onready var _animated_sprite = $AnimatedSprite2D
var dead = false

func _ready():
	start_position = position.x

func _physics_process(delta):
	
	if !dead:
		velocity.y += delta * gravity
		position.x += direction * speed * delta
		
		_animated_sprite.play("walk")
		
		if (position.x >= start_position + walking_distance):
			_animated_sprite.flip_h = true
			direction = -1

		if (position.x <= start_position - walking_distance):
			_animated_sprite.flip_h = false
			direction = 1
		
		move_and_slide()

func death():
	_animated_sprite.play("splat")
	$CollisionShape2D.disabled=true
	GlobalSignals.mob_died.emit()
