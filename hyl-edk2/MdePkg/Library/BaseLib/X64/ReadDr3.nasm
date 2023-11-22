;------------------------------------------------------------------------------
;
; Copyright (c) 2006, Intel Corporation. All rights reserved.<BR>
; SPDX-License-Identifier: BSD-2-Clause-Patent
;
; Module Name:
;
;   ReadDr3.Asm
;
; Abstract:
;
;   AsmReadDr3 function
;
; Notes:
;
;------------------------------------------------------------------------------

    DEFAULT REL
    SECTION .text

;------------------------------------------------------------------------------
; UINTN
; EFIAPI
; AsmReadDr3 (
;   VOID
;   );
;------------------------------------------------------------------------------
global ASM_PFX(AsmReadDr3)
ASM_PFX(AsmReadDr3):
    mov     rax, dr3
    ret

