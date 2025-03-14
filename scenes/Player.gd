extends CharacterBody2D

@export var gravity = 500.0
@export var walk_speed = 200
var walk = walk_speed
@export var run_speed = 500
var run = run_speed
@export var jump_speed = -300
var jump = jump_speed
var can_double_jump = false
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _raycast = $RayCast2D
@onready var _area2d = $Area2D

var right_tap_timer = 0
var left_tap_timer = 0
var dash_left = false
var dash_right = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if right_tap_timer > 0:
		right_tap_timer -= delta
	if left_tap_timer > 0:
		left_tap_timer -= delta
	
	if Input.is_action_just_released("ui_right"):
		right_tap_timer = 0.25
	if Input.is_action_just_released("ui_left"):
		left_tap_timer = 0.25

func _physics_process(delta):
	velocity.y += delta * gravity
	
	# Handle crouch and jump
	if Input.is_action_pressed("ui_down"):
		walk = walk_speed / 4
		run = run_speed / 4
		scale.y = 0.75
		
		if !is_on_floor():
			#_raycast.enabled = true
			#var target = _raycast.get_collider()
			
			var targets = _area2d.get_overlapping_bodies()
			
			for i in range(targets.size()):
				var target = targets[i]
				if target is Seal:
					target.dead = true
					target.death()
					
			velocity.y += delta * 20 * gravity
	else:
		#_raycast.enabled = false
		scale.y = 1
		walk = walk_speed
		run = run_speed
		
		if is_on_floor() and Input.is_action_just_pressed("ui_up"):
			velocity.y = jump
			can_double_jump = true
		elif !is_on_floor() and can_double_jump and Input.is_action_just_pressed("ui_up"):
			velocity.y = jump
			can_double_jump = false
	
	# Handle walk and run
	if Input.is_action_pressed("ui_left"):
		_animated_sprite.play("walk")
		_animated_sprite.flip_h = true
		if (left_tap_timer > 0 or dash_left):
			velocity.x = -run
			dash_left = true
		else:
			velocity.x = -walk
	elif Input.is_action_pressed("ui_right"):
		_animated_sprite.play("walk")
		_animated_sprite.flip_h = false
		if (right_tap_timer > 0 or dash_right):
			velocity.x = run
			dash_right = true
		else:
			velocity.x = walk
	else:
		_animated_sprite.play("idle")
		velocity.x = 0
		dash_left = false
		dash_right = false
	
	# "move_and_slide" already takes delta time into account....?
	
	move_and_slide()
