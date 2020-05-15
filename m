Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB43C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931DD207D3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEPALR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgEPALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:11:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:11:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPO-0002Kp-S0; Sat, 16 May 2020 02:10:31 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 69023FF834;
        Sat, 16 May 2020 02:10:30 +0200 (CEST)
Message-Id: <20200515235126.317328545@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: [patch V6 19/37] x86/irq: Convey vector as argument and not in ptregs
References: <20200515234547.710474468@linutronix.de>
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


Device interrupts which go through do_IRQ() or the spurious interrupt
handler have their separate entry code on 64 bit for no good reason.

Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
pt_regs. Further the vector number is forced to fit into an u8 and is
complemented and offset by 0x80 so it's in the signed character
range. Otherwise GAS would expand the pushq to a 5 byte instruction for any
vector > 0x7F.

Treat the vector number like an error code and hand it to the C function as
argument. This allows to get rid of the extra entry code in a later step.

Simplify the error code push magic by implementing the pushq imm8 via a
'.byte 0x6a, vector' sequence so GAS is not able to screw it up. As the
pushq imm8 is sign extending the resulting error code needs to be truncated
to 8 bits in C code.

Originally-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Gerst <brgerst@gmail.com>

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 1c7f13bb6728..98da0d3c0b1a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -341,7 +341,10 @@ For 32-bit we have the following conventions - kernel is built with
 #endif
 .endm
 
-#endif /* CONFIG_X86_64 */
+#else /* CONFIG_X86_64 */
+# undef		UNWIND_HINT_IRET_REGS
+# define	UNWIND_HINT_IRET_REGS
+#endif /* !CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c6e146b71de5..ce113d5613b6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1215,40 +1215,15 @@ SYM_FUNC_END(entry_INT80_32)
 #endif
 .endm
 
-/*
- * Build the entry stubs with some assembler magic.
- * We pack 1 stub into every 8-byte block.
- */
-	.align 8
-SYM_CODE_START(irq_entries_start)
-    vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
-    vector=vector+1
-	jmp	common_interrupt
-	.align	8
-    .endr
-SYM_CODE_END(irq_entries_start)
-
 #ifdef CONFIG_X86_LOCAL_APIC
-	.align 8
-SYM_CODE_START(spurious_entries_start)
-    vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
-	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
-    vector=vector+1
-	jmp	common_spurious
-	.align	8
-    .endr
-SYM_CODE_END(spurious_entries_start)
-
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
@@ -1261,12 +1236,12 @@ SYM_CODE_END(common_spurious)
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e908f1440f36..9c8529035e58 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -358,34 +358,6 @@ SYM_CODE_START(ret_from_fork)
 SYM_CODE_END(ret_from_fork)
 .popsection
 
-/*
- * Build the entry stubs with some assembler magic.
- * We pack 1 stub into every 8-byte block.
- */
-	.align 8
-SYM_CODE_START(irq_entries_start)
-    vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
-	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
-	jmp	common_interrupt
-	.align	8
-	vector=vector+1
-    .endr
-SYM_CODE_END(irq_entries_start)
-
-	.align 8
-SYM_CODE_START(spurious_entries_start)
-    vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
-	UNWIND_HINT_IRET_REGS
-	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
-	jmp	common_spurious
-	.align	8
-	vector=vector+1
-    .endr
-SYM_CODE_END(spurious_entries_start)
-
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
 	pushq %rax
