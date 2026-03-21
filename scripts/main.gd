# 根节点

extends Node

# 首次开始游戏
func first_start():
	$Begin.hide()
	$View.show()
	$Map.hide()
	var view = load("res://scenes/view/Start.tscn").instantiate()
	$View.add_child(view)

# 清空游戏实例
func clear_game_objects():
	for node :Node in $View.get_children(): node.queue_free()
	for node :Node in $Map.get_children(): node.queue_free()

func _on_exit_pressed() -> void:
	self.get_tree().quit()

func _on_play_pressed() -> void:
	first_start()
