extends CanvasLayer

@onready var sprite: Sprite2D = $"Sprite2D"
@export var textures: Array[Texture2D]
var contador = 0

func mensage_edit(level):
	if level == 1:
		$MsgLabel.text = "Encontre os Hidrogênios para fomar o H₂O"
	if level == 2:
		$MsgLabel.text = "Encontre o Nitrogênio (N)"
	if level == 3:
		$MsgLabel.text = "Encontre o Nitrogênio (H)"
	if level == 4:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
	if level == 5:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
	if level == 6:
		$MsgLabel.text = "Encontre o Nitrogênio (O)"
		
func sprite_show():
	contador += 1
	if contador == 1:
		sprite.texture = textures[0]
	if contador == 2:
		sprite.texture = textures[1]
