extends Area3D

# Numero de grados que va a rotar la moneda en cada frame
const VELOCIDAD_ROTACION = 2 

func _ready():
	pass


func _process(delta):
	rotate_y(deg_to_rad(VELOCIDAD_ROTACION))
	
	# Codigo NO eficiente para detectar colisiones (es mejor con señales)
#	if has_overlapping_bodies():
#		queue_free()

# Es mejor detectar colisiones con señales, de esta manera será mas eficiente
func _on_body_entered(body):
	# Oculta el nodo del modelo y colision
	$MeshInstance3D.visible = false
	get_node("CollisionShape3D").set_deferred("disabled", true)
	
	# Reproduce el sonido
	$Sonido.play()

# Funcion para borrar completamente la moneda cuando el sonido haya terminado
func _on_sonido_finished():
	queue_free()
