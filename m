Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FAE207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEPAL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728053AbgEPALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:11:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFEC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:11:03 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPc-0002Y2-Il; Sat, 16 May 2020 02:10:44 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 18D9CFF834;
        Sat, 16 May 2020 02:10:44 +0200 (CEST)
Message-Id: <20200515235127.404958221@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:17 +0200
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
Subject: [patch V6 30/37] x86/entry: Convert reschedule interrupt to IDTENTRY_RAW
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


The scheduler IPI does not need the full interrupt entry handling logic
when the entry is from kernel mode.

Even if tracing is enabled the only requirement is that RCU is watching and
preempt_count has the hardirq bit on.

The NOHZ tick state does not have to be adjusted. If the tick is not
running then the CPU is in idle and the idle exit will restore the
tick. Softinterrupts are not raised here, so handling them on return is not
required either.

User mode entry must go through the regular entry path as it will invoke
the scheduler on return so context tracking needs to be in the correct
state.

Use IDTENTRY_RAW and the RCU conditional variants of idtentry_enter/exit()
to guarantee that RCU is watching even if the IPI hits a RCU idle section.

Remove the tracepoint static key conditional which is incomplete
vs. tracing anyway because e.g. ack_APIC_irq() calls out into
instrumentable code.

Avoid the overhead of irq time accounting and introduce variants of
__irq_enter/exit() so instrumentation observes the correct preempt count
state.

Spare the switch to the interrupt stack as the IPI is not going to use only
a minimal amount of stack space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 943ffd64363a..38dc4d1f7a7b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,10 +956,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_SMP
-apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index a01bb74244ac..3e841ed5c17a 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -10,6 +10,3 @@
  * is no hardware IRQ pin equivalent for them, they are triggered
  * through the ICC by us (IPIs)
  */
-#ifdef CONFIG_SMP
-BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
-#endif
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index fd5e7c8825e1..74c12437401e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,9 +28,6 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 
-/* Interrupt handlers registered during init_IRQ */
-extern asmlinkage void reschedule_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1bedae4f297a..a380303089cd 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -576,6 +576,7 @@ DECLARE_IDTENTRY_SYSVEC(X86_PLATFORM_IPI_VECTOR,	sysvec_x86_platform_ipi);
 #endif
 
 #ifdef CONFIG_SMP
+DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule_ipi);
 DECLARE_IDTENTRY_SYSVEC(IRQ_MOVE_CLEANUP_VECTOR,	sysvec_irq_move_cleanup);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single);
diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
index 57c8da027d99..f0f9bcdb74d9 100644
--- a/arch/x86/include/asm/trace/common.h
+++ b/arch/x86/include/asm/trace/common.h
@@ -5,12 +5,8 @@
 DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
 #define trace_pagefault_enabled()			\
 	static_branch_unlikely(&trace_pagefault_key)
-DECLARE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-#define trace_resched_ipi_enabled()			\
-	static_branch_unlikely(&trace_resched_ipi_key)
 #else
 static inline bool trace_pagefault_enabled(void) { return false; }
-static inline bool trace_resched_ipi_enabled(void) { return false; }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 33b9d0f0aafe..88e7f0f3bf62 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -10,9 +10,6 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-extern int trace_resched_ipi_reg(void);
-extern void trace_resched_ipi_unreg(void);
-
 DECLARE_EVENT_CLASS(x86_irq_vector,
 
 	TP_PROTO(int vector),
@@ -37,18 +34,6 @@ DEFINE_EVENT_FN(x86_irq_vector, name##_exit,	\
 	TP_PROTO(int vector),			\
 	TP_ARGS(vector), NULL, NULL);
 
-#define DEFINE_RESCHED_IPI_EVENT(name)		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_entry,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);		\
-DEFINE_EVENT_FN(x86_irq_vector, name##_exit,	\
-	TP_PROTO(int vector),			\
-	TP_ARGS(vector),			\
-	trace_resched_ipi_reg,			\
-	trace_resched_ipi_unreg);
-
 /*
  * local_timer - called when entering/exiting a local timer interrupt
  * vector handler
@@ -99,7 +84,7 @@ TRACE_EVENT_PERF_PERM(irq_work_exit, is_sampling_event(p_event) ? -EPERM : 0);
 /*
  * reschedule - called when entering/exiting a reschedule vector handler
  */
-DEFINE_RESCHED_IPI_EVENT(reschedule);
+DEFINE_IRQ_VECTOR_EVENT(reschedule);
 
 /*
  * call_function - called when entering/exiting a call function interrupt
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 4ae0dd2773e3..eab476979697 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -109,7 +109,7 @@ static const __initconst struct idt_data def_idts[] = {
  */
 static const __initconst struct idt_data apic_idts[] = {
 #ifdef CONFIG_SMP
-	INTG(RESCHEDULE_VECTOR,			reschedule_interrupt),
+	INTG(RESCHEDULE_VECTOR,			asm_sysvec_reschedule_ipi),
 	INTG(CALL_FUNCTION_VECTOR,		asm_sysvec_call_function),
 	INTG(CALL_FUNCTION_SINGLE_VECTOR,	asm_sysvec_call_function_single),
 	INTG(IRQ_MOVE_CLEANUP_VECTOR,		asm_sysvec_irq_move_cleanup),
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index e5647daa7e96..eff4ce3b10da 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -220,26 +220,15 @@ static void native_stop_other_cpus(int wait)
 
 /*
  * Reschedule call back. KVM uses this interrupt to force a cpu out of
- * guest mode
+ * guest mode.
  */
-__visible void __irq_entry smp_reschedule_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
 {
 	ack_APIC_irq();
+	trace_reschedule_entry(RESCHEDULE_VECTOR);
 	inc_irq_stat(irq_resched_count);
-
-	if (trace_resched_ipi_enabled()) {
-		/*
-		 * scheduler_ipi() might call irq_enter() as well, but
-		 * nested calls are fine.
-		 */
-		irq_enter();
-		trace_reschedule_entry(RESCHEDULE_VECTOR);
-		scheduler_ipi();
-		trace_reschedule_exit(RESCHEDULE_VECTOR);
-		irq_exit();
-		return;
-	}
 	scheduler_ipi();
+	trace_reschedule_exit(RESCHEDULE_VECTOR);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index 496748ed266a..fcfc077afe2d 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -25,20 +25,3 @@ void trace_pagefault_unreg(void)
 {
 	static_branch_dec(&trace_pagefault_key);
 }
-
-#ifdef CONFIG_SMP
-
-DEFINE_STATIC_KEY_FALSE(trace_resched_ipi_key);
-
-int trace_resched_ipi_reg(void)
-{
-	static_branch_inc(&trace_resched_ipi_key);
-	return 0;
-}
-
-void trace_resched_ipi_unreg(void)
-{
-	static_branch_dec(&trace_resched_ipi_key);
-}
-
-#endif

