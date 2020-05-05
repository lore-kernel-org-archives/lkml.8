Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46750C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248262083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgEEOOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgEEOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1CAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:33 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKb-0000pO-Vn; Tue, 05 May 2020 16:13:58 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5A0C7FFC8D;
        Tue,  5 May 2020 16:13:57 +0200 (CEST)
Message-Id: <20200505134101.525508608@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:37 +0200
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 35/36] x86: Replace ist_enter() with nmi_enter()
References: <20200505131602.633487962@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

A few exceptions (like #DB and #BP) can happen at any location in the code,
this then means that tracers should treat events from these exceptions as
NMI-like. The interrupted context could be holding locks with interrupts
disabled for instance.

Similarly, #MC is an actual NMI-like exception.

All of them use ist_enter() which only concerns itself with RCU, but does
not do any of the other setup that NMIs need. This means things like:

	printk()
	  raw_spin_lock_irq(&logbuf_lock);
	  <#DB/#BP/#MC>
	     printk()
	       raw_spin_lock_irq(&logbuf_lock);

are entirely possible (well, not really since printk tries hard to
play nice, but the concept stands).

So replace ist_enter() with nmi_enter(). Also observe that any nmi_enter()
caller must be both notrace and NOKPROBE, or in the noinstr text section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/traps.h      |    3 -
 arch/x86/kernel/cpu/mce/core.c    |    5 +-
 arch/x86/kernel/cpu/mce/p5.c      |    5 +-
 arch/x86/kernel/cpu/mce/winchip.c |    5 +-
 arch/x86/kernel/traps.c           |   71 ++++++++------------------------------
 5 files changed, 24 insertions(+), 65 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -79,9 +79,6 @@ void smp_spurious_interrupt(struct pt_re
 void smp_error_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
-extern void ist_enter(struct pt_regs *regs);
-extern void ist_exit(struct pt_regs *regs);
-
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -43,6 +43,7 @@
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
 #include <linux/task_work.h>
+#include <linux/hardirq.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1266,7 +1267,7 @@ void noinstr do_machine_check(struct pt_
 	if (__mc_check_crashing_cpu(cpu))
 		return;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	this_cpu_inc(mce_exception_count);
 
@@ -1374,7 +1375,7 @@ void noinstr do_machine_check(struct pt_
 	}
 
 out_ist:
-	ist_exit(regs);
+	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/smp.h>
+#include <linux/hardirq.h>
 
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -24,7 +25,7 @@ static void pentium_machine_check(struct
 {
 	u32 loaddr, hi, lotype;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
@@ -39,7 +40,7 @@ static void pentium_machine_check(struct
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	ist_exit(regs);
+	nmi_exit();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -6,6 +6,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/hardirq.h>
 
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -18,12 +19,12 @@
 /* Machine check handler for WinChip C6: */
 static void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-	ist_enter(regs);
+	nmi_enter();
 
 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	ist_exit(regs);
+	nmi_exit();
 }
 
 /* Set up machine check reporting on the Winchip C6 series */
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,10 +37,12 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/io.h>
+#include <linux/hardirq.h>
+#include <linux/atomic.h>
+
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>
-#include <linux/atomic.h>
 #include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/traps.h>
@@ -82,41 +84,6 @@ static inline void cond_local_irq_disabl
 		local_irq_disable();
 }
 
-/*
- * In IST context, we explicitly disable preemption.  This serves two
- * purposes: it makes it much less likely that we would accidentally
- * schedule in IST context and it will force a warning if we somehow
- * manage to schedule by accident.
- */
-void ist_enter(struct pt_regs *regs)
-{
-	if (user_mode(regs)) {
-		RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
-	} else {
-		/*
-		 * We might have interrupted pretty much anything.  In
-		 * fact, if we're a machine check, we can even interrupt
-		 * NMI processing.  We don't want in_nmi() to return true,
-		 * but we need to notify RCU.
-		 */
-		rcu_nmi_enter();
-	}
-
-	preempt_disable();
-
-	/* This code is a bit fragile.  Test it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "ist_enter didn't work");
-}
-NOKPROBE_SYMBOL(ist_enter);
-
-void ist_exit(struct pt_regs *regs)
-{
-	preempt_enable_no_resched();
-
-	if (!user_mode(regs))
-		rcu_nmi_exit();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;
@@ -366,7 +333,7 @@ dotraplinkage void do_double_fault(struc
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for ist_enter here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't use RCU.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
@@ -406,7 +373,7 @@ dotraplinkage void do_double_fault(struc
 	}
 #endif
 
-	ist_enter(regs);
+	nmi_enter();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -603,19 +570,13 @@ dotraplinkage void notrace do_int3(struc
 		return;
 
 	/*
-	 * Unlike any other non-IST entry, we can be called from a kprobe in
-	 * non-CONTEXT_KERNEL kernel mode or even during context tracking
-	 * state changes.  Make sure that we wake up RCU even if we're coming
-	 * from kernel code.
-	 *
-	 * This means that we can't schedule even if we came from a
-	 * preemptible kernel context.  That's okay.
+	 * Unlike any other non-IST entry, we can be called from pretty much
+	 * any location in the kernel through kprobes -- text_poke() will most
+	 * likely be handled by poke_int3_handler() above. This means this
+	 * handler is effectively NMI-like.
 	 */
-	if (!user_mode(regs)) {
-		rcu_nmi_enter();
-		preempt_disable();
-	}
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	if (!user_mode(regs))
+		nmi_enter();
 
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -637,10 +598,8 @@ dotraplinkage void notrace do_int3(struc
 	cond_local_irq_disable(regs);
 
 exit:
-	if (!user_mode(regs)) {
-		preempt_enable_no_resched();
-		rcu_nmi_exit();
-	}
+	if (!user_mode(regs))
+		nmi_exit();
 }
 NOKPROBE_SYMBOL(do_int3);
 
@@ -745,7 +704,7 @@ dotraplinkage void do_debug(struct pt_re
 	unsigned long dr6;
 	int si_code;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	get_debugreg(dr6, 6);
 	/*
@@ -838,7 +797,7 @@ dotraplinkage void do_debug(struct pt_re
 	debug_stack_usage_dec();
 
 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_debug);
 

