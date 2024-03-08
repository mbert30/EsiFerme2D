class_name Player extends CharacterBody2D

#Liste @onready
@onready var player:Player = $Player
@onready var animSprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var rayCastUp:RayCast2D = $RayCastUp
@onready var rayCastDown:RayCast2D = $RayCastDown
@onready var rayCastLeft:RayCast2D = $RayCastLeft
@onready var rayCastRight:RayCast2D = $RayCastRight
@onready var inventory:Inventory = Inventory.new()
@onready var item_equiped:Tool = inventory._get_hoe()
@onready var seed_equiped:Seed = inventory._get_seed("wheat")

#Liste constante
const SPEED = 400.0

#Liste variable
var is_doing_action:bool = false

func _ready():
	print(inventory)
	self.get_node("Hud/hud_nbSeed").set_text(str(inventory._get_seed(seed_equiped._get_seedName())._get_nbSeed()))
	self.get_node("Hud/hud_seed").set_texture(load("res://assets/hud/"+ seed_equiped._get_seedName() +"_seed.png"))
	self.get_node("Hud/hud_hoe").set_texture(load("res://assets/hud/hoe_selected.png"))
	self.get_node("Hud/menu_coin").play("coin")
	self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
	

func _physics_process(delta):
	get_mouvement_input()
	get_action_input()
	get_changeItem_input()
	get_changeSeed_input()
	move_and_slide()
	
# get_mouvement_input() recupère les mouvement du joueur et effectue les animations de déplacement
func get_mouvement_input():
	var input_dir = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	if not is_doing_action and direction:
		velocity = direction * SPEED
		if (velocity.x < 0 and velocity.y == 0):
			animSprite.play("move_left")
		if (velocity.x > 0 and velocity.y == 0):
			animSprite.play("move_right")
		if (velocity.y < 0):
			animSprite.play("move_up")
		if (velocity.y > 0 ):
			animSprite.play("move_down")
	else:
		if is_doing_action:
			return
		velocity = direction
		animSprite.play("idle")
		
func get_action_input():
	if is_doing_action:
		return
	
	if Input.is_action_just_released("player_action_down"):
		velocity = Vector2()
		is_doing_action = true
		animSprite.play(item_equiped._get_toolName() + "_action_down")
		
		if item_equiped._get_toolName() == "hand":
			if rayCastDown.get_collider():
				if rayCastDown.get_collider() is Seed_shop_wheat or rayCastDown.get_collider() is Seed_shop_redmelon:
					rayCastDown.get_collider()._buy_seed(inventory)
					self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
					self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
					
				elif rayCastDown.get_collider().get_parent()._plant_seed(seed_equiped):
					if seed_equiped._get_nbSeed() >= 1:
						seed_equiped._set_nbSeed(seed_equiped._get_nbSeed() - 1)
						self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
						
		if item_equiped._get_toolName() == "hoe":
			if rayCastDown.get_collider() is Area2D:
				print(rayCastDown.get_collider())
				rayCastDown.get_collider().get_parent().get_node("Dirt").play("dirt_2")
				
		if item_equiped._get_toolName() == "watercan":
			if rayCastDown.get_collider() is Area2D:
				rayCastDown.get_collider().get_parent()._water_seed()
		
		if item_equiped._get_toolName() == "axe":
			if rayCastDown.get_collider() is Area2D:
				inventory._set_coin(inventory._get_coin() + rayCastDown.get_collider().get_parent()._harvest())
				self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))

	if Input.is_action_just_released("player_action_up"):
		velocity = Vector2()
		is_doing_action = true
		animSprite.play(item_equiped._get_toolName() +"_action_up")
		
		if item_equiped._get_toolName() == "hoe":
			if rayCastUp.get_collider() is Area2D:
				rayCastUp.get_collider().get_parent().get_node("Dirt").play("dirt_2")
		
		if item_equiped._get_toolName() == "hand":
			if rayCastUp.get_collider():
				if rayCastUp.get_collider() is Seed_shop_wheat or rayCastUp.get_collider() is Seed_shop_redmelon:
					rayCastUp.get_collider()._buy_seed(inventory)
					self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
					self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
					
				elif rayCastUp.get_collider().get_parent()._plant_seed(seed_equiped):
					if seed_equiped._get_nbSeed() >= 1:
						seed_equiped._set_nbSeed(seed_equiped._get_nbSeed() - 1)
						self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
						
	
		if item_equiped._get_toolName() == "watercan":
			if rayCastUp.get_collider() is Area2D:
				rayCastUp.get_collider().get_parent()._water_seed()
		
		if item_equiped._get_toolName() == "axe":
			if rayCastUp.get_collider() is Area2D:
				inventory._set_coin(inventory._get_coin() + rayCastUp.get_collider().get_parent()._harvest())
				self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
				
	if Input.is_action_just_released("player_action_left"):
		velocity = Vector2()
		is_doing_action = true
		animSprite.play(item_equiped._get_toolName() + "_action_left")
		
		if item_equiped._get_toolName() == "hoe":
			if rayCastLeft.get_collider() is Area2D:
				rayCastLeft.get_collider().get_parent().get_node("Dirt").play("dirt_2")
		
		if item_equiped._get_toolName() == "hand":
			if rayCastLeft.get_collider():
				if rayCastLeft.get_collider() is Seed_shop_wheat or rayCastLeft.get_collider() is Seed_shop_redmelon:
					rayCastLeft.get_collider()._buy_seed(inventory)
					self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
					self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
					
				elif rayCastLeft.get_collider().get_parent()._plant_seed(seed_equiped):
					if seed_equiped._get_nbSeed() >= 1:
						seed_equiped._set_nbSeed(seed_equiped._get_nbSeed() - 1)
						self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
						
		
		if item_equiped._get_toolName() == "watercan":
			if rayCastLeft.get_collider() is Area2D:
				rayCastLeft.get_collider().get_parent()._water_seed()
				
		if item_equiped._get_toolName() == "axe":
			if rayCastLeft.get_collider() is Area2D:
				inventory._set_coin(inventory._get_coin() + rayCastLeft.get_collider().get_parent()._harvest())
				self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
				
	if Input.is_action_just_released("player_action_right"):
		velocity = Vector2()
		is_doing_action = true
		animSprite.play(item_equiped._get_toolName() + "_action_right")
		
		if item_equiped._get_toolName() == "hoe":
			if rayCastRight.get_collider() is Area2D:
				rayCastRight.get_collider().get_parent().get_node("Dirt").play("dirt_2")
				
		if item_equiped._get_toolName() == "hand":
			if rayCastRight.get_collider():
				if rayCastRight.get_collider() is Seed_shop_wheat or rayCastRight.get_collider() is Seed_shop_redmelon:
					rayCastRight.get_collider()._buy_seed(inventory)
					self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
					self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
					
				elif rayCastRight.get_collider().get_parent()._plant_seed(seed_equiped):
					if seed_equiped._get_nbSeed() >= 1:
						seed_equiped._set_nbSeed(seed_equiped._get_nbSeed() - 1)
						self.get_node("Hud/hud_nbSeed").set_text(str(seed_equiped._get_nbSeed()))
						
		
		if item_equiped._get_toolName() == "watercan":
			if rayCastRight.get_collider() is Area2D:
				rayCastRight.get_collider().get_parent()._water_seed()
	
		if item_equiped._get_toolName() == "axe":
			if rayCastRight.get_collider() is Area2D:
				inventory._set_coin(inventory._get_coin() + rayCastRight.get_collider().get_parent()._harvest())
				self.get_node("Hud/hud_coin").set_text(str(inventory._get_coin()))
