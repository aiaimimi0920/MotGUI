extends PanelContainer

var auto_say = false
var say_character = ""

var message = null
func set_message(cur_message):
	message = cur_message
	init_message_text()
	message.connect("add_text", add_message_text)
	message.start_response()


var infer_text = ""

func init_message_text():
	%TextLabel.text = message.text
	if auto_say and say_character!="":
		infer_text += message.text
		if len(infer_text)>=40:
			var tts_list = await PluginManager.get_plugin_instance_by_script_name("tts_list")
			await tts_list.tts_infer_from_character({"character_name":say_character,"text":infer_text})
			infer_text = ""
		else:
			begin_say_timer()
	%TextLabel.visible_characters = %TextLabel.text.length()
	if auto_say and say_character!="":
		begin_say_timer()
	

func add_message_text(content, all_text):
	%TextLabel.text = all_text
	if auto_say and say_character!="":
		infer_text += content
		if len(infer_text)>=40:
			var tts_list = await PluginManager.get_plugin_instance_by_script_name("tts_list")
			await tts_list.tts_infer_from_character({"character_name":say_character,"text":infer_text})
			infer_text = ""
		else:
			begin_say_timer()
	add_show_characters()
	
	pass

func add_show_characters():
	if %TextLabel.visible_characters < %TextLabel.text.length():
		%Timer.start(0.02)

func _on_timer_timeout():
	%TextLabel.visible_characters +=1
	if %TextLabel.visible_characters >= %TextLabel.text.length():
		%Timer.stop()
	else:
		add_show_characters()

func _on_say_timer_timeout():
	if auto_say and say_character!="":
		if len(infer_text)>0:
			var tts_list = await PluginManager.get_plugin_instance_by_script_name("tts_list")
			await tts_list.tts_infer_from_character({"character_name":say_character,"text":infer_text})
			infer_text = ""

func begin_say_timer():
	%SayTimer.start(2)
	
