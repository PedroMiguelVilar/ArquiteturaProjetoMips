# ArquiteturaProjetoMips

Trabalho de Arquitetura de computadores 2021/2022

Developed by: - Pedro & Nuno Industries
         
         
------------------------------------------1FASE---------------------------------------------------------------------------------
         
A-Fazer Matriz 
(FEITO)

B-Sortear um Codigo 
(FEITO)

C-Ler uma Tentativa, caso esta sequência não seja válida, o programa irá solicitar ao utilizador uma nova combinação.
(FEITO)

D- Após cada jogada será impresso na consola o estado do atual tabuleiro (FEITO)


E-A validação da combinação é automática sendo apresentado o número de cores 
corretas  numa  posição  certa ,  e  o  número  de  cores  corretas  nas  posições  erradas. 
Atenção, que esta validação nunca deve indicar qual é a cor correta e a sua posição (cf. 
Regras do Mastermind). 
(FEITO)


F-O  jogo  termina  caso  o  utilizador  tenha  acertado  na  combinação  correta  (i.e., 
cores + ordenação), ou caso este tenha esgotado as 10 linhas de combinações possíveis. 
Após uma partida ser finalizada, a aplicação deve primeiro revelar qual era a combinação 
gerada automaticamente e, após limpar as jogadas, dar início a um novo jogo. 
(FEITO)

G-A  aplicação  deverá  armazenar,  durante  a  sua  execução,  a  pontuação  do 
jogador.  Cada  vez  que  um  jogador  vencer  a  partida,  este  irá  somar  doze  pontos;  e  em 
contrapartida quando perder será-lhe-á retirado três pontos; contudo um utilizador nunca 
poderá  ter  pontuações  negativas.  Na  última  jogada,  caso  este  tenha  acertado 
parcialmente  na  combinação,  este  deve  somar  três  pontos  por  cor  correta  na  posição 
certa. 
(FEITO)

H-A  aplicação  deverá  permitir  no  final  da  partida  apresentar  a  pontuação  atual. 
Esta  deve  contemplar  todos  os  pontos  acumulados  pelo  utilizador  desde  o  início  da 
aplicação. 
(FEITO)

I-A aplicação será finalizada quando a tecla ‘e’ for executada, após ter finalizado uma partida 
(FEITO)
         
------------------------------------------2FASE---------------------------------------------------------------------------------


A.  (40 pontos) Na  segunda  fase  o  tabuleiro  será  composto  por  uma  dimensão  flexível.  O 
número  de  células  será  inicialmente  definido  pelo  utilizador,  i.e.,  M  colunas  e  N  linhas 
(4<=M & 2<=N). Onde M corresponde a dimensão da sequência de cores, quanto maior 
o número for, maior terá de ser a senha inserida e a respetiva validação; e N corresponde 
ao número de jogadas disponíveis para tentar adivinhar a sequência correta. 
(FEITO)

B.  (30 pontos) Será possível redefinir o alfabeto usado na sequência, i.e, pode ser adicionado 
ou removidas novas siglas as seis indicadas na alínea I.A. Por exemplo, a nova sequência 
poderá  ser:  ABCDEFGHIJ  (não  poderão  existir  caracteres  duplicados!).  A  geração 
aleatória  da  nova  sequência  deverá  contemplar  os  elementos  desse  alfabeto.  As 
combinações inseridas pelo jogador irão também usar elementos deste mesmo alfabeto. 
A parametrização do alfabeto, a semelhança da alínea anterior só pode ser feita no início 
do jogo.
(FALTA)
 
C.  (20 pontos) O  programa  deve  ser  capaz,  usando  o  Bitmap  display,  de  gerar  a  grelha  de 
dimensão MxN. Deve desenhar e apresentar a sequência de cores de cada jogador nesta 
mesma  grelha.  Caso  o  alfabeto  de  cores  tenha  sido  alterado  (alínea  anterior  -  II.B), 
poderão  colocar  uma  cor  aleatória  da  vossa  escolha  para  cada  um  dos  símbolos. 
Relembro que no jogo original é assinalada as peças com cor correta na posição certa 
com cor vermelhas (uma por cada), peças com cor correta mas em posição erradas com 
cor branca (uma por cada).
(FALTA)
