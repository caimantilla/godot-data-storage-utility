@tool
extends EditorPlugin


const CommonScript = preload("common.gd")


func _enter_tree() -> void:
	if not ProjectSettings.has_setting(CommonScript.SETTING_ALLOWED_EXTENSIONS):
		ProjectSettings.set_setting(CommonScript.SETTING_ALLOWED_EXTENSIONS, CommonScript.DEFAULT_EXTENSIONS)
	ProjectSettings.set_initial_value(CommonScript.SETTING_ALLOWED_EXTENSIONS, CommonScript.DEFAULT_EXTENSIONS)
