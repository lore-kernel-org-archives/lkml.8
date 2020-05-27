Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D67C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C12215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgE0INy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgE0ILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A423C061A0F;
        Wed, 27 May 2020 01:11:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAF-0002Xq-Ai; Wed, 27 May 2020 10:11:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED6301C03A9;
        Wed, 27 May 2020 10:11:50 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use idtentry for interrupts
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.078690991@linutronix.de>
References: <20200521202119.078690991@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711080.17951.6273747671425562945.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     e1177738020f5ad104b5a5c31c78b1b4252deaca
Gitweb:        https://git.kernel.org/tip/e1177738020f5ad104b5a5c31c78b1b4252deaca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Use idtentry for interrupts

Replace the extra interrupt handling code and reuse the existing idtentry
machinery. This moves the irq stack switching on 64-bit from ASM to C code;
32-bit already does the stack switching in C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.078690991@linutronix.de
---
 arch/x86/entry/entry_32.S       | 31 -------------------------------
 arch/x86/entry/entry_64.S       | 31 +++----------------------------
 arch/x86/include/asm/hw_irq.h   |  1 -
 arch/x86/include/asm/idtentry.h | 10 ++++++++--
 arch/x86/include/asm/traps.h    |  1 -
 arch/x86/kernel/apic/apic.c     | 23 ++++++++---------------
 arch/x86/kernel/apic/msi.c      |  3 ++-
 arch/x86/kernel/irq.c           | 27 +++++++--------------------
 8 files changed, 28 insertions(+), 99 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6930ec1..d86e056 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9162a07..e54bcd3 100644
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
@@ -945,8 +920,8 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-SYM_CODE_END(common_interrupt)
-_ASM_NOKPROBE(common_interrupt)
+SYM_CODE_END(common_interrupt_return)
+_ASM_NOKPROBE(common_interrupt_return)
 
 /*
  * APIC interrupts.
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 0ffe807..3213d36 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -38,7 +38,6 @@ extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
 extern asmlinkage void uv_bau_message_intr1(void);
 
-extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 6e00055..32035d1 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -395,7 +395,7 @@ SYM_CODE_START(irq_entries_start)
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
-	jmp	common_interrupt
+	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
 	. = pos + 8
@@ -412,7 +412,7 @@ SYM_CODE_START(spurious_entries_start)
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
 	.byte	0x6a, vector
-	jmp	common_spurious
+	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
 	. = pos + 8
@@ -484,6 +484,12 @@ DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
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
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 32b2bec..97e6945 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -43,7 +43,6 @@ asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 void smp_apic_timer_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
 void smp_spurious_apic_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a4218a3..66c3cfc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2154,9 +2154,9 @@ void __init register_lapic_address(unsigned long address)
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
@@ -2164,18 +2164,10 @@ void __init register_lapic_address(unsigned long address)
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
@@ -2196,21 +2188,22 @@ __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs,
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
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 159bd0c..5cbaca5 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -115,7 +115,8 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * denote it as spurious which is no harm as this is a rare event
 	 * and interrupt handlers have to cope with spurious interrupts
 	 * anyway. If the vector is unused, then it is marked so it won't
-	 * trigger the 'No irq handler for vector' warning in do_IRQ().
+	 * trigger the 'No irq handler for vector' warning in
+	 * common_interrupt().
 	 *
 	 * This requires to hold vector lock to prevent concurrent updates to
 	 * the affected vector.
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 5495ea4..c449b84 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -20,6 +20,7 @@
 #include <asm/mce.h>
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
+#include <asm/traps.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -232,37 +233,25 @@ static __always_inline void handle_irq(struct irq_desc *desc,
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
@@ -270,8 +259,6 @@ __visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
 		}
 	}
 
-	exiting_irq();
-
 	set_irq_regs(old_regs);
 }
 
