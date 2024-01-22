@tool
class_name DataStorageHelper
extends RefCounted


const _CommonScript = preload("../common.gd")


static var _RECORD_EXTENSIONS := PackedStringArray()
static var _RECORD_CACHE: Dictionary = {}


static func get_allowed_record_extensions() -> PackedStringArray:
	if _RECORD_EXTENSIONS.is_empty():
		if ProjectSettings.has_setting(_CommonScript.SETTING_ALLOWED_EXTENSIONS):
			_RECORD_EXTENSIONS = PackedStringArray(ProjectSettings.get_setting(_CommonScript.SETTING_ALLOWED_EXTENSIONS))
	return _RECORD_EXTENSIONS


static func dir_get_record(p_dir_path: String, p_record_id: String) -> Resource:
	# Check record cache first.
	if _RECORD_CACHE.has(p_dir_path) and _RECORD_CACHE[p_dir_path].has(p_record_id):
		return _RECORD_CACHE[p_dir_path][p_record_id] as Resource
	
	var record: Resource = null
	var record_path: String = dir_get_record_path(p_dir_path, p_record_id)
	
	if not record_path.is_empty():
		record = ResourceLoader.load(record_path, "", ResourceLoader.CACHE_MODE_IGNORE)
	
	# If running in-game, cache the record in the static dictionary so that ResourceLoader isn't needed when loading later.
	# This is avoided in-editor, since performance isn't as great of a concern and it could cause issues.
	if not Engine.is_editor_hint() and record != null:
		if not _RECORD_CACHE.has(p_dir_path):
			_RECORD_CACHE[p_dir_path] = {}
		_RECORD_CACHE[p_dir_path][p_record_id] = record
	
	return record


static func dir_get_record_path(p_dir_path: String, p_record_id: String) -> String:
	for extension in get_allowed_record_extensions():
		var record_path: String = p_dir_path.path_join(p_record_id + "." + extension)
		if ResourceLoader.exists(record_path):
			return record_path
	
	return ""


static func dir_get_ids(p_dir_path: String) -> PackedStringArray:
	var ids := PackedStringArray()
	var file_names: PackedStringArray = _dir_get_file_names(p_dir_path)
	
	for file_name in file_names:
		if get_allowed_record_extensions().has(file_name.get_extension()):
			var id: String = file_name.get_basename()
			ids.push_back(id)
	
	return ids


static func dir_get_hint_string(p_dir_path: String) -> String:
	var ids: PackedStringArray = dir_get_ids(p_dir_path)
	var hint_string: String = ",".join(ids)
	return hint_string


static func _dir_get_file_names(p_dir_path: String) -> PackedStringArray:
	if DirAccess.dir_exists_absolute(p_dir_path):
		return DirAccess.get_files_at(p_dir_path)
	else:
		return PackedStringArray()
