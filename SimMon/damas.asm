;---Jogo da Forca---;

; Estrutura do Jogo:
;	<Jogo da Forca>
;main:
;   Seta parametros...
;   Call InputPalavra
;   Call DesenhaForca
;
;	Loop:
;		Call InputLetra
;		Call Compara
;		Call TestaFim
;		jmp Loop
;
;   Halt
;
;InputPalavra:
;   -- Pede para um jogador digitar uma palava para o outro adivinhar
;   Call DigitaLetra
;
;DigitaLetra:
;   -- Le o teclado ate' que uma tecla seja pressionada
;
;DesenhaForca:
;   Seta parametros...
;   Call LimpaTela
;   Call DesenhaTela
;   RTS
;
;DesenhaTela:
;   -- Desenha uma tela inteira 40 x 30
;   Seta parametros...
;
;	Loop:
;		call ImprimeStr ; Call ImprimeStr  30 vezes    (Tem essa funcao no Hello4.asm)
;		add r0, r0, 40  ; incrementaposicao para a segunda linha na tela!
;		add r1, r1, 41  ; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 por causa do /0 !!)
;		cmp r0, 1200
;		jne Loop
;	RTS
;
;LimpaTela:
;   -- Limpa toda a tela
;
;ImprimeSTR:
;   -- Imprime uma String na tela(Tem essa funcao no Hello4.asm)
;
;InputLetra:
;	-- O jogador digita uma Letra e testa se ja' foi digitada
;	Seta Parametros...
;	Printf (Digite uma Letra)
;	Loop:		-- Compara Letra com todas as letras da lista Trylist
;		Call DigitaLetra
;		If(TryListSize == 0) goto Fim
;		For i = 0 to TryListSize-1  {
;			If(Letra == TryList[i]) {
;				Printf(Letra Repetida)
;				Printf(TryList)
;				Goto Loop
;				}
;			}
; Fim:
;	TryList[TryListSize] = Letra	    -- Se nao esta' na Lista, acrescente na Lista
;	TryListSize++
;	TryList[TryListSize] = /0	     	-- Poe /0 no Final!!
;	RTS
;
;Compara
;	-- Compara a Letra digitada para ver se pertence a Palavra
;	Seta Parametros...
;	FlagAcerto == 0
;	For i = 0 to PalavraSize-1 {
;		If(Letra == palavra[i]) {
;			Printf(Letra  --> PosicaoFixa+i)
;			Acerto++
;			FlagAcerto = 1
;			}
;		}
;
;		If(FlagAcerto == 0) {
;			Erro++
;			Switch(Erro) {
;				Case 1 -> Desenha Cabeca
;					. . .
;				Case 7 -> Desenha Perna Direita
;			}
;		}
;	RTS
;
;
;TestaFim:
;		-- Rotina que testa se o Jogo terminou
;		-- Se acertou todas as letras da palavra
;		-- ou Se ja' desenhou todo o carinha
;	Seta Parametros...
;	If(Erro == 8) {
;		Printf(TelaEnforcado)
;		Printf(Palavra)
;
;		Printf(Quer Jogar Novamente??)
;		Call DigLetra
;		If(Letra == S) {
;			Call ApagaTela
;			Pop R0		-- Como da' um Goto direto pro Main tem que esvasiar a pilha do Call TestaFim
;			Goto Main
;			}
;		else Halt
;		}
;	If(Acerto == PalavraSize){
;		Printf(Voce Venceu)
;
;		Printf(Quer Jogar Novamente??)
;		Call DigLetra
;		If(Letra == S) {
;			Call ApagaTela
;			Pop R0		-- Como da' um Goto direto pro Main tem que esvasiar a pilha do Call TestaFim
;			Goto Main
;			}
;		else Halt
;       }
;	RTS

jmp main

;---- Declaracao de Variaveis Globais -----
; Sao todas aquelas que precisam ser vistas por mais de uma funcao: Evita a passagem de parametros!!!
; As variaveis locais de cada funcao serao alocadas nos Registradores internos = r0 - r7

Palavra: var #41	; Vetor para Armazenar as letras da Palavra
PalavraSize: var #1	; Tamanho da Palavra
Letra: var #1		; Contem a letra que foi digitada
TryList: var #60	; Lista com as letras ja' digitadas
TryListSize: var #1	; Tamanho da Lista com as letras ja' digitadas
Acerto: var #1		; Contador de Acertos
Erro: var #1			; Contador de Erros

; Mensagens que serao impressas na tela
Msn1: string "PRESS ENTER TO START"
Msn2: string "Digite uma letra"
Msn3: string "                "
Msn4: string "Voce Venceu! Uhuuuu! )"
Msn5: string "Quer jogar novamente? <s/n>"
Msn6: string "Voce Perdeu! /"
Msn7: string "Letra ja foi digitada, digite novamente!Letras: "
Msn8: string "                                        "


;---- Inicio do Programa Principal -----
main:
	; Inicialisa as variaveis Globais
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  		; cor branca!
	call ImprimeTela
;	loadn r0, #0
;	store Acerto, r0	; Contador de Acertos
;	store Erro, r0		; Contador de Erros
;	store TryList, r0	; Salva '\0' na primeira posicao de TryList
;	store TryListSize, r0	; Zera o tamanho da TryList

;	call inputPalavra
	;call printPalavra	; Testa se a palavra foi digitada corretamente!!

;	call DesForca
	
;	loop:
;		call inputLetra
;		call Compara
;		call TestaFim
;	jmp loop

	halt	; Nunca chega aqui !!! Mas nao custa nada colocar!!!!
	
;---- Fim do Programa Principal -----
	
	
;---- Inicio das Subrotinas -----

;********************************************************
;                   Tela Inicial
;********************************************************

;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push fr		; Protege o registrador de flags
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3
		jeq ImprimeStr_Sai
		add r4, r2, r4
		outchar r4, r0
		inc r0
		inc r1
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
;------------------------	
	
	

;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push fr		; Protege o registrador de flags
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	pop fr
	rts
	
;----------------
	

	
;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push fr		; Protege o registrador de flags
	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5		; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
				
;---------------------


; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "                                        " 
tela1Linha1  : string "                                        " 
tela1Linha2  : string "     ___ ___ ___ ___ ___ ___ ___ ___    "
tela1Linha3  : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha4  : string "    | + |   |   |   |   |   |   |   |   "
tela1Linha5  : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha6  : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha7  : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha8  : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha9  : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha10 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha11 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha12 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha13 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha14 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha15 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha16 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha17 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha18 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha19 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha20 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha21 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha22 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha23 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha24 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha25 : string "    |   |   |   |   |   |   |   |   |   "
tela1Linha26 : string "    |___|___|___|___|___|___|___|___|   "
tela1Linha27 : string "                                        "
tela1Linha28 : string "                                        "
tela1Linha29 : string "                                        "