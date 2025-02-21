extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300
var can_double_jump = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		can_double_jump = true
	elif !is_on_floor() and can_double_jump and Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
		can_double_jump = false
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = walk_speed
	else:
		velocity.x = 0
	
	# "move_and_slide" already takes delta time into account....?
	
	move_and_slide()
