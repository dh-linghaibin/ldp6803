/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */


main()
{
	while (1);
}


LED_SendData(BYTE Rdt, BYTE Gdt, BYTE Bdt) { 
 ......  SCLK = 0;  SDO = 0; 
 for(i=0;i<32;i++){SCLK=1;SCLK=0} //送起始32bits 0  SDO=1;SCLK=1;SCLK=0;       //送起始位'1'  //输出5位红色  mask = 0x10; 
 for(j=0;j<5;j++)  { 
  if(mask&Rdt)  SDO = 1;   else     SDO = 0;   SCLK=1;SCLK=0;   mask>>=1;  } 
 //输出5位绿色  mask = 0x10; 
 for(j=0;j<5;j++)  { 
  if(mask&Bdt)  SDO = 1;   else     SDO = 0;   SCLK=1;SCLK=0;   mask>>=1;  } 
 //输出5位蓝色  mask = 0x10; 
 for(j=0;j<5;j++)  { 
  if(mask&Bdt)  SDO = 1;   else     SDO = 0;   SCLK=1;SCLK=0;   mask>>=1;  } 
 SDO=0; 
 SCLK=1;SCLK=0;   //补1个CLOCK，如果一次送出了n个点的数据，则需要补n个Clock.  ...... }
