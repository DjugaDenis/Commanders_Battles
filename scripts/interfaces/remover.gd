extends Node

func remove_object(object: Node) -> void:
	object.get_parent().remove_child(object)
	object.queue_free()
