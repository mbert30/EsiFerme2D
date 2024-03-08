class_name Seed extends Node

var id:int
var seedName:String
var growTime:int
var nbSeed:int = 0
var coinCost = 0
var coinGain = 0
# Called when the node enters the scene tree for the first time.
func _init(newId, newSeedName, newGrowTime, newNbSeed, newCoinCost, newCoinGain):
	id = newId
	seedName = newSeedName
	growTime = newGrowTime
	nbSeed = newNbSeed
	coinCost = newCoinCost
	coinGain = newCoinGain

func _get_id() -> int:
	return id

func _set_id(newId) -> void:
	id = newId
	
func _get_seedName() -> String:
	return seedName

func _set_seedName(newSeedName) -> void:
	seedName = newSeedName
	
func _get_growTime() -> int:
	return growTime

func _set_growTime(newGrowTime) -> void:
	growTime = newGrowTime
	
func _get_nbSeed() -> int:
	return nbSeed

func _set_nbSeed(newNbSeed) -> void:
	nbSeed = newNbSeed
	
func _get_coinCost() -> int:
	return coinCost

func _set_coinCost(newCoinCost) -> void:
	coinCost = newCoinCost

func _get_coinGain() -> int:
	return coinGain

func _set_coinGain(newCoinGain) -> void:
	coinGain = newCoinGain
	
func _to_string() -> String:
	return str("ID : ", id, ", seedName : ", seedName, ", growTime : ", growTime)
