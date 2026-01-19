extends CanvasLayer

@onready var sprite: Sprite2D = $"Sprite2D"
@export var textures: Array[Texture2D]
var contador = 0

func mensage_edit(level):
	if level == 1:
		$MsgLabel.text = "Encontre os Hidrogênios para fomar o H₂O"
	if level == 2:
		$MsgLabel.text = "Encontre as células pra fazer a fórmula química do metanol (CH₃OH)"
	if level == 3:
		$MsgLabel.text = "Encontre o Nitrogênio (H)"
	if level == 4:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
	if level == 5:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
	if level == 6:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
		
func sprite_show():
	var p := get_parent() # pega o pai atual do nó
	
	#---------Level 1-----------
	if p and p.name == "Level01":
		contador += 1
		if contador == 1:
			sprite.texture = textures[0]
		if contador == 2:
			sprite.texture = textures[1]
		if contador >= 3:
			contador = 0
	#----------Level 2-----------
	if p and p.name == "Level02": # vai do 2-6
		
		contador += 1
		if contador == 1:
			sprite.texture = textures[2]
		if contador == 2:
			sprite.texture = textures[3]
		if contador == 3:
			sprite.texture = textures[4]
		if contador == 4:
			sprite.texture = textures[5]
		if contador == 5:
			sprite.texture = textures[6]
			contador = 0
