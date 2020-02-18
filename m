Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C14C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B36206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t22CG8bA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBRVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:49:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgBRVtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ctv/hKrgWOEKHsFm2tQrzfZ1HeA6YyBG7W+nTCpDmjg=; b=t22CG8bAp8ECkSc/uyU4E7ZmEy
        5NuealTrnEtUg/COiR5oBUWGvHP7xJgyKJ2wnLWh1SYZpJVCMNfQkWP+P7Zz8OxaVjvozxo9TMGSK
        C+4zcshrpVdBGBN/uGprx8JxBZSW6tuuXWPdMPH5Z7qwX6GGNJDFxN/C7B7UOw6Jo04ZBp9Sd84IG
        pnZ8hlLsvKgKfEkEyt33dALbm7cjAfPJLVXSGTyoFfSpk/U0IsEZ95ObCT2sQr3fmXB5+szvS4BQo
        sw5bKypM44HwTWM2xEWAAjwNPeFiJrFj0yeZ0lmRR50lWF0747G1ySZeXyheAsRNt6YuyPil6q9Ba
        6en8oGqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Ajq-0007fg-SW; Tue, 18 Feb 2020 21:49:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30291980E59; Tue, 18 Feb 2020 22:49:04 +0100 (CET)
Date:   Tue, 18 Feb 2020 22:49:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, paulmck@kernel.org
Subject: Re: [RFC] #MC mess
Message-ID: <20200218214904.GD11802@worktop.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
 <20200218203404.GI11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218203404.GI11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:34:04PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 08:11:10PM +0000, Luck, Tony wrote:
> > > Then please rewrite the #MC entry code to deal with nested exceptions
> > > unmasking the MCE, very similr to NMI.
> > 
> > #MC doesn't work like NMI.  It isn't enabled by IRET.  Nested #MC cause an
> > immediate reset.  Detection of nested case is by IA32_MCG_STATUS.MCIP.
> > We don't clear MCG_STATUS until we are ready to return from the machine
> > check handler.
> 
> Ooh, excellent! That saves a whole heap of problems.
> 
> Then I suppose we should work at getting in_nmi() set. Let me have
> another look at things.

How's something like the -- completely untested -- below?


---
 arch/arm64/kernel/sdei.c          | 14 +-----
 arch/arm64/kernel/traps.c         |  8 +---
 arch/powerpc/kernel/traps.c       | 19 +++-----
 arch/x86/include/asm/traps.h      |  5 ---
 arch/x86/kernel/cpu/mce/core.c    | 60 ++++++++++++++-----------
 arch/x86/kernel/cpu/mce/p5.c      |  7 +--
 arch/x86/kernel/cpu/mce/winchip.c |  7 +--
 arch/x86/kernel/traps.c           | 94 ++++-----------------------------------
 include/linux/hardirq.h           |  2 +-
 include/linux/preempt.h           |  4 +-
 include/linux/sched.h             |  6 +++
 kernel/printk/printk_safe.c       |  6 ++-
 12 files changed, 72 insertions(+), 160 deletions(-)

diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index d6259dac62b6..e396e69e33a1 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -251,22 +251,12 @@ asmlinkage __kprobes notrace unsigned long
 __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
 {
 	unsigned long ret;
-	bool do_nmi_exit = false;

-	/*
-	 * nmi_enter() deals with printk() re-entrance and use of RCU when
-	 * RCU believed this CPU was idle. Because critical events can
-	 * interrupt normal events, we may already be in_nmi().
-	 */
-	if (!in_nmi()) {
-		nmi_enter();
-		do_nmi_exit = true;
-	}
+	nmi_enter();

 	ret = _sdei_handler(regs, arg);

-	if (do_nmi_exit)
-		nmi_exit();
+	nmi_exit();

 	return ret;
 }
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..c728f163f329 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -906,17 +906,13 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)

 asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
 {
-	const bool was_in_nmi = in_nmi();
-
-	if (!was_in_nmi)
-		nmi_enter();
+	nmi_enter();

 	/* non-RAS errors are not containable */
 	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
 		arm64_serror_panic(regs, esr);

-	if (!was_in_nmi)
-		nmi_exit();
+	nmi_exit();
 }

 asmlinkage void enter_from_user_mode(void)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 014ff0701f24..aaaeb2884f59 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -441,15 +441,9 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
 void system_reset_exception(struct pt_regs *regs)
 {
 	unsigned long hsrr0, hsrr1;
-	bool nested = in_nmi();
 	bool saved_hsrrs = false;

-	/*
-	 * Avoid crashes in case of nested NMI exceptions. Recoverability
-	 * is determined by RI and in_nmi
-	 */
-	if (!nested)
-		nmi_enter();
+	nmi_enter();

 	/*
 	 * System reset can interrupt code where HSRRs are live and MSR[RI]=1.
@@ -521,8 +515,7 @@ void system_reset_exception(struct pt_regs *regs)
 		mtspr(SPRN_HSRR1, hsrr1);
 	}

-	if (!nested)
-		nmi_exit();
+	nmi_exit();

 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
@@ -823,9 +816,8 @@ int machine_check_generic(struct pt_regs *regs)
 void machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+
+	nmi_enter();

 	__this_cpu_inc(irq_stat.mce_exceptions);

@@ -863,8 +855,7 @@ void machine_check_exception(struct pt_regs *regs)
 	return;

 bail:
-	if (!nested)
-		nmi_exit();
+	nmi_exit();
 }

 void SMIException(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index ffa0dc8a535e..6aa9da422d23 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -121,11 +121,6 @@ void smp_spurious_interrupt(struct pt_regs *regs);
 void smp_error_interrupt(struct pt_regs *regs);
 asmlinkage void smp_irq_move_cleanup_interrupt(void);

-extern void ist_enter(struct pt_regs *regs);
-extern void ist_exit(struct pt_regs *regs);
-extern void ist_begin_non_atomic(struct pt_regs *regs);
-extern void ist_end_non_atomic(void);
-
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c4f949611e4..403380f857c7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1084,23 +1084,6 @@ static void mce_clear_state(unsigned long *toclear)
 	}
 }

-static int do_memory_failure(struct mce *m)
-{
-	int flags = MF_ACTION_REQUIRED;
-	int ret;
-
-	pr_err("Uncorrected hardware memory error in user-access at %llx", m->addr);
-	if (!(m->mcgstatus & MCG_STATUS_RIPV))
-		flags |= MF_MUST_KILL;
-	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
-	if (ret)
-		pr_err("Memory error not recovered");
-	else
-		set_mce_nospec(m->addr >> PAGE_SHIFT);
-	return ret;
-}
-
-
 /*
  * Cases where we avoid rendezvous handler timeout:
  * 1) If this CPU is offline.
@@ -1202,6 +1185,30 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 	*m = *final;
 }

+static void mce_kill_me_now(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void mce_kill_me_maybe(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	int flags = MF_ACTION_REQUIRED;
+	int ret;
+
+	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+	if (!(p->mce_status & MCG_STATUS_RIPV))
+		flags |= MF_MUST_KILL;
+	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
+	if (ret)
+		pr_err("Memory error not recovered");
+	else
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+
+	if (ret)
+		mce_kill_me_now(cb);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1214,7 +1221,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
  * MCE broadcast. However some CPUs might be broken beyond repair,
  * so be always careful when synchronizing with others.
  */
-void do_machine_check(struct pt_regs *regs, long error_code)
+notrace void do_machine_check(struct pt_regs *regs, long error_code)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1251,7 +1258,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 	if (__mc_check_crashing_cpu(cpu))
 		return;

-	ist_enter(regs);
+	nmi_enter();

 	this_cpu_inc(mce_exception_count);

@@ -1344,22 +1351,23 @@ void do_machine_check(struct pt_regs *regs, long error_code)

 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
-		ist_begin_non_atomic(regs);
-		local_irq_enable();
+		current->mce_addr = m->addr;
+		current->mce_status = m->mcgstatus;
+		current->mce_kill_me.func = mce_kill_me_maybe;
+		if (kill_it)
+			current->mce_kill_me.func = mce_kill_me_now;

-		if (kill_it || do_memory_failure(&m))
-			force_sig(SIGBUS);
-		local_irq_disable();
-		ist_end_non_atomic();
+		task_work_add(current, &current->mce_kill_me, true);
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
 	}

 out_ist:
-	ist_exit(regs);
+	nmi_exit();
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
+NOKPROBE_SYMBOL(do_machine_check);

 #ifndef CONFIG_MEMORY_FAILURE
 int memory_failure(unsigned long pfn, int flags)
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 4ae6df556526..135f6d5df3db 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -20,11 +20,11 @@
 int mce_p5_enabled __read_mostly;

 /* Machine check handler for Pentium class Intel CPUs: */
-static void pentium_machine_check(struct pt_regs *regs, long error_code)
+static notrace void pentium_machine_check(struct pt_regs *regs, long error_code)
 {
 	u32 loaddr, hi, lotype;

-	ist_enter(regs);
+	nmi_enter();

 	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
 	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
@@ -39,8 +39,9 @@ static void pentium_machine_check(struct pt_regs *regs, long error_code)

 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);

-	ist_exit(regs);
+	nmi_exit();
 }
