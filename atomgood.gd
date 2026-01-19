extends RigidBody2D

@export var level : int = 1
@onready var label: Label = $Label
var rng := RandomNumberGenerator.new()

var LEVEL_DIC : Dictionary = {
	1: ["H"],
	2: ["H", "O"],
	3: ["C", "H"]
}
	
func _apply_random_label() -> void:
	var pool : Array = LEVEL_DIC.get(level, [])
	if pool.is_empty():
		push_warning("LEVEL_DIC[%d] está vazio. Defina itens para este nível." % level)
		label.text = "@"
		return
		
	var idx := rng.randi_range(0, pool.size() - 1) #pega um número aleatório de acordo com o tamanho da array
	var picked: String = pool[idx]   # pega o valor a aleatório adquirido e transforma em um endereçamento de array
	if typeof(picked) != TYPE_STRING:
		picked = str(picked)

	label.text = picked

func set_level(new_level: int) -> void: #Variavel global
	level = new_level
	if is_inside_tree():
		_apply_random_label()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
