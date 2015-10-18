   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
4393                     ; 7 main()
4393                     ; 8 {
4395                     	switch	.text
4396  0000               _main:
4400                     ; 10 	CLK_CKDIVR=0x00;
4402  0000 725f50c6      	clr	_CLK_CKDIVR
4403                     ; 12 	PD_DDR |= BIT(1);
4405  0004 72125011      	bset	_PD_DDR,#1
4406                     ; 13 	PD_CR1 |= BIT(1); 
4408  0008 72125012      	bset	_PD_CR1,#1
4409                     ; 14 	PD_CR2 |= BIT(1);
4411  000c 72125013      	bset	_PD_CR2,#1
4412                     ; 16 	PD_DDR |= BIT(2);
4414  0010 72145011      	bset	_PD_DDR,#2
4415                     ; 17 	PD_CR1 |= BIT(2); 
4417  0014 72145012      	bset	_PD_CR1,#2
4418                     ; 18 	PD_CR2 |= BIT(2);
4420  0018 72145013      	bset	_PD_CR2,#2
4421  001c               L1003:
4422                     ; 26 		LED_SendData(0,0,0);
4424  001c 4b00          	push	#0
4425  001e 5f            	clrw	x
4426  001f 4f            	clr	a
4427  0020 95            	ld	xh,a
4428  0021 ad2b          	call	_LED_SendData
4430  0023 84            	pop	a
4432  0024 20f6          	jra	L1003
4475                     ; 36 void delayms(u16 ms)	
4475                     ; 37 {						
4476                     	switch	.text
4477  0026               _delayms:
4479  0026 89            	pushw	x
4480  0027 89            	pushw	x
4481       00000002      OFST:	set	2
4484  0028 2011          	jra	L1303
4485  002a               L7203:
4486                     ; 42 		for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
4488  002a 5f            	clrw	x
4489  002b 1f01          	ldw	(OFST-1,sp),x
4490  002d               L5303:
4494  002d 1e01          	ldw	x,(OFST-1,sp)
4495  002f 1c0001        	addw	x,#1
4496  0032 1f01          	ldw	(OFST-1,sp),x
4499  0034 1e01          	ldw	x,(OFST-1,sp)
4500  0036 a30465        	cpw	x,#1125
4501  0039 25f2          	jrult	L5303
4502  003b               L1303:
4503                     ; 39 	while(ms--)
4505  003b 1e03          	ldw	x,(OFST+1,sp)
4506  003d 1d0001        	subw	x,#1
4507  0040 1f03          	ldw	(OFST+1,sp),x
4508  0042 1c0001        	addw	x,#1
4509  0045 a30000        	cpw	x,#0
4510  0048 26e0          	jrne	L7203
4511                     ; 44 }
4514  004a 5b04          	addw	sp,#4
4515  004c 81            	ret
4549                     ; 52 void delayus(u16 us) 	
4549                     ; 53 {	
4550                     	switch	.text
4551  004d               _delayus:
4555                     ; 55 }
4558  004d 81            	ret
4623                     ; 57 LED_SendData(u8 Rdt, u8 Gdt, u8 Bdt) 
4623                     ; 58 { 
4624                     	switch	.text
4625  004e               _LED_SendData:
4627  004e 89            	pushw	x
4628  004f 5203          	subw	sp,#3
4629       00000003      OFST:	set	3
4632                     ; 59 	u8 j = 0,i = 0;
4634  0051 7b02          	ld	a,(OFST-1,sp)
4635  0053 97            	ld	xl,a
4638  0054 7b01          	ld	a,(OFST-2,sp)
4639  0056 97            	ld	xl,a
4640                     ; 60 	u8 mask = 0;
4642  0057 7b03          	ld	a,(OFST+0,sp)
4643  0059 97            	ld	xl,a
4644                     ; 62 	SCLK = 0;  
4646  005a 7213500f      	bres	_OPD1
4647                     ; 63 	SDO = 0; 
4649  005e 7215500f      	bres	_OPD2
4650                     ; 64 	delayus(10);
4652  0062 ae000a        	ldw	x,#10
4653  0065 ade6          	call	_delayus
4655                     ; 66 	for(i=0;i<32;i++)
4657  0067 0f01          	clr	(OFST-2,sp)
4658  0069               L3113:
4659                     ; 68 		SCLK=1;
4661  0069 7212500f      	bset	_OPD1
4662                     ; 69 		delayus(10);
4664  006d ae000a        	ldw	x,#10
4665  0070 addb          	call	_delayus
4667                     ; 70 		SCLK=0;
4669  0072 7213500f      	bres	_OPD1
4670                     ; 71 		delayus(10);
4672  0076 ae000a        	ldw	x,#10
4673  0079 add2          	call	_delayus
4675                     ; 66 	for(i=0;i<32;i++)
4677  007b 0c01          	inc	(OFST-2,sp)
4680  007d 7b01          	ld	a,(OFST-2,sp)
4681  007f a120          	cp	a,#32
4682  0081 25e6          	jrult	L3113
4683                     ; 74 	for(i = 0;i < 1; i++)	
4685  0083 0f01          	clr	(OFST-2,sp)
4686  0085               L1213:
4687                     ; 76 		SDO=1;
4689  0085 7214500f      	bset	_OPD2
4690                     ; 77 		SCLK=1;
4692  0089 7212500f      	bset	_OPD1
4693                     ; 78 		delayus(10);
4695  008d ae000a        	ldw	x,#10
4696  0090 adbb          	call	_delayus
4698                     ; 79 		SCLK=0;   
4700  0092 7213500f      	bres	_OPD1
4701                     ; 80 		delayus(10);
4703  0096 ae000a        	ldw	x,#10
4704  0099 adb2          	call	_delayus
4706                     ; 83 		mask = 0x10; 
4708  009b a610          	ld	a,#16
4709  009d 6b03          	ld	(OFST+0,sp),a
4710                     ; 84 		for(j=0;j<5;j++)  
4712  009f 0f02          	clr	(OFST-1,sp)
4713  00a1               L7213:
4714                     ; 86 			if(mask&Rdt)  
4716  00a1 7b03          	ld	a,(OFST+0,sp)
4717  00a3 1504          	bcp	a,(OFST+1,sp)
4718  00a5 2706          	jreq	L5313
4719                     ; 87 				SDO = 1;   
4721  00a7 7214500f      	bset	_OPD2
4723  00ab 2004          	jra	L7313
4724  00ad               L5313:
4725                     ; 89 				SDO = 0;  
4727  00ad 7215500f      	bres	_OPD2
4728  00b1               L7313:
4729                     ; 90 			delayus(10);			
4731  00b1 ae000a        	ldw	x,#10
4732  00b4 ad97          	call	_delayus
4734                     ; 91 			SCLK=1;
4736  00b6 7212500f      	bset	_OPD1
4737                     ; 92 			delayus(10);
4739  00ba ae000a        	ldw	x,#10
4740  00bd ad8e          	call	_delayus
4742                     ; 93 			SCLK=0;  
4744  00bf 7213500f      	bres	_OPD1
4745                     ; 94 			delayus(10);
4747  00c3 ae000a        	ldw	x,#10
4748  00c6 ad85          	call	_delayus
4750                     ; 95 			mask>>=1;  
4752  00c8 0403          	srl	(OFST+0,sp)
4753                     ; 84 		for(j=0;j<5;j++)  
4755  00ca 0c02          	inc	(OFST-1,sp)
4758  00cc 7b02          	ld	a,(OFST-1,sp)
4759  00ce a105          	cp	a,#5
4760  00d0 25cf          	jrult	L7213
4761                     ; 98 		mask = 0x10; 
4763  00d2 a610          	ld	a,#16
4764  00d4 6b03          	ld	(OFST+0,sp),a
4765                     ; 99 		for(j=0;j<5;j++)  
4767  00d6 0f02          	clr	(OFST-1,sp)
4768  00d8               L1413:
4769                     ; 101 			if(mask&Rdt)  
4771  00d8 7b03          	ld	a,(OFST+0,sp)
4772  00da 1504          	bcp	a,(OFST+1,sp)
4773  00dc 2706          	jreq	L7413
4774                     ; 102 				SDO = 1;   
4776  00de 7214500f      	bset	_OPD2
4778  00e2 2004          	jra	L1513
4779  00e4               L7413:
4780                     ; 104 				SDO = 0;  
4782  00e4 7215500f      	bres	_OPD2
4783  00e8               L1513:
4784                     ; 105 			delayus(10);			
4786  00e8 ae000a        	ldw	x,#10
4787  00eb cd004d        	call	_delayus
4789                     ; 106 			SCLK=1;
4791  00ee 7212500f      	bset	_OPD1
4792                     ; 107 			delayus(10);
4794  00f2 ae000a        	ldw	x,#10
4795  00f5 cd004d        	call	_delayus
4797                     ; 108 			SCLK=0;  
4799  00f8 7213500f      	bres	_OPD1
4800                     ; 109 			delayus(10);
4802  00fc ae000a        	ldw	x,#10
4803  00ff cd004d        	call	_delayus
4805                     ; 110 			mask>>=1;  
4807  0102 0403          	srl	(OFST+0,sp)
4808                     ; 99 		for(j=0;j<5;j++)  
4810  0104 0c02          	inc	(OFST-1,sp)
4813  0106 7b02          	ld	a,(OFST-1,sp)
4814  0108 a105          	cp	a,#5
4815  010a 25cc          	jrult	L1413
4816                     ; 113 		mask = 0x10; 
4818  010c a610          	ld	a,#16
4819  010e 6b03          	ld	(OFST+0,sp),a
4820                     ; 114 		for(j=0;j<5;j++)  
4822  0110 0f02          	clr	(OFST-1,sp)
4823  0112               L3513:
4824                     ; 116 			if(mask&Rdt)  
4826  0112 7b03          	ld	a,(OFST+0,sp)
4827  0114 1504          	bcp	a,(OFST+1,sp)
4828  0116 2706          	jreq	L1613
4829                     ; 117 				SDO = 1;   
4831  0118 7214500f      	bset	_OPD2
4833  011c 2004          	jra	L3613
4834  011e               L1613:
4835                     ; 119 				SDO = 0;  
4837  011e 7215500f      	bres	_OPD2
4838  0122               L3613:
4839                     ; 120 			delayus(10);			
4841  0122 ae000a        	ldw	x,#10
4842  0125 cd004d        	call	_delayus
4844                     ; 121 			SCLK=1;
4846  0128 7212500f      	bset	_OPD1
4847                     ; 122 			delayus(10);
4849  012c ae000a        	ldw	x,#10
4850  012f cd004d        	call	_delayus
4852                     ; 123 			SCLK=0;  
4854  0132 7213500f      	bres	_OPD1
4855                     ; 124 			delayus(10);
4857  0136 ae000a        	ldw	x,#10
4858  0139 cd004d        	call	_delayus
4860                     ; 125 			mask>>=1;  
4862  013c 0403          	srl	(OFST+0,sp)
4863                     ; 114 		for(j=0;j<5;j++)  
4865  013e 0c02          	inc	(OFST-1,sp)
4868  0140 7b02          	ld	a,(OFST-1,sp)
4869  0142 a105          	cp	a,#5
4870  0144 25cc          	jrult	L3513
4871                     ; 74 	for(i = 0;i < 1; i++)	
4873  0146 0c01          	inc	(OFST-2,sp)
4876  0148 0d01          	tnz	(OFST-2,sp)
4877  014a 2603          	jrne	L41
4878  014c cc0085        	jp	L1213
4879  014f               L41:
4880                     ; 128 	SDO=0; 
4882  014f 7215500f      	bres	_OPD2
4883                     ; 133 	for(i = 0;i < 1; i++)
4885  0153 0f01          	clr	(OFST-2,sp)
4886  0155               L5613:
4887                     ; 135 		SCLK = 1;
4889  0155 7212500f      	bset	_OPD1
4890                     ; 136 		delayus(10);
4892  0159 ae000a        	ldw	x,#10
4893  015c cd004d        	call	_delayus
4895                     ; 137 		SCLK = 0;
4897  015f 7213500f      	bres	_OPD1
4898                     ; 138 		delayus(10);
4900  0163 ae000a        	ldw	x,#10
4901  0166 cd004d        	call	_delayus
4903                     ; 133 	for(i = 0;i < 1; i++)
4905  0169 0c01          	inc	(OFST-2,sp)
4908  016b 0d01          	tnz	(OFST-2,sp)
4909  016d 27e6          	jreq	L5613
4910                     ; 140 	delayms(500);
4912  016f ae01f4        	ldw	x,#500
4913  0172 cd0026        	call	_delayms
4915                     ; 142 }
4918  0175 5b05          	addw	sp,#5
4919  0177 81            	ret
4932                     	xdef	_delayms
4933                     	xdef	_main
4934                     	xdef	_delayus
4935                     	xdef	_LED_SendData
4954                     	end