+NOKPROBE_SYMBOL(pentium_machine_check);

 /* Set up machine check reporting for processors with Intel style MCE: */
 void intel_p5_mcheck_init(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index a30ea13cccc2..fbc5216c72f7 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -16,15 +16,16 @@
 #include "internal.h"

 /* Machine check handler for WinChip C6: */
-static void winchip_machine_check(struct pt_regs *regs, long error_code)
+static notrace void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-	ist_enter(regs);
+	nmi_enter();

 	pr_emerg("CPU0: Machine Check Exception.\n");
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);

-	ist_exit(regs);
+	nmi_exit();
 }
+NOKPROBE_SYMBOL(winchip_machine_check);

 /* Set up machine check reporting on the Winchip C6 series */
 void winchip_mcheck_init(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9e6f822922a3..acc3a847c610 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -83,78 +83,6 @@ static inline void cond_local_irq_disable(struct pt_regs *regs)
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
-/**
- * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
- * @regs:	regs passed to the IST exception handler
- *
- * IST exception handlers normally cannot schedule.  As a special
- * exception, if the exception interrupted userspace code (i.e.
- * user_mode(regs) would return true) and the exception was not
- * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
- * begins a non-atomic section within an ist_enter()/ist_exit() region.
- * Callers are responsible for enabling interrupts themselves inside
- * the non-atomic section, and callers must call ist_end_non_atomic()
- * before ist_exit().
- */
-void ist_begin_non_atomic(struct pt_regs *regs)
-{
-	BUG_ON(!user_mode(regs));
-
-	/*
-	 * Sanity check: we need to be on the normal thread stack.  This
-	 * will catch asm bugs and any attempt to use ist_preempt_enable
-	 * from double_fault.
-	 */
-	BUG_ON(!on_thread_stack());
-
-	preempt_enable_no_resched();
-}
-
-/**
- * ist_end_non_atomic() - begin a non-atomic section in an IST exception
- *
- * Ends a non-atomic section started with ist_begin_non_atomic().
- */
-void ist_end_non_atomic(void)
-{
-	preempt_disable();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;
@@ -345,7 +273,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	 * The net result is that our #GP handler will think that we
 	 * entered from usermode with the bad user context.
 	 *
-	 * No need for ist_enter here because we don't use RCU.
+	 * No need for nmi_enter() here because we don't use RCU.
 	 */
 	if (((long)regs->sp >> P4D_SHIFT) == ESPFIX_PGD_ENTRY &&
 		regs->cs == __KERNEL_CS &&
@@ -380,7 +308,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	}
 #endif

-	ist_enter(regs);
+	nmi_enter();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);

 	tsk->thread.error_code = error_code;
@@ -432,6 +360,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
 }
+NOKPROBE_SYMBOL(do_double_fault)
 #endif

 dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
@@ -645,14 +574,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	if (poke_int3_handler(regs))
 		return;

-	/*
-	 * Use ist_enter despite the fact that we don't use an IST stack.
-	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
-	 * mode or even during context tracking state changes.
-	 *
-	 * This means that we can't schedule.  That's okay.
-	 */
-	ist_enter(regs);
+	nmi_enter();
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -674,7 +596,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	cond_local_irq_disable(regs);

 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_int3);

@@ -771,14 +693,14 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
  *
  * May run on IST stack.
  */
-dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
+dotraplinkage notrace void do_debug(struct pt_regs *regs, long error_code)
 {
 	struct task_struct *tsk = current;
 	int user_icebp = 0;
 	unsigned long dr6;
 	int si_code;

-	ist_enter(regs);
+	nmi_enter();

 	get_debugreg(dr6, 6);
 	/*
@@ -871,7 +793,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	debug_stack_usage_dec();

 exit:
-	ist_exit(regs);
+	nmi_exit();
 }
 NOKPROBE_SYMBOL(do_debug);

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index da0af631ded5..146332764673 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -71,7 +71,7 @@ extern void irq_exit(void);
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
-		BUG_ON(in_nmi());				\
+		BUG_ON(in_nmi() == 0xf);			\
 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bbb68dba37cc..9b26069531de 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -26,13 +26,13 @@
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00100000
+ *             NMI_MASK:	0x00f00000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	4

 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b49901f90ef5..ad2aed16b74b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1285,6 +1285,12 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif

+#ifdef CONFIG_MEMORY_FAILURE
+	u64				mce_addr;
+	u64				mce_status;
+	struct callback_head		mce_kill_me;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e782743..a029393a8541 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)

 void notrace printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	if (!in_nmi())
+		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
 }

 void notrace printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	if (!in_nmi())
+		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
 }

 /*

