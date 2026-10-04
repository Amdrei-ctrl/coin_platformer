
extends CharacterBody2D

@export var speed := 50.0
var direction := 1

func _physics_process(_delta):
	velocity.x = speed * direction
	move_and_slide()

	if is_on_wall():
		turn_around()
	elif not $FloorCheck.is_colliding():
		turn_around()


func turn_around():
	direction *= -1
	$FloorCheck.position.x = abs($FloorCheck.position.x) * direction
	$Sprite2D.flip_h = direction < 0

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage()


func _on_stomp_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.velocity.y = -400
		queue_free()