@@ -755,13 +727,14 @@ _ASM_NOKPROBE(interrupt_entry)
 /* Interrupt entry/exit. */
 
 /*
- * The interrupt stubs push (~vector+0x80) onto the stack and
+ * The interrupt stubs push vector onto the stack and
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
@@ -770,10 +743,11 @@ _ASM_NOKPROBE(common_spurious)
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
@@ -1022,7 +996,7 @@ apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
 apicinterrupt ERROR_APIC_VECTOR			error_interrupt			smp_error_interrupt
-apicinterrupt SPURIOUS_APIC_VECTOR		spurious_interrupt		smp_spurious_interrupt
+apicinterrupt SPURIOUS_APIC_VECTOR		spurious_apic_interrupt		smp_spurious_apic_interrupt
 
 #ifdef CONFIG_IRQ_WORK
 apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index 416422762845..cd57ce6134c9 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -35,7 +35,7 @@ BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
 
 BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
-BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
+BUILD_INTERRUPT(spurious_apic_interrupt,SPURIOUS_APIC_VECTOR)
 BUILD_INTERRUPT(x86_platform_ipi, X86_PLATFORM_IPI_VECTOR)
 
 #ifdef CONFIG_IRQ_WORK
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 4154bc5f6a4e..0ffe80792b2d 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -39,6 +39,7 @@ extern asmlinkage void irq_work_interrupt(void);
 extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
+extern asmlinkage void spurious_apic_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3c239db60d7b..1fad257372e3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -324,6 +324,46 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_XEN(vector, func)				\
 	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
+/*
+ * ASM code to emit the common vector entry stubs where each stub is
+ * packed into 8 bytes.
+ *
+ * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
+ * GCC treats the local vector variable as unsigned int and would expand
+ * all vectors above 0x7F to a 5 byte push. The original code did an
+ * adjustment of the vector number to be in the signed byte range to avoid
+ * this. While clever it's mindboggling counterintuitive and requires the
+ * odd conversion back to a real vector number in the C entry points. Using
+ * .byte achieves the same thing and the only fixup needed in the C entry
+ * point is to mask off the bits above bit 7 because the push is sign
+ * extending.
+ */
+	.align 8
+SYM_CODE_START(irq_entries_start)
+    vector=FIRST_EXTERNAL_VECTOR
+    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	.byte	0x6a, vector
+	jmp	common_interrupt
+	.align	8
+    vector=vector+1
+    .endr
+SYM_CODE_END(irq_entries_start)
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	.align 8
+SYM_CODE_START(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	.byte	0x6a, vector
+	jmp	common_spurious
+	.align	8
+    vector=vector+1
+    .endr
+SYM_CODE_END(spurious_entries_start)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 72fba0eeeb30..74690a373c58 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -36,7 +36,7 @@ extern void native_init_IRQ(void);
 
 extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
-extern __visible void do_IRQ(struct pt_regs *regs);
+extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
 
 extern void init_ISA_irqs(void);
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index d7de360eec74..32b2becf7806 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -41,8 +41,9 @@ asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
 #endif
 
 void smp_apic_timer_interrupt(struct pt_regs *regs);
-void smp_spurious_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
+void smp_spurious_apic_interrupt(struct pt_regs *regs);
+void smp_spurious_interrupt(struct pt_regs *regs, unsigned long vector);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e53dda210cd7..a4218a3726f9 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2153,15 +2153,29 @@ void __init register_lapic_address(unsigned long address)
  * Local APIC interrupts
  */
 
-/*
- * This interrupt should _never_ happen with our APIC/SMP architecture
+/**
+ * smp_spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @error_code:	The vector number is in the lower 8 bits
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
+	/*
+	 * The push in the entry ASM code which stores the vector number on
+	 * the stack in the error code slot is sign expanding. Just use the
+	 * lower 8 bits.
+	 */
+	vector &= 0xFF;
 	trace_spurious_apic_entry(vector);
 
 	inc_irq_stat(irq_spurious_count);
@@ -2182,11 +2196,11 @@ __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
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
@@ -2194,6 +2208,11 @@ __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
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
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index b4bd866568ee..3e49e1fac1c6 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -142,7 +142,7 @@ static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_X86_UV
 	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
 #endif
-	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
+	INTG(SPURIOUS_APIC_VECTOR,	spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
 };
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 252065d32ab5..c7669363251a 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -227,14 +227,18 @@ u64 arch_irq_stat(void)
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-__visible void __irq_entry do_IRQ(struct pt_regs *regs)
+__visible void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long vector)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct irq_desc * desc;
-	/* high bit used in ret_from_ code  */
-	unsigned vector = ~regs->orig_ax;
+	struct irq_desc *desc;
 
 	entering_irq();
+	/*
+	 * The push in the entry ASM code which stores the vector number on
+	 * the stack in the error code slot is sign expanding. Just use the
+	 * lower 8 bits.
+	 */
+	vector &= 0xFF;
 
 	/* entering_irq() tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
@@ -249,7 +253,7 @@ __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 		ack_APIC_irq();
 
 		if (desc == VECTOR_UNUSED) {
-			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
+			pr_emerg_ratelimited("%s: %d.%lu No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
 		} else {

