extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		get_parent().add_coin()
		queue_free()
