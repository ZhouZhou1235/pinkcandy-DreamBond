# 开始界面

extends Control

func _on_exit_pressed() -> void:
	self.get_tree().quit()
