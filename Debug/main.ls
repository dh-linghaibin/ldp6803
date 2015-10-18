   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
4392                     ; 7 main()
4392                     ; 8 {
4394                     	switch	.text
4395  0000               _main:
4399                     ; 10 	CLK_CKDIVR=0x00;
4401  0000 725f50c6      	clr	_CLK_CKDIVR
4402                     ; 12 	PC_DDR |= BIT(4);
4404  0004 7218500c      	bset	_PC_DDR,#4
4405                     ; 13 	PC_CR1 |= BIT(4); 
4407  0008 7218500d      	bset	_PC_CR1,#4
4408                     ; 14 	PC_CR2 |= BIT(4);
4410  000c 7218500e      	bset	_PC_CR2,#4
4411                     ; 16 	PC_DDR |= BIT(3);
4413  0010 7216500c      	bset	_PC_DDR,#3
4414                     ; 17 	PC_CR1 |= BIT(3); 
4416  0014 7216500d      	bset	_PC_CR1,#3
4417                     ; 18 	PC_CR2 |= BIT(3);
4419  0018 7216500e      	bset	_PC_CR2,#3
4420  001c               L1003:
4421                     ; 20 	while (1);
4423  001c 20fe          	jra	L1003
4495                     ; 24 LED_SendData(u8 Rdt, u8 Gdt, u8 Bdt) 
4495                     ; 25 { 
4496                     	switch	.text
4497  001e               _LED_SendData:
4499  001e 89            	pushw	x
4500  001f 89            	pushw	x
4501       00000002      OFST:	set	2
4504                     ; 26 	u8 j = 0,i = 0;
4506  0020 7b02          	ld	a,(OFST+0,sp)
4507  0022 97            	ld	xl,a
4510  0023 7b02          	ld	a,(OFST+0,sp)
4511  0025 97            	ld	xl,a
4512                     ; 27 	u8 mask = 0;
4514  0026 0f01          	clr	(OFST-1,sp)
4515                     ; 29 	SCLK = 0;  
4517  0028 7217500a      	bres	_OPC3
4518                     ; 30 	SDO = 0; 
4520  002c 7219500f      	bres	_OPD4
4521                     ; 31 	for(i=0;i<32;i++)
4523  0030 0f02          	clr	(OFST+0,sp)
4524  0032               L3403:
4525                     ; 33 		SCLK=1;
4527  0032 7216500a      	bset	_OPC3
4528                     ; 34 		SCLK=0;
4530  0036 7217500a      	bres	_OPC3
4531                     ; 31 	for(i=0;i<32;i++)
4533  003a 0c02          	inc	(OFST+0,sp)
4536  003c 7b02          	ld	a,(OFST+0,sp)
4537  003e a120          	cp	a,#32
4538  0040 25f0          	jrult	L3403
4539                     ; 39 	for(j=0;j<5;j++)  
4541  0042 0f02          	clr	(OFST+0,sp)
4542  0044               L1503:
4543                     ; 41 		if(mask&Rdt)  
4545  0044 7b01          	ld	a,(OFST-1,sp)
4546  0046 1503          	bcp	a,(OFST+1,sp)
4547  0048 2706          	jreq	L7503
4548                     ; 42 			SDO = 1;   
4550  004a 7218500f      	bset	_OPD4
4552  004e 2004          	jra	L1603
4553  0050               L7503:
4554                     ; 44 			SDO = 0;   
4556  0050 7219500f      	bres	_OPD4
4557  0054               L1603:
4558                     ; 45 		SCLK=1;
4560  0054 7216500a      	bset	_OPC3
4561                     ; 46 		SCLK=0;  
4563  0058 7217500a      	bres	_OPC3
4564                     ; 47 		mask>>=1;  
4566  005c 0401          	srl	(OFST-1,sp)
4567                     ; 39 	for(j=0;j<5;j++)  
4569  005e 0c02          	inc	(OFST+0,sp)
4572  0060 7b02          	ld	a,(OFST+0,sp)
4573  0062 a105          	cp	a,#5
4574  0064 25de          	jrult	L1503
4575                     ; 50 	for(j=0;j<5;j++)  
4577  0066 0f02          	clr	(OFST+0,sp)
4578  0068               L3603:
4579                     ; 52 		if(mask&Bdt)  
4581  0068 7b01          	ld	a,(OFST-1,sp)
4582  006a 1507          	bcp	a,(OFST+5,sp)
4583  006c 2706          	jreq	L1703
4584                     ; 53 			SDO = 1;   
4586  006e 7218500f      	bset	_OPD4
4588  0072 2004          	jra	L3703
4589  0074               L1703:
4590                     ; 55 			SDO = 0;   
4592  0074 7219500f      	bres	_OPD4
4593  0078               L3703:
4594                     ; 56 		SCLK=1;
4596  0078 7216500a      	bset	_OPC3
4597                     ; 57 		SCLK=0;   
4599  007c 7217500a      	bres	_OPC3
4600                     ; 58 		mask>>=1;  
4602  0080 0401          	srl	(OFST-1,sp)
4603                     ; 50 	for(j=0;j<5;j++)  
4605  0082 0c02          	inc	(OFST+0,sp)
4608  0084 7b02          	ld	a,(OFST+0,sp)
4609  0086 a105          	cp	a,#5
4610  0088 25de          	jrult	L3603
4611                     ; 61 	for(j=0;j<5;j++)  
4613  008a 0f02          	clr	(OFST+0,sp)
4614  008c               L5703:
4615                     ; 63 		if(mask&Bdt)  
4617  008c 7b01          	ld	a,(OFST-1,sp)
4618  008e 1507          	bcp	a,(OFST+5,sp)
4619  0090 2706          	jreq	L3013
4620                     ; 64 			SDO = 1;   
4622  0092 7218500f      	bset	_OPD4
4624  0096 2004          	jra	L5013
4625  0098               L3013:
4626                     ; 66 			SDO = 0;   
4628  0098 7219500f      	bres	_OPD4
4629  009c               L5013:
4630                     ; 67 		SCLK=1;
4632  009c 7216500a      	bset	_OPC3
4633                     ; 68 		SCLK=0;   
4635  00a0 7217500a      	bres	_OPC3
4636                     ; 69 		mask>>=1;  
4638  00a4 0401          	srl	(OFST-1,sp)
4639                     ; 61 	for(j=0;j<5;j++)  
4641  00a6 0c02          	inc	(OFST+0,sp)
4644  00a8 7b02          	ld	a,(OFST+0,sp)
4645  00aa a105          	cp	a,#5
4646  00ac 25de          	jrult	L5703
4647                     ; 71 	SDO=0; 
4649  00ae 7219500f      	bres	_OPD4
4650                     ; 72 	SCLK=1;
4652  00b2 7216500a      	bset	_OPC3
4653                     ; 73 	SCLK=0;   
4655  00b6 7217500a      	bres	_OPC3
4656                     ; 75 }
4659  00ba 5b04          	addw	sp,#4
4660  00bc 81            	ret
4673                     	xdef	_LED_SendData
4674                     	xdef	_main
4693                     	end
