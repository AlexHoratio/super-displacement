extends Node

var savedata
var save_location = "user://score.scr"
var signed_in = false

func _ready():
	if(not(get_node("/root/menumusic").is_playing())):
		get_node("/root/menumusic").play_song("res://Sound/a_brief_intermission.ogg")
	savedata = ConfigFile.new()
	savedata.load(save_location)
	var music_value = savedata.get_value("Options", "music")
	var username = savedata.get_value("GameJolt", "username")
	if(username == null):
		savedata.set_value("GameJolt", "username", "")
	var fullscreen = savedata.get_value("Options", "fullscreen")
	if(fullscreen == null):
		savedata.set_value("Options", "fullscreen", false)
		fullscreen = false
	OS.set_window_fullscreen(fullscreen)
	var token = savedata.get_value("GameJolt", "token")
	if(token == null):
		savedata.set_value("GameJolt", "token", "")
	var controller = savedata.get_value("Options", "controller")
	if(controller == null):
		savedata.set_value("GameJolt", "controller", false)
	signed_in = savedata.get_value("GameJolt", "signed_in")
	if(signed_in == null):
		savedata.set_value("GameJolt", "signed_in", false)
	elif(signed_in == true):
		get_node("CanvasLayer/welcome_user").set_text("Welcome, " + username + "!")
		get_node("CanvasLayer/welcome_user").set_hidden(false)
	var auto_submit = savedata.get_value("GameJolt", "auto_submit")
	if(auto_submit == null):
		savedata.set_value("GameJolt", "auto_submit", true)
	if(music_value == null):
		savedata.set_value("Options", "music", true)
	var sound_value = savedata.get_value("Options", "sound")
	if(sound_value == null):
		savedata.set_value("Options", "sound", true)
	savedata.save(save_location)
	var cursor = load("res://Graphics/cursor.png")
	Input.set_custom_mouse_cursor(cursor, Vector2(22, 22))
	get_tree().set_pause(false)
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	get_node("CanvasLayer/StartButton").set_pos(Vector2((OS.get_window_size().x/2) - 125, 290))
	get_node("CanvasLayer/OptionButton").set_pos(Vector2((OS.get_window_size().x/2) - 125, 510))
	#get_node("CanvasLayer/SignInButton").set_pos(Vector2((OS.get_window_size().x/2) - 125, 510))
	get_node("CanvasLayer/HighScoreButton").set_pos(Vector2((OS.get_window_size().x/2) - 125, 400))
	get_node("CanvasLayer/QuitButton").set_pos(Vector2((OS.get_window_size().x/2) - 125, 620))
	get_node("CanvasLayer/Label").set_pos(Vector2((OS.get_window_size().x/2) - 425, 75))

func _on_StartButton_released():
	get_tree().change_scene("res://Scenes/MainGame.tscn")

func _on_QuitButton_released():
	get_tree().quit()

func _on_OptionButton_released():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_SignInButton_released():
	get_tree().change_scene("res://Scenes/SignIn.tscn")

func _on_HighScoreButton_released():
	get_tree().change_scene("res://Scenes/HighScores.tscn")
