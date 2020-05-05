Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D41C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FE220675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEEORM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729514AbgEEORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FBAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:02 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNG-0002Tk-4q; Tue, 05 May 2020 16:16:42 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 95D97FFC8D;
        Tue,  5 May 2020 16:16:41 +0200 (CEST)
Message-Id: <20200505135829.790154766@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:58 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 5 17/31] x86/entry: Provide IDTENTRY_SYSVEC
References: <20200505135341.730586321@linutronix.de>
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

Provide a IDTENTRY variant for system vectors to consolidate the different
mechanisms to emit the ASM stubs for 32 an 64 bit.

On 64bit this also moves the stack switching from ASM to C code. 32bit will
excute the system vectors w/o stack switching as before. As some of the
system vector handlers require access to pt_regs this requires a new stack
switching macro which can handle an argument.

The alternative solution would be to implement the set_irq_regs() dance
right in the entry macro, but most system vector handlers do not require
it, so avoid the overhead.

Provide the entry/exit handling as inline functions so the scheduler IPI
can use it to implement lightweight entry handling depending on trace point
enablement. This ensures that the code is consistent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S        |    4 ++
 arch/x86/entry/entry_64.S        |    8 ++++
 arch/x86/include/asm/idtentry.h  |   72 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irq_stack.h |   33 +++++++++++++++++
 4 files changed, 116 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -765,6 +765,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 SYM_CODE_END(asm_\cfunc)
 .endm
 
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit.
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -543,6 +543,14 @@ SYM_CODE_END(\asmsym)
 .endm
 
 /*
+ * System vectors which invoke their handlers directly and are not
+ * going through the regular common device interrupt handling code.
+ */
+.macro idtentry_sysvec vector cfunc
+	idtentry \vector asm_\cfunc \cfunc has_error_code=0
+.endm
+
+/*
  * MCE and DB exceptions
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -6,6 +6,9 @@
 #include <asm/trapnr.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/hardirq.h>
+
+#include <asm/irq_stack.h>
 
 void idtentry_enter(struct pt_regs *regs);
 void idtentry_exit(struct pt_regs *regs);
@@ -207,6 +210,71 @@ static __always_inline void __##func(str
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
 
+/**
+ * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Declares three functions:
+ * - The ASM entry point: asm_##func
+ * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the ASM entry point
+ *
+ * Maps to DECLARE_IDTENTRY().
+ */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	DECLARE_IDTENTRY(vector, func)
+
+
+static __always_inline void idtentry_sysvec_enter(struct pt_regs *regs)
+{
+	idtentry_enter(regs);
+	instr_begin();
+	irq_enter_rcu();
+	kvm_set_cpu_l1tf_flush_l1d();
+	instr_end();
+}
+
+static __always_inline void idtentry_sysvec_exit(struct pt_regs *regs)
+{
+	instr_begin();
+	irq_exit_rcu();
+	lockdep_hardirq_exit();
+	instr_end();
+	idtentry_exit(regs);
+}
+
+/**
+ * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
+ * @func:	Function name of the entry point
+ *
+ * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * function body. KVM L1D flush request is set.
+ *
+ * Runs the function on the interrupt stack if the entry hit kernel mode
+ */
+#define DEFINE_IDTENTRY_SYSVEC(func)					\
+__visible void __##func(struct pt_regs *regs);				\
+									\
+static noinstr void irqst_##func(struct pt_regs *regs)			\
+{									\
+	RUN_ON_IRQSTACK_ARG1(__##func, regs);				\
+}									\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	idtentry_sysvec_enter(regs);					\
+	instr_begin();							\
+	if (!irq_needs_irq_stack(regs))					\
+		__##func (regs);					\
+	else								\
+		irqst_##func(regs);					\
+	instr_end();							\
+	idtentry_sysvec_exit(regs);					\
+}									\
+									\
+__visible void __##func(struct pt_regs *regs)
+
 #ifdef CONFIG_X86_64
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
@@ -354,6 +422,10 @@ static __always_inline void __##func(str
 #define DECLARE_IDTENTRY_IRQ(vector, func)				\
 	idtentry_irq vector func
 
+/* System vector entries */
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+	idtentry_sysvec vector func
+
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	idtentry_mce_db vector asm_##func func
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -46,9 +46,40 @@ static __always_inline bool irqstack_act
 	__this_cpu_sub(irq_count, 1);					\
 }
 
+#define RUN_ON_IRQSTACK_ARG1(func, arg) {				\
+	unsigned long tos;						\
+									\
+	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
+									\
+	__this_cpu_add(irq_count, 1);					\
+	asm volatile(							\
+		"pushq  %%rbp					\n"	\
+		"movq   %%rsp, %%rbp				\n"	\
+		"movq	%%rsp, (%[ts])				\n"	\
+		"movq	%[ts], %%rsp				\n"	\
+		"1:						\n"	\
+		"	.pushsection .discard.instr_begin	\n"	\
+		"	.long 1b - .				\n"	\
+		"	.popsection				\n"	\
+		"call	" __ASM_FORM(func) "			\n"	\
+		"2:						\n"	\
+		"	.pushsection .discard.instr_end		\n"	\
+		"	.long 2b - .				\n"	\
+		"	.popsection				\n"	\
+		"popq	%%rsp					\n"	\
+		"leaveq						\n"	\
+		:							\
+		: [ts] "r" (tos),					\
+		  "D" (arg)						\
+		: "memory"						\
+		);							\
+	__this_cpu_sub(irq_count, 1);					\
+}
+
 #else /* CONFIG_X86_64 */
 static __always_inline bool irqstack_active(void) { return false; }
-#define RUN_ON_IRQSTACK(func)	do { } while (0)
+#define RUN_ON_IRQSTACK(func)		do { } while (0)
+#define RUN_ON_IRQSTACK_ARG1(func, arg)	do { } while (0)
 #endif /* !CONFIG_X86_64 */
 
 static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)

