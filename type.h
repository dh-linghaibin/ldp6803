

#include "STM8S103F.h"


/*数据类型定义*/
typedef unsigned char    u8;
typedef unsigned int     u16;
typedef unsigned long    u32;
typedef signed char    s8;
typedef signed int     s16;
typedef signed long    s32;

#define BIT(x) (1 << (x))

#define WDT()	IWDG_KR = 0xAA

//离散IO定义
#define SCLK OPD1 //指示LED
#define SDO OPD2

LED_SendData(u8 Rdt, u8 Gdt, u8 Bdt) ;
void delayus(u16 us);
