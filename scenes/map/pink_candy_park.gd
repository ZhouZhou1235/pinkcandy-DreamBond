extends Node2D

func _ready() -> void:
	if GLBOAL.save_dict["step"]=="first_day":
		var zhou :Node2D = load("res://scenes/role/ZhouZhou.tscn").instantiate()
		zhou.position = Vector2(1512,-96)
		self.add_child(zhou)
