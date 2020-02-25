Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4CC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995BB24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgBYX16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbgBYX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:50 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jas-00051S-0u; Wed, 26 Feb 2020 00:26:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2F90A10408F;
        Wed, 26 Feb 2020 00:25:51 +0100 (CET)
Message-Id: <20200225231609.000955823@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
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

Device interrupts which go through do_IRQ() or the spurious interrupt
handler have their separate entry code on 64 bit for no good reason.

Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
pt_regs. Further the vector number is forced to fit into an u8 and is
complemented and offset by 0x80 for historical reasons.

Push the vector number into the error code slot instead and hand the plain
vector number to the C functions.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S         |   11 ++++++-----
 arch/x86/entry/entry_64.S         |   14 ++++++++------
 arch/x86/include/asm/entry_arch.h |    2 +-
 arch/x86/include/asm/hw_irq.h     |    1 +
 arch/x86/include/asm/irq.h        |    2 +-
 arch/x86/include/asm/traps.h      |    3 ++-
 arch/x86/kernel/apic/apic.c       |   25 +++++++++++++++++++------
 arch/x86/kernel/idt.c             |    2 +-
 arch/x86/kernel/irq.c             |    6 ++----
 9 files changed, 41 insertions(+), 25 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1233,7 +1233,7 @@ SYM_FUNC_END(entry_INT80_32)
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
+	pushl	$(vector)
     vector=vector+1
 	jmp	common_interrupt
 	.align	8
@@ -1245,7 +1245,7 @@ SYM_CODE_END(irq_entries_start)
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
+	pushl	$(vector)
     vector=vector+1
 	jmp	common_spurious
 	.align	8
@@ -1254,11 +1254,12 @@ SYM_CODE_END(spurious_entries_start)
 
 SYM_CODE_START_LOCAL(common_spurious)
 	ASM_CLAC
-	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
 SYM_CODE_END(common_spurious)
@@ -1271,12 +1272,12 @@ SYM_CODE_END(common_spurious)
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
-	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
-
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
+	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
+	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	do_IRQ
 	jmp	ret_from_intr
 SYM_CODE_END(common_interrupt)
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -364,7 +364,7 @@ SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
+	pushq	$(vector)
 	jmp	common_interrupt
 	.align	8
 	vector=vector+1
@@ -376,7 +376,7 @@ SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
+	pushq	$(vector)
 	jmp	common_spurious
 	.align	8
 	vector=vector+1
@@ -756,9 +756,10 @@ SYM_CODE_END(interrupt_entry)
  * then jump to common_spurious/interrupt.
  */
 SYM_CODE_START_LOCAL(common_spurious)
-	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
+	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
+	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
 	call	smp_spurious_interrupt		/* rdi points to pt_regs */
 	jmp	ret_from_intr
 SYM_CODE_END(common_spurious)
@@ -767,10 +768,11 @@ SYM_CODE_END(common_spurious)
 /* common_interrupt is a hotpath. Align it */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
-	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
-	call	do_IRQ	/* rdi points to pt_regs */
+	movq	ORIG_RAX(%rdi), %rsi		/* get vector from stack */
+	movq	$-1, ORIG_RAX(%rdi)		/* no syscall to restart */
+	call	do_IRQ				/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
 	DISABLE_INTERRUPTS(CLBR_ANY)
@@ -1019,7 +1021,7 @@ apicinterrupt RESCHEDULE_VECTOR			resche
 #endif
 
 apicinterrupt ERROR_APIC_VECTOR			error_interrupt			smp_error_interrupt
-apicinterrupt SPURIOUS_APIC_VECTOR		spurious_interrupt		smp_spurious_interrupt
+apicinterrupt SPURIOUS_APIC_VECTOR		spurious_apic_interrupt		smp_spurious_apic_interrupt
 
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -35,7 +35,7 @@ BUILD_INTERRUPT(kvm_posted_intr_nested_i
 
 BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_apic_interrupt,SPURIOUS_APIC_VECTOR)
 BUILD_INTERRUPT(x86_platform_ipi, X86_PLATFORM_IPI_VECTOR)
 
 #ifdef CONFIG_IRQ_WORK
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -39,6 +39,7 @@ extern asmlinkage void irq_work_interrup
 extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
+extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,7 +36,7 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs);
+extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
 
 extern void init_ISA_irqs(void);
 
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -39,8 +39,9 @@ asmlinkage void smp_deferred_error_inter
 #endif
 
 void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
+void smp_spurious_apic_interrupt(struct pt_regs *regs);
+void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 extern void ist_enter(struct pt_regs *regs);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2158,12 +2158,20 @@ void __init register_lapic_address(unsig
  * Local APIC interrupts
  */
 
-/*
- * This interrupt should _never_ happen with our APIC/SMP architecture
+/**
+ * smp_spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @vector:	Vector number
+ *
+ * This is invoked from ASM entry code to catch all interrupts which
+ * trigger on an entry which is routed to the common_spurious idtentry
+ * point.
+ *
+ * Also called from smp_spurious_apic_interrupt().
  */
-__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
+__visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs,
+						  unsigned long vector)
 {
-	u8 vector = ~regs->orig_ax;
 	u32 v;
 
 	entering_irq();
@@ -2187,11 +2195,11 @@ void __init register_lapic_address(unsig
 	 */
 	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
 	if (v & (1 << (vector & 0x1f))) {
-		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
+		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Acked\n",
 			vector, smp_processor_id());
 		ack_APIC_irq();
 	} else {
-		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
+		pr_info("Spurious interrupt (vector 0x%02lx) on CPU#%d. Not pending!\n",
 			vector, smp_processor_id());
 	}
 out:
@@ -2199,6 +2207,11 @@ void __init register_lapic_address(unsig
 	exiting_irq();
 }
 
+__visible void smp_spurious_apic_interrupt(struct pt_regs *regs)
+{
+	smp_spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+}
+
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -142,7 +142,7 @@ static const __initconst struct idt_data
 #ifdef CONFIG_X86_UV
 	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,	spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
 };
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -230,12 +230,10 @@ u64 arch_irq_stat(void)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-__visible void __irq_entry do_IRQ(struct pt_regs *regs)
+__visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc * desc;
-	/* high bit used in ret_from_ code  */
-	unsigned vector = ~regs->orig_ax;
 
 	entering_irq();
 
@@ -252,7 +250,7 @@ u64 arch_irq_stat(void)
 		ack_APIC_irq();
 
 		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
+			pr_emerg_ratelimited("%s: %d.%lu No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
 		} else {

