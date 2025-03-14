extends Node2D
@onready var seal_death = $SealDeathAudio
@onready var player = $Player2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.mob_died.connect(_on_mob_died)

func _on_mob_died():
	print("enter")
	seal_death.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
