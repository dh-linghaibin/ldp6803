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
	PD_DDR |= BIT(1);
	PD_CR1 |= BIT(1); 
	PD_CR2 |= BIT(1);
	//ͨѶPC3 ��
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
����: delayms
����: ��ʱ���ȴ�
����: ms��ʱʱ������
���: ��
˵��: �ȴ�
***************************************/
void delayms(u16 ms)	
{						
	u16 i;
	while(ms--)
	{
	//	WDT();//�忴�Ź�
		for(i=0;i<1125;i++);//2M����һ����1us��i=140;�պ�1ms,16Mʱ��i=1125
	}
}
/***************************************
����: delayus
����: ��ʱ���ȴ�
����: us��ʱʱ������
���: ��
˵��: �ȴ� ע�⣺��ʱʱ�䲻��ȷ
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
	//����ʼ32bits 0      
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
		//����ʼλ'1'  
		//���5λ��ɫ  
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
		//���5λ��ɫ  
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
		//���5λ��ɫ  
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
	//��1��CLOCK�����һ���ͳ���n��������ݣ�����Ҫ��n��Clock
}

