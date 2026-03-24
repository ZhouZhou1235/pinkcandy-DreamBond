# 全局加载脚本

extends Node

var save_path :String = OS.get_user_data_dir()+"/save.json"
var save_dict :Dictionary
var player_map_dialoguing = false
@onready var Main :Node = self.get_node("/root/Main")

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

# 获取dialogic中玩家信息更新存档
func get_dialogic_to_update_playerinfo():
	var player_name = Dialogic.VAR.get_variable("player_name")
	var player_sex = Dialogic.VAR.get_variable("player_sex")
	save_dict["player_name"] = player_name
	save_dict["player_sex"] = player_sex

# 为dialogic中玩家信息赋值
func store_dialogic_vars_playerinfo():
	Dialogic.VAR.set_variable("player_name",save_dict["player_name"])
	Dialogic.VAR.set_variable("player_sex",save_dict["player_sex"])

# 故事开始
func story_start():
	GLBOAL.save_dict["step"] = "first_day"
	Main.go_to_map("PinkCandyPark",[0,0])

# 设置玩家在地图中是否在对话
func set_player_map_dialoguing(boolen:bool):
	player_map_dialoguing = boolen

# 添加事件
func add_event(event:String):
	var list :Array = GLBOAL.save_dict["events"]
	if event in list: return
	list.push_back(event)
	GLBOAL.save_dict["events"] = list

# 添加物品
func add_item(item:String):
	var list :Array = GLBOAL.save_dict["items"]
	list.push_back(item)
	GLBOAL.save_dict["items"] = list

# 在数值中寻找元素
func find_element_in_array(list:Array,e:Variant):
	for i in len(list):
		if list[i]==e:
			return i
	return -1

# 更新玩家物品栏UI
func update_player_items_ui():
	if Main:
		Main.update_player_items_ui()

func _ready() -> void:
	load_save()
	store_dialogic_vars_playerinfo()

func _exit_tree() -> void:
	save_save()
