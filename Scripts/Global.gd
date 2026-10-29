extends Node

var tem_chave: bool = false
var minigamePc_vencido: bool = false
var minigameLista_vencido = false
enum Dificuldade { Facil, Medio, Dificil, Impossivel }
var Dificuldade_atual: Dificuldade = Dificuldade.Medio

var tempo: float = 90.0

func Escolher_dificuldade(dificuldade_escolhida: Dificuldade):
	Dificuldade_atual = dificuldade_escolhida
	
	match Dificuldade_atual:
		Dificuldade.Facil:
			tempo = 90.0
		Dificuldade.Medio:
			tempo = 70.0
		Dificuldade.Dificil:
			tempo = 50.0
		Dificuldade.Impossivel:
			tempo = 30.0
			
func velocidade_botao() -> float:
	match Dificuldade_atual:
		Dificuldade.Facil:
			return 1.0  
		Dificuldade.Medio:
			return 0.8   
		Dificuldade.Dificil:
			return 0.7   
		Dificuldade.Impossivel:
			return 0.4  
	return 1.0