func _on_player_animation_finished():
	is_doing_action = false
	animSprite.play("idle")
	
func get_changeItem_input():
	if is_doing_action:
		return
	if Input.is_action_just_released("player_change_tool"):
		match item_equiped._get_id():
			1:
				item_equiped = inventory._get_axe()
				self.get_node("Hud/hud_hand").set_texture(load("res://assets/hud/hand.png"))
				self.get_node("Hud/hud_axe").set_texture(load("res://assets/hud/axe_selected.png"))
				self.get_node("Hud/hud_watercan").set_texture(load("res://assets/hud/watercan.png"))
				self.get_node("Hud/hud_hoe").set_texture(load("res://assets/hud/hoe.png"))
			2:
				item_equiped = inventory._get_watercan()
				self.get_node("Hud/hud_hand").set_texture(load("res://assets/hud/hand.png"))
				self.get_node("Hud/hud_watercan").set_texture(load("res://assets/hud/watercan_selected.png"))
				self.get_node("Hud/hud_hoe").set_texture(load("res://assets/hud/hoe.png"))
				self.get_node("Hud/hud_axe").set_texture(load("res://assets/hud/axe.png"))
			3:
				item_equiped = inventory._get_hoe()
				self.get_node("Hud/hud_hand").set_texture(load("res://assets/hud/hand.png"))
				self.get_node("Hud/hud_hoe").set_texture(load("res://assets/hud/hoe_selected.png"))
				self.get_node("Hud/hud_watercan").set_texture(load("res://assets/hud/watercan.png"))
				self.get_node("Hud/hud_axe").set_texture(load("res://assets/hud/axe.png"))
			4:
				item_equiped = inventory._get_hand()
				self.get_node("Hud/hud_hand").set_texture(load("res://assets/hud/hand_selected.png"))
				self.get_node("Hud/hud_axe").set_texture(load("res://assets/hud/axe.png"))
				self.get_node("Hud/hud_watercan").set_texture(load("res://assets/hud/watercan.png"))
				self.get_node("Hud/hud_hoe").set_texture(load("res://assets/hud/hoe.png"))

func get_changeSeed_input():
	if is_doing_action:
		return
	if Input.is_action_just_released("player_change_seed"):
		match seed_equiped._get_id():
			1:
				seed_equiped = inventory._get_seed("wheat")
			2:
				seed_equiped = inventory._get_seed("redmelon")
		self.get_node("Hud/hud_nbSeed").set_text(str(inventory._get_seed(seed_equiped._get_seedName())._get_nbSeed()))
		self.get_node("Hud/hud_seed").set_texture(load("res://assets/hud/"+ seed_equiped._get_seedName() +"_seed.png"))

