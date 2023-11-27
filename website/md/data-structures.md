# Communicator MOS 1.00 Data Structures

## Introduction

This documentation contains notes on the data structures used by the 
Communicator MOS as uncovered during its disassembly. The information here
should not be taken as being authoritative but it is hoped it may provide
some help in deciphering the code.

## Handle Allocation Table

A table pointed to by a long pointer at $FF02, each 16 bit entry in the table
is either 0 or contains a bank0 pointer to a [Handle Block](#handleblocks).

The first entry is the index of the last entry + 2 i.e. the size of the table

On the Communicator 1.00 MOS this table is at $08DF00

## Handle Blocks


<a name="CBIQ"></a>
### Type E - CBIQ - Interrupt handler

There are actually two types of CBIQ block to fit the data required. The 
second block is chained from the first through the bank 0 pointer at offset
7.

These first block is given a handle in the Handle Allocation Table and is also
added to a linked list of items pointed to by $FE06. The blocks are maintained
in priority then seniority order as they are added. The priority is at byte 0
in the second block.

#### CBIQ - first block

   | Offset | Purpose 
   |--------|--------------------------------------------------------------
   |   0..1 | B0 pointer to next lower priority handler in linked list from FE06
   |   2..4 | BHA - Hardware address 
   |   5    | AND mask for status register
   |   6    | EOR mask for status register
   |   7..8 | B0 Pointer to second CBIQ block
   |   9..B | pointer to FF byte in MOS ROM (ff/fd06) or secondary mask
   

#### CBIQ - second block

   | Offset | Purpose 
   |--------|--------------------------------------------------------------
   |   0    | Interrupt priority
   |   1..2 | Direct Page
   |   3    | P Mode OR 4 - i.e. flags on entry with I flag forced on
   |   4..6 | BHA - interrupt handler address
   |   7..A | Hit counter
   |   B    | "$0E" (type CBIQ)


## Interrupt Handlers

Interrupt handlers are allocated a handle in the regular [Handle Allocation Table](#handleallocationtable)
each handle has two [chained blocks](#CBIQ) there is a linked list of handle 
blocks pointed to from $FE06 in bank 0 the list is sorted and check in 
priority order when an IRQ is received.

The interrupt handler is called by checking whether the device is signalling
an interrupt:

	A = read device register pointed 1st block offset 2..4
	Y = A (used by irq handler?)
	AND with mask pointed to by long pointer at 9 in 1st block
	EOR with flip mask at offset 6 in 1st block
	AND with mask in 1st block offset 5
	if zero:
		next handler	
	else non-zero:
		DP, P set up from second block
		increment hit counter
		call the handler at offset 4 in second block with registers 
		if CS 
			next handler


