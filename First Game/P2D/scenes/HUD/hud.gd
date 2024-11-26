extends CanvasLayer

# Señal que se emite para indicar el inicio del juego
signal start_game

# Muestra un mensaje en pantalla por un tiempo determinado
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

# Muestra el mensaje de "Game Over" y prepara el juego para reiniciar
func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.text = "Dodge the Creeps!"
	$MessageLabel.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

# Actualiza el puntaje mostrado en pantalla
func update_score(score):
	$ScoreLabel.text = str(score)
	
# Función que se llama cuando se presiona el botón de inicio
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

# Función que se llama cuando el temporizador del mensaje termina
func _on_message_timer_timeout():
	$MessageLabel.hide()
