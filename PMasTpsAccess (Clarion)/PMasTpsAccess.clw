   PROGRAM



   INCLUDE('ABASCII.INC'),ONCE
   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABPRHTML.INC'),ONCE
   INCLUDE('ABPRPDF.INC'),ONCE
   INCLUDE('ABQUERY.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABUSERCONTROL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('ABWMFPAR.INC'),ONCE
   INCLUDE('CSIDLFOLDER.INC'),ONCE
   INCLUDE('CLAMAIL.INC'),ONCE
   INCLUDE('CLARUNEXT.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('JSON.INC'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('SPECIALFOLDER.INC'),ONCE
   INCLUDE('ABBREAK.INC'),ONCE
   INCLUDE('ABCPTHD.INC'),ONCE
   INCLUDE('ABEXCEL20.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABGRID.INC'),ONCE
   INCLUDE('ABOFFICE20.INC'),ONCE
   INCLUDE('ABPRNAME.INC'),ONCE
   INCLUDE('ABPRTARG.INC'),ONCE
   INCLUDE('ABPRTARY.INC'),ONCE
   INCLUDE('ABPRTEXT.INC'),ONCE
   INCLUDE('ABPRXML.INC'),ONCE
   INCLUDE('ABQEIP.INC'),ONCE
   INCLUDE('ABRPATMG.INC'),ONCE
   INCLUDE('ABRPPSEL.INC'),ONCE
   INCLUDE('ABRULE.INC'),ONCE
   INCLUDE('ABSQL.INC'),ONCE
   INCLUDE('ABVCRFRM.INC'),ONCE
   INCLUDE('ABWORD20.INC'),ONCE
   INCLUDE('CFILTBASE.INC'),ONCE
   INCLUDE('CFILTERLIST.INC'),ONCE
   INCLUDE('CWSYNCHC.INC'),ONCE
   INCLUDE('MDISYNC.INC'),ONCE
   INCLUDE('QPROCESS.INC'),ONCE
   INCLUDE('RTFCTL.INC'),ONCE
   INCLUDE('TCW_EIP.INC'),ONCE
   INCLUDE('TRIGGER.INC'),ONCE
   INCLUDE('WINEXT.INC'),ONCE
   INCLUDE('XTRN.INC'),ONCE

   MAP
     MODULE('PMASTPSACCESS_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('PMASTPSACCESS001.CLW')
ReadClientsTableWrapper FUNCTION(),BSTRING,PASCAL,NAME('ReadClientsTableWrapper')   !
AddClientWrapper       FUNCTION(BSTRING TIPREG,BSTRING CODIGO,BSTRING NOMBRE,BSTRING DIRECC1,BSTRING NUMTEL,BSTRING RIF,BSTRING CODVEN,BSTRING CODZON,BSTRING TIPOCOMERCIO,BSTRING NOMBRE1,BSTRING NOMBRE2,BSTRING APELLIDO1,BSTRING APELLIDO2),BSTRING,PASCAL,NAME('AddClientWrapper')   !
DeleteClientWrapper    FUNCTION(BSTRING VALOR1,BSTRING VALOR2),BSTRING,PASCAL,NAME('DeleteClientWrapper')   !
ModifyClientWrapper    FUNCTION(BSTRING VALOR1,BSTRING VALOR2,BSTRING VALOR3,BSTRING VALOR4,BSTRING VALOR5,BSTRING VALOR6,BSTRING VALOR7,BSTRING VALOR8,BSTRING VALOR9,BSTRING VALOR10,BSTRING VALOR11,BSTRING VALOR12,BSTRING VALOR13),BSTRING,PASCAL,NAME('ModifyClientWrapper')   !
     END
     MODULE('PMASTPSACCESS002.CLW')
Main                   PROCEDURE(),PASCAL,NAME('VentanaClarion')   !Window
     END
    ! Declare functions defined in this DLL
PMasTpsAccess:Init     PROCEDURE(<ErrorClass curGlobalErrors>, <INIClass curINIMgr>)
PMasTpsAccess:Kill     PROCEDURE
   END

DCT:ProCliML         CSTRING(126)
DCT:ParameML         CSTRING(126)
DCT:Zonas            CSTRING(126)
DCT:Vendedores       CSTRING(126)
DCT:TiposComercio    CSTRING(126)
glo:rutaprog         CSTRING(125)
glo:rutadatos        CSTRING(125)
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
ParameML             FILE,DRIVER('TOPSPEED'),NAME(Dct:ParameML),PRE(PAR),BINDABLE,CREATE,THREAD !Tabla de Parametros de Empresa
Keypar01                 KEY(PAR:CONTROL),NAME('Keypar01'),NOCASE,OPT,PRIMARY !Por Control         
Record                   RECORD,PRE()
CONTROL                     LONG                           !Control numeración Automática
NOMBRE                      CSTRING(101)                   !Nombre Empresa      
DIRECC1                     CSTRING(41)                    !Direccion           
DIRECC2                     CSTRING(41)                    !Direccion           
NUMTEL                      CSTRING(41)                    !Números Teléfonicos 
IDFISCAL                    CSTRING(9)                     !Identificador Fiscal
NUMFISCAL                   CSTRING(31)                    !Número de Identificador Fiscal
IDIMPUESTO                  CSTRING(9)                     !Identificador del Impuesto
MONEDA                      CSTRING(11)                    !Tipo de Moneda      
NROINIFAC                   LONG                           !Número Inicial Factura
NROINIPRE                   LONG                           !Número Inicial Presupuesto o cotización
NROINIDEV                   LONG                           !Número Inicial Devolución
NROINIREC                   LONG                           !Número Inicial Recibo de Caja
NROININC                    LONG                           !Número Inicial  de Nota de Crédito
NROININD                    LONG                           !Número Inicial  de Nota de Débito
IMPVENTAS                   BYTE                           !Utiliza Impuesto en Ventas
IMPCOMPRAS                  BYTE                           !Utiliza Impuesto en Compras
IMPPOR                      DECIMAL(5,2)                   !Porcentaje de Impuesto
RUTADATOS                   CSTRING(256)                   !Ruta de los datos   
FPRECIO1                    CSTRING(1000)                  !Formula del Precio 1
ACTPRECIO1                  BYTE                           !Actualiza Precio 1 con las compras
FPRECIO2                    CSTRING(1000)                  !Formula del Precio 2
ACTPRECIO2                  BYTE                           !Actualiza Precio 2 con las compras
FPRECIO3                    CSTRING(1000)                  !Formula del Precio 3
ACTPRECIO3                  BYTE                           !Actualiza Precio 3 con las compras
FECCIERRE                   LONG                           !Fecha del ultimo cierre de mes Numerica
FECCIERRES                  CSTRING(11)                    !Fecha del ultimo cierre de mes dd/mm/aaaa
CODPROAU                    BYTE                           !Genera Código de Producto Automatico
OBSERVACION                 BYTE                           !Maneja Observaciones
IDFISCAL2                   CSTRING(9)                     !Identificador Fiscal
NUMFISCAL2                  CSTRING(21)                    !Número de Identificador Fiscal
REDONDEO                    BYTE                           !Tipo de Redondeo en precios
PREAUTO                     BYTE                           !Calculo Automatico de Precio
NROINITRA                   LONG                           !Número Inicial  de traslado o traspaso
NROINIDES                   LONG                           !Número Inicial  de Descargos de Inventario
NROINICAR                   LONG                           !Número Inicial  de Cargos de Inventario
NROINIAJU                   LONG                           !Número Inicial  de Ajustes al Inventario
TITPRECIO1                  CSTRING(20)                    !Titúlo del Precio 1 
TITPRECIO2                  CSTRING(20)                    !Titúlo del Precio 2 
TITPRECIO3                  CSTRING(20)                    !Titúlo del Precio 3 
SERIAL                      CSTRING(31)                    !Numero del Serial de Seguridad
DEMO                        BYTE                           !0 DEMO 1 NORMAL     
NROINITRAS                  LONG                           !Número Inicial traslado o traspaso
NROFACESP                   LONG                           !Número de Facturas en Espera
DIASVEN                     LONG                           !Dias de Vencimiento por defecto
IMPRESORA                   CSTRING(257)                   !Formatos de impresión
USACONTABILIDAD             BYTE                           !Usa Contabilidad    
RUTACONTAB                  CSTRING(255)                   !Ruta Programas Sistema Contabilidad o .Sis
RUTADATOSCONTAB             CSTRING(255)                   !Ruta Datos sistema de Contabilidad
USACXCGEN                   BYTE                           !Usa Cuentas por Cobrar General
CTACXCGEN                   CSTRING(23)                    !Cuenta CXC General  
USACXPGEN                   BYTE                           !Usa Cuentas por Pagar General
CTACXPGEN                   CSTRING(23)                    !Cuenta CXP General  
USAINVPER                   BYTE                           !Usa Inventario Permanente
CTAVENIMP                   CSTRING(23)                    !Cuenta de impuesto a las ventas
CTAVENFIS                   CSTRING(23)                    !Cuenta de tercero fisco nacional
CTAVENDES                   CSTRING(23)                    !Cuenta de descuentos contado
CTAVENDEV                   CSTRING(23)                    !Cuenta de devoluciones
USACAJA                     BYTE                           !Ventas al contado contra caja
CTAVENCAJA                  CSTRING(23)                    !Cuenta de Caja      
CTACOMIMP                   CSTRING(23)                    !Cuenta de impuesto a las ventas
CTACOMFIS                   CSTRING(23)                    !Cuenta de tercero fisco nacional
CTACOMDES                   CSTRING(23)                    !Cuenta de descuentos
CTACOMDEV                   CSTRING(23)                    !Cuenta de devoluciones
CTAINVCON                   CSTRING(23)                    !Cuenta de ventas contado
CTAINVCRE                   CSTRING(23)                    !Cuenta de ventas credito
CTAINVCOM                   CSTRING(23)                    !Cuenta de compras   
CTAINVCAR                   CSTRING(23)                    !Cuenta de cargos    
CTAINVDES                   CSTRING(23)                    !Cuenta de descargos 
CTAINVAJU                   CSTRING(23)                    !Cuenta de ajustes   
CTAINVREAL                  CSTRING(23)                    !Cuenta real de inventario
CTASERCON                   CSTRING(23)                    !Cuenta de ventas contado
CTASERCRE                   CSTRING(23)                    !Cuenta de ventas credito
CTASERCOM                   CSTRING(23)                    !Cuenta de compras   
CAT1                        BYTE                           !Categoria 1         
CAT2                        BYTE                           !Categoria 2         
CAT3                        BYTE                           !Categoria 3         
CAT4                        BYTE                           !Categoria 4         
CAT5                        BYTE                           !Categoria 5         
NOMCAT1                     CSTRING(21)                    !Nombre categorial 1 
NOMCAT2                     CSTRING(21)                    !Nombre categorial 2 
NOMCAT3                     CSTRING(21)                    !Nombre categorial 3 
NOMCAT4                     CSTRING(21)                    !Nombre categorial 4 
NOMCAT5                     CSTRING(21)                    !Nombre categorial 5 
CIUDAD                      CSTRING(41)                    !Ciudad              
ESTADO                      CSTRING(41)                    !Estado              
TELEFONOS                   CSTRING(41)                    !Telefonos           
ACTECONOMICA                CSTRING(41)                    !Actividad Economica Principal
REPRESENTANTE               CSTRING(41)                    !Representante de la Empresa
CEDULA                      CSTRING(21)                    !Cedula del Representante
CEDULAR                     CSTRING(21)                    !Cedula del Representante Legal
NROCPC                      CSTRING(21)                    !Numero CPC          
TASACAMBIO1                 DECIMAL(10,2)                  !Tasa de cambio en moneda extranjera 1.
NROINIODC                   LONG                           !Número Inicial  de Orden de compras
NROINISOL                   LONG                           !Número Inicial  de Solicitud de Precios
NROINIBANCHE                LONG                           !Número Inicial  de comprobante de cheque
NROINIBANDEP                LONG                           !Número Inicial  de comprobante de deposito
NROINIBANND                 LONG                           !Número Inicial  de comprobante de nota de debito
NROINIBANNC                 LONG                           !Número Inicial  de comprobante de nota de credito
USANE                       BYTE                           !Usa notas de entrega en facturación
CONESPECIAL                 BYTE                           !Contribuyente especial ? Aplicar retencion sobre impuesto
NRORETIMP                   LONG                           !Número Inicial  de Recibos de retencion Impuesto
PORRETIMP                   DECIMAL(5,2)                   !Porcentaje de Retención de Impuesto Proveedores
PORRETIMPCLI                DECIMAL(5,2)                   !Porcentaje de Retención de Impuesto Clientes
CTARETIMPCOM                CSTRING(23)                    !Cuenta de retencion de iva en compras
CTARETIMPVEN                CSTRING(23)                    !Cuenta de retencion de iva en Ventas
IDIMPUESTO2                 CSTRING(9)                     !Identificador del Impuesto 2
IMPPOR2                     DECIMAL(5,2)                   !Porcentaje de Impuesto 2
IDIMPUESTO3                 CSTRING(9)                     !Identificador del Impuesto 3
IMPPOR3                     DECIMAL(5,2)                   !Porcentaje de Impuesto 3
ACTIMP2                     BYTE                           !Activa impuesto 2   
ACTIMP3                     BYTE                           !Activa impuesto 3   
NROAUTOSER                  BYTE                           !Numero automatico Servicios (0 no, 1 si)
CONTADORSER                 LONG                           !Contador de Servicios (proximo)
CONTADORCAJA                LONG                           !Contador de movimientos de Caja
CONTADORCONTROL             LONG                           !Contador unico para CONTROL
NRO_NC_DEV_VENTAS           LONG                           !Contador de N/C y Devoluciones Ventas
PVPMenor                    BYTE                           !Precio Menor        
NRO_ND_DEV_COMPRAS          LONG                           !Contador de N/D y Devoluciones Compras
NRO_ND_LIBRO_CxC            LONG                           !Contador de N/D de Cxc que afectan el libro
NROPAGOCXP                  LONG                           !Contador de pagos abonos CxP
CONTRIFORMAL                BYTE                           !Contribuyente Formal
RECONVERSION                BYTE                           !0 Normal, 1 Fase 1, 2 Fase 2, 3 Fase 3
FACTORCONVERSION            DECIMAL(14,4)                  !Factor de reconversion
NOMBREMONEDA                CSTRING(20)                    !Nombre moneda referencial
MASKDECCANT                 CSTRING(11)                    !Mascara para decimales en cantidad
CONTCIERREDIA               LONG                           !¿Próximo número de Movimiento de Caja?
USAOPERACIONES              BYTE                           !¿Usar clasificador de documentos?
OPEROBLIGA                  BYTE                           !¿Clasificador de documentos obligatorio?
USACAMPOSADD                BYTE                           !¿Usa campos adicionales en clientes?
NOMBRETABLAADIC             CSTRING(16)                    !Nombre de la tabla adicional de clientes
NOMCAMPTEX01                CSTRING(16)                    !Nombre del campo de texto 01
NOMCAMPTEX02                CSTRING(16)                    !Nombre del campo de texto 02
NOMCAMPTEX03                CSTRING(16)                    !Nombre del campo de texto 03
NOMCAMPTEX04                CSTRING(16)                    !Nombre del campo de texto 04
NOMCAMPTEX05                CSTRING(16)                    !Nombre del campo de texto 05
NOMCAMPFEC01                CSTRING(16)                    !Nombre del campo de fecha 01
NOMCAMPFEC02                CSTRING(16)                    !Nombre del campo de fecha 02
NOMCAMPNUM01                CSTRING(16)                    !Nombre del campo numérico 01
NOMCAMPNUM02                CSTRING(16)                    !Nombre del campo numérico 02
VERCAMPTEXTADD02            BYTE                           !Ver Campo texto 02  
VERCAMPTEXTADD03            BYTE                           !Ver campo texto 03  
VERCAMPTEXTADD04            BYTE                           !Ver campo texto 04  
VERCAMPTEXTADD05            BYTE                           !Ver campo texto 05  
VERCAMPFECADD01             BYTE                           !Ver campo fecha 01  
VERCAMPFECADD02             BYTE                           !Ver campo fecha 02  
VERCAMPNUMADD01             BYTE                           !Ver campo número 01 
VERCAMPNUMADD02             BYTE                           !Ver campo número 02 
ACTIVIDADAUTOMOTRIZ         BYTE                           !Indica si se activa para automotriz
RUTALOGOEMPRE               CSTRING(251)                   !                    
VERCAMPTEXTADD06            BYTE                           !                    
NOMCAMPTEX06                CSTRING(16)                    !Nombre campo de texto 06
NOMOBSERV01                 CSTRING(16)                    !Observación 01      
NOMOBSERV02                 CSTRING(16)                    !Observación 02      
NOMOBSERV03                 CSTRING(16)                    !Observación 03      
NOMOBSERV04                 CSTRING(16)                    !Observación 04      
NOMOBSERV05                 CSTRING(16)                    !Observación 05      
NOMOBSERV06                 CSTRING(16)                    !Observación 06      
NOMOBSERV07                 CSTRING(16)                    !Observación 07      
NOMOBSERV08                 CSTRING(16)                    !Observación 08      
NOMOBSERV09                 CSTRING(16)                    !Observación 09      
NOMOBSERV10                 CSTRING(16)                    !Observación 10      
NROPEDCLI                   LONG                           !Correlativo de pedidos de clientes
NROINIATRIBUTOS             LONG                           !Número correlativo para atributos
DESAMP01                    LONG                           !Longitud de línea 01
DESAMP02                    LONG                           !Longitud de línea 02
DESAMP03                    LONG                           !Longitud de línea 03
DESAMP04                    LONG                           !Longitud de línea 04
DESAMP05                    LONG                           !Longitud de línea 05
DESAMP06                    LONG                           !Longitud de línea 06
DESAMP07                    LONG                           !Longitud de línea 07
DESAMP08                    LONG                           !Longitud de línea 08
DESAMP09                    LONG                           !Longitud de línea 09
DESAMP10                    LONG                           !Longitud de línea 10
LNGOBS01                    LONG                           !                    
LNGOBS02                    LONG                           !                    
LNGOBS03                    LONG                           !                    
LNGOBS04                    LONG                           !                    
LNGOBS05                    LONG                           !                    
LNGOBS06                    LONG                           !                    
LNGOBS07                    LONG                           !                    
LNGOBS08                    LONG                           !                    
LNGOBS09                    LONG                           !                    
LNGOBS10                    LONG                           !                    
MULTIPLICA_DIVIDE           CSTRING(2)                     !Multiplica o divide 
ACT_MSN                     BYTE                           !Activar envio de Mensajes de Texto 0=No,1=Si
MSN_VENTAS_MENOS_COSTO      BYTE                           !Envio Automatico por ventas menos del costo
MSN_VENTAS_MENOS_MINIMO     BYTE                           !Envio Automatico por ventas producto por debajo de minimo
MSN_CHE_MONTO_MAX           BYTE                           !Envio Automatico por cheques mayores a
MSN_CHE_MONTO               DECIMAL(17,2)                  !Monto maximo Cheque 
MSN_RES_VENTAS              BYTE                           !Envio Automatico por resumen diario de ventas
PREFIJO_MOVIL1              CSTRING(5)                     !Prefijo Movil 1     
NUMERO_MOVIL1               CSTRING(11)                    !Numero Movil 1      
PREFIJO_MOVIL2              CSTRING(5)                     !Prefijo Movil 2     
NUMERO_MOVIL2               CSTRING(11)                    !Numero Movil 2      
USUARIO_SMS_EMP             CSTRING(33)                    !Usuario SMS Empresa 
CLAVE_SMS_EMP               CSTRING(33)                    !Clave SMS Empresa   
APLICAESTADPROD             BYTE                           !Aplicar estadisticas a productos
FEC_PER_INI                 LONG                           !Fecha inicial periodo para estadisticas productos
FEC_PER_FIN                 LONG                           !Fecha final periodo para estadisticas productos
SEGENEROESTD                BYTE                           !Se genero estadisticas de productos
NROCIEPAR                   LONG                           !Numero Cierre Parcial (Colombia)
NROCIEDEF                   LONG                           !Numero Cierre Definitiva (Colombia)
NOMDETDIR1                  CSTRING(20)                    !Nombre detalle de direccion 1
NOMDETDIR2                  CSTRING(20)                    !Nombre detalle de direccion 2
NOMDETDIR3                  CSTRING(20)                    !Nombre detalle de direccion 3
VALMAS1                     BYTE                           !                    
VALGRA1                     BYTE                           !                    
LEER_CAN_PRE_EN             CSTRING(20)                    !Leer cantidad o precio en código o referencia
POS_INICIAL_CODREF          BYTE                           !Posicion inicial del código o referencia
LARGO_CODREF                BYTE                           !Largo del código o referencia
POS_INICIAL_MEDIDA          BYTE                           !Posicion inicial medida
LARGO_MEDIDA                BYTE                           !Largo de medida     
ACTIVARSAINTINSPECTOR       BYTE                           !Activar Saint Inspector 0 No, 1 Si
SERIALKEYPRO                CSTRING(31)                    !Serial Key Licencia Professional
IDSAINTINSPECTOR            LONG                           !Id registrado de Saint Inspector
HOSTNOTIFY                  CSTRING(101)                   !Direccion IP del servicio de notificaciones
PUERTONOTIFY                LONG                           !Puerto de salida del servicio de notificaciones
FACXREGIMEN                 BYTE                           !Facturación por régimen (0 no, 1 si)
NOMREGIMEN1                 CSTRING(21)                    !Nombre (Etiqueta regimen 1)
NOMREGIMEN2                 CSTRING(21)                    !Nombre (Etiqueta regimen 2)
NROINIFAC2                  LONG                           !Número Inicial Factura regimen 2
VALMAS2                     BYTE                           !                    
LICSERIAL                   CSTRING(100)                   !Serial licencia anual
LICKEY                      CSTRING(100)                   !Key licencia anual  
LICHOST                     CSTRING(100)                   !Host licencia anual 
LICPUERTO                   LONG                           !Puerto licencia anual
CODPRO                      CSTRING(16)                    !Código serivicio automatico en ventas
CODPROFOR                   CSTRING(255)                   !Formula de calculo servicio automatico
CODPROALE                   BYTE                           !Alerta en facturacion del servicio automatico
VALMAS3                     BYTE                           !                    
NROESTABLECIMIENTO          CSTRING(21)                    !                    
VALMAS4                     BYTE                           !                    
PREFAC_CONFIN               CSTRING(20)                    !Prefijo factura consumidor final
NROFAC_CONFIN               REAL                           !Numero factura consumidor final
PRENC_CONFIN                CSTRING(20)                    !Prefijo nota credito consumidor final
NRONC_CONFIN                REAL                           !Numero nota credito consumidor final
PREFAC_CONTRI               CSTRING(20)                    !Prefijo factura contribuyente
NROFAC_CONTRI               REAL                           !Numero factura contribuyente
PRENC_CONTRI                CSTRING(20)                    !Prefijo nota credito contribuyente
NRONC_CONTRI                REAL                           !Numero nota credito contribuyente
NROFAC_CONFIN_H             REAL                           !Numero factura consumidor final hasta
NRONC_CONFIN_H              REAL                           !Numero nota credito consumidor final hasta
NROFAC_CONTRI_H             REAL                           !Numero factura contribuyente hasta
NRONC_CONTRI_H              REAL                           !Numero nota credito contribuyente hasta
NROFAC_CONFIN_D             REAL                           !Numero factura consumidor final desde
NRONC_CONFIN_D              REAL                           !Numero nota credito consumidor final desde
NROFAC_CONTRI_D             REAL                           !Numero factura contribuyente desde
NRONC_CONTRI_D              REAL                           !Numero nota credito contribuyente desde
PREFAC_GUBER                CSTRING(20)                    !Prefijo factura gubernamental
NROFAC_GUBER                REAL                           !Numero factura gubernamental
NROFAC_GUBER_D              REAL                           !Numero factura gubernamental desde
NROFAC_GUBER_H              REAL                           !Numero factura gubernamental hasta
PRENC_GUBER                 CSTRING(20)                    !Prefijo nota credito gubernamental
NRONC_GUBER                 REAL                           !Numero nota credito gubernamental
NRONC_GUBER_D               REAL                           !Numero nota credito gubernamental desde
NRONC_GUBER_H               REAL                           !Numero nota credito gubernamental hasta
PREFAC_REGESP               CSTRING(20)                    !Prefijo factura regimen especial
NROFAC_REGESP               REAL                           !Numero factura regimen especial
NROFAC_REGESP_D             REAL                           !Numero factura regimen especial desde
NROFAC_REGESP_H             REAL                           !Numero factura regimen especial hasta
PRENC_REGESP                CSTRING(20)                    !Prefijo nota credito regimen especial
NRONC_REGESP                REAL                           !Numero nota credito regimen especial
NRONC_REGESP_D              REAL                           !Numero nota credito regimen especial desde
NRONC_REGESP_H              REAL                           !Numero nota credito regimen especial hasta
PAIS                        CSTRING(7)                     !Pais                
PRECIOVENTAD                BYTE                           !Precio de Venta por defectos
TIPOVENCMTO                 BYTE                           !Tipo Vencimiento 0 Dia Fijo segun inscripcion, 1 Segun fecha de pago, 2 Dia fijo
ACTIVARCUMPLE               BYTE                           !Activar ventana de cumple años? 0 No, 1 Si
MENSAJECUMPLE               CSTRING(61)                    !Mensaje de cumpleaños
IMAGENCUMPLE                CSTRING(81)                    !Imagen mostraen en cumple
DURACIONASISTENCIA          BYTE                           !Duracion informacion de asistencia segundos
DIAVENCE                    BYTE                           !Dia del mes que vence la cuota
DIATOLERANCIA               BYTE                           !Dias de Tolerancia para el vencimiento
PRORRATACUOTA               BYTE                           !Se prorratea la 1ra cuota, 0 NO, 1 SI
INSCRIPCIONVENCE            BYTE                           !Vence la inscripción 0 NO, 1 SI
INSCRIPCIONVENCETIPO        BYTE                           !Tipo de vencimiento de inscripcion 0 dia y mes fijo, 1 dias inactivo, 2 al año de la inscripcion
INSCRIPCIONFECHADIAS        LONG                           !Dia y mes del vencimiento o dias de inactividad
MONTOMAXDCTOIVA             DECIMAL(17,2)                  !Monto Maximo de descuento IVA
NRORETIMPISLR               LONG                           !Contador de retenciones en compras del ISLR
ACTIVARGYM                  BYTE                           !Activar gimnasios   
MONTOMAXDCTOIVA2            DECIMAL(17,2)                  !Monto Maximo de descuento IVA2
ACTIVARIVAREDUCIDO          BYTE                           !Activar descuento IVA
                         END
                     END                       

ProCliML             FILE,DRIVER('TOPSPEED'),NAME(dct:ProCliML),PRE(PRO),BINDABLE,CREATE,THREAD !Tabla de Proveedores y Clientes
KeyPro01                 KEY(PRO:TIPREG,PRO:CODIGO),NAME('KeyPro01'),NOCASE,OPT,PRIMARY !Por Tipo - Código   
KeyPro02                 KEY(PRO:TIPREG,PRO:NOMBRE),DUP,NAME('KeyPro02'),NOCASE,OPT !Por Tipo - Nombre   
KeyPro03                 KEY(PRO:CODIGO),DUP,NAME('KeyPro03'),NOCASE,OPT !Por Código          
KeyPro04                 KEY(PRO:CODVEN),DUP,NAME('KeyPro04'),NOCASE,OPT !Por Código del Vendedor
KeyPro05                 KEY(PRO:NOMBRE),DUP,NAME('KeyPro05'),NOCASE,OPT !Por Nombre          
KeyPro06                 KEY(PRO:RIF),DUP,NAME('KeyPro06'),NOCASE,OPT !Por Identificador fiscal
KeyPro07                 KEY(PRO:MARKAR,PRO:TIPREG),DUP,NOCASE,OPT !Por Marcar - Tipreg 
KeyPro08                 KEY(PRO:NOMBREBAREMO,PRO:CODIGO),DUP,NOCASE,OPT !Por Baremo - Codigo 
KeyPro09                 KEY(PRO:CODIGOPAGADOR,PRO:CODIGO),DUP,NOCASE,OPT !Por Pagador - Dependiente
KeyPro10                 KEY(PRO:INTEGRADO,PRO:TIPREG,PRO:CODIGO),DUP,NOCASE,OPT !Por Integrado - Tipreg - Codigo
Record                   RECORD,PRE()
TIPREG                      BYTE                           !Tipo de Registro 0 Proveedores 1 Clientes
CODIGO                      CSTRING(26)                    !Código del Cliente o Proveedor
NOMBRE                      CSTRING(101)                   !Nombre              
REPRESEN                    CSTRING(41)                    !Nombre Contacto     
DIRECC1                     CSTRING(61)                    !Direccion 1         
DIRECC2                     CSTRING(61)                    !Direccion 2         
NUMTEL                      CSTRING(41)                    !Números Teléfonicos 
RIF                         CSTRING(26)                    !Identificador fiscal
NIT                         CSTRING(26)                    !Identificador fiscal
PRECIO                      BYTE                           !Tipo de Precio para Cliente
FECHA1                      LONG                           !Fecha Ultimo Pago   
FECHA2                      LONG                           !Fecha Ultima Venta - Fecha Ultima Compra
FECHA1S                     CSTRING(11)                    !Fecha Ultimo Pago String
FECHA2S                     CSTRING(11)                    !Fecha Ultima Venta - Fecha Ultima Compra String
MONTODEB                    DECIMAL(17,2)                  !Monto Debitos del Mes
MONTOCRE                    DECIMAL(17,2)                  !Monto Creditos del Mes
LIMITECRE                   DECIMAL(17,2)                  !Monto de Limte de Crédito
CODVEN                      CSTRING(16)                    !Código del Vendedor asignado al Cliente
DIASBLOQUEO                 LONG                           !Días de tolerancia para bloqueo de crédito
TIPOCLI                     CSTRING(20)                    !Tipo de Cliente Contribuyente-Consumidor Final-Exportacion-Exento
DIASCRE                     LONG                           !Número de días de Credito otrogado por el proveedor
PORRET                      DECIMAL(5,2)                   !Porcentaje de Retención ISLR
TIPOPRO                     CSTRING(20)                    !Tipo de Proveedor Nacional-Extranjero
ANTICIPOS                   DECIMAL(12,2)                  !Monto de Anticipos (Notas Especiales)
CODZON                      CSTRING(5)                     !Código de Zona      
NUMFAX                      CSTRING(41)                    !Número de Fax       
DIRCORREO                   CSTRING(101)                   !Dirección de Correo electronico
CLASE                       CSTRING(11)                    !Clase               
PERCREDITO                  BYTE                           !Permite Credito     
CUENTACON                   CSTRING(23)                    !Numero Cuenta Contable
CUENTATER                   CSTRING(23)                    !Numero Cuenta Contable Tercero
CALCIMPUESTO                BYTE                           !Se le calcula impuesto Retenciones ISLR
DIRECCALTERNA1              CSTRING(61)                    !Direccion alternativa 1
DIRECCALTERNA2              CSTRING(61)                    !Direccion alternativa 2
PORRETIMP                   DECIMAL(5,2)                   !Porcentaje de Retención de Impuesto IVA
CONESPECIAL                 BYTE                           !Contribuyente especial ? Aplicar retencion sobre impuesto IVA
TIPOPROVEEDOR               BYTE                           !Tipo Proveedor      
PORMAXDESPAR                DECIMAL(7,2)                   !Porcentaje Maximo de descuento Parcial
PORMAXDESGLO                DECIMAL(7,2)                   !Porcentaje Maximo de descuento GLobal
SERFuma                     BYTE                           !Fuma (0,1)          
SERAlergias                 BYTE                           !Alegias (0,1)       
SERDiabetes                 BYTE                           !Diabetes (0,1)      
SERSida                     BYTE                           !VIH (0,1)           
SERTensionBaja              BYTE                           !Tension Baja (0,1)  
SERTensionAlta              BYTE                           !Tension Alta (0,1)  
SERAsma                     BYTE                           !Asma (0,1)          
SERProblemasRenales         BYTE                           !Problemas renales (0,1)
SERInfarto                  BYTE                           !Infarto (0,1)       
SEREpilepsia                BYTE                           !Epilepsia (0,1)     
SERCancer                   BYTE                           !Cancer (0,1)        
SEROtros1                   CSTRING(40)                    !Otros 1             
SEROtros2                   CSTRING(40)                    !Otros 2             
FECHANAC                    LONG                           !Fecha de Nacimiento 
SEXO                        CSTRING(20)                    !Sexo Cliente        
FOTO                        CSTRING(81)                    !Foto                
PREFIJO_MOVIL               CSTRING(5)                     !Prefijo Movil       
NUMERO_MOVIL                CSTRING(11)                    !Numero Movil        
MARKAR                      BYTE                           !Marcar registro     
NUMTELCONTACTO              CSTRING(41)                    !Números Teléfonicos Contacto
NOMBREGERENTE               CSTRING(41)                    !Nombre del Gerente  
NUMTELGERENTE               CSTRING(41)                    !Números Teléfonicos Gerente
FECNACCONTACTO              LONG                           !Fecha de nacimiento contacto
FECNACGERENTE               LONG                           !Fecha de nacimiento gerente
TIPOCOMERCIO                CSTRING(31)                    !Tipo Comercio       
MENSAFACTURAR               CSTRING(61)                    !Mensaje al momento de facturar
NOMBREEGEO1                 CSTRING(41)                    !Nombre entidad geografica 1
NOMBREEGEO2                 CSTRING(41)                    !Nombre entidad geografica 2
NOMBREEGEO3                 CSTRING(41)                    !Nombre entidad geografica 3
NOMBRE1                     CSTRING(31)                    !Nombre 1            
NOMBRE2                     CSTRING(31)                    !Nombre 2            
APELLIDO1                   CSTRING(31)                    !Apellido 1          
APELLIDO2                   CSTRING(31)                    !Apellido 2          
CODIGOPOSTAL                CSTRING(21)                    !Código postal       
NOMBREBAREMO                CSTRING(41)                    !Nombre del baremo   
APLICADSTOFAC               BYTE                           !Aplicar descuento global en factura
TIPOAFILIADO                BYTE                           !Tipo Afiliado Pagador 0, Dependiente 1
CODIGOPAGADOR               CSTRING(26)                    !Código del Afiliado Pagador
SITAFILIADO                 BYTE                           !Situacion Nuevo 0 , Activo 1, Inactivo 2, Exonerado 3
INTEGRADO                   BYTE                           !Registro Integrado 0 NO, 1 SI
                         END
                     END                       

TiposComercio        FILE,DRIVER('TOPSPEED'),NAME(dct:TiposComercio),PRE(TIPC),BINDABLE,CREATE,THREAD !Tabla de Tipos de COmercio
KeyTIPC01                KEY(TIPC:TIPOCOMERCIO),NOCASE,OPT,PRIMARY !Por Tipo Comercio   
Record                   RECORD,PRE()
TIPOCOMERCIO                CSTRING(31)                    !Tipo Comercio       
TIPODESCRIP                 BYTE                           !Tipo descripcion 0 normal, 1 separada
                         END
                     END                       

Vendedores           FILE,DRIVER('TOPSPEED'),NAME(dct:Vendedores),PRE(VEN),BINDABLE,CREATE,THREAD !Tabla de Vendedores 
KeyVen01                 KEY(VEN:CODVEN),NAME('KeyVen01'),NOCASE,OPT,PRIMARY !Por Código          
KeyVen02                 KEY(VEN:NOMBRE),DUP,NAME('KeyVen02'),NOCASE,OPT !Por Nombre          
Record                   RECORD,PRE()
CODVEN                      CSTRING(16)                    !Código  Vendedor    
NOMBRE                      CSTRING(41)                    !Nombre del Vendedor 
DIRECC1                     CSTRING(61)                    !Direccion 1         
DIRECC2                     CSTRING(61)                    !Direccion 2         
NUMTEL                      CSTRING(41)                    !Números Teléfonicos 
PORVENBAJO                  DECIMAL(5,2)                   !Porcentaje de Venta bajo el mínimio
PORVENP1                    DECIMAL(5,2)                   !Porcentaje de Venta Precio 1
PORVENP2                    DECIMAL(5,2)                   !Porcentaje de Venta Precio 2
PORVENP3                    DECIMAL(5,2)                   !Porcentaje de Venta Precio 3
PORCOBP1                    DECIMAL(5,2)                   !Porcentaje de Cobro Precio 1
PORCOBP2                    DECIMAL(5,2)                   !Porcentaje de Cobro Precio 2
PORCOBP3                    DECIMAL(5,2)                   !Porcentaje de Cobro Precio 3
PORVENSER                   DECIMAL(5,2)                   !Porcentaje de Venta por Servicio
PORCOBSER                   DECIMAL(5,2)                   !Porcentaje de Cobro por Servicio
PORCOBBAJO                  DECIMAL(5,2)                   !Porcentaje de Cobro bajo el mínimio
PORVENGEN                   DECIMAL(5,2)                   !Porcentaje de Venta Generico
PORCOBGEN                   DECIMAL(5,2)                   !Porcentaje de Cobro Generico
CLASE                       CSTRING(11)                    !Clase               
NUMFAX                      CSTRING(41)                    !Número de Fax       
DIRCORREO                   CSTRING(101)                   !Dirección de Correo electronico
CUENTACON                   CSTRING(23)                    !Numero Cuenta Contable
CUENTATER                   CSTRING(23)                    !Numero Cuenta Contable Tercero
USATABCOBROS                BYTE                           !¿Usa tabla de cobros?
TIPOCALCULOCOBRO            CSTRING(16)                    !Tipo de cálculo     
TCR1D                       DECIMAL(15,2)                  !Rango de cobro 1 desde
TCR1H                       DECIMAL(15,2)                  !Rango de cobro 1 hasta
TCR1CAL                     DECIMAL(15,2)                  !Rango de cobro 1 factor
TCR2D                       DECIMAL(15,2)                  !Rango de cobro 2 desde
TCR2H                       DECIMAL(15,2)                  !Rango de cobro 2 hasta
TCR2CAL                     DECIMAL(15,2)                  !Rango de cobro 2 factor
TCR3D                       DECIMAL(15,2)                  !Rango de cobro 3 desde
TCR3H                       DECIMAL(15,2)                  !Rango de cobro 3 hasta
TCR3CAL                     DECIMAL(15,2)                  !Rango de cobro 3 factor
TCR4D                       DECIMAL(15,2)                  !Rango de cobro 4 desde
TCR4H                       DECIMAL(15,2)                  !Rango de cobro 4 hasta
TCR4CAL                     DECIMAL(15,2)                  !Rango de cobro 4 factor
TCR5D                       DECIMAL(15,2)                  !Rango de cobro 5 desde
TCR5H                       DECIMAL(15,2)                  !Rango de cobro 5 hasta
TCR5CAL                     DECIMAL(15,2)                  !Rango de cobro 5 factor
USATABLAVENTAS              BYTE                           !¿Usa tabla de ventas?
TIPOCALCULOVENTA            CSTRING(16)                    !Tipo de cálculo     
TVR1D                       DECIMAL(15,2)                  !Rango de ventas 1 desde
TVR1H                       DECIMAL(15,2)                  !Rango de ventas 1 hasta
TVR1CAL                     DECIMAL(17,2)                  !Rango de ventas 1 factor
TVR2D                       DECIMAL(15,2)                  !Rango de ventas 2 desde
TVR2H                       DECIMAL(15,2)                  !Rango de ventas 2 hasta
TVR2CAL                     DECIMAL(17,2)                  !Rango de ventas 2 factor
TVR3D                       DECIMAL(15,2)                  !Rango de ventas 3 desde
TVR3H                       DECIMAL(15,2)                  !Rango de ventas 3 hasta
TVR3CAL                     DECIMAL(15,2)                  !Rango de ventas 3 factor
TVR4D                       DECIMAL(15,2)                  !Rango de ventas 4 desde
TVR4H                       DECIMAL(15,2)                  !Rango de ventas 4 hasta
TVR4CAL                     DECIMAL(15,2)                  !Rango de ventas 4 factor
TVR5D                       DECIMAL(15,2)                  !Rango de ventas 5 desde
TVR5H                       DECIMAL(15,2)                  !Rango de ventas 5 hasta
TVR5CAL                     DECIMAL(15,2)                  !Rango de ventas 5 factor
NOMBREFORMATOFAC            CSTRING(255)                   !Nombre formato factura del vendedor
FOTO                        CSTRING(81)                    !Foto Usuario        
                         END
                     END                       

Zonas                FILE,DRIVER('TOPSPEED'),NAME(dct:Zonas),PRE(ZON),BINDABLE,CREATE,THREAD !Tabla de Zonas      
KeyZON01                 KEY(ZON:CODZON),NAME('KeyZON01'),NOCASE,OPT,PRIMARY !Por Código          
Record                   RECORD,PRE()
CODZON                      CSTRING(5)                     !Código de Zona      
NOMBRE                      CSTRING(61)                    !Nombre de Zona      
MARCA                       BYTE                           !Documento marcado para reimprsion 0 no 1 si
CLASE                       CSTRING(11)                    !Clase               
                         END
                     END                       

!endregion

Access:ParameML      &FileManager,THREAD                   ! FileManager for ParameML
Relate:ParameML      &RelationManager,THREAD               ! RelationManager for ParameML
Access:ProCliML      &FileManager,THREAD                   ! FileManager for ProCliML
Relate:ProCliML      &RelationManager,THREAD               ! RelationManager for ProCliML
Access:TiposComercio &FileManager,THREAD                   ! FileManager for TiposComercio
Relate:TiposComercio &RelationManager,THREAD               ! RelationManager for TiposComercio
Access:Vendedores    &FileManager,THREAD                   ! FileManager for Vendedores
Relate:Vendedores    &RelationManager,THREAD               ! RelationManager for Vendedores
Access:Zonas         &FileManager,THREAD                   ! FileManager for Zonas
Relate:Zonas         &RelationManager,THREAD               ! RelationManager for Zonas

GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons
FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
LocalErrorStatus     ErrorStatusClass,THREAD
LocalErrors          ErrorClass
LocalINIMgr          INIClass
GlobalErrors         &ErrorClass
INIMgr               &INIClass
DLLInitializer       CLASS,TYPE                            ! An object of this type is used to initialize the dll, it is created in the generated bc module
Construct              PROCEDURE
Destruct               PROCEDURE
                     END

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
DLLInitializer.Construct PROCEDURE


  CODE
  LocalErrors.Init(LocalErrorStatus)
  LocalINIMgr.Init('.\PMasTpsAccess.INI', NVD_INI)         ! Initialize the local INI manager to use windows INI file
  INIMgr &= LocalINIMgr
  IF GlobalErrors &= NULL
    GlobalErrors &= LocalErrors                            ! Assign local managers to global managers
  END
  DctInit
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
      Glo:RutaProg    = CLIP(PATH())
      glo:rutadatos    = GETINI('Sistemas','RutaDatos',' ',GLO:RUTAPROG&'\'&'Professional.ini')
  !
      DCT:ProCliML             = clip(glo:rutadatos)&'\'&'CFPROCLI.TPS'
      DCT:ParameML             = clip(glo:rutadatos)&'\'&'CFPARAME.TPS'
      DCT:TiposComercio        = clip(glo:rutadatos)&'\'&'CFTIPCOM.TPS'
      DCT:Vendedores           = clip(glo:rutadatos)&'\'&'CFVENDED.TPS'
      DCT:Zonas                = clip(glo:rutadatos)&'\'&'CFZONA.TPS'
  
!These procedures are used to initialize the DLL. It must be called by the main executable when it starts up
PMasTpsAccess:Init PROCEDURE(<ErrorClass curGlobalErrors>, <INIClass curINIMgr>)
PMasTpsAccess:Init_Called    BYTE,STATIC

  CODE
  IF PMasTpsAccess:Init_Called
     RETURN
  ELSE
     PMasTpsAccess:Init_Called = True
  END
  IF ~curGlobalErrors &= NULL
    GlobalErrors &= curGlobalErrors
  END
  IF ~curINIMgr &= NULL
    INIMgr &= curINIMgr
  END
  Access:ParameML.SetErrors(GlobalErrors)
  Access:ProCliML.SetErrors(GlobalErrors)
  Access:TiposComercio.SetErrors(GlobalErrors)
  Access:Vendedores.SetErrors(GlobalErrors)
  Access:Zonas.SetErrors(GlobalErrors)

!This procedure is used to shutdown the DLL. It must be called by the main executable before it closes down

PMasTpsAccess:Kill PROCEDURE
PMasTpsAccess:Kill_Called    BYTE,STATIC

  CODE
  IF PMasTpsAccess:Kill_Called
     RETURN
  ELSE
     PMasTpsAccess:Kill_Called = True
  END
  

DLLInitializer.Destruct PROCEDURE

  CODE
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher
  LocalINIMgr.Kill                                         ! Kill local managers and assign NULL to global refernces
  INIMgr &= NULL                                           ! It is an error to reference these object after this point
  GlobalErrors &= NULL



Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

