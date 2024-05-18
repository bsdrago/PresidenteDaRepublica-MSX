﻿1000 ' O PRESIDENTE
1010 '
1020 ' DA
1030 '
1040 ' REPUBLICA
1050 '
1060 '
1070 GOSUB 2350: REM INICIALIZAÇÃO
1080 '*******************************************
1090 ' LOOP PRINCIPAL
1100 '*******************************************
1110 P = INT(P+(P*273/ML))
1120 GOSUB 1270: REM IMPRESSAO
1130 GOSUB 1650: REM CALCULOS
1140 ' AQUI E VERIFICADO DO FIM DA SIMULAÇÃO
1150 GOSUB 1860: REM NIVEL DE VIDA
1160 GOSUB 2590: REM ACABOU?
1170 GOSUB 1940: REM NIVEL DE INFLACAO
1180 GOSUB 2590: REM ACABOU?
1190 GOSUB 2010: REM DESEMPREGO
1200 GOSUB 2590: REM ACABOU?
1210 GOSUB 1790: REM DEFICIT
1220 GOSUB 2590: REM ACABOU?
1230 GOTO 1110
1240 ' ****************************************
1250 ' IMPRESSAO
1260 ' ****************************************
1270 CLS
1280 PRINT "Presidente:";A$
1290 PRINT "No poder ha'"; Y+Z/4;" anos."
1300 PRINT "====================================="
1310 PRINT "--------- SITUACAO DO PAIS ----------"
1320 PRINT "====================================="
1330 PRINT "Populacao:"; P
1340 PRINT "Desempregados: " INT(U) "  "INT(100*U/P)"%"
1350 PRINT "Sal.minimo: $" INT (WO)"  Inflacao:" INT(IP)"%"
1360 PRINT:PRINT "Gastos no ultimo periodo:$M" INT(GE)
1370 PRINT "Custo do desemprego:$M " INT(10*GU)/10
1380 PRINT:PRINT "Entradas por impostos: $M"INT(GI*10)/10
1390 PRINT "Caixa atual: $M" INT (BD*10)/10
1400 PRINT "Produto Nacional Bruto: $M"INT(GDP*10)/10
1410 IF Y+7/4 > .5 THEN PRINT "MUDANCA NO NIVEL DE VIDA" INT((2*((RGDP/AGDP) *100)-100)/3) "%"
1420 PRINT "Invest. publicos: $M " INT(IV*10)/10
1430 PRINT "-----------------------------------"
1440 PRINT "Sr.Presidente " A$ ":"
1450 GOSUB 2610: INPUT "Informe os gastos do governo $M"; GE
1460 GOSUB 2610
1470 INPUT "e os gastos com salarios $M";WN
1480 WN = WN + 1E-03
1490 GOSUB 2610
1500 PRINT "E' a favor dos imigrantes (S/N) ?"
1510 X$ = INKEY$
1520 IF X$<>"S" And X$<>"N" And X$<>"s" And X$<>"n" THEN GOTO 1510
1530 PRINT TAB(2D) "Ok... "X$ 
1540 FOR H=1 TO 500: Next H
1550 IF X$<>"S" And X$<>"s" THEN RETURN
1560 GOSUB 2610
1570 PRINT "Permitira' a entrada de quantos imigrantes";
1580 INPUT M
1590 IF M<O THEN GOTO 1580 
1600 P = P+M
1610 RETURN
1620 ' ****************************************
1630 ' CALCULOS
1640 ' ****************************************
1650 CN = CN+(CN*IP/100)
1660 U = P*(GE+IV)/(CN*10)+P*(IP/1000)
1670 GU = U*WN/ML: ' CUSTO DO DESEMPREGO
1680 GI = (((P-U)*WN*.4)/ML): ' REM RENDA DOS IMPOSTOS
1690 BD = BD+GI-GU-GE: ' REM DEFICIT
1700 AGDP = AGDP*(1+(IP/100))
1710 GDP = GE+IV+((P-U) *WN/ML)
1720 RGDP = GDP*440/AGDP
1730 IP = ((GE+IV)/CN *.1 + (WN/WO) /100) * 100
1740 IV = (CN*67)/(IP*IP)
1750 WO = WN
1760 Z = Z+1: If Z > 4 Then Let Z=1 Let Y= Y+1
1770 RETURN
1780 ' ****************************************
1790 ' * COMPROVA O DEFICIT
1800 ' ****************************************
1810 IF BD > -1000 THEN RETURN
1820 GAME = 1
1830 FLAG = 1
1840 RETURN
1850 ' ****************************************
1860 ' * COMPROVA O NIVEL DE VIDA
1870 ' ****************************************
1880 IF Y<.75 THEN RETURN
1890 IF INT ((2*((RGDP/AGDP)*100) -100)/3) > —15 THEN RETURN
1900 GAME = 1
1910 FLAG = 2
1920 RETURN
1930 ' ****************************************
1940 ' * COMPROVA A INFLACAO
1950 ' ****************************************
1960 IF IP<15 THEN RETURN
1970 GAME = 1
1980 FLAG = 3
1990 RETURN
2000 ' ****************************************
2010 ' * COMPROVA O DESEMPREGO
2020 ' ****************************************
2030 IF INT(U*100/P)<15 THEN RETURN
2040 GAME = 1
2050 FLAG = 4
2060 RETURN
2070 ' ****************************************
2080 ' * FINALIZA A SIMULACAO
2090 ' ****************************************
2100 CLS
2110 PRINT "Presidente "A$":"
2120 PRINT:PRINT"A linha economica de sua administracao"
2130 PRINT "levou o nosso pais a um inaceitavel"
2140 IF FLAG = 1 THEN PRINT "deficit de balanca."
2150 IF FLAG = 2 THEN PRINT "nivel de vida."
2160 IF FLAG = 3 THEN PRINT "indice inflacionario."
2170 IF FLAG = 4 THEN PRINT "numero de desempregados"
2180 PRINT: PRINT " A falta de eficacia na sua administra-"
2190 PRINT "cao e tal que foi solicitada a sua re-"
2200 PRINT "nuncia...": PRINT
2210 FOR H=1 TO 1000: Next H
2220 PRINT " O vice-presidente passa a ocupar o seu"
2230 PRINT "cargo.": PRINT
2240 LOCATE 15,23: PRINT "TECLE ALGO."
2250 IF INKEY$ = "" THEN 2250
2260 CLS: PRINT "RELATORIO DE RENUNCIA:": PRINT
2270 PRINT "" A$ " foi presidente por " Y+(Z*.25)" anos.": PRINT
2280 PRINT " Durante o seu mandato a populacao": PRINT
2290 PRINT "cresceu "P-3*ML" pessoas.": PRINT
2300 PRINT "A taxa de desemprego passou a ser ";: PRINT INT(UX1DOD / P / 10)"%.": PRINT
2310 PRINT " A taxa de inflacao era de" INT(10*IP)/10"%.":PRINT
2320 PRINT "O balanco passou a ser $M ";: PRINT INT(10 * BD)/10 "."
2330 LOCATE 0,21: Stop
2340 ' ****************************************
2350 ' * INICIALIZACAO
2360 ' ****************************************
2370 SCREEN 0: KEY OFF
2380 ML = 1000000#
2390 P = 3*ML: ' * POPULACAO
2400 U = P/10: ' * DESEMPREGADOS
2410 IV = 236: ' * INVERSAO
2420 GE = 118: ' * GASTO DO GOVERNO
2430 GU = 0:   ' * CUSTO DO DESEMPREGO
2440 G1 = 0:   ' * $ POR IMPOSTOS
2450 WN = 100: ' * NOVOS SALARIOS
2460 WO = 100: ' * ANTIGOS SALARIOS
2470 IP = 5:   ' * % DE INFLACAO
2480 GDP = 440:' * PROD. NAC. BRUTO
2490 AGDP= 440:' * BASE DO PROD. NAC. BRUTO
2500 RGDP= 440:' * PNB REAL
2510 CN = 354: ' * CONSTANTE ECONOMICA
2520 Z=1: GAME = 0 : FLAG = 0
2530 Y=0: ' * ANOS NA PRESIDENCIA
2540 PRINT "DIGITE O SEU NOME, PRESIDENTE"
2550 INPUT A$
2560 BD = 0
2570 RETURN
2580 ' * VERIFICA SE ACABOU A SIMULACAO
2590 IF GAME=1 THEN CLS: GoTo 2070
2600 RETURN
2610 ' * APAGA PARTE INFERIOR DA TELA
2620 FOR H=1 TO 2
2630 LOCATE 0,20+H: PRINT "                                   "
2640 NEXT H
2650 LOCATE 0,21
2660 RETURN