programa
{
	//Inclusão de bibliotecas diversificas para o bom funcionamento do jogo.
	inclua biblioteca Graficos --> g
	inclua biblioteca Arquivos --> a
	inclua biblioteca Texto --> tx
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	inclua biblioteca Sons --> s


	//Declaração de variaveis globais (Carregamento de caminhos e geração de personagens).
	cadeia caminho = "./txt.txt", linha = "", cam_pers="./personagem.png", cam_comida="./comida.png"
	cadeia cam_fog="./foguinho.png", cam_vidas="./vida.png", som_caminho = "./pacman_som.mp3"
	cadeia cam_pedras="./parede.png", cam_grama="./caminho.png"
	inteiro pers=g.carregar_imagem(cam_pers), comida=g.carregar_imagem(cam_comida)
	inteiro parede=g.carregar_imagem(cam_pedras), grama=g.carregar_imagem(cam_grama)
	inteiro fogo=g.carregar_imagem(cam_fog), tinicial, tfinal, vidas=g.carregar_imagem(cam_vidas)
	//Declaração de variaveis glovais (De valor numérico).
	inteiro x_cam=0, y_cam=0, tecla=0
	caracter matriz[23][30]
	inteiro pos_fogox[4], pos_fogoy[4], mov_fogo[4], contador_vidas=4, pontos=0, verificador=0
	inteiro som_bumbo = 0 


	funcao carregar_sons() {
		//Função que executa o carregamento do som e determina seu volume.
		som_bumbo = s.carregar_som(som_caminho)
		s.definir_volume(100)
		s.reproduzir_som(som_bumbo,verdadeiro)
	}
	funcao liberar_sons() {
		//Função que irá parar (liberar) o som.
		s.liberar_som(som_bumbo)
	}
	funcao controle () {
		tinicial=u.tempo_decorrido()
		faca{
			se(t.tecla_pressionada(39)){
				//Função do movimento para direita.
				tecla=39
			}
			se(t.tecla_pressionada(37)){
				//Função do movimento para esquerda.
				tecla=37
			}
			se(t.tecla_pressionada(40)){
				//Função do movimento para baixo.
				tecla=40
			}
			se(t.tecla_pressionada(38)){
				//Função do movimento para cima.
				tecla=38
			}
			se(t.tecla_pressionada(27)){
				//Função de saida do jogo.
				tecla=27
			}
			tfinal=u.tempo_decorrido()
		}enquanto(tfinal - tinicial <=70)
		MovimentacaoGeral()
	}
	funcao tela_geral () {
		//Reset da tela grafica.
		g.limpar()
		g.definir_cor(0)
		g.limpar()
		//Pré configurações de tela e texto setadas.
		g.definir_cor(65280)
		g.definir_tamanho_texto(18.0)
		g.definir_estilo_texto(falso, verdadeiro, falso)
		se(pontos==1000 e contador_vidas>0){
			telaVencedor()
		}senao{
			telaPerdedor()
		}
		g.renderizar()
		reiniciar()
	}
	funcao telaVencedor () {
		//Tela de vencedor.
		/*Tamanho 20x20 utilize
		g.desenhar_texto(171, 100, "VOCÊ VENCEU, PARABÉNS!!!")
		g.desenhar_texto(138, 300, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(175, 330, "PRESSIONE ESC PARA SAIR")
		*/
		/*Tamanho 37x37 utilize
		g.desenhar_texto(426, 100, "VOCÊ VENCEU, PARABÉNS!!!")
		g.desenhar_texto(394, 550, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(430, 580, "PRESSIONE ESC PARA SAIR")
		*/			 
		g.desenhar_texto(171, 100, "VOCÊ VENCEU, PARABÉNS!!!")
		g.desenhar_texto(138, 300, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(175, 330, "PRESSIONE ESC PARA SAIR")	
	}
	funcao telaPerdedor () {
		//Tela de desistente.
		/*Tamanho 20x20 utilize
		g.desenhar_texto(121, 100, "Infelizmente você não chegou até o final!")
		g.desenhar_texto(201, 130, "Mas voce fez "+pontos+" pontos!")
		g.desenhar_texto(138, 300, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(175, 330, "PRESSIONE ESC PARA SAIR")
		*/
		/*Tamanho 37x37 utilize
		g.desenhar_texto(376, 100, "Infelizmente você não chegou até o final!")
		g.desenhar_texto(456, 130, "Mas voce fez "+pontos+" pontos!")
		g.desenhar_texto(394, 550, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(430, 580, "PRESSIONE ESC PARA SAIR")
		*/
		g.desenhar_texto(121, 100, "Infelizmente você não chegou até o final!")
		g.desenhar_texto(201, 130, "Mas voce fez "+pontos+" pontos!")
		g.desenhar_texto(138, 300, "PRESSIONE ENTER PARA REINICIAR")
		g.desenhar_texto(175, 330, "PRESSIONE ESC PARA SAIR")
	}
	funcao reiniciar () {
		//Reinicialização de todo o programa.
		inteiro tecla_
		tecla_=t.ler_tecla()
		se(tecla_==10) {
			//Reinicialização de variaveis globais.
			contador_vidas=4
			tecla=0
			tecla=0
			y_cam=0
			x_cam=0
			verificador=0
			pontos=0
			linha = ""
			para(inteiro aux_2=0; aux_2<4; aux_2++){
				pos_fogox[aux_2]=0
				pos_fogoy[aux_2]=0
				mov_fogo[aux_2]=0
			}
			
			inicio()
		}senao se(tecla_==27){
			//Encerramento do programa.
		}
	}
	funcao renderizar (){
		//Renderização a cada comando da nova tela.
		//Para o tamanho 20x20, utilize a variavel tamanho com valor 20, caso seja 37x37, troque para 37.
		inteiro x=0, y=0, tamanho=20
		
		g.definir_cor(16777215)
		g.limpar()
				
		g.definir_cor(0)		
		/*Repetidor de exibicação do pac-man, com verificador em uma matriz, onde 0 é um quadrado branco, 1 preto, 2 o personagem e 3
		a comida.*/
		para(inteiro i=0;i<23;i++){
			para(inteiro j=0;j<30;j++){
				se (matriz[i][j]=='0') {
					g.desenhar_imagem(x, y, grama)
				}senao se(matriz[i][j]=='1'){
					g.desenhar_imagem(x, y, parede)
				}senao se(matriz[i][j]=='2'){
					g.desenhar_imagem(x, y, grama)
					g.desenhar_imagem(x, y, pers)
				}senao se(matriz[i][j]=='3'){
					g.desenhar_imagem(x, y, comida)
				}senao se(matriz[i][j]=='4' ou matriz[i][j]=='5'){
					g.desenhar_imagem(x, y, fogo)
				}
				x+=tamanho //A variavel tamanho define o espaçamento entra cada quadrado do pac-man.
			}
			y+=tamanho
			x=0 // Reset da variavel x de coordenadas.
			escreva("\n")
		}
		contadorVidas()
		placar()
	}
	funcao contadorVidas () {
		inteiro redimensionador=25
		para(inteiro cont_vidas=1; cont_vidas<=contador_vidas; cont_vidas++){
			g.desenhar_imagem(600-redimensionador, 0, vidas)
			redimensionador+=25
		}
	}
	funcao placar () {
		//Exibição do placar de pontos e renderização de todos elementos da função.
		g.definir_cor(65280)
		g.definir_tamanho_texto(18.0)
		g.desenhar_texto(2, 2, "Pontos: " + pontos)
		g.renderizar()
	}
	funcao morreu () {
		//Reinicialização de variaveis globais.
		matriz[x_cam][y_cam]='0'
		tecla=0
		tecla=0
		y_cam=0
		x_cam=0
		linha = ""
		para(inteiro aux_2=0; aux_2<4; aux_2++){
			matriz[pos_fogox[aux_2]][pos_fogoy[aux_2]]='0'
			pos_fogox[aux_2]=0
			pos_fogoy[aux_2]=0
			mov_fogo[aux_2]=0
		}
		
		inicio()	
	}
	funcao ler_matriz_txt () {
		//Função em que ira ler todo o documento txt e reescrever na matriz.
		inteiro labirinto = a.abrir_arquivo(caminho, a.MODO_LEITURA), aux_3=0, l=0
		enquanto (aux_3<23) {
			linha = a.ler_linha(labirinto) //Leitura da linha do documento txt.	
			para (inteiro j=0; j <= tx.numero_caracteres(linha) - 1; j++) {
				caracter digito = tx.obter_caracter(linha, j) //Captura do caracter do indice indicado do documento.
				matriz[l][j]=digito //Reescritura do caracter capturado anteriormente, na posição da matriz.
			}
			//Incremento das variaveis de controle, sobre a posição na matriz e continuidade do repetidor.
			l++
			aux_3++
		}
		//Encerramento do arquivo txt.
		a.fechar_arquivo(labirinto)
		l=0
		aux_3=0
	}
	funcao sorteioPersonagem () {
		inteiro i_sort, j_sort, aux=0
		//Sorteio de elementos essenciais para o jogo.
		faca{
			//Sorteio da posição onde o personagem irá aparecer.
			i_sort=u.sorteia(0, 22)
			j_sort=u.sorteia(0, 29)
			//Verificação da posição para validar se é possível o personagem aparecer ali.
			se(matriz[i_sort][j_sort]=='0'){
				x_cam=i_sort
				y_cam=j_sort
				aux++
				matriz[i_sort][j_sort]='2'
			}
		}enquanto(aux==0)
		aux=0		
	}
	funcao sorteioComida () {
		inteiro i_sort, j_sort, aux=0
		aux=0
		faca{
			//Sorteio da posição onde todas as comidas irão aparecer.
			i_sort=u.sorteia(0, 22)
			j_sort=u.sorteia(0, 29)
			//Verificação da posição para validar se é possível a comida aparecer naquela posição.
			se(matriz[i_sort][j_sort]=='0'){
				aux++
				matriz[i_sort][j_sort]='3'
			}	
		}enquanto(aux<100)
		aux=0			
	}
	funcao SorteioFogos () {
		inteiro i_sort, j_sort, aux=0	
		aux=0
		faca{
			//Sorteio da posição onde todos os chineses irão aparecer.
			i_sort=u.sorteia(0, 22)
			j_sort=u.sorteia(0, 29)
			//Verificação da posição para validar se é possível o chines aparecer naquela posição.
			se(matriz[i_sort][j_sort]=='0'){
				pos_fogox[aux]=i_sort
				pos_fogoy[aux]=j_sort
				matriz[i_sort][j_sort]='4'
				aux++
			}	
		}enquanto(aux<4)	
	}
	funcao SorteioMovFogos () {
		para(inteiro aux_2=0; aux_2<4; aux_2++){
			mov_fogo[aux_2]=u.sorteia(1, 4)
		}
		MovimentacaoGeralFogo()
	}
	funcao MovimentacaoGeral () {
		MovimentacaoGeralPers()
		SorteioMovFogos()
	}
	funcao MovimentacaoGeralFogo () {
		para(inteiro aux_2=0; aux_2<4; aux_2++){
			se(mov_fogo[aux_2]==1){
				pos_fogox[aux_2]=MovimentacaoFogoCima(pos_fogox[aux_2], pos_fogoy[aux_2])					
			}senao se(mov_fogo[aux_2]==2){
				pos_fogoy[aux_2]=MovimentacaoFogoDireita(pos_fogox[aux_2], pos_fogoy[aux_2])
			}senao se(mov_fogo[aux_2]==3){
				pos_fogox[aux_2]=MovimentacaoFogoBaixo(pos_fogox[aux_2], pos_fogoy[aux_2])					
			}senao se(mov_fogo[aux_2]==4){
				pos_fogoy[aux_2]=MovimentacaoFogoEsquerda(pos_fogox[aux_2], pos_fogoy[aux_2])
			}
		}
		renderizar()
	}
	funcao inteiro MovimentacaoFogoCima (inteiro x, inteiro y) {
		se(matriz[x][y]=='5'){
			se(matriz[x-1][y]=='0'){
				matriz[x][y]='3'
				matriz[x-1][y]='4'
				x--
			}senao se(matriz[x-1][y]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x-1][y]=='3'){
				matriz[x][y]='3'
				matriz[x-1][y]='5'
				x--	
			}			
		}senao{
			se(matriz[x-1][y]=='0'){
				matriz[x][y]='0'
				matriz[x-1][y]='4'
				x--
			}senao se(matriz[x-1][y]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x-1][y]=='3'){
				matriz[x][y]='0'
				matriz[x-1][y]='5'
				x--	
			}			
		}
		retorne x
	}
	funcao inteiro MovimentacaoFogoDireita (inteiro x, inteiro y) {
		se(matriz[x][y]=='5' e y+1!=30){
			se(matriz[x][y+1]=='0'){
				matriz[x][y]='3'
				matriz[x][y+1]='4'
				y++
			}senao se(matriz[x][y+1]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x][y+1]=='3'){
				matriz[x][y]='3'
				matriz[x][y+1]='5'
				y++		
			}			
		}senao se(y+1!=30){
			se(matriz[x][y+1]=='0'){
				matriz[x][y]='0'
				matriz[x][y+1]='4'
				y++
			}senao se(matriz[x][y+1]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x][y+1]=='3'){
				matriz[x][y]='0'
				matriz[x][y+1]='5'
				y++			
			}			
		}
		retorne y
	}
	funcao inteiro MovimentacaoFogoBaixo (inteiro x, inteiro y) {
		se(matriz[x][y]=='5'){
			se(matriz[x+1][y]=='0'){
				matriz[x][y]='3'
				matriz[x+1][y]='4'
				x++
				
				renderizar()
			}senao se(matriz[x+1][y]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x+1][y]=='3'){
				matriz[x][y]='3'
				matriz[x+1][y]='5'
				x++
				
				renderizar()			
			}			
		}senao {
			se(matriz[x+1][y]=='0'){
				matriz[x][y]='0'
				matriz[x+1][y]='4'
				x++
				
				renderizar()
			}senao se(matriz[x+1][y]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x+1][y]=='3'){
				matriz[x][y]='0'
				matriz[x+1][y]='5'
				x++
				
				renderizar()			
			}			
		}
		retorne x
	}
	funcao inteiro MovimentacaoFogoEsquerda (inteiro x, inteiro y) {
		se(matriz[x][y]=='5'){
			se(matriz[x][y-1]=='0' e y-1!=0){
				matriz[x][y]='3'
				matriz[x][y-1]='4'
				y--
			}senao se(matriz[x][y-1]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x][y-1]=='3'){
				matriz[x][y]='3'
				matriz[x][y-1]='5'
				y--				
			}			
		}senao se(y-1!=0){
			se(matriz[x][y-1]=='0'){
				matriz[x][y]='0'
				matriz[x][y-1]='4'
				y--
			}senao se(matriz[x][y-1]=='2'){
				contador_vidas--
				morreu()
			}senao se(matriz[x][y-1]=='3'){
				matriz[x][y]='0'
				matriz[x][y-1]='5'
				y--					
			}
		}
		retorne y
	}
	funcao MovimentacaoGeralPers () {
		se(tecla==38){
			//Função do movimento para cima.
			x_cam=MovimentacaoCima(x_cam, y_cam)
		}senao se(tecla==40){
			//Função do movimento para baixo.
			x_cam=MovimentacaoBaixo(x_cam, y_cam)	
		}senao se(tecla==39){
			//Função do movimento para direita.
			y_cam=MovimentacaoDireita(x_cam, y_cam)
		}senao se(tecla==37){
			//Função do movimento para esquerda.
			y_cam=MovimentacaoEsquerda(x_cam, y_cam)
		}	
	}
	funcao inteiro MovimentacaoBaixo (inteiro x, inteiro y){
		/*Verificará se aquele movimento é valido, na primeira condição verifica se o quadrado abaixo esta em branco, ou seja se 
		não é uma parede; e no segundo se é uma comida que ocupa aquela posição. Assim já se faz as devidas substituições, e soma dos
		pontos caso necessário.*/
		se(matriz[x+1][y]=='0'){
			matriz[x][y]='0'
			matriz[x+1][y]='2'
			x++
			
			renderizar()
		}senao se(matriz[x+1][y]=='3'){
			matriz[x][y]='0'
			matriz[x+1][y]='2'
			x++
			pontos+=10
			
			renderizar()
		}senao se(matriz[x+1][y]=='4'){
			contador_vidas--
			morreu()
		}
		retorne x
	}
	funcao inteiro MovimentacaoCima (inteiro x, inteiro y){
		/*Verificará se aquele movimento é valido, na primeira condição verifica se o quadrado acima esta em branco, ou seja se 
		não é uma parede; e no segundo se é uma comida que ocupa aquela posição. Assim já se faz as devidas substituições, e soma dos
		pontos caso necessário.*/
		se(matriz[x-1][y]=='0'){
			matriz[x][y]='0'
			matriz[x-1][y]='2'
			x--
			
			renderizar()
		}senao se(matriz[x-1][y]=='3'){
			matriz[x][y]='0'
			matriz[x-1][y]='2'
			x--
			pontos+=10
			
			renderizar()
		}senao se(matriz[x-1][y]=='4'){
			contador_vidas--
			morreu()
		}
		retorne x
	}
	funcao inteiro MovimentacaoDireita (inteiro x, inteiro y){
		/*Verificará se aquele movimento é valido, na primeira condição verifica se o quadrado a direita esta em branco, ou seja se 
		não é uma parede; e no segundo se é uma comida que ocupa aquela posição. Assim já se faz as devidas substituições, e soma dos
		pontos caso necessário.*/
		se(y==29 e x==12){
			y=teleportePersDireita(x, y)
		}senao{
			se(matriz[x][y+1]=='0'){
				matriz[x][y]='0'
				matriz[x][y+1]='2'
				y++
				
				renderizar()
			}senao se(matriz[x][y+1]=='3'){
				matriz[x][y]='0'
				matriz[x][y+1]='2'
				y++
				pontos+=10
				
				renderizar()
			}senao se(matriz[x][y+1]=='4'){
				contador_vidas--
				morreu()
			}
		}
		retorne y
	}
	funcao inteiro MovimentacaoEsquerda (inteiro x, inteiro y){
		/*Verificará se aquele movimento é valido, na primeira condição verifica se o quadrado a esquerda esta em branco, ou seja se 
		não é uma parede; e no segundo se é uma comida que ocupa aquela posição. Assim já se faz as devidas substituições, e soma dos
		pontos caso necessário.*/
		se(y==0 e x==12){
			y=teleportePersEsquerda(x, y)
		}senao {
			se(matriz[x][y-1]=='0'){
				matriz[x][y]='0'
				matriz[x][y-1]='2'
				y--
				
				renderizar()
			}senao se(matriz[x][y-1]=='3'){
				matriz[x][y]='0'
				matriz[x][y-1]='2'
				y--
				pontos+=10
				
				renderizar()
			}senao se(matriz[x][y-1]=='4'){
				contador_vidas--
				morreu()
			}			
		}
		retorne y	
	}
	funcao inteiro teleportePersDireita (inteiro x, inteiro y) {
		se(matriz[x][y]=='3'){
			matriz[x][y]='0'
			matriz[x][0]='2'
			y=0
			pontos+=10
			
			renderizar()
		}senao se(matriz[x][y]=='4'){
			contador_vidas--
			morreu()
		}senao {
			matriz[x][y]='0'
			matriz[x][0]='2'
			y=0
		}
		retorne y
	}
	funcao inteiro teleportePersEsquerda (inteiro x, inteiro y) {
		se(matriz[x][y]=='3'){
			matriz[x][y]='0'
			matriz[x][29]='2'
			y=29
			pontos+=10
			
			renderizar()
		}senao se(matriz[x][y]=='4'){
			contador_vidas--
			morreu()
		}senao {
			matriz[x][y]='0'
			matriz[x][29]='2'
			y=29
		}
		retorne y
	}
	funcao inicio()
	{	
		//Configurações inicias do modo gráfico.
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(600, 460) /*Tamanho 20x20 utilize g.definir_dimensoes_janela(600, 460), 
		37x37 utilize g.definir_dimensoes_janela(1110, 851)*/ 
		g.definir_titulo_janela("Pac-Man")
		g.definir_fonte_texto("Arial")
		carregar_sons()

		//Condição de verificação sobre a execução do programa.
		se(verificador==0){
			ler_matriz_txt() //Função que lerá toda a matriz no documento txt e gravar na matriz.
			sorteioComida() //Sorteio da posição das comidas.
			verificador++	
		}
		sorteioPersonagem() //Sorteio da posição do personagem.
		SorteioFogos() //Sorteio da posição dos foguinhos.
		renderizar() //Renderização geral do programa.	

		//Repetidor de movimentos, com cancelamento ao pressionar ESC (Código 27) ou chegar aos 1000 pontos.
		faca{
			controle() //Função controladora geral.
		}enquanto(tecla!=27 e pontos<1000 e contador_vidas>0)
		liberar_sons() //Encerramento do som.
		tela_geral() //Exibição da tela de vitória ou desistÊncia, que posteriormente levará a reinicialização ou encerramento.
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 5048; 
 * @DOBRAMENTO-CODIGO = [25, 31, 35, 62, 79, 95, 114, 173, 180, 187, 204, 222, 239, 254, 271, 270, 276, 280, 294, 324, 354, 392, 422, 438, 437, 460, 483, 510, 537, 555, 573];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */