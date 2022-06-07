#define soc_cv_av

#define DEBUG

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>

#include <stdlib.h>
//#include <string.h>
#include "hwlib.h"
#include "soc_cv_av/socal/socal.h"
#include "soc_cv_av/socal/hps.h"
#include "soc_cv_av/socal/alt_gpio.h"
#include "hps_0.h"





#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 ) //64 MB with 32 bit adress space this is 256 MB
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )


//setting for the HPS2FPGA AXI Bridge
#define ALT_AXI_FPGASLVS_OFST (0xC0000000) // axi_master
#define HW_FPGA_AXI_SPAN (0x40000000) // Bridge span 1GB
#define HW_FPGA_AXI_MASK ( HW_FPGA_AXI_SPAN - 1 )







//pointer to the different address spaces

void *virtual_base;
//void *axi_virtual_base;
int fd;


//void *h2p_lw_reg1_addr;
//void *h2p_lw_reg2_addr;
void *h2p_lw_reg3_addr;
//void *h2p_lw_reg4_addr;


// boucle pour faire tourner le programme un nombre de fois N


int main(int argc, char *argv[]) {
   
   int iter; 
   
   int x = 0;
   int i = 0;
   int k_1 = 0;
   printf("\ncmdline args count=%d", argc);
   
   /*first argument is executable name*/
   printf("\nexe name=%s", argv[0]);
   
   for (i=0; i<argc ; i++)
   {
      printf("\narg%d=%s", i , argv[i]);
   }
   /*
   if(argc<2){
      printf("Missing Parameter\n");
      exit(1);
   } */
   printf("\n\n\n----------0---------- \n\n" ); 
   
   if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
      printf( "ERROR: could not open \"/dev/mem\"...\n" );
      return( 1 );
   }
   printf("\n\n\n----------1---------- \n\n" ); 
   
   //lightweight HPS-to-FPGA bridge
   virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

   if( virtual_base == MAP_FAILED ) {
      printf( "ERROR: mmap() failed...\n" );
      close( fd );
      return( 1 );
   }


   printf("\n\n\n----------2----------x \n\n" ); 

   iter = atoi(argv[1]);

   printf("\n\n\n----------3----------%d \n\n", iter ); 
   
   h2p_lw_reg3_addr=virtual_base + ( ( unsigned long )( ALT_LWFPGASLVS_OFST + PIO_REG3_IN_BASE ) & ( unsigned long )( HW_REGS_MASK ) );

   printf("\n\n\n----------4---------- \n\n" ); 

   for(;x<iter; x++){   
      //printf("\n\n\n----------4---------- \n\n" );
      k_1 = *((uint32_t *)h2p_lw_reg3_addr)*195+50;
      printf( "Numero de la plage  :  %d\n", *((uint32_t *)h2p_lw_reg3_addr));
      printf( "Frequence :  %d\n", k_1);
      sleep(1);
   }
   printf("\n\n\n----------5---------- \n\n" ); 
   if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
      printf( "ERROR: munmap() failed...\n" );
      close( fd );
      return( 1 );
   }
   close( fd );

   return( 0 );
}

