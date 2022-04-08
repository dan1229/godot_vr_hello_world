extends State
class_name PlayerState
# Base type for the player's state classes. Contains boilerplate code to get
# autocompletion and type hints.

var player: Player = $Player/Player
var skin: Mannequiny = $Player/Mannequiny


func _ready() -> void:
	yield(owner, "ready")
	player = owner
	skin = owner.skin
