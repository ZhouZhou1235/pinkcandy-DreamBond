# 开始界面

extends Control

# 更新菜单
func update_menu():
	var step = GLBOAL.save_dict["step"]
	if step=="start":
		$Menu/Play.show()
		$Menu/Continue.hide()
		$Menu/Restart.hide()
		$Menu/Memory.hide()
	elif step=="end":
		$Menu/Play.hide()
		$Menu/Continue.hide()
		$Menu/Restart.show()
		$Menu/Memory.show()
	else:
		$Menu/Play.hide()
		$Menu/Continue.show()
		$Menu/Restart.hide()
		$Menu/Memory.hide()

func _ready() -> void:
	update_menu()
