# 玩家

extends CharacterBody2D

var speed = 200
var jump_velocity = -250
@onready var Sprite :AnimatedSprite2D = $Sprite

# 移动逻辑
func move_logic(delta:float)->void:
	if not is_on_floor(): velocity += get_gravity()*delta
	if Input.is_action_just_pressed("game_jump") and is_on_floor(): velocity.y=jump_velocity
	var direction := Input.get_axis("ui_left","ui_right")
	if direction: 
		velocity.x=direction*speed
		if direction < 0:
			Sprite.flip_h = true
		elif direction > 0:
			Sprite.flip_h = false
	else: 
		velocity.x=move_toward(velocity.x,0,speed)

# 动画
func animation():
	if not is_on_floor():
		if velocity.y < 0:
			if Sprite.animation != "jump":
				Sprite.play("jump")
		else:
			if Sprite.animation != "fall":
				Sprite.play("fall")
	elif velocity.x != 0:
		if Sprite.animation != "move":
			Sprite.play("move")
	else:
		if Sprite.animation != "default":
			Sprite.play("default")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("game_camera_zoom"):
		$Camera.zoom = Vector2(1,1)
	if Input.is_action_just_released("game_camera_zoom"):
		$Camera.zoom = Vector2(2,2)

func _physics_process(delta: float) -> void:
	move_logic(delta)
	move_and_slide()
	animation()

func _exit_tree() -> void:
	GLBOAL.save_dict["position"] = [position.x,position.y]
