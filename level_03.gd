extends Node

@export var atomsec_scene: PackedScene
@export var atomgood_scene: PackedScene

var level: int = 3

func _ready() -> void:
	$UI.show()
	$Atomsec.set_level(level)
	$StartTimer.start() #assim que esse inicia também inicia o atomsec_timer e o atomgood_timer
	$Player.niveis_player(level)
	$Atomgood.set_level(level)
	$Player.start($StartPosition.position)
	$UI.mensage_edit(level)

func _on_atomsec_timer_timeout(): # --> faz os Atomsec andar/surgir aleatoriamente pela tela
	var atomsec = atomsec_scene.instantiate()

	var atomsec_spawn = $AtomPath/AtomSpawn
	atomsec_spawn.progress_ratio = randf()

	atomsec.position = atomsec_spawn.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = atomsec_spawn.rotation + PI / 2

	#Faz os Átomos irem na diagonal, porém, faz o Label ficar torto também
	direction += randf_range(-PI / 4, PI / 4)
	atomsec.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	atomsec.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(atomsec)
	atomsec.set_level(level)



func _on_atomgood_timer_timeout(): #--> Faz o AtomGood andar/surgir pela tela aleatoriamente
	var atomgood = atomgood_scene.instantiate()

	var atomgood_spawn = $AtomPath/AtomSpawn
	atomgood_spawn.progress_ratio = randf()

	atomgood.position = atomgood_spawn.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = atomgood_spawn.rotation + PI / 2

	#Faz os Átomos irem na diagonal, porém, faz o Label ficar torto também
	direction += randf_range(-PI / 4, PI / 4)
	atomgood.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	atomgood.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(atomgood)
	atomgood.set_level(level)

func _on_start_timer_timeout() -> void:
	$AtomsecTimer.start()
	$AtomgoodTimer.start()
