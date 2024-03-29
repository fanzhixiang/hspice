***DiffPair

.protect
.lib 'rf018.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12
*.option dccap=1 accurate=1 post

***netlist***
M1	1	Vinp	b		b		pch	W = 18.6u L = 0.2u m = 2
M2	2	Vinn	b		b		pch	W = 18.6u L = 0.2u m = 2
M5	1	b1		vss	vss	nch	W = 7.2u L = 0.2u m = 1
M6	2	b1		vss	vss	nch	W = 7.2u L = 0.2u m = 1
Mb	b	cmfb	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
*low f gain = 26.9db (22.13)
*kappa ~= 0.7


***param***
.param 
+comon		= 0.5
+bias			= 0.6
+supplyp	= 1.0
+supplyn	= 0
+diff			= 0

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
*vocm	vocm	gnd dc comon 
vb 		cmfb	gnd dc bias *ac = 1 
vb1		b1		gnd dc = 0.3


***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' ac = 1 180

***output***
*Vo	2	gnd dc = 0.5v

***testing
*mt	vdt	vgt	vdd	vdd	pch	w = 10u l = 1u m = 2 			*vgs=0.4: (vds, id) = (0.2, 0.5546u)(0.4, 0.565u); 
.param wp = 19u wn = 7.2u
*mt	vdt	vgt	vdd	vdd	pch	w = 19u l = 0.2u m = 2  *vgs=0.3: (vds, id) = (0.4, 281n)
*mt	vdt	vgt	vss	vss	nch	w = 7.2 l = 0.2u
*mt	vdt	vgt	vdd	vdd	pch	w = 6u l = 0.2u m = 2 *vgs=0.35:	(vds, id) = (0.15, 275.72n)
*mt	vdt	vgt	vss	vss	nch	w = 7.8u l = 0.2u			*vgs=0.3:		(vds, id) = (0.25, 277.572n)
mt	vdt	vgt	vss	vss	nch	w = 30u l = 0.2u			*vgs=0.25:	(vds, id) = (0.25, 278.555n)
vtg	vgt	gnd dc = 0.25v
vtd	vdt	gnd dc = 0.25v

.op

***sweep***
.dc diff -0.5 0.5 0.01
***testing***
*.dc vtd 0.2 0.4 0.01 *sweep wn 1u 20u 200n

***probe&measuring***
.ac dec 1000 10 1g
.pz v(2) vinp
.probe dc I(mt) I(m1) I(m2)
.probe ac gain=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')


.end
