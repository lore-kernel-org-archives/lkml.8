Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEEDC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AC024680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgBYX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgBYX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:05 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jav-00053J-4v; Wed, 26 Feb 2020 00:26:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D99F81040C0;
        Wed, 26 Feb 2020 00:25:51 +0100 (CET)
Message-Id: <20200225231609.322174713@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:23 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 04/15] x86/entry: Use idtentry for interrupts
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IDTENTRY_IRQ for interrupts. Remove the existing stub code and let the
IDTENTRY machinery emit it automatically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |   39 +++++++++----------------------
 arch/x86/entry/entry_64.S       |   49 +++++++++++++++-------------------------
 arch/x86/include/asm/hw_irq.h   |    1 
 arch/x86/include/asm/idtentry.h |    4 +++
 arch/x86/include/asm/irq.h      |    2 -
 arch/x86/include/asm/traps.h    |    1 
 arch/x86/kernel/apic/apic.c     |    7 ++---
 arch/x86/kernel/apic/msi.c      |    3 +-
 arch/x86/kernel/irq.c           |    8 +++---
 9 files changed, 44 insertions(+), 70 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -769,12 +769,6 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
- * Include the defines which emit the idt entries which are shared
- * shared between 32 and 64 bit.
- */
-#include <asm/idtentry.h>
-
-/*
  * %eax: prev task
  * %edx: next task
  */
@@ -1235,7 +1229,7 @@ SYM_CODE_START(irq_entries_start)
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	pushl	$(vector)
     vector=vector+1
-	jmp	common_interrupt
+	jmp	asm_common_interrupt
 	.align	8
     .endr
 SYM_CODE_END(irq_entries_start)
@@ -1247,40 +1241,31 @@ SYM_CODE_START(spurious_entries_start)
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	pushl	$(vector)
     vector=vector+1
-	jmp	common_spurious
+	jmp	asm_spurious_interrupt
 	.align	8
     .endr
 SYM_CODE_END(spurious_entries_start)
+#endif
 
-SYM_CODE_START_LOCAL(common_spurious)
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+SYM_CODE_START_LOCAL(asm_\cfunc)
 	ASM_CLAC
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
 	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
-	call	smp_spurious_interrupt
+	call	\cfunc
 	jmp	ret_from_intr
-SYM_CODE_END(common_spurious)
-#endif
+SYM_CODE_END(asm_\cfunc)
+.endm
 
 /*
- * the CPU automatically disables interrupts when executing an IRQ vector,
- * so IRQ-flags tracing has to follow that:
+ * Include the defines which emit the idt entries which are shared
+ * shared between 32 and 64 bit.
  */
-	.p2align CONFIG_X86_L1_CACHE_SHIFT
-SYM_CODE_START_LOCAL(common_interrupt)
-	ASM_CLAC
-	SAVE_ALL switch_stacks=1
-	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
-	movl	%esp, %eax
-	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
-	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
-	call	do_IRQ
-	jmp	ret_from_intr
-SYM_CODE_END(common_interrupt)
+#include <asm/idtentry.h>
 
 #define BUILD_INTERRUPT3(name, nr, fn)			\
 SYM_FUNC_START(name)					\
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -365,7 +365,7 @@ SYM_CODE_START(irq_entries_start)
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	pushq	$(vector)
-	jmp	common_interrupt
+	jmp	asm_common_interrupt
 	.align	8
 	vector=vector+1
     .endr
@@ -377,7 +377,7 @@ SYM_CODE_START(spurious_entries_start)
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	pushq	$(vector)
-	jmp	common_spurious
+	jmp	asm_spurious_interrupt
 	.align	8
 	vector=vector+1
     .endr
@@ -563,6 +563,20 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * Interrupt entry/exit.
+ *
+ + The interrupt stubs push (vector) onto the stack, which is the error_code
+ * position of idtentry exceptions, and jump to one of the two idtentry points
+ * (common/spurious).
+ *
+ * common_interrupt is a hotpath, align it to a cache line
+ */
+.macro idtentry_irq vector cfunc
+	.p2align CONFIG_X86_L1_CACHE_SHIFT
+	idtentry \vector asm_\cfunc \cfunc has_error_code=1 irq_stack=1
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
@@ -758,32 +772,7 @@ SYM_CODE_START(interrupt_entry)
 SYM_CODE_END(interrupt_entry)
 _ASM_NOKPROBE(interrupt_entry)
 
