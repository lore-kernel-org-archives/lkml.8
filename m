Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF4FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D2820874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgEUUdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgEUUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92ECC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:06 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqx-0000fR-Tz; Thu, 21 May 2020 22:31:44 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 40A00100606;
        Thu, 21 May 2020 22:31:43 +0200 (CEST)
Message-Id: <20200521202119.078690991@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 24/39] x86/entry: Use idtentry for interrupts
References: <20200521200513.656533920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the extra interrupt handling code and reuse the existing idtentry
machinery. This moves the irq stack switching on 64 bit from ASM to C code;
32bit already does the stack switching in C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S       |   31 -------------------------------
 arch/x86/entry/entry_64.S       |   31 +++----------------------------
 arch/x86/include/asm/hw_irq.h   |    1 -
 arch/x86/include/asm/idtentry.h |   10 ++++++++--
 arch/x86/include/asm/traps.h    |    1 -
 arch/x86/kernel/apic/apic.c     |   23 ++++++++---------------
 arch/x86/kernel/apic/msi.c      |    3 ++-
 arch/x86/kernel/irq.c           |   27 +++++++--------------------
 8 files changed, 28 insertions(+), 99 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1229,37 +1229,6 @@ SYM_FUNC_END(entry_INT80_32)
 #endif
 .endm
 
-#ifdef CONFIG_X86_LOCAL_APIC
-SYM_CODE_START_LOCAL(common_spurious)
-	ASM_CLAC
-	SAVE_ALL switch_stacks=1
-	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
-	movl	%esp, %eax
-	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
-	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
-	call	smp_spurious_interrupt
-	jmp	ret_from_intr
-SYM_CODE_END(common_spurious)
-#endif
-
-/*
- * the CPU automatically disables interrupts when executing an IRQ vector,
- * so IRQ-flags tracing has to follow that:
- */
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
-
 #define BUILD_INTERRUPT3(name, nr, fn)			\
 SYM_FUNC_START(name)					\
 	ASM_CLAC;					\
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -737,32 +737,7 @@ SYM_CODE_START(interrupt_entry)
 SYM_CODE_END(interrupt_entry)
 _ASM_NOKPROBE(interrupt_entry)
 
-
-/* Interrupt entry/exit. */
-
-/*
- * The interrupt stubs push vector onto the stack and
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
@@ -945,8 +920,8 @@ SYM_INNER_LABEL(native_irq_return_iret,
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
@@ -395,7 +395,7 @@ SYM_CODE_START(irq_entries_start)
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
-	jmp	common_interrupt
+	jmp	asm_common_interrupt
 	.nops (pos + 8) - .
     pos=pos+8
     vector=vector+1
@@ -410,7 +410,7 @@ SYM_CODE_START(spurious_entries_start)
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
-	jmp	common_spurious
+	jmp	asm_spurious_interrupt
 	.nops (pos + 8) - .
     pos=pos+8
     vector=vector+1
@@ -480,6 +480,12 @@ DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_dou
 DECLARE_IDTENTRY(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
 #endif
 
+/* Device interrupts common/spurious */
+DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
+#ifdef CONFIG_X86_LOCAL_APIC
+DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	spurious_interrupt);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -43,7 +43,6 @@ asmlinkage void smp_deferred_error_inter
 void smp_apic_timer_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
 void smp_spurious_apic_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2154,9 +2154,9 @@ void __init register_lapic_address(unsig
  */
 
 /**
- * smp_spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * spurious_interrupt - Catch all for interrupts raised on unused vectors
  * @regs:	Pointer to pt_regs on stack
- * @error_code:	The vector number is in the lower 8 bits
+ * @vector:	The vector number
  *
  * This is invoked from ASM entry code to catch all interrupts which
  * trigger on an entry which is routed to the common_spurious idtentry
@@ -2164,18 +2164,10 @@ void __init register_lapic_address(unsig
  *
  * Also called from smp_spurious_apic_interrupt().
  */
-__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs,
-						  unsigned long vector)
+DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
 	u32 v;
 
-	entering_irq();
-	/*
-	 * The push in the entry ASM code which stores the vector number on
-	 * the stack in the error code slot is sign expanding. Just use the
-	 * lower 8 bits.
-	 */
-	vector &= 0xFF;
 	trace_spurious_apic_entry(vector);
 
 	inc_irq_stat(irq_spurious_count);
@@ -2196,21 +2188,22 @@ void __init register_lapic_address(unsig
 	 */
 	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
 	if (v & (1 << (vector & 0x1f))) {
-		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Acked\n",
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
 			vector, smp_processor_id());
 		ack_APIC_irq();
 	} else {
-		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Not pending!\n",
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
 			vector, smp_processor_id());
 	}
 out:
 	trace_spurious_apic_exit(vector);
-	exiting_irq();
 }
 
 __visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
 {
-	smp_spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	entering_irq();
+	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	exiting_irq();
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
@@ -20,6 +20,7 @@
 #include <asm/mce.h>
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
+#include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -232,37 +233,25 @@ static __always_inline void handle_irq(s
 }
 
 /*
- * do_IRQ handles all normal device IRQ's (the special
- * SMP cross-CPU interrupts have their own specific
- * handlers).
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
  */
-__visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
+DEFINE_IDTENTRY_IRQ(common_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	entering_irq();
-	/*
-	 * The push in the entry ASM code which stores the vector number on
-	 * the stack in the error code slot is sign expanding. Just use the
-	 * lower 8 bits.
-	 */
-	vector &= 0xFF;
-
-	/* entering_irq() tells RCU that we're not quiescent.  Check it. */
+	/* entry code tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
-		if (IS_ENABLED(CONFIG_X86_32))
-			__handle_irq(desc, regs);
-		else
-			generic_handle_irq_desc(desc);
+		handle_irq(desc, regs);
 	} else {
 		ack_APIC_irq();
 
 		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%lu No irq handler for vector\n",
+			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
 		} else {
@@ -270,8 +259,6 @@ static __always_inline void handle_irq(s
 		}
 	}
 
-	exiting_irq();
-
 	set_irq_regs(old_regs);
 }
 

