# 全局加载脚本

extends Node

var save_path :String = OS.get_user_data_dir()+"/save.json"
var save_dict :Dictionary

# 加载存档
func load_save():
	if FileAccess.file_exists(save_path):
		var save_string = FileAccess.get_file_as_string(save_path)
		var dict = JSON.parse_string(save_string)
		if dict:
			save_dict = dict
		else:
			save_dict = JSON.parse_string(FileAccess.get_file_as_string("res://json/save.json"))
	else:
		save_dict = JSON.parse_string(FileAccess.get_file_as_string("res://json/save.json"))
	save_dict["time"]=Time.get_datetime_string_from_system()

# 保存存档
func save_save():
	save_dict["time"]=Time.get_datetime_string_from_system()
	var json_string = JSON.stringify(save_dict, "\t")
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		return true
	else:
		return false

# 重置存档
func reset_save():
	var default_dict = JSON.parse_string(FileAccess.get_file_as_string("res://json/save.json"))
	if default_dict:
		save_dict = default_dict
		save_save()

# 获取dialogic中玩家的信息更新存档
func get_dialogic_to_update_playerinfo():
	var player_name = Dialogic.VAR.get_variable("player_name")
	var player_sex = Dialogic.VAR.get_variable("player_sex")
	save_dict["player_name"] = player_name
	save_dict["player_sex"] = player_sex

func _ready() -> void:
	load_save()

func _exit_tree() -> void:
	save_save()
