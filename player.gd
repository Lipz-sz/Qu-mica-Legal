extends Area2D


@export var speed: float = 300.0
@export var limite_erros: int = 3 #limite_erros: int = 5 #<-- modo easy
@export var textures: Array[Texture2D]

var screen_size: Vector2
var erros: int = 0
var invulneravel: bool = false
var ligacao: int = 0
var level_global: int = 0 #função promover variavel local (level) para o escopo do objet
var controle: int = 0

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var label_erros: Label = $"../UI/ErroLabel"   # ajuste caminho conforme sua cena
@onready var msg_label: Label  = $"../UI/MsgLabel"
@onready var label: Label  = $"Label"

func _ready():
	sprite.texture = textures[0]
	screen_size = get_viewport_rect().size
	if label_erros:
		label_erros.text = "Erros: %d/%d" % [erros, limite_erros]
		
func start(pos):
	position = pos
	show()

func niveis_player(level):
	if level == 1:
		level_global = level
		label.text = "O"
	if level == 2:	# TODO ainda falta escrever
		level_global = level
		label.text = "C" 
	if level == 3:	# TODO ainda falta escrever
		level_global = level
		label.text = "H"
	if level == 4:	# TODO ainda falta escrever
		level_global = level
		label.text = "H"
	if level == 5:	# TODO ainda falta escrever
		level_global = level
		label.text = "H"
	if level == 6:	# TODO ainda falta escrever
		level_global = level
		label.text = "H"
		
func _process(delta): # --> Movimento do player
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	#correr
	if Input.is_action_pressed("run"):
		speed = 1000
	if Input.is_action_just_released("run"):
		speed = 300

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(body: RigidBody2D): # aqui fica tudo que acontece quando entra na hitbox do Area2D
	# Diferencia pelo grupo
	if body.is_in_group("atom_bad"):
		_sofrer_erro(body)
	elif body.is_in_group("atom_correct"):
		level_body(body)


func level_body(body) -> void:
	var p := get_parent()
	if p and p.name == "Level01":
		if $"../Atomgood/Label".text == "H":
			ligacao += 1 # conrole de Label
			sprite.texture = textures[1]
			sprite.scale = Vector2(0.12,0.12)
			get_tree().queue_delete(body)
			sprit_inferior(ligacao)
			if ligacao == 3:
				label.text = "?"
			if ligacao > 3:
				_sofrer_erro(body)

	if p and p.name == "Level02":
		if $"../Atomgood/Label".text == "H" and "O":
			ligacao += 1 # conrole de Label
			sprite.texture = textures[1]
			sprite.scale = Vector2(0.12,0.12)
			get_tree().queue_delete(body)
			sprit_inferior(ligacao)
			if ligacao == 6:
				label.text = "?"
			if ligacao > 6:
				_sofrer_erro(body)


func _on_area_entered(area: Area2D):
	if area.is_in_group("entrega_group"):
		if level_global == 1:
			level_1()
		if level_global == 2:
			level_2()

#----------------------------LÓGICA DE NÍVEIS (ENTREGA) -----------------------------------
func level_1():
	if ligacao == 1:
		msg_label.text = "Ainda falta um célula de Hidrogênio."
		await get_tree().create_timer(2.5).timeout
		msg_label.text = "Encontre os Hidrogênios para fomar o H₂O."
	elif ligacao == 2:
		msg_label.position = Vector2(5,360)
		msg_label.text = "Parabéns!! Você formou o H₂O, mais conhecido como, água."
		await get_tree().create_timer(2.5).timeout
		get_tree().call_group("atom_correct","queue_free")
		get_tree().call_group("atom_bad","queue_free")
		$"../StartTimer".stop()
		get_tree().change_scene_to_file("res://level_02.tscn")
	elif ligacao >= 3:
		msg_label.text = "Fórmula química não encontrada."
		await get_tree().create_timer(2.0).timeout
		msg_label.text = "Reiniciando..."
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()


func level_2():
	if ligacao < 5:
		msg_label.text = "Ainda falta outras células."
		await get_tree().create_timer(2.5).timeout
		msg_label.text = "Forme o a fórmula química do metanol (CH₃OH)."
		msg_label.scale = Vector2(20,20)
	elif ligacao == 5:
		msg_label.position = Vector2(5,360)
		msg_label.text = "Parabéns!! Você formou o CH₃OH, infelizmente conhecido por, metanol."
		await get_tree().create_timer(2.0).timeout
		get_tree().call_group("atom_correct","queue_free")
		get_tree().call_group("atom_bad","queue_free")
		$"../StartTimer".stop()
		get_tree().change_scene_to_file("res://level_03.tscn")
	elif ligacao >= 6:
		msg_label.text = "Fórmula química não encontrada."

			
#----------------------------LÓGICA DE NÍVEIS -----------------------------------
			
func sprit_inferior(_ligacao):
	var p := get_parent()
	
	if p and p.name == "Level01":
		if ligacao == 1: # resposta do controle de Label
			label.text = "HO"
			$"../UI".sprite_show()
		elif ligacao == 2:
			label.text = "H₂O"
			$"../UI".sprite_show()

	if p and p.name == "Level02":
		if ligacao == 1:
			label.text = "CH"
			$"../UI".sprite_show()
		if ligacao == 2:
			label.text = "CH₂"
			$"../UI".sprite_show()
		if ligacao == 3:
			label.text = "CH₃"
			$"../UI".sprite_show()
		if ligacao == 4:
			label.text = "CH₃O"
			$"../UI".sprite_show()
		if ligacao == 5:
			label.text = "CH₃OH"
			$"../UI".sprite_show()


func _sofrer_erro(area_que_bateu: RigidBody2D):
	if invulneravel:
		return
	erros += 1
	if label_erros:
		label_erros.text = "Erros: %d/%d" % [erros, limite_erros]

	# Feedback visual + som (se tiver)
		invulneravel = true
		modulate = Color(1, 0.8, 0.8)

	# Knockback simples na direção oposta ao contato
	var dir := (global_position - area_que_bateu.global_position).normalized()
	var knockback_dist := 28.0
	position += dir * knockback_dist

	# Pequena janela de invulnerabilidade para não contar múltiplos hits seguidos
	await get_tree().create_timer(0.35).timeout
	modulate = Color(1, 1, 1)
	invulneravel = false

	# Regra de derrota
	if erros >= limite_erros:
		if msg_label:
			msg_label.text = "Você foi atingido %d vezes. Reiniciando..." % limite_erros
		await get_tree().create_timer(2.5).timeout
		get_tree().reload_current_scene()
		
