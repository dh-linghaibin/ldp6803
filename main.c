/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "type.h"

main()
{
	//ʱ�ӳ�ʼ��
	CLK_CKDIVR=0x00;
	//ͨѶPC4 ���			
	PC_DDR |= BIT(4);
	PC_CR1 |= BIT(4); 
	PC_CR2 |= BIT(4);
	//ͨѶPC3 ��
	PC_DDR |= BIT(3);
	PC_CR1 |= BIT(3); 
	PC_CR2 |= BIT(3);
	
	while (1);
}


LED_SendData(u8 Rdt, u8 Gdt, u8 Bdt) 
{ 
	u8 j = 0,i = 0;
	u8 mask = 0;
	
	SCLK = 0;  
	SDO = 0; 
	for(i=0;i<32;i++)
	{
		SCLK=1;
		SCLK=0;
	} 
	//����ʼ32bits 0  SDO=1;SCLK=1;SCLK=0;       
	//����ʼλ'1'  
	//���5λ��ɫ  mask = 0x10; 
	for(j=0;j<5;j++)  
	{ 
		if(mask&Rdt)  
			SDO = 1;   
		else     
			SDO = 0;   
		SCLK=1;
		SCLK=0;  
		mask>>=1;  
	} 
	//���5λ��ɫ  mask = 0x10; 
	for(j=0;j<5;j++)  
	{ 
		if(mask&Bdt)  
			SDO = 1;   
		else     
			SDO = 0;   
		SCLK=1;
		SCLK=0;   
		mask>>=1;  
	} 
	//���5λ��ɫ  mask = 0x10; 
	for(j=0;j<5;j++)  
	{ 
		if(mask&Bdt)  
			SDO = 1;   
		else     
			SDO = 0;   
		SCLK=1;
		SCLK=0;   
		mask>>=1;  
	} 
	SDO=0; 
	SCLK=1;
	SCLK=0;   
	//��1��CLOCK�����һ���ͳ���n��������ݣ�����Ҫ��n��Clock
}