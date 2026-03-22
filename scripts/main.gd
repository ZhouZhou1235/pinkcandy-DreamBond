# 根节点

extends Node

# 清空游戏实例
func clear_game_objects():
	for node :Node in $World.get_children(): node.queue_free()

# 去往地图
func go_to_map(mapname:String,position:Array):
	clear_game_objects()
	var player :CharacterBody2D = load("res://scenes/Player.tscn").instantiate()
	$World.add_child(player)
	if mapname=="PinkCandyPark":
		var view = load("res://scenes/map/PinkCandyPark.tscn").instantiate()
		$World.add_child(view)
		player.position = Vector2(position[0],position[1])
		GLBOAL.save_dict["map"] = "PinkCandyPark"
		GLBOAL.save_dict["position"] = position

# 回到欢迎界面
func back_to_begin():
	if $Begin.visible==false:
		clear_game_objects()
		GLBOAL.save_save()
		$Begin.update_menu()
		$Begin.show()
		$World.hide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_end"):
		back_to_begin()

func _on_exit_pressed() -> void:
	self.get_tree().quit()

func _on_play_pressed() -> void:
	# 首次进入游戏
	$Begin.hide()
	$World.show()
	var view = load("res://scenes/view/Start.tscn").instantiate()
	$World.add_child(view)
	GLBOAL.save_dict["map"] = "PinkCandyPark"
	GLBOAL.save_dict["position"] = [0,0]

func _on_continue_pressed() -> void:
	# 继续游戏
	$Begin.hide()
	$World.show()
	go_to_map(GLBOAL.save_dict["map"],GLBOAL.save_dict["position"])
