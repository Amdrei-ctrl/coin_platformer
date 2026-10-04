
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var health := 3

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$jumpsound.play()

	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func take_damage():
	$hurt.play()
	health -= 1
	print("Health: ", health)

	get_node("../UI/Health").text = "Health: " + str(health)

	if health <= 0:
		die()


func die():
	$dead.play()
	await $dead.finished
	get_tree().reload_current_scene()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.global_position.y < global_position.y - 10:
			# Player landed on top
			body.velocity.y = -400
			queue_free()
