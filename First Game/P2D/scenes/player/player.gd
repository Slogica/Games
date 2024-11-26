extends Area2D

# Señal que se emite cuando el personaje es golpeado
signal hit

@export var speed = 400 # Velocidad del personaje (pixel/sec).
var screen_size # Tamaño de la ventana del juego

# Función que se ejecuta cuando el nodo está listo (se llama al inicio)
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
# Función que se llama cada frame para procesar la entrada y actualizar la posición
func _process(delta):
	var velocity = Vector2.ZERO # Vector de movimiento del jugador.
	
	# Detecta las teclas de movimiento y ajusta la dirección en consecuencia
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	
	# Si el jugador está en movimiento, normaliza y aplica la velocidad
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	
	# Actualiza la posición del personaje y restringe los límites de la pantalla
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	
	# Cambia la animación y la dirección de acuerdo a la dirección del movimiento
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

# Función que inicia el personaje en una posición dada
func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false

# Función que se ejecuta cuando otro cuerpo entra en contacto con el personaje
func _on_body_entered(body):
	hide() # EL jugador desaparecerá después de que lo golpeén
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	

