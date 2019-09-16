/*
 * Created by SharpDevelop.
 * User: Andres
 * Date: 11/7/2019
 * Time: 3:33 p. m.
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Runtime.InteropServices;

namespace CSTpsAccess
{
	public class TpsAccess
	{
		public static string Resultado { get; set; }
		//public static Int32 reslong { get; set; }
			
		
		[DllImport("PMasTpsAccess.Dll")]
		[return: MarshalAs(UnmanagedType.BStr)]
		static extern string ReadClientsTableWrapper();
		
		[DllImport("PMasTpsAccess.Dll")]
		[return: MarshalAs(UnmanagedType.BStr)]
		static extern string AddClientWrapper([param: MarshalAs(UnmanagedType.BStr)] string Valor1,[param: MarshalAs(UnmanagedType.BStr)] string Valor2,[param: MarshalAs(UnmanagedType.BStr)] string Valor3,[param: MarshalAs(UnmanagedType.BStr)] string Valor4,[param: MarshalAs(UnmanagedType.BStr)] string Valor5,[param: MarshalAs(UnmanagedType.BStr)] string Valor6,[param: MarshalAs(UnmanagedType.BStr)] string Valor7,[param: MarshalAs(UnmanagedType.BStr)] string Valor8,[param: MarshalAs(UnmanagedType.BStr)] string Valor9 = "NULL",[param: MarshalAs(UnmanagedType.BStr)] string Valor10 = "NULL",[param: MarshalAs(UnmanagedType.BStr)] string Valor11 = "NULL",[param: MarshalAs(UnmanagedType.BStr)] string Valor12 = "NULL",[param: MarshalAs(UnmanagedType.BStr)] string Valor13 = "NULL");
		
		[DllImport("PMasTpsAccess.Dll")]
		[return: MarshalAs(UnmanagedType.BStr)]
		static extern string DeleteClientWrapper([param: MarshalAs(UnmanagedType.BStr)] string Valor1,[param: MarshalAs(UnmanagedType.BStr)] string Valor2);
				
		[DllImport("PMasTpsAccess.Dll")]
		[return: MarshalAs(UnmanagedType.BStr)]
		static extern string ModifyClientWrapper([param: MarshalAs(UnmanagedType.BStr)] string Valor1,[param: MarshalAs(UnmanagedType.BStr)] string Valor2,[param: MarshalAs(UnmanagedType.BStr)] string Valor3,[param: MarshalAs(UnmanagedType.BStr)] string Valor4,[param: MarshalAs(UnmanagedType.BStr)] string Valor5,[param: MarshalAs(UnmanagedType.BStr)] string Valor6,[param: MarshalAs(UnmanagedType.BStr)] string Valor7,[param: MarshalAs(UnmanagedType.BStr)] string Valor8,[param: MarshalAs(UnmanagedType.BStr)] string Valor9,[param: MarshalAs(UnmanagedType.BStr)] string Valor10,[param: MarshalAs(UnmanagedType.BStr)] string Valor11,[param: MarshalAs(UnmanagedType.BStr)] string Valor12,[param: MarshalAs(UnmanagedType.BStr)] string Valor13);

		
		public static string ReadClientsTable()
		{
			Resultado = "";
			Resultado=ReadClientsTableWrapper();
			return Resultado;
		}
		
		public static string AddClient(string valor1,string valor2,string valor3,string valor4,string valor5,string valor6,string valor7,string valor8,string valor9 = "NULL",string valor10 = "NULL",string valor11 = "NULL",string valor12 = "NULL",string valor13 = "NULL")
		{
			Resultado = "";
			Resultado=AddClientWrapper(valor1,valor2,valor3,valor4,valor5,valor6,valor7,valor8,valor9,valor10,valor11,valor12,valor13);
			return Resultado;
		}
		
		public static string DeleteClient(string valor1,string valor2)
		{
			Resultado = "";
			Resultado=DeleteClientWrapper(valor1,valor2);
			return Resultado;
		}
		
		public static string ModifyClient(string valor1,string valor2,string valor3,string valor4,string valor5,string valor6,string valor7,string valor8,string valor9 = "NULL",string valor10 = "NULL",string valor11 = "NULL",string valor12 = "NULL",string valor13 = "NULL")
		{
			Resultado = "";
			Resultado=ModifyClientWrapper(valor1,valor2,valor3,valor4,valor5,valor6,valor7,valor8,valor9,valor10,valor11,valor12,valor13);
			return Resultado;
		}
		
		static void Main(string[] args)
		{
			//Console.WriteLine("Valor: ");
			//string Valor = Console.ReadLine();
			//string Valor1 = "1";
			//string Valor2 = "88888888";
			//string Valor3 = "Andrés Barroso";
			//string Valor4 = "Direccion Random";
			//string Valor5 = "6546354654";
			//string Valor6 = "RIFsadygdsauydsa";
			//string Valor7 = "V03";
			//string Valor8 = "01";
			//string Valor9 = "sadadsdassadsad"; //CLIENTE IMPRESION ELECTRONICA
			//string Valor10 = "Andres";
			//string Valor11 = "De Leon";
			//string Valor12 = "Barroso";
			//string Valor13 = "Cifuentes";


			//AbrirVentanaClarion();
			
			//Resultado = AddClient(Valor1,Valor2,Valor3,Valor4,Valor5,Valor6,Valor7,Valor8,Valor9,Valor10,Valor11,Valor12,Valor13); //,Valor9,Valor10,Valor11,Valor12,Valor13			
			//Resultado = ModifyClient(Valor1,Valor2,Valor3,Valor4,Valor5,Valor6,Valor7,Valor8,Valor9,Valor10,Valor11,Valor12,Valor13); //,Valor9,Valor10,Valor11,Valor12,Valor13			
			//Resultado = DeleteClient(Valor1,Valor2);
			//Console.WriteLine(Resultado);
			//Console.ReadKey(true);
		}
	}
}