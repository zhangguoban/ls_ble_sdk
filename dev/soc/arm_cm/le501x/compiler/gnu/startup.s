/* File: startup_ARMCM0.S
 * Purpose: startup file for Cortex-M0 devices. Should use with
 *   GCC for ARM Embedded Processors
 * Version: V2.0
 * Date: 16 August 2013
 *
/* Copyright (c) 2011 - 2013 ARM LIMITED

   All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
   - Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
   - Neither the name of ARM nor the names of its contributors may be used
     to endorse or promote products derived from this software without
     specific prior written permission.
   *
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
   ---------------------------------------------------------------------------*/
	.syntax	unified
	.arch	armv6-m

	.section .stack
	.align	3

	.equ	Stack_Size, 0x1000

	.globl	__StackTop
	.globl	__StackLimit
__StackLimit:
	.space	Stack_Size
	.size	__StackLimit, . - __StackLimit
__StackTop:
	.size	__StackTop, . - __StackTop

	.section .heap
	.align	3

	.equ	Heap_Size, 0x800

	.globl	__HeapBase
	.globl	__HeapLimit
__HeapBase:
	.if	Heap_Size
	.space	Heap_Size
	.endif
	.size	__HeapBase, . - __HeapBase
__HeapLimit:
	.size	__HeapLimit, . - __HeapLimit

	.section .isr_vector
	.align 2
	.globl	__isr_vector
__isr_vector:
	.long	__StackTop            /* Top of Stack */
	.long	Reset_Handler         /* Reset Handler */
	.long	NMI_Handler           /* NMI Handler */
	.long	HardFault_Handler     /* Hard Fault Handler */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	SVC_Handler           /* SVCall Handler */
	.long	0                     /* Reserved */
	.long	0                     /* Reserved */
	.long	PendSV_Handler        /* PendSV Handler */
	.long	SysTick_Handler       /* SysTick Handler */

	/* External interrupts */
	.long	EXTI_Handler
	.long	WWDT_Handler
	.long	LPWKUP_Handler
	.long	BLE_Handler
	.long	RTC_Handler
	.long	DMA_Handler
	.long	QSPI_Handler
	.long	ECC_Handler
	.long	CACHE_Handler
	.long	TRNG_Handler
	.long	IWDT_Handler
	.long	CRYPT_Handler
	.long	PDM_Handler
	.long	BLE_Handler
	.long	ADC_Handler
	.long	ADTIM1_Handler
	.long	BSTIM1_Handler
	.long	GPTIMA1_Handler
	.long	GPTIMB1_Handler
	.long	BLE_Handler
	.long	LVD33_Handler
	.long	GPTIMC1_Handler
	.long	LPTIM_Handler
	.long	I2C1_Handler
	.long	I2C2_Handler
	.long	SPI1_Handler
	.long	SPI2_Handler
	.long	UART1_Handler
	.long	UART2_Handler
	.long	UART3_Handler
	.long	BLE_Handler
	.long	BLE_Handler

	.size	__isr_vector, . - __isr_vector

	.text
	.thumb
	.thumb_func
	.align	1
	.globl	Reset_Handler
	.type	Reset_Handler, %function
Reset_Handler:

	bl	SystemInit

/*  Single section scheme.
 *
 *  The ranges of copy from/to are specified by following symbols
 *    __data_lma__: LMA of start of the section to copy from. Usually end of text
 *    __data_start__: VMA of start of the section to copy to
 *    __data_end__: VMA of end of the section to copy to
 *
 *  All addresses must be aligned to 4 bytes boundary.
 */
	ldr	r1, =__data_lma__
	ldr	r2, =__data_start__
	ldr	r3, =__data_end__

	subs	r3, r2
	ble	.L_loop1_done

.L_loop1:
	subs	r3, #4
	ldr	r0, [r1,r3]
	str	r0, [r2,r3]
	bgt	.L_loop1

.L_loop1_done:

	bl	_start

	.pool
	.size	Reset_Handler, . - Reset_Handler

	.align	1
	.thumb_func
	.weak	Default_Handler
	.type	Default_Handler, %function
Default_Handler:
	b	.
	.size	Default_Handler, . - Default_Handler

/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers */
	.macro	def_irq_handler	handler_name
	.weak	\handler_name
	.set	\handler_name, Default_Handler
	.endm

	def_irq_handler	NMI_Handler
	def_irq_handler	HardFault_Handler
	def_irq_handler	SVC_Handler
	def_irq_handler	PendSV_Handler
	def_irq_handler	SysTick_Handler
	def_irq_handler	EXTI_Handler
	def_irq_handler	WWDT_Handler
	def_irq_handler	LPWKUP_Handler
	def_irq_handler	BLE_Handler
	def_irq_handler	RTC_Handler
	def_irq_handler	DMA_Handler
	def_irq_handler	QSPI_Handler
	def_irq_handler	ECC_Handler
	def_irq_handler	CACHE_Handler
	def_irq_handler	TRNG_Handler
	def_irq_handler	IWDT_Handler
	def_irq_handler	CRYPT_Handler
	def_irq_handler	PDM_Handler
	def_irq_handler	ADC_Handler
	def_irq_handler	ADTIM1_Handler
	def_irq_handler	BSTIM1_Handler
	def_irq_handler	GPTIMA1_Handler
	def_irq_handler	GPTIMB1_Handler
	def_irq_handler	LVD33_Handler
	def_irq_handler	GPTIMC1_Handler
	def_irq_handler	LPTIM_Handler
	def_irq_handler	I2C1_Handler
	def_irq_handler	I2C2_Handler
	def_irq_handler	SPI1_Handler
	def_irq_handler	SPI2_Handler
	def_irq_handler	UART1_Handler
	def_irq_handler	UART2_Handler
	def_irq_handler	UART3_Handler

	.end
