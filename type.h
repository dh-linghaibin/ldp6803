

#include "STM8S103F.h"


/*�������Ͷ���*/
typedef unsigned char    u8;
typedef unsigned int     u16;
typedef unsigned long    u32;
typedef signed char    s8;
typedef signed int     s16;
typedef signed long    s32;

#define BIT(x) (1 << (x))

#define WDT()	IWDG_KR = 0xAA

//��ɢIO����
#define SCLK OPC3 //ָʾLED
#define SDO OPD4
