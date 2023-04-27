extends KinematicBody2D


export (int) var speed = 200

#Delete if you aren't planning to use it.
export (float) var rotation_speed = 1.5

var ammo = 0
export (bool) var OnWater = false

onready var WGTimer = get_node("WGTimer")
onready var ShootTimer = get_node("ShootTimer")

var velocity = Vector2()

	

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("Refill") and WGTimer.is_stopped():
		if OnWater == true:
			if ammo <= 100:
				WGTimer.start()
				ammo += 20
				update_ammo_counter()
			
	if Input.is_action_pressed("click") and ShootTimer.is_stopped():
		if ammo >= 1:
			ammo -= 10
			ShootTimer.start()
			update_ammo_counter()


func update_ammo_counter():
	get_node("Hud/CanvasLayer/Ammo").set_text(str("Ammo: ")+str(ammo))


func _process(delta):
	if ammo > 100:
		ammo = 100
		update_ammo_counter()

	
func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
