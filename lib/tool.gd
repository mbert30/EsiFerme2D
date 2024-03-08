class_name Tool extends Node

var id:int
var toolName:String
var cost:int

func _init(newId, newToolName, newCost):
	id = newId
	toolName = newToolName
	cost = newCost

func _get_id() -> int:
	return id

func _set_id(newId) -> void:
	id = newId
	
func _get_toolName() -> String:
	return toolName

func _set_toolName(newToolName) -> void:
	toolName = newToolName
	
func _get_cost() -> int:
	return cost

func _set_cost(newCost) -> void:
	cost = newCost
	
func _to_string() -> String:
	return str("ID : ", id, ", toolName : ", toolName, ", cost : ", cost)