-
-/* Interrupt entry/exit. */
-
-/*
- * The interrupt stubs push (~vector+0x80) onto the stack and
- * then jump to common_spurious/interrupt.
- */
-SYM_CODE_START_LOCAL(common_spurious)
-	call	interrupt_entry
-	UNWIND_HINT_REGS indirect=1
-	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
-	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
-	call	smp_spurious_interrupt		/* rdi points to pt_regs */
-	jmp	ret_from_intr
-SYM_CODE_END(common_spurious)
-_ASM_NOKPROBE(common_spurious)
-
-/* common_interrupt is a hotpath. Align it */
-	.p2align CONFIG_X86_L1_CACHE_SHIFT
-SYM_CODE_START_LOCAL(common_interrupt)
-	call	interrupt_entry
-	UNWIND_HINT_REGS indirect=1
-	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
-	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
-	call	do_IRQ				/* rdi points to pt_regs */
-	/* 0(%rsp): old RSP */
+SYM_CODE_START_LOCAL(common_interrupt_return)
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
@@ -965,8 +954,8 @@ SYM_INNER_LABEL(native_irq_return_iret,
 	 */
 	jmp	native_irq_return_iret
 #endif
-SYM_CODE_END(common_interrupt)
-_ASM_NOKPROBE(common_interrupt)
+SYM_CODE_END(common_interrupt_return)
+_ASM_NOKPROBE(common_interrupt_return)
 
 /*
  * APIC interrupts.
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -38,7 +38,6 @@ extern asmlinkage void error_interrupt(v
 extern asmlinkage void irq_work_interrupt(void);
 extern asmlinkage void uv_bau_message_intr1(void);
 
-extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -450,6 +450,10 @@ DECLARE_IDTENTRY_CR2(X86_TRAP_PF,	exc_pa
 DECLARE_IDTENTRY_CR2(X86_TRAP_PF,	exc_async_page_fault);
 #endif
 
+/* Device interrupts common/spurious */
+DECLARE_IDTENTRY_IRQ(X6_TRAP_OTHER,	common_interrupt);
+DECLARE_IDTENTRY_IRQ(X6_TRAP_OTHER,	spurious_interrupt);
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,8 +36,6 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
-
 extern void init_ISA_irqs(void);
 
 extern void __init init_IRQ(void);
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -41,7 +41,6 @@ asmlinkage void smp_deferred_error_inter
 void smp_apic_timer_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
 void smp_spurious_apic_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 extern void ist_enter(struct pt_regs *regs);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2159,7 +2159,7 @@ void __init register_lapic_address(unsig
  */
 
 /**
- * smp_spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * spurious_interrupt - Catch all for interrupts raised on unused vectors
  * @regs:	Pointer to pt_regs on stack
  * @vector:	Vector number
  *
@@ -2169,8 +2169,7 @@ void __init register_lapic_address(unsig
  *
  * Also called from smp_spurious_apic_interrupt().
  */
-__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs,
-						  unsigned long vector)
+DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
 	u32 v;
 
@@ -2209,7 +2208,7 @@ void __init register_lapic_address(unsig
 
 __visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
 {
-	smp_spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
 }
 
 /*
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -115,7 +115,8 @@ msi_set_affinity(struct irq_data *irqd,
 	 * denote it as spurious which is no harm as this is a rare event
 	 * and interrupt handlers have to cope with spurious interrupts
 	 * anyway. If the vector is unused, then it is marked so it won't
-	 * trigger the 'No irq handler for vector' warning in do_IRQ().
+	 * trigger the 'No irq handler for vector' warning in
+	 * common_interrupt().
 	 *
 	 * This requires to hold vector lock to prevent concurrent updates to
 	 * the affected vector.
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -19,6 +19,7 @@
 #include <asm/mce.h>
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
+#include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -226,11 +227,10 @@ u64 arch_irq_stat(void)
 
 
 /*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own specific handlers).
  */
-__visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
+DEFINE_IDTENTRY_IRQ(common_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc * desc;

