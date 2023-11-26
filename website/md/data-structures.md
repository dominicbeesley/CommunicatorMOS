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



### Type E - CBIQ - Interrupt handler

There are actually two types of CBIQ block

#### CBIQ - first block

   | Offset | Purpose 
   |--------|--------------------------------------------------------------
   |      0 | 
   |      2 | BHA - Hardware address 
   |      5 | AND mask for status register
   |      6 | EOR mask for status register
   |      7 | Pointer to second CBIQ block
   |      9 | "$fd06" - QRY then some gymastics?
   |      B | K - program bank of MOS module


#### CBIQ - second block

   | Offset | Purpose 
   |--------|--------------------------------------------------------------
   |      0 | Interrupt priority
   |      1 | Direct Page
   |      3 | P Mode OR 4 - i.e. flags on entry with I flag forced on
   |      4 | BHA - interrupt handler address
   |      7 | 0000
   |      9 | 0000
   |      B | "$0E"


## Interrupt Handlers

Interrupt handlers look to be allocated in regular [Handle Blocks](#handleblocks)
there is a linked list of handle blocks pointed to from $FE06 in bank 0

