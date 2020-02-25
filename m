Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B07C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF74924680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgBYX0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbgBYX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:16 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaU-0004mc-4S; Wed, 26 Feb 2020 00:26:02 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 601851040A0;
        Wed, 26 Feb 2020 00:25:40 +0100 (CET)
Message-Id: <20200225222649.959120054@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:24 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 18/24] x86/entry: Convert Stack segment exception to IDTENTRY
References: <20200225221606.511535280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert #SS to IDTENTRY_ERRORCODE:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    6 ------
 arch/x86/entry/entry_64.S       |    1 -
 arch/x86/include/asm/idtentry.h |    1 +
 arch/x86/include/asm/traps.h    |    3 ---
 arch/x86/kernel/idt.c           |    2 +-
 arch/x86/kernel/traps.c         |    7 ++++++-
 arch/x86/xen/enlighten_pv.c     |    2 +-
 arch/x86/xen/xen-asm_64.S       |    2 +-
 8 files changed, 10 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1327,12 +1327,6 @@ SYM_CODE_START(native_iret)
 SYM_CODE_END(native_iret)
 #endif
 
-SYM_CODE_START(stack_segment)
-	ASM_CLAC
-	pushl	$do_stack_segment
-	jmp	common_exception
-SYM_CODE_END(stack_segment)
-
 SYM_CODE_START(alignment_check)
 	ASM_CLAC
 	pushl	$do_alignment_check
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,7 +1061,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
  * Exception entry points.
  */
 
-idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
 idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
 idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
 idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -131,5 +131,6 @@ DECLARE_IDTENTRY(X86_TRAP_OLD_MF,	exc_co
 /* Simple exception entries with error code pushed by hardware */
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_TS,	exc_invalid_tss);
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_NP,	exc_segment_not_present);
+DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_SS,	exc_stack_segment);
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,7 +16,6 @@ asmlinkage void nmi(void);
 #ifdef CONFIG_X86_64
 asmlinkage void double_fault(void);
 #endif
-asmlinkage void stack_segment(void);
 asmlinkage void general_protection(void);
 asmlinkage void page_fault(void);
 asmlinkage void async_page_fault(void);
@@ -32,7 +31,6 @@ asmlinkage void simd_coprocessor_error(v
 asmlinkage void xen_xennmi(void);
 asmlinkage void xen_xendebug(void);
 asmlinkage void xen_double_fault(void);
-asmlinkage void xen_stack_segment(void);
 asmlinkage void xen_general_protection(void);
 asmlinkage void xen_page_fault(void);
 asmlinkage void xen_spurious_interrupt_bug(void);
@@ -49,7 +47,6 @@ dotraplinkage void do_nmi(struct pt_regs
 #if defined(CONFIG_X86_64) || defined(CONFIG_DOUBLEFAULT)
 dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsigned long cr2);
 #endif
-dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -78,7 +78,7 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_OLD_MF,		asm_exc_coproc_segment_overrun),
 	INTG(X86_TRAP_TS,		asm_exc_invalid_tss),
 	INTG(X86_TRAP_NP,		asm_exc_segment_not_present),
-	INTG(X86_TRAP_SS,		stack_segment),
+	INTG(X86_TRAP_SS,		asm_exc_stack_segment),
 	INTG(X86_TRAP_GP,		general_protection),
 	INTG(X86_TRAP_SPURIOUS,		spurious_interrupt_bug),
 	INTG(X86_TRAP_MF,		coprocessor_error),
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -314,6 +314,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_no
 		      SIGBUS, 0, NULL);
 }
 
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+		      0, NULL);
+}
+
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
 #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
 dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
@@ -321,7 +327,6 @@ dotraplinkage void do_##name(struct pt_r
 	do_error_trap(regs, error_code, str, trapnr, signr, sicode, addr); \
 }
 
-DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
 DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -627,7 +627,7 @@ static struct trap_array_entry trap_arra
 	TRAP_ENTRY(exc_coproc_segment_overrun,		false ),
 	TRAP_ENTRY(exc_invalid_tss,			false ),
 	TRAP_ENTRY(exc_segment_not_present,		false ),
-	{ stack_segment,               xen_stack_segment,               false },
+	TRAP_ENTRY(exc_stack_segment,			false ),
 	{ general_protection,          xen_general_protection,          false },
 	{ spurious_interrupt_bug,      xen_spurious_interrupt_bug,      false },
 	{ coprocessor_error,           xen_coprocessor_error,           false },
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -41,7 +41,7 @@ xen_pv_trap double_fault
 xen_pv_trap asm_exc_coproc_segment_overrun
 xen_pv_trap asm_exc_invalid_tss
 xen_pv_trap asm_exc_segment_not_present
-xen_pv_trap stack_segment
+xen_pv_trap asm_exc_stack_segment
 xen_pv_trap general_protection
 xen_pv_trap page_fault
 xen_pv_trap spurious_interrupt_bug

