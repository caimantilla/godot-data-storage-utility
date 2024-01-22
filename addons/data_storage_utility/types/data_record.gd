@tool
class_name DataRecord
extends Resource


## Each record type should have 4 static functions.
## Unfortunately, due to how GDScript is implemented, these need to be reimplemented manually.
## Use the following comments as a guide:
#
## Returns the directory where records of this type are stored.
##	static func get_data_directory() -> String:
##		return "res://data/records"
#
## Returns a record of this type with the ID passed.
## DataStorageHelper has a function for this, just cast it to your subclass.
##	static func get_record(p_id: String) -> DataRecord:
##		return DataStorageHelper.dir_get_record(get_data_directory(), p_id) as DataRecord
#
## Returns the property hint for this record type.
## This should almost always be PropertyHint.PROPERTY_HINT_ENUM_SUGGESTION.
## PropertyHint.PROPERTY_HINT_ENUM can be used, but this causes issues when a missing value (eg. empty string) is set on the property.
##	static func get_hint() -> PropertyHint:
##		return PropertyHint.PROPERTY_HINT_ENUM_SUGGESTION
#
## Returns the property hint string for this record type, for use with _get_property_list.
## This should usually be an enum hint. DataStorageHelper has a function to do this.
##	static func get_hint_string() -> String:
##		return DataStorageHelper.dir_get_hint_string(get_data_directory())


var id: String: set = __DNA_SET_ID, get = get_id


## Returns the record's ID.
## This matches the filename.
func get_id() -> String:
	return get_path().get_file().get_basename()


func __DNA_SET_ID(_p_id: String) -> void:
	assert(false, "Setting the ID is not allowed.")
