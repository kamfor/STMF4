#include <stm32f4xx.h>
 
#define LED_PIN 5
#define LED_ON() GPIOA->BSRR |= (1 << 5)
#define LED_OFF() GPIOA->BSRR |= (1 << 5)

int i; 
 
int main() {
	/* Enbale GPIOA clock */
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	/* Configure GPIOA pin 5 as output */
	GPIOA->MODER |= (1 << (LED_PIN << 1));
	/* Configure GPIOA pin 5 in max speed */
	GPIOA->OSPEEDR |= (3 << (LED_PIN << 1));
 
	/* Turn on the LED */
	while(1){
		LED_ON(); 
		for(i=0; i<1000000; i++){
			__asm__("nop");
		}
		LED_OFF(); 
		for(i=0; i<1000000; i++){
			__asm__("nop");
		}
	}
		
}
