*simple_wi_OTA.sp
.protect
.lib 'rf018.l' TT
.lib 'rf018.l' DIO
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***
.option brief = 0
.inc 'OTA.sp'

.option brief = 0

XOTA vdd	vss	winp	winn	iout	vb	OTA

v1	winp	inx dc = 0v

Mb		inx	vbm	vdd		vdd	pch	w = 4u	l = 200n	m = 1
*Mi	inx	inx	vss	vss	nch	w = 10u	l = 200n	m = 10
Mnw	inx	vg	nms	nms	nch	w = 2.6u	l = 200n	m = 4
Vnms	nms	gnd dc = 0.5

***OTA	Bias***
vref	winn	gnd dc = 0.9v
vd	vdd	gnd	dc = 1.8v
vs	vss	gnd	dc = 0v
Vbo	vb	gnd	dc = 1.5v
***Input	Bias***
vbias	vbm	gnd	dc = '1.8-0.28'


**G1		inx	gnd	VCCS	vin	gnd	'10^-7'
*Vi		vin gnd dc = 1.2
Ef		vg	gnd	OPAMP	vr	iout
*D1 		vr	vo	NDIO 0.4
*Ed		vg	gnd	OPAMP	vo	gnd
Rf		iout	vg	10x
vr		vr		gnd dc = 0.9v
**Mo	inx	inx	gnd	gnd	nch	w = 2.6u	l = 200n	m = 20
*Rnw nws	gnd 6x


***Trsting***
.param wt = 4.5u
Mt	vdt	vgt	vss	vss	nch	w = wt	l = 200n	m = 1
vtg	vgt	gnd	dc = 0.3v
vtd	vdt	gnd	dc = 0.9v
*Mt	vdt	vdt	vss	vss	nch	w = 10u	l = 200n	m = 10	*this diode connect give id vs vdt: 1e-5_0.3365; 1e-8:0.1047
It	gnd	vt	dc = 0.1u
Dt vt gnd	PDIO 

***
.op
.dc wt	1u	10u	0.1u
.print v(vdt)
.probe I(mt)
.end