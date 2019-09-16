# PMasTPSAccess
Solución para acceder y modificar los datos del .TPS de Clientes y Proveedores del Professional Mas.

Descargar Dlls [Aquí!](https://www.dropbox.com/s/o9kkenwmduvrv00/Dll%20de%20Acceso%20al%20TPS%20de%20Clientes%20PMas.rar?dl=0).

[ARCHIVOS REQUERIDOS PARA EJECUTAR]

ClaASC.dll  //Estos 4 dll se encuentran dentro de la carpeta base del Professional Más
ClaDOS.dll
ClaRUN.dll
ClaTPS.dll

CSTpsAccess.dll     //Dll creado en C# que contiene todos los imports y declaraciones necesarias para una integración más sencilla

PMasTpsAccess.dll   //Dll creado en Clarion que contiene toda la lógica que interactúa con la base de datos

Professional.ini    //Este archivo se encuentra dentro de la carpeta base del Professional Más, dicho .ini contiene la dirección de la base de datos 

NOTA:   En caso de querer alojar la solución en un lugar ajeno a la carpeta del professional más,
        se deberán guardar en el mismo lugar todos los archivos mencionados anteriormente.
-----------------------------------------------------------------------------------
[EN EL CÓDIGO]

using CSTpsAccess;                  //Añadir como referencia CSTpsAccess.dll
TpsAccess cls = new TpsAccess();    //Declaración de la clase

Resultado = TpsAccess.AddClient(TIPREG,CODIGO,NOMBRE,DIRECC1,NUMTEL,RIF,CODVEN,CODZON,TIPOCOMERCIO,NOMBRE1,NOMBRE2,APELLIDO1,APELLIDO2);        //Añadir Cliente 			
Resultado = TpsAccess.ModifyClient(TIPREG,CODIGO,NOMBRE,DIRECC1,NUMTEL,RIF,CODVEN,CODZON,TIPOCOMERCIO,NOMBRE1,NOMBRE2,APELLIDO1,APELLIDO2);		//Modificar Cliente	
Resultado = TpsAccess.DeleteClient(TIPREG,CODIGO);      //Borrar Cliente
Resultado = TpsAccess.ReadClientsTable();               //Leer todos los clientes y proveedores y almacenarlos en una variable. Separando cada columna con '<9>' y marcando el fin de cada fila con '<13>'

-----------------------------------------------------------------------------------
[VARIABLES A UTILIZAR]

TIPREG(Ingresa un tipo string '0' o '1')          STRING !Tipo de Registro 0 Proveedores 1 Clientes
CODIGO          STRING(26) !Código del Cliente o Proveedor
NOMBRE          STRING(101) !Nombre
DIRECC1         STRING(61) !Direccion 1
NUMTEL          STRING(41) !Números Teléfonicos
RIF             STRING(26) !Identificador fiscal
CODVEN          STRING(16) !Código del Vendedor asignado al Cliente
CODZON          STRING(5) !Código de Zona
TIPOCOMERCIO(NO OBLIGATORIO)    STRING(31) !Tipo Comercio. En caso de que el tipo de comercio use descripción separada, se utilizarán las variables de abajo, de resto no son obligatorias.
NOMBRE1(NO OBLIGATORIO)         STRING(31) !Nombre 1
NOMBRE2(NO OBLIGATORIO)         STRING(31) !Nombre 2
APELLIDO1(NO OBLIGATORIO)       STRING(31) !Apellido 1
APELLIDO2(NO OBLIGATORIO)       STRING(31) !Apellido 2

-----------------------------------------------------------------------------------

