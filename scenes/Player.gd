extends CharacterBody2D

@export var gravity = 500.0
@export var walk_speed = 200
@export var run_speed = 500
@export var jump_speed = -300
var can_double_jump = false

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
	
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		can_double_jump = true
	elif !is_on_floor() and can_double_jump and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		can_double_jump = false
	
	
	
	if Input.is_action_pressed("ui_left"):
		if (left_tap_timer > 0 or dash_left):
			velocity.x = -run_speed
			dash_left = true
		else:
			velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		if (right_tap_timer > 0 or dash_right):
			velocity.x = run_speed
			dash_right = true
		else:
			velocity.x = walk_speed
	else:
		velocity.x = 0
		dash_left = false
		dash_right = false
	
	# "move_and_slide" already takes delta time into account....?
	
	move_and_slide()
