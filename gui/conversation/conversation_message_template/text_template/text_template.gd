extends PanelContainer

var auto_say = false
var say_character = ""

var message = null
func set_message(cur_message):
	message = cur_message
	set_message_text()

func set_message_text():
	%TextLabel.text = message.text
	if auto_say and say_character!="":
		var tts_list = await PluginManager.get_plugin_instance_by_script_name("tts_list")
		await tts_list.tts_infer_from_character({"character_name":say_character,"text":%TextLabel.text})
		
