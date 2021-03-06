#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "snake_defines.h"  /* Declatations for these labs */
#include <stdbool.h>
#include <stdio.h>

/*returns what direction the user wants to move in based on which buttons are pressed
- if more than one button is pressed the snake moves nowhere and continues on its current path
- Left <=> 'L', Up <=> 'U', Right <=> 'R', Down <=> 'D', None <=> 'N'
- BTN4 <=> left, BTN1 <=> right, BTN3 <=> up, BTN2 <=> down
*/ //3 LS bits of return value is:
//   BTN4,BTN3,BTN2
//bit 7,   6,   5 of port D (7<=> BTN4 etc.)
//i.e. 0000....00ABCD, A<=> BTN4, B <=> BTN3, C<=>BTN2, D<=>BTN1
uint16_t getbtns(void){
    //get BTN4,BTN3,BTN2
    uint16_t btn_4_3_2 = (PORTD >>4) & 0b0000000000001110;//0b00000000ABC00000>>4 & 0b0000000000001110 = 0b0000000000000ABC0

    //get BTN1
    uint16_t btn1 = (PORTF >> 1) & 1;
    //sum them
    return btn_4_3_2 + btn1; //0b0000000000000ABC0 + 0b0000000000000000D = 0b000000000000ABCD
}
Direction user_move_direction(){
 //A,D,B,C funkar
  uint16_t button_status = getbtns(); //0000...0ABCD
  if(button_status != 0){
    bool btn_4_status =  button_status >> 3; //000.0A
    bool btn_3_status =  (button_status >> 2) - (btn_4_status << 1); /// 000AB - 0A<<1 = 000.00B
    bool btn_2_status =  (button_status -(btn_4_status << 3)- (btn_3_status << 2)) >>1; ///000.0CD >> 1 = 000C
    bool btn_1_status =  button_status -(btn_4_status << 3)- (btn_3_status << 2)-(btn_2_status << 1); ///000.000D
    
    if((btn_1_status + btn_2_status + btn_3_status + btn_4_status) > 1){
        //dont move
        return 'N';
    }
    
    if(btn_4_status == true){

        return 'L';
    }

    if(btn_3_status == true){
        
        return 'U';
    }
    
    if(btn_2_status == true){

        return 'D';
    }

    if(btn_1_status == true){
        
        return 'R';
    }
  }
  return 'N';
}




