extends Node
signal init_level
@export var level_01: PackedScene
@onready var UI = $"Level01/UI"

func _ready() -> void:
	UI.hide()

func _new_game() -> void:
	init_level.emit()
	
	
