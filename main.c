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
	PD_DDR |= BIT(1);
	PD_CR1 |= BIT(1); 
	PD_CR2 |= BIT(1);
	//通讯PC3 后拨
	PD_DDR |= BIT(2);
	PD_CR1 |= BIT(2); 
	PD_CR2 |= BIT(2);
	
	while (1)
	{
		//SCLK=1;
	//	delayus(10);
	//	SCLK=0;
	//	delayus(10);
		LED_SendData(0,0,0);
	}
}
/**********************************
函数: delayms
功能: 延时、等待
输入: ms延时时间设置
输出: 无
说明: 等待
***************************************/
void delayms(u16 ms)	
{						
	u16 i;
	while(ms--)
	{
	//	WDT();//清看门狗
		for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
	}
}
/***************************************
函数: delayus
功能: 延时、等待
输入: us延时时间设置
输出: 无
说明: 等待 注意：延时时间不精确
***************************************/
void delayus(u16 us) 	
{	
//	while(us--);
}

LED_SendData(u8 Rdt, u8 Gdt, u8 Bdt) 
{ 
	u8 j = 0,i = 0;
	u8 mask = 0;
	
	SCLK = 0;  
	SDO = 0; 
	delayus(10);
	//送起始32bits 0      
	for(i=0;i<32;i++)
	{
		SCLK=1;
		delayus(10);
		SCLK=0;
		delayus(10);
	}
	
	for(i = 0;i < 1; i++)	
	{
		SDO=1;
		SCLK=1;
		delayus(10);
		SCLK=0;   
		delayus(10);
		//送起始位'1'  
		//输出5位红色  
		mask = 0x10; 
		for(j=0;j<5;j++)  
		{ 
			if(mask&Rdt)  
				SDO = 1;   
			else     
				SDO = 0;  
			delayus(10);			
			SCLK=1;
			delayus(10);
			SCLK=0;  
			delayus(10);
			mask>>=1;  
		} 
		//输出5位绿色  
		mask = 0x10; 
		for(j=0;j<5;j++)  
		{ 
			if(mask&Rdt)  
				SDO = 1;   
			else     
				SDO = 0;  
			delayus(10);			
			SCLK=1;
			delayus(10);
			SCLK=0;  
			delayus(10);
			mask>>=1;  
		} 
		//输出5位蓝色  
		mask = 0x10; 
		for(j=0;j<5;j++)  
		{ 
			if(mask&Rdt)  
				SDO = 1;   
			else     
				SDO = 0;  
			delayus(10);			
			SCLK=1;
			delayus(10);
			SCLK=0;  
			delayus(10);
			mask>>=1;  
		}  
	}
	SDO=0; 
//	SCLK=1;
//	delayus(10);
//	SCLK=0;   
//	delayus(10);
	for(i = 0;i < 1; i++)
	{
		SCLK = 1;
		delayus(10);
		SCLK = 0;
		delayus(10);
	}
	delayms(500);
	//补1个CLOCK，如果一次送出了n个点的数据，则需要补n个Clock
}

