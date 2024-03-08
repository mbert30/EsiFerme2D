class_name Inventory extends Node

#Liste variable
var hand:Tool = Tool.new(1, 'hand', 0)
var axe:Tool = Tool.new(2, 'axe', 20)
var watercan:Tool = Tool.new(3, 'watercan', 20)
var hoe:Tool = Tool.new(4, 'hoe', 20)
var redMelon:Seed = Seed.new(1, 'redmelon', 15, 2, 20, 40)
var wheat:Seed = Seed.new(2, 'wheat', 15, 10, 10, 20)
var coin:int = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _get_hand() -> Tool:
	return hand

func _get_axe() -> Tool:
	return axe

func _set_axe(newAxe) -> void:
	axe = newAxe

func _get_watercan() -> Tool:
	return watercan

func _set_watercan(newWatercan) -> void:
	watercan = newWatercan

func _get_hoe() -> Tool:
	return hoe

func _set_hoe(newHoe) -> void:
	hoe = newHoe

func _get_seed(seed:String) -> Seed:
	match seed:
		"wheat":
			return wheat
		"redmelon":
			return redMelon
		_:
			return wheat

func _set_nbSeed(seed:String, nbSeed:int) -> void:
	_get_seed(seed)._set_nbSeed(nbSeed)

func _get_coin() -> int:
	return coin

func _set_coin(newCoin: int) -> void:
	coin = newCoin

func _to_string():
	return str("axe : ", axe, "\nwatercan : ", watercan, "\nhoe : ", hoe)
