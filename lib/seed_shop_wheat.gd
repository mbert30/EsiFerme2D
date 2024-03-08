class_name Seed_shop_wheat extends Node2D

var seed:Seed = null

func _get_seed() -> Seed:
	return seed

func _set_seed(newSeed: Seed) -> void:
	seed = newSeed
	
func _buy_seed(inventory:Inventory) -> void:
	print(inventory._get_coin(), "!" , inventory._get_seed("wheat")._get_coinCost())
	if inventory._get_coin() >= inventory._get_seed("wheat")._get_coinCost():
		inventory._set_coin(inventory._get_coin() - inventory._get_seed("wheat")._get_coinCost())
		inventory._get_seed("wheat")._set_nbSeed(inventory._get_seed("wheat")._get_nbSeed() + 1)
