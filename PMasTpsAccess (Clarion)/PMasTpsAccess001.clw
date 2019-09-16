

   MEMBER('PMasTpsAccess.clw')                             ! This is a MEMBER module

                     MAP
                       INCLUDE('PMASTPSACCESS001.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ReadClientsTable     PROCEDURE                             ! Declare Procedure
RR                  CSTRING(300000)
R                   STRING(300000)

  CODE
    open(ProCliML)
    RR = ''
    set(PRO:KeyPro01,PRO:KeyPro01)
    LOOP
        case Access:ProCliML.Next()
        of Level:Notify  OROF Level:Fatal
            break
        else
            RR = RR&PRO:NOMBRE&'<9>'&PRO:REPRESEN&'<9>'&PRO:DIRECC1&'<9>'&PRO:DIRECC2&'<9>'&PRO:NUMTEL&'<9>'&PRO:RIF&'<9>'&PRO:NIT&'<9>'&PRO:PRECIO&'<9>'&PRO:FECHA1&'<9>'&PRO:FECHA2&'<9>'&PRO:FECHA1S&'<9>'&PRO:FECHA2S&'<9>'&PRO:MONTODEB&'<9>'&PRO:MONTOCRE&'<9>'&PRO:LIMITECRE&'<9>'&PRO:CODVEN&'<9>'&PRO:DIASBLOQUEO&'<9>'&PRO:TIPOCLI&'<9>'&PRO:DIASCRE&'<9>'&PRO:PORRET&'<9>'&PRO:TIPOPRO&'<9>'&PRO:ANTICIPOS&'<9>'&PRO:CODZON&'<9>'&PRO:NUMFAX&'<9>'&PRO:DIRCORREO&'<9>'&PRO:CLASE&'<9>'&PRO:PERCREDITO&'<9>'&PRO:CUENTACON&'<9>'&PRO:CUENTATER&'<9>'&PRO:CALCIMPUESTO&'<9>'&PRO:DIRECCALTERNA1&'<9>'&PRO:DIRECCALTERNA2&'<9>'&PRO:PORRETIMP&'<9>'&PRO:CONESPECIAL&'<9>'&PRO:TIPOPROVEEDOR&'<9>'&PRO:PORMAXDESPAR&'<9>'&PRO:PORMAXDESGLO&'<9>'&PRO:SERFuma&'<9>'&PRO:SERAlergias&'<9>'&PRO:SERDiabetes&'<9>'&PRO:SERSida&'<9>'&PRO:SERTensionBaja&'<9>'&PRO:SERTensionAlta&'<9>'&PRO:SERAsma&'<9>'&PRO:SERProblemasRenales&'<9>'&PRO:SERInfarto&'<9>'&PRO:SEREpilepsia&'<9>'&PRO:SERCancer&'<9>'&PRO:SEROtros1&'<9>'&PRO:SEROtros2&'<9>'&PRO:FECHANAC&'<9>'&PRO:SEXO&'<9>'&PRO:FOTO&'<9>'&PRO:PREFIJO_MOVIL&'<9>'&PRO:NUMERO_MOVIL&'<9>'&PRO:MARKAR&'<9>'&PRO:NUMTELCONTACTO&'<9>'&PRO:NOMBREGERENTE&'<9>'&PRO:NUMTELGERENTE&'<9>'&PRO:FECNACCONTACTO&'<9>'&PRO:FECNACGERENTE&'<9>'&PRO:TIPOCOMERCIO&'<9>'&PRO:MENSAFACTURAR&'<9>'&PRO:NOMBREEGEO1&'<9>'&PRO:NOMBREEGEO2&'<9>'&PRO:NOMBREEGEO3&'<9>'&PRO:NOMBRE1&'<9>'&PRO:NOMBRE2&'<9>'&PRO:APELLIDO1&'<9>'&PRO:APELLIDO2&'<9>'&PRO:CODIGOPOSTAL&'<9>'&PRO:NOMBREBAREMO&'<9>'&PRO:APLICADSTOFAC&'<9>'&PRO:TIPOAFILIADO&'<9>'&PRO:CODIGOPAGADOR&'<9>'&PRO:SITAFILIADO&'<9>'&PRO:INTEGRADO&'<13>'
        END
    until Access:ProCliML.GetEOF()
    R = CLIP(RR)
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ReadClientsTableWrapper PROCEDURE                          ! Declare Procedure
R                   BSTRING

  CODE
    R = ReadClientsTable()
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
AddClient            PROCEDURE  (STRING TIPREG,STRING CODIGO,STRING NOMBRE,STRING DIRECC1,STRING NUMTEL,STRING RIF,STRING CODVEN,STRING CODZON,STRING TIPOCOMERCIO,STRING NOMBRE1,STRING NOMBRE2,STRING APELLIDO1,STRING APELLIDO2) ! Declare Procedure
loc:error            BYTE                                  !
R                   STRING(100)

  CODE
    PRO:TIPREG = TIPREG
    PRO:CODIGO = CODIGO
    PRO:NOMBRE = NOMBRE
    PRO:DIRECC1 = DIRECC1
    PRO:NUMTEL = NUMTEL
    PRO:RIF = RIF
    PRO:CODVEN = CODVEN
    PRO:CODZON = CODZON 
    PRO:TIPOCOMERCIO = TIPOCOMERCIO
    PRO:NOMBRE1 = NOMBRE1
    PRO:NOMBRE2 = NOMBRE2
    PRO:APELLIDO1 = APELLIDO1
    PRO:APELLIDO2 = APELLIDO2
    loc:error = 0

    open(Vendedores)
    VEN:CODVEN = CODVEN
    if Access:Vendedores.Fetch(VEN:KeyVen01)
        R = 'El código de vendedor no existe'
        loc:error = 1
    END
    open(Zonas)
    ZON:CODZON = CODZON
    if Access:Zonas.Fetch(ZON:KeyZON01)
        R = 'El código de zona no existe'
        loc:error = 1
    END
    open(TiposComercio)
    if PRO:TIPOCOMERCIO <> 'NULL' and PRO:TIPOCOMERCIO <> ''
        TIPC:TIPOCOMERCIO = PRO:TIPOCOMERCIO
        if Access:TiposComercio.Fetch(TIPC:KeyTIPC01)
                PRO:TIPOCOMERCIO = ''
                PRO:NOMBRE1 = ''
                PRO:NOMBRE2 = ''
                PRO:APELLIDO1 = ''
                PRO:APELLIDO2 = ''
        ELSE
                if TIPC:TIPODESCRIP = 1
                        if PRO:NOMBRE1 = 'NULL' or PRO:NOMBRE1 = ''
                            R = 'No ingresó el nombre del cliente/proveedor'
                            loc:error = 1
                        ELSE
                            if PRO:NOMBRE2 = 'NULL'
                                PRO:NOMBRE2 = ''
                            END
                            if PRO:APELLIDO1 = 'NULL' or PRO:APELLIDO1 = ''
                                R = 'No ingresó el apellido del cliente/proveedor'
                                loc:error = 1
                            END
                            if PRO:APELLIDO2 = 'NULL'
                                PRO:APELLIDO2 = ''
                            END                            
                        END

                        PRO:NOMBRE = PRO:NOMBRE1&' '&PRO:NOMBRE2&','&PRO:APELLIDO1&' '&PRO:APELLIDO2
                 ELSE
                        PRO:NOMBRE1 = ''
                        PRO:NOMBRE2 = ''
                        PRO:APELLIDO1 = ''
                        PRO:APELLIDO2 = ''
                 END
        END
    ELSE
    PRO:TIPOCOMERCIO = ''
    PRO:NOMBRE1 = ''
    PRO:NOMBRE2 = ''
    PRO:APELLIDO1 = ''
    PRO:APELLIDO2 = ''
    END
    if loc:error = 1
    ELSE
        open(ProCliML)
        if Access:ProCliML.Insert()
            R = error()
        ELSE
            R = '1'
        END
    END

    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
AddClientWrapper     PROCEDURE  (BSTRING TIPREG,BSTRING CODIGO,BSTRING NOMBRE,BSTRING DIRECC1,BSTRING NUMTEL,BSTRING RIF,BSTRING CODVEN,BSTRING CODZON,BSTRING TIPOCOMERCIO,BSTRING NOMBRE1,BSTRING NOMBRE2,BSTRING APELLIDO1,BSTRING APELLIDO2) ! Declare Procedure
R                   BSTRING

  CODE
    R = AddClient(TIPREG,CODIGO,NOMBRE,DIRECC1,NUMTEL,RIF,CODVEN,CODZON,TIPOCOMERCIO,NOMBRE1,NOMBRE2,APELLIDO1,APELLIDO2)
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
DeleteClient         PROCEDURE  (STRING VALOR1,STRING VALOR2) ! Declare Procedure
R                   STRING(100)

  CODE
    open(ProCliML)
    R = 'Error: No se encontró registro'
    set(PRO:KeyPro01,PRO:KeyPro01)
    LOOP
        case Access:ProCliML.Next()
        of Level:Notify  OROF Level:Fatal
            break
        else
            if PRO:TIPREG = VALOR1
                if PRO:CODIGO = VALOR2
                    DELETE(ProCliML)
!                    Access:ParameML.DeleteRecord()                 !! Si se usa este, pregunta que si quiere o no borrar el registro.
                    R = '1'
                    break
                END
            END
            
        END
    until Access:ProCliML.GetEOF()
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
DeleteClientWrapper  PROCEDURE  (BSTRING VALOR1,BSTRING VALOR2) ! Declare Procedure
R                   BSTRING

  CODE
    R = DeleteClient(VALOR1,VALOR2)
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ModifyClient         PROCEDURE  (STRING VALOR1,STRING VALOR2,STRING VALOR3,STRING VALOR4,STRING VALOR5,STRING VALOR6,STRING VALOR7,STRING VALOR8,STRING VALOR9,STRING VALOR10,STRING VALOR11,STRING VALOR12,STRING VALOR13) ! Declare Procedure
loc:error            BYTE                                  !
R                   STRING(100)

  CODE
    open(ProCliML)
    set(PRO:KeyPro01,PRO:KeyPro01)
    LOOP
        case Access:ProCliML.Next()
        of Level:Notify  OROF Level:Fatal
            R = 'No se encontró registro del cliente/proveedor'
            break
        else
            if PRO:TIPREG = VALOR1
                if PRO:CODIGO = VALOR2                  
                    if VALOR3 = 'NULL' or VALOR3 = ''
                    ELSE
                        PRO:NOMBRE = VALOR3
                    END
                    if VALOR4 = 'NULL' or VALOR4 = ''
                    ELSE
                        PRO:DIRECC1 = VALOR4
                    END
                    IF VALOR5 = 'NULL' or VALOR5 = ''
                    ELSE
                        PRO:NUMTEL = VALOR5
                    END
                    if VALOR6 = 'NULL' or VALOR6 = ''
                    ELSE
                        PRO:RIF = VALOR6
                    END
                    if VALOR7 = 'NULL' or VALOR7 = ''
                    ELSE
                        open(Vendedores)
                        VEN:CODVEN = VALOR7
                        if Access:Vendedores.Fetch(VEN:KeyVen01)
                            R = 'El código de vendedor no existe'
                            loc:error = 1
                            break
                        ELSE
                            PRO:CODVEN = VALOR7
                        END
                    END
                    if VALOR8 = 'NULL' or VALOR8 = ''
                    ELSE
                        open(Zonas)
                        ZON:CODZON = VALOR8
                        if Access:Zonas.Fetch(ZON:KeyZON01)
                            R = 'El código de zona no existe'
                            loc:error = 1
                            break
                        ELSE
                            PRO:CODZON = VALOR8
                        END
                    END
                    if VALOR9 = 'NULL'
                    ELSE
                        if VALOR9 = ''
                            PRO:TIPOCOMERCIO = VALOR9
                        ELSE
                            open(TiposComercio)
                            TIPC:TIPOCOMERCIO = VALOR9
                                if Access:TiposComercio.Fetch(TIPC:KeyTIPC01)
                                ELSE
                                    PRO:TIPOCOMERCIO = VALOR9
                                    if TIPC:TIPODESCRIP = 1
                                        if VALOR10 = 'NULL' or VALOR10 = ''
                                        ELSE
                                            PRO:NOMBRE1 = VALOR10
                                        END
                                        if VALOR11 = 'NULL' or VALOR11 = ''
                                        ELSE
                                            PRO:NOMBRE2 = VALOR11
                                        END
                                        if VALOR12 = 'NULL' or VALOR12 = ''
                                        ELSE
                                            PRO:APELLIDO1 = VALOR12
                                        END
                                        if VALOR13 = 'NULL' or VALOR13 = ''
                                        ELSE
                                            PRO:APELLIDO2 = VALOR13
                                        END
                                            if PRO:NOMBRE1 = 'NULL' or PRO:NOMBRE1 = ''
                                                R = 'No ingresó el nombre del cliente/proveedor'
                                                loc:error = 1
                                            ELSE
                                                if PRO:NOMBRE2 = 'NULL'
                                                    PRO:NOMBRE2 = ''
                                                END
                                                if PRO:APELLIDO1 = 'NULL' or PRO:APELLIDO1 = ''
                                                    R = 'No ingresó el apellido del cliente/proveedor'
                                                    loc:error = 1
                                                END
                                                if PRO:APELLIDO2 = 'NULL'
                                                    PRO:APELLIDO2 = ''
                                                END                            
                                            END
                                        PRO:NOMBRE = PRO:NOMBRE1&' '&PRO:NOMBRE2&','&PRO:APELLIDO1&' '&PRO:APELLIDO2
                                     END
                                END
                        END
                    END
                    if loc:error = 1
                        break
                    ELSE
                        if Access:ProCliML.Update()
                            R = error()
                        ELSE
                            R = '1'
                        END
                        break
                    END
                END
            END
            
        END
    until Access:ProCliML.GetEOF()
    RETURN(R)
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ModifyClientWrapper  PROCEDURE  (BSTRING VALOR1,BSTRING VALOR2,BSTRING VALOR3,BSTRING VALOR4,BSTRING VALOR5,BSTRING VALOR6,BSTRING VALOR7,BSTRING VALOR8,BSTRING VALOR9,BSTRING VALOR10,BSTRING VALOR11,BSTRING VALOR12,BSTRING VALOR13) ! Declare Procedure
R                   BSTRING

  CODE
  R = ModifyClient(VALOR1,VALOR2,VALOR3,VALOR4,VALOR5,VALOR6,VALOR7,VALOR8,VALOR9,VALOR10,VALOR11,VALOR12,VALOR13)
  RETURN(R)
