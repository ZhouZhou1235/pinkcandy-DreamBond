extends AnimatedSprite2D

var player :CharacterBody2D
var can_dialog = false

func _input(_event: InputEvent) -> void:
	if can_dialog and !GLBOAL.player_map_dialoguing:
		if Input.is_action_just_pressed("game_dialog"):
			if GLBOAL.save_dict["step"]=="first_day":
				Dialogic.start("timeline2-first_meet_zhou")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D: player=body
	can_dialog = true
	if player:
		if player.position.x-self.position.x<=0 and !self.flip_h:
			self.flip_h = true
		elif player.position.x-self.position.x>0 and self.flip_h:
			self.flip_h = false

func _on_area_2d_body_exited(_body: Node2D) -> void:
	can_dialog = false
	GLBOAL.player_map_dialoguing = false
	Dialogic.end_timeline()
	if player.position.x-self.position.x<=0 and !self.flip_h:
		self.flip_h = true
	elif player.position.x-self.position.x>0 and self.flip_h:
		self.flip_h = false
