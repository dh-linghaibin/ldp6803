/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "type.h"

main()
{
	//时钟初始化
	CLK_CKDIVR=0x00;
	//通讯PC4 码表			
	PC_DDR |= BIT(4);
	PC_CR1 |= BIT(4); 
	PC_CR2 |= BIT(4);
	//通讯PC3 后拨
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
	//送起始32bits 0  SDO=1;SCLK=1;SCLK=0;       
	//送起始位'1'  
	//输出5位红色  mask = 0x10; 
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
	//输出5位绿色  mask = 0x10; 
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
	//输出5位蓝色  mask = 0x10; 
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
	//补1个CLOCK，如果一次送出了n个点的数据，则需要补n个Clock
}