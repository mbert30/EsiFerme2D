class_name PlantableDirt extends Node2D

@onready var dirt:AnimatedSprite2D = $Dirt
@onready var plant:AnimatedSprite2D = $Plant
@onready var dirtTime:Timer = $DirtTime
@onready var plantTime:Timer = $PlantTime

#Liste Variable
var is_disturbed:bool = false
var is_planted:bool = false
var plant_phase:int = 0
var plant_name:Seed = null

# Called when the node enters the scene tree for the first time.
func _ready():
	dirt.play("dirt_1")
	plant.play("no_plant")
	
func _plant_seed(newPlant_name:Seed):
	if is_disturbed and not is_planted and newPlant_name._get_nbSeed() >= 1:
		plant_name = newPlant_name
		plant_phase = 1
		is_planted = true
		plant.play(plant_name.seedName + "_" + str(plant_phase))
		return true
	else:
		return false

func _water_seed():
	if is_planted and plant_phase == 1:
		plant_phase = 2
		plant.play(plant_name.seedName + "_" + str(plant_phase))
		plantTime.start(5)

func _harvest() -> int:
	if is_disturbed and is_planted and plant_phase == 4:
		dirt.play("dirt_1")
		plant.play("no_plant")
		var coinGain = plant_name._get_coinGain()
		is_disturbed = false
		plant_name = null
		plant_phase = 0
		is_planted = false
		return coinGain
	else:
		return 0

func _on_dirt_animation_changed():
	
	if dirt.get_animation() == "dirt_2":
		is_disturbed = true
		dirtTime.start(5)
	elif dirt.get_animation() == "dirt_1":
		is_disturbed = false
		

func _on_dirt_time_timeout():
	if not is_planted:
		is_disturbed = false
		dirt.play("dirt_1")


func _on_plant_time_timeout():
	match plant_phase:
		0:
			pass
		1:
			pass
		2:
			plant_phase = 3
			plant.play(plant_name.seedName + "_" + str(plant_phase))
			plantTime.start(5)
		3:
			plant_phase = 4
			plant.play(plant_name.seedName + "_" + str(plant_phase))
			plantTime.start(5)
		4:
			pass
