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
4706                     ; 83 		mask = 0x00; 
4708  009b 0f03          	clr	(OFST+0,sp)
4709                     ; 84 		for(j=0;j<5;j++)  
4711  009d 0f02          	clr	(OFST-1,sp)
4712  009f               L7213:
4713                     ; 86 			if(mask&Rdt)  
4715  009f 7b03          	ld	a,(OFST+0,sp)
4716  00a1 1504          	bcp	a,(OFST+1,sp)
4717  00a3 2706          	jreq	L5313
4718                     ; 87 				SDO = 1;   
4720  00a5 7214500f      	bset	_OPD2
4722  00a9 2004          	jra	L7313
4723  00ab               L5313:
4724                     ; 89 				SDO = 0;  
4726  00ab 7215500f      	bres	_OPD2
4727  00af               L7313:
4728                     ; 90 			delayus(10);			
4730  00af ae000a        	ldw	x,#10
4731  00b2 ad99          	call	_delayus
4733                     ; 91 			SCLK=1;
4735  00b4 7212500f      	bset	_OPD1
4736                     ; 92 			delayus(10);
4738  00b8 ae000a        	ldw	x,#10
4739  00bb ad90          	call	_delayus
4741                     ; 93 			SCLK=0;  
4743  00bd 7213500f      	bres	_OPD1
4744                     ; 94 			delayus(10);
4746  00c1 ae000a        	ldw	x,#10
4747  00c4 ad87          	call	_delayus
4749                     ; 95 			mask>>=1;  
4751  00c6 0403          	srl	(OFST+0,sp)
4752                     ; 84 		for(j=0;j<5;j++)  
4754  00c8 0c02          	inc	(OFST-1,sp)
4757  00ca 7b02          	ld	a,(OFST-1,sp)
4758  00cc a105          	cp	a,#5
4759  00ce 25cf          	jrult	L7213
4760                     ; 98 		mask = 0x00; 
4762  00d0 0f03          	clr	(OFST+0,sp)
4763                     ; 99 		for(j=0;j<5;j++)  
4765  00d2 0f02          	clr	(OFST-1,sp)
4766  00d4               L1413:
4767                     ; 101 			if(mask&Rdt)  
4769  00d4 7b03          	ld	a,(OFST+0,sp)
4770  00d6 1504          	bcp	a,(OFST+1,sp)
4771  00d8 2706          	jreq	L7413
4772                     ; 102 				SDO = 1;   
4774  00da 7214500f      	bset	_OPD2
4776  00de 2004          	jra	L1513
4777  00e0               L7413:
4778                     ; 104 				SDO = 0;  
4780  00e0 7215500f      	bres	_OPD2
4781  00e4               L1513:
4782                     ; 105 			delayus(10);			
4784  00e4 ae000a        	ldw	x,#10
4785  00e7 cd004d        	call	_delayus
4787                     ; 106 			SCLK=1;
4789  00ea 7212500f      	bset	_OPD1
4790                     ; 107 			delayus(10);
4792  00ee ae000a        	ldw	x,#10
4793  00f1 cd004d        	call	_delayus
4795                     ; 108 			SCLK=0;  
4797  00f4 7213500f      	bres	_OPD1
4798                     ; 109 			delayus(10);
4800  00f8 ae000a        	ldw	x,#10
4801  00fb cd004d        	call	_delayus
4803                     ; 110 			mask>>=1;  
4805  00fe 0403          	srl	(OFST+0,sp)
4806                     ; 99 		for(j=0;j<5;j++)  
4808  0100 0c02          	inc	(OFST-1,sp)
4811  0102 7b02          	ld	a,(OFST-1,sp)
4812  0104 a105          	cp	a,#5
4813  0106 25cc          	jrult	L1413
4814                     ; 113 		mask = 0x00; 
4816  0108 0f03          	clr	(OFST+0,sp)
4817                     ; 114 		for(j=0;j<5;j++)  
4819  010a 0f02          	clr	(OFST-1,sp)
4820  010c               L3513:
4821                     ; 116 			if(mask&Rdt)  
4823  010c 7b03          	ld	a,(OFST+0,sp)
4824  010e 1504          	bcp	a,(OFST+1,sp)
4825  0110 2706          	jreq	L1613
4826                     ; 117 				SDO = 1;   
4828  0112 7214500f      	bset	_OPD2
4830  0116 2004          	jra	L3613
4831  0118               L1613:
4832                     ; 119 				SDO = 0;  
4834  0118 7215500f      	bres	_OPD2
4835  011c               L3613:
4836                     ; 120 			delayus(10);			
4838  011c ae000a        	ldw	x,#10
4839  011f cd004d        	call	_delayus
4841                     ; 121 			SCLK=1;
4843  0122 7212500f      	bset	_OPD1
4844                     ; 122 			delayus(10);
4846  0126 ae000a        	ldw	x,#10
4847  0129 cd004d        	call	_delayus
4849                     ; 123 			SCLK=0;  
4851  012c 7213500f      	bres	_OPD1
4852                     ; 124 			delayus(10);
4854  0130 ae000a        	ldw	x,#10
4855  0133 cd004d        	call	_delayus
4857                     ; 125 			mask>>=1;  
4859  0136 0403          	srl	(OFST+0,sp)
4860                     ; 114 		for(j=0;j<5;j++)  
4862  0138 0c02          	inc	(OFST-1,sp)
4865  013a 7b02          	ld	a,(OFST-1,sp)
4866  013c a105          	cp	a,#5
4867  013e 25cc          	jrult	L3513
4868                     ; 74 	for(i = 0;i < 1; i++)	
4870  0140 0c01          	inc	(OFST-2,sp)
4873  0142 0d01          	tnz	(OFST-2,sp)
4874  0144 2603          	jrne	L41
4875  0146 cc0085        	jp	L1213
4876  0149               L41:
4877                     ; 128 	SDO=0; 
4879  0149 7215500f      	bres	_OPD2
4880                     ; 133 	for(i = 0;i < 1; i++)
4882  014d 0f01          	clr	(OFST-2,sp)
4883  014f               L5613:
4884                     ; 135 		SCLK = 1;
4886  014f 7212500f      	bset	_OPD1
4887                     ; 136 		delayus(10);
4889  0153 ae000a        	ldw	x,#10
4890  0156 cd004d        	call	_delayus
4892                     ; 137 		SCLK = 0;
4894  0159 7213500f      	bres	_OPD1
4895                     ; 138 		delayus(10);
4897  015d ae000a        	ldw	x,#10
4898  0160 cd004d        	call	_delayus
4900                     ; 133 	for(i = 0;i < 1; i++)
4902  0163 0c01          	inc	(OFST-2,sp)
4905  0165 0d01          	tnz	(OFST-2,sp)
4906  0167 27e6          	jreq	L5613
4907                     ; 140 	delayms(500);
4909  0169 ae01f4        	ldw	x,#500
4910  016c cd0026        	call	_delayms
4912                     ; 142 }
4915  016f 5b05          	addw	sp,#5
4916  0171 81            	ret
4929                     	xdef	_delayms
4930                     	xdef	_main
4931                     	xdef	_delayus
4932                     	xdef	_LED_SendData
4951                     	end
