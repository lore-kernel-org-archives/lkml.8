Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EA4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811DB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgESTwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgESTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E9C08C5C2;
        Tue, 19 May 2020 12:52:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hx-0007pI-VB; Tue, 19 May 2020 21:52:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 76B251C0178;
        Tue, 19 May 2020 21:52:33 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:33 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] x86: Replace ist_enter() with nmi_enter()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.525508608@linutronix.de>
References: <20200505134101.525508608@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795339.17951.6882263788319051588.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0d00449c7a28a1514595630735df383dec606812
Gitweb:        https://git.kernel.org/tip/0d00449c7a28a1514595630735df383dec606812
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 19 Feb 2020 09:46:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:20 +02:00

x86: Replace ist_enter() with nmi_enter()

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
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134101.525508608@linutronix.de


---
 arch/x86/include/asm/traps.h      |  3 +-
 arch/x86/kernel/cpu/mce/core.c    |  5 +-
 arch/x86/kernel/cpu/mce/p5.c      |  5 +-
 arch/x86/kernel/cpu/mce/winchip.c |  5 +-
 arch/x86/kernel/traps.c           | 71 ++++++------------------------
 5 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index fe109fc..6f6c417 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -118,9 +118,6 @@ void smp_spurious_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);
 
-extern void ist_enter(struct pt_regs *regs);
-extern void ist_exit(struct pt_regs *regs);
-
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2f0ef95..e9265e2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -43,6 +43,7 @@
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
 #include <linux/task_work.h>
+#include <linux/hardirq.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1266,7 +1267,7 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 	if (__mc_check_crashing_cpu(cpu))
 		return;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	this_cpu_inc(mce_exception_count);
 
@@ -1374,7 +1375,7 @@ void noinstr do_machine_check(struct pt_regs *regs, long error_code)
 	}
 
 out_ist:
-	ist_exit(regs);
+	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
 
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 4ae6df5..5ee94aa 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/smp.h>
+#include <linux/hardirq.h>
 
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -24,7 +25,7 @@ static void pentium_machine_check(struct pt_regs *regs, long error_code)
 {
 	u32 loaddr, hi, lotype;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
@@ -39,7 +40,7 @@ static void pentium_machine_check(struct pt_regs *regs, long error_code)
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	ist_exit(regs);
+	nmi_exit();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE: */
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index a30ea13..b3938c1 100644
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
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6740e83..f7cfb9d 100644
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
@@ -82,41 +84,6 @@ static inline void cond_local_irq_disable(struct pt_regs *regs)
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
@@ -326,7 +293,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for ist_enter here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't use RCU.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
@@ -361,7 +328,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	}
 #endif
 
-	ist_enter(regs);
+	nmi_enter();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
 	tsk->thread.error_code = error_code;
@@ -555,19 +522,13 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
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
@@ -589,10 +550,8 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
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
 
@@ -696,7 +655,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	unsigned long dr6;
 	int si_code;
 
-	ist_enter(regs);
+	nmi_enter();
 
 	get_debugreg(dr6, 6);
 	/*
@@ -789,7 +748,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	debug_stack_usage_dec();
 
 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_debug);
 
