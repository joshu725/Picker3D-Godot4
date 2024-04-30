extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Se obtiene la gravedad predeterminada del proyecto
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Añade la gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Configura el salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$Sonido_Salto.play()
		velocity.y = JUMP_VELOCITY

	# Obtiene la dirección que se está pulsando y configura el movimiento/desaceleración
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Configurar la camara para que se relacione con la posicion del personaje
	$Control_Camara.position = lerp($Control_Camara.position, position, 0.15)
