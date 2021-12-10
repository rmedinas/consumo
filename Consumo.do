* LA FUNCIÓN CONSUMO KEYNESIANA Y LA HIPÓTESIS DEL INGRESO PERMANENTE
* UN ANÁLISIS EMPÍRICO PARA MÉXICO, 1993 - 2021

* AUTOR: RAMÓN MEDINA SÁNCHEZ
* Estudiante del DCE de la UABC


* GENERACIÓN DE VARIABLES Y FORMATO DE TIEMPO
* Importar datos
clear all
import excel "...\Consumo.xlsx", sheet("Consumo") firstrow

* Generar formato de fecha para series de tiempo
gen trim = quarterly(periodo, "YQ")
format trim %tq

* Generar formato de fecha para series de tiempo
tsset trim, quarterly

* Variables en logarítmos: consumo e ingreso
gen lncons = ln(cons)
gen lnpib = ln(pib)

* Logarítmo del consumo con 1 lag
gen lncons_lag = lncons[_n-1]
gen cons_lag = cons[_n-1]

* Tasa de Interés real
gen intreal = interes - infl


* TRANSFORMACIÓN DE VARIABLES PARA LAS GRÁFICAS

gen cons_mill = cons*1000000
gen cons_milm = cons_mill/1000000000

gen consgob_mill = consgob*1000000
gen consgob_milm = consgob_mill/1000000000


* GRÁFICAS
* Gráfica 1. Consumo privado y consumo como proporción del PIB de la economía mexicana (1993-2021)
graph twoway tsline cons_milm consgob_milm, lp(solid dash) ytitle("Miles de millones de pesos") xtitle("Año") ///
tlabel(1993q1 1997q1 2001q1 2005q1 2009q1 2013q1 2017q1 2021q1) graphregion(fcolor(white)) ysize(1) xsize(1.8)

* Gráfica 2. Consumo privado y consumo por parte del gobierno para la economía mexicana (1993-2021)
twoway area cons_ppib consgob_ppib trim, ytitle("Porcentaje") xtitle("Año") ///
tlabel(1993q1 1997q1 2001q1 2005q1 2009q1 2013q1 2017q1 2021q1) graphregion(fcolor(white)) ysize(1) xsize(1.8)


* RESULATADOS
* Función consumo keynesiana
reg lncons lnpib intreal
reg lncons pib intreal

* Hipótesis del Ingreso Permanente
reg lncons lnpib lncons_lag intreal
reg cons pib cons_lag
