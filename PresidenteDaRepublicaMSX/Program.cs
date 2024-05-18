using System;

namespace SimulacaoPresidencial
{
    class Program
    {
        static double ML = 1000000;
        static double P = 3 * ML; // População
        static double U = P / 10; // Desempregados
        static double IV = 236; // Investimentos públicos
        static double GE = 118; // Gastos do governo
        static double GU = 0; // Custo do desemprego
        static double GI = 0; // Entradas por impostos
        static double WN = 100; // Novos salários
        static double WO = 100; // Antigos salários
        static double IP = 5; // Taxa de inflação
        static double GDP = 440; // Produto Nacional Bruto
        static double AGDP = 440; // Base do Produto Nacional Bruto
        static double RGDP = 440; // PNB real
        static double CN = 354; // Constante econômica
        static double BD = 0; // Balanço
        static double Z = 1;
        static double Y = 0; // Anos na presidência
        static bool GAME = false;
        static int FLAG = 0;
        static string AS;

        static void Main(string[] args)
        {
            Inicializacao();

            while (!GAME)
            {
                P = (int)( P + ( P * 273 / ML ) );
                Impressao();
                Calculos();

                VerificaNivelDeVida();
                VerificaFimDaSimulacao();

                VerificaInflacao();
                VerificaFimDaSimulacao();

                VerificaDesemprego();
                VerificaFimDaSimulacao();

                VerificaDeficit();
                VerificaFimDaSimulacao();
            }
        }

        static void Inicializacao()
        {
            Console.WriteLine("DIGITE O SEU NOME, PRESIDENTE");
            AS = Console.ReadLine();
            BD = 0;
        }

        static void Impressao()
        {
            Console.Clear();
            Console.WriteLine("Presidente: " + AS);
            Console.WriteLine("No poder ha' " + ( Y + Z / 4 ) + " anos.");
            Console.WriteLine("=====================================");
            Console.WriteLine("--------- SITUACAO DO PAIS ----------");
            Console.WriteLine("=====================================");
            Console.WriteLine("Populacao: " + P);
            Console.WriteLine("Desempregados: " + (int)U + "  " + (int)( 100 * U / P ) + "%");
            Console.WriteLine("Sal.minimo: $" + (int)WO + "  Inflacao: " + (int)IP + "%");
            Console.WriteLine("Gastos no ultimo periodo:$M " + (int)GE);
            Console.WriteLine("Custo do desemprego:$M " + (int)( 10 * GU ) / 10);
            Console.WriteLine("Entradas por impostos: $M " + (int)( GI * 10 ) / 10);
            Console.WriteLine("Caixa atual: $M " + (int)( BD * 10 ) / 10);
            Console.WriteLine("Produto Nacional Bruto: $M " + (int)( GDP * 10 ) / 10);

            if (Y + 7 / 4 > .5)
                Console.WriteLine("MUDANCA NO NIVEL DE VIDA " + (int)( ( 2 * ( ( RGDP / AGDP ) * 100 ) - 100 ) / 3 ) + "%");

            Console.WriteLine("Invest. publicos: $M " + (int)( IV * 10 ) / 10);
            Console.WriteLine("-----------------------------------");
            Console.WriteLine("Sr.Presidente " + AS +":");

            Console.WriteLine("Informe os gastos do governo $M");
            GE = Convert.ToDouble(Console.ReadLine());

            Console.WriteLine("e os gastos com salarios $M");
            WN = Convert.ToDouble(Console.ReadLine()) + 1E-03;

            Console.WriteLine("E' a favor dos imigrantes (S/N) ?");
            string XS = Console.ReadLine();

            if (XS != "S" && XS != "N" && XS != "s" && XS != "n")
                Console.WriteLine("Resposta inválida. Tente novamente.");

            if (XS == "S" || XS == "s")
            {
                Console.WriteLine("Permitira' a entrada de quantos imigrantes?");
                double M = Convert.ToDouble(Console.ReadLine());

                if (M < 0)
                {
                    Console.WriteLine("Número inválido. Tente novamente.");
                }

                P = P + M;
            }
        }

        static void Calculos()
        {
            CN = CN + ( CN * IP / 100 );
            U = P * ( GE + IV ) / ( CN * 10 ) + P * ( IP / 1000 );
            GU = U * WN / ML; // CUSTO DO DESEMPREGO
            GI = ( ( ( P - U ) * WN * .4 ) / ML ); // RENDA DOS IMPOSTOS
            BD = BD + GI - GU - GE; // DEFICIT
            AGDP = AGDP * ( 1 + ( IP / 100 ) );
            GDP = GE + IV + ( ( P - U ) * WN / ML );
            RGDP = GDP * 440 / AGDP;
            IP = ( ( GE + IV ) / CN * .1 + ( WN / WO ) / 100 ) * 100;
            IV = ( CN * 67 ) / ( IP * IP );
            WO = WN;
            Z = Z + 1;

            if (Z > 4)
            {
                Z = 1;
                Y = Y + 1;
            }
        }

        static void VerificaDeficit()
        {
            if (BD > -1000)
                return;

            GAME = true;
            FLAG = 1;
        }

        static void VerificaNivelDeVida()
        {
            if (Y < .75)
                return;

            if ((int)( ( 2 * ( ( RGDP / AGDP ) * 100 ) - 100 ) / 3 ) > -15)
                return;

            GAME = true;
            FLAG = 2;
        }

        static void VerificaInflacao()
        {
            if (IP < 15)
                return;

            GAME = true;
            FLAG = 3;
        }

        static void VerificaDesemprego()
        {
            if ((int)( U * 100 / P ) < 15)
                return;

            GAME = true;
            FLAG = 4;
        }

        static void VerificaFimDaSimulacao()
        {
            if (GAME)
            {
                FinalizaSimulacao();
            }
        }

        static void FinalizaSimulacao()
        {
            Console.Clear();
            Console.WriteLine("Presidente " + AS +":");
            Console.WriteLine("A linha economica de sua administracao");
            Console.WriteLine("levou o nosso pais a um inaceitavel");

            switch (FLAG)
            {
                case 1:
                Console.WriteLine("deficit de balanca.");
                break;
                case 2:
                Console.WriteLine("nivel de vida.");
                break;
                case 3:
                Console.WriteLine("indice inflacionario.");
                break;
                case 4:
                Console.WriteLine("numero de desempregados");
                break;
            }

            Console.WriteLine("A falta de eficacia na sua administracao e tal que foi solicitada a sua renuncia...");
            Console.WriteLine("O vice-presidente passa a ocupar o seu cargo.");
            Console.WriteLine("RELATORIO DE RENUNCIA:");
            Console.WriteLine(AS +" foi presidente por " + ( Y + ( Z * .25 ) ) + " anos.");
            Console.WriteLine("Durante o seu mandato a populacao cresceu " + ( P - 3 * ML ) + " pessoas.");
            Console.WriteLine("A taxa de desemprego passou a ser " + (int)( U * 100 / P ) / 10 + "%.");
            Console.WriteLine("A taxa de inflacao era de " + (int)( IP * 10 ) / 10 + "%.");
            Console.WriteLine("O balanco passou a ser $M " + (int)( BD * 10 ) / 10 + ".");
        }
    }
}
