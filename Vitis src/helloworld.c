/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include<stdio.h>
#include"platform.h"
#include"xil_printf.h"
#include"xuartps.h"
#include"xparameters.h"
#include"xil_io.h"

#define NUM_OF_BYTE 1

XUartPs_Config *Config_0;
XUartPs Uart_PS_0;
XUartPs_Config *Config_1;
XUartPs Uart_PS_1;

int main(){
    init_platform();
    int Status;
    u8 BufferPtr_rx[10]={0,0x0a,0x0d,0,0,0,0,0,0,0};
    /*************************
     * UART 0 initialization *
     *************************/
     
    /*************************
     * UART 1 initialization *
    *************************/
   Config_1 = XUartPs_LookupConfig(XPAR_UART1_BASEADDR);
   if (NULL == Config_1) {
        return XST_FAILURE;
   }
   Status = XUartPs_CfgInitialize(&Uart_PS_1, Config_1, Config_1->BaseAddress);
   if (Status != XST_SUCCESS){
        return XST_FAILURE;
   }

   u32 setuprx=1;
   u32 setuptx=0;
   u32 datarx = 0;
   u32 datatx = 0;
   u32 rxvalid=0;
   u32 txbusy = 0;
   while(1){
        Status=0;
        //Set up rx for UART IP
        setuptx=0;
        rxvalid=0;
        setuprx=1;
        Xil_Out32(XPAR_MYIP_UART_0_BASEADDR + 0, setuprx);
        // Recieve data with UART2
        rxvalid = Xil_In32(XPAR_MYIP_UART_0_BASEADDR + 16);
        rxvalid &= 2;
        while (rxvalid == 0){
            rxvalid = Xil_In32(XPAR_MYIP_UART_0_BASEADDR + 16);
            rxvalid &= 2;
        }
        datarx = Xil_In32(XPAR_MYIP_UART_0_BASEADDR + 12);
        //Send data with UART2
        datatx = datarx;
        setuprx=0;
        setuptx=1;
        Xil_Out32(XPAR_MYIP_UART_0_BASEADDR + 4, datatx); //send data form Rx to Tx to send out
        Xil_Out32(XPAR_MYIP_UART_0_BASEADDR + 0, setuprx); // turn off Rx
        Xil_Out32(XPAR_MYIP_UART_0_BASEADDR + 8, setuptx); // turn on Tx
        //Poll to send data
        txbusy = Xil_In32(XPAR_MYIP_UART_0_BASEADDR + 16);
        txbusy &= 1;
        while (txbusy == 1){
            txbusy = Xil_In32(XPAR_MYIP_UART_0_BASEADDR + 16);
            txbusy &= 1;
        }
   }
   cleanup_platform();
   return 0;
}
