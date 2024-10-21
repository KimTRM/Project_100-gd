@icon("res://Assets/Art/Entities/Player/Player.png") 
class_name Player extends CharacterBody2D

var AniDirction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_manager: PlayerStateManager = $"State Machine"
@onready var interact_dir: Marker2D = $Direction

# Called when the node enters the scene tree for the first time.
func _ready():
	state_manager.Initialize(self)
# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
	
func _physics_process(_delta):
	move_and_slide()

func SetDirection() -> bool:
	var new_dir: Vector2 = AniDirction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == AniDirction:
		return false
	
	AniDirction = new_dir
	sprite.scale.x = -1 if AniDirction == Vector2.LEFT else 1
	interact_dir.rotation = 90 if AniDirction == Vector2.LEFT else -90
	return true

func UpdateAnimation( state : String) -> void:
	animation_player.play( state + "_" + AnimDirection() )

func AnimDirection() -> String:
	if AniDirction == Vector2.DOWN:
		return "down"
	elif AniDirction == Vector2.UP:
		return "up"
	else:
		return "side"
	
