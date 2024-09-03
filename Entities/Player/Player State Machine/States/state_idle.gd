class_name State_Idle extends State

@onready var walk : State = $"../Walk"

# Enters State
func Enter() -> void:
	player.UpdateAnimation("idle")

# Exits State
func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func Phisics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	