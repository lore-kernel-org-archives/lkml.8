Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AC0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441E12070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/87tzvQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ReQoGn9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHDIaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbgHDIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:30:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B92C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:30:08 -0700 (PDT)
Date:   Tue, 04 Aug 2020 08:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596529804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LVBkT30IeCMKRUK7hDMBOOElR+y7Bf9utueqht7o/RM=;
        b=d/87tzvQVpeXvAtnE0J7NF32Mync0qPIFZ/U5PF8v6HKsAQ7tae6CYy0GZc23eFtzwApYP
        UKYKWO6JyVz88To4GhntfC0GxfnTRW+jwJZTEoYGjKgBD7Rmr1PkImfkoAIEcSbguMI6mN
        3R3+T4a6c4rNJkAh4/vIjRsSqkV9DEJz79QwQqLElM719f9GdQ/rvlF3w7FBgkp+sf0iGk
        VtM9G7emyFs3v+xKiNRsff09TT8UBdAN2mlSV7eXtxm43jpX8nE8Nwak658xc+y8hZA2Ke
        USWkA787tT7DFUV9KOpu1gSznbdnMBr4G+BkHdFoRyehog4aY3yYgC5ZqcOQ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596529804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=LVBkT30IeCMKRUK7hDMBOOElR+y7Bf9utueqht7o/RM=;
        b=ReQoGn9uBmWf2bxIDFKF/Z34jNy6wA+8UY1dsNz71Hk+nCceVDQThMpklsZC0GzhtbxKqc
        n2YyJhLAYA9T4pDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/entry for v5.9
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
Message-ID: <159652931703.11821.10293235307345307460.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-08-04

up to:  adb334d17858: Merge branch 'WIP.x86/entry' into x86/entry, to merge the latest generic code and resolve conflicts

The conversion of X86 syscall, interrupt and exception entry/exit handling
to the generic code. Pretty much a straight forward 1:1 conversion plus the
consolidation of the KVM handling of pending work before entering guest
mode.

Contains the core/entry branch (previous pull request) and has the already
merged locking/core changes which caused conflicts integrated.

Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/entry: Rename idtentry_enter/exit_cond_rcu() to idtentry_enter/exit()

Herbert Xu (1):
      lockdep: Split header file into lockdep and lockdep_types

Ingo Molnar (1):
      entry: Correct 'noinstr' attributes

Ira Weiny (1):
      x86: Correct noinstr qualifiers

Marco Elver (1):
      kcsan: Make KCSAN compatible with new IRQ state tracking

Peter Zijlstra (2):
      lockdep: Prepare for NMI IRQ state tracking
      x86/entry: Fix NMI vs IRQ state tracking

Thomas Gleixner (18):
      x86/idtentry: Remove stale comment
      seccomp: Provide stub for __secure_computing()
      entry: Provide generic syscall entry functionality
      entry: Provide generic syscall exit function
      entry: Provide generic interrupt entry/exit code
      entry: Provide infrastructure for work before transitioning to guest mode
      x86/entry: Consolidate check_user_regs()
      x86/entry: Consolidate 32/64 bit syscall entry
      x86/entry: Move user return notifier out of loop
      x86/ptrace: Provide pt_regs helper for entry/exit
      x86/entry: Use generic syscall entry function
      x86/entry: Use generic syscall exit functionality
      x86/entry: Cleanup idtentry_entry/exit_user
      x86/entry: Use generic interrupt entry/exit code
      x86/entry: Cleanup idtentry_enter/exit
      x86/kvm: Use generic xfer to guest work function
      entry: Correct __secure_computing() stub
      x86/kvm: Use __xfer_to_guest_mode_work_pending() in kvm_run_vcpu()


 arch/Kconfig                        |   3 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/entry/common.c             | 638 ++++--------------------------------
 arch/x86/entry/entry_32.S           |   2 +-
 arch/x86/entry/entry_64.S           |   2 +-
 arch/x86/include/asm/entry-common.h |  76 +++++
 arch/x86/include/asm/idtentry.h     |  42 ++-
 arch/x86/include/asm/ptrace.h       |   5 +
 arch/x86/include/asm/signal.h       |   1 -
 arch/x86/include/asm/thread_info.h  |   5 -
 arch/x86/kernel/alternative.c       |   2 +-
 arch/x86/kernel/cpu/mce/core.c      |   6 +-
 arch/x86/kernel/kvm.c               |   6 +-
 arch/x86/kernel/nmi.c               |   9 +-
 arch/x86/kernel/signal.c            |   3 +-
 arch/x86/kernel/traps.c             |  41 +--
 arch/x86/kvm/Kconfig                |   1 +
 arch/x86/kvm/vmx/vmx.c              |  11 +-
 arch/x86/kvm/x86.c                  |  15 +-
 arch/x86/mm/fault.c                 |   6 +-
 include/linux/entry-common.h        | 372 +++++++++++++++++++++
 include/linux/entry-kvm.h           |  80 +++++
 include/linux/hardirq.h             |  28 +-
 include/linux/kvm_host.h            |   8 +
 include/linux/lockdep.h             | 178 +---------
 include/linux/lockdep_types.h       | 196 +++++++++++
 include/linux/seccomp.h             |   2 +
 include/linux/spinlock.h            |   1 +
 include/linux/spinlock_types.h      |   2 +-
 kernel/Makefile                     |   1 +
 kernel/entry/Makefile               |  13 +
 kernel/entry/common.c               | 374 +++++++++++++++++++++
 kernel/entry/kvm.c                  |  51 +++
 kernel/kcsan/core.c                 |   5 +-
 kernel/kcsan/report.c               |   9 +-
 kernel/locking/lockdep.c            |  46 ++-
 virt/kvm/Kconfig                    |   3 +
 37 files changed, 1384 insertions(+), 860 deletions(-)
 create mode 100644 arch/x86/include/asm/entry-common.h
 create mode 100644 include/linux/entry-common.h
 create mode 100644 include/linux/entry-kvm.h
 create mode 100644 include/linux/lockdep_types.h
 create mode 100644 kernel/entry/Makefile
 create mode 100644 kernel/entry/common.c
 create mode 100644 kernel/entry/kvm.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..852a527f418f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -27,6 +27,9 @@ config HAVE_IMA_KEXEC
 config HOTPLUG_SMT
 	bool
 
+config GENERIC_ENTRY
+       bool
+
 config OPROFILE
 	tristate "OProfile system profiling"
 	depends on PROFILING
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..ccf02e6c144c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -115,6 +115,7 @@ config X86
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ENTRY
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK	if SMP
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f09288431f28..48512c7944e7 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -10,20 +10,13 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/entry-common.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
-#include <linux/audit.h>
-#include <linux/seccomp.h>
-#include <linux/signal.h>
 #include <linux/export.h>
-#include <linux/context_tracking.h>
-#include <linux/user-return-notifier.h>
 #include <linux/nospec.h>
-#include <linux/uprobes.h>
-#include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
@@ -42,343 +35,12 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
-/* Check that the stack and regs on entry from user mode are sane. */
-static noinstr void check_user_regs(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
-		/*
-		 * Make sure that the entry code gave us a sensible EFLAGS
-		 * register.  Native because we want to check the actual CPU
-		 * state, not the interrupt state as imagined by Xen.
-		 */
-		unsigned long flags = native_save_fl();
-		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
-				      X86_EFLAGS_NT));
-
-		/* We think we came from user mode. Make sure pt_regs agrees. */
-		WARN_ON_ONCE(!user_mode(regs));
-
-		/*
-		 * All entries from user mode (except #DF) should be on the
-		 * normal thread stack and should have user pt_regs in the
-		 * correct location.
-		 */
-		WARN_ON_ONCE(!on_thread_stack());
-		WARN_ON_ONCE(regs != task_pt_regs(current));
-	}
-}
-
-#ifdef CONFIG_CONTEXT_TRACKING
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall entry disables interrupts, but user mode is traced as interrupts
- * enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- */
-static noinstr void enter_from_user_mode(void)
-{
-	enum ctx_state state = ct_state();
-
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	CT_WARN_ON(state != CONTEXT_USER);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-#else
-static __always_inline void enter_from_user_mode(void)
-{
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-#endif
-
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall exit enables interrupts, but the kernel state is interrupts
- * disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Clear CPU buffers if CPU is affected by MDS and the migitation is on.
- * 4) Tell lockdep that interrupts are enabled
- */
-static __always_inline void exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	instrumentation_end();
-
-	user_enter_irqoff();
-	mds_user_clear_cpu_buffers();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
-{
-#ifdef CONFIG_X86_64
-	if (arch == AUDIT_ARCH_X86_64) {
-		audit_syscall_entry(regs->orig_ax, regs->di,
-				    regs->si, regs->dx, regs->r10);
-	} else
-#endif
-	{
-		audit_syscall_entry(regs->orig_ax, regs->bx,
-				    regs->cx, regs->dx, regs->si);
-	}
-}
-
-/*
- * Returns the syscall nr to run (which should match regs->orig_ax) or -1
- * to skip the syscall.
- */
-static long syscall_trace_enter(struct pt_regs *regs)
-{
-	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
-
-	struct thread_info *ti = current_thread_info();
-	unsigned long ret = 0;
-	u32 work;
-
-	work = READ_ONCE(ti->flags);
-
-	if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
-		ret = tracehook_report_syscall_entry(regs);
-		if (ret || (work & _TIF_SYSCALL_EMU))
-			return -1L;
-	}
-
-#ifdef CONFIG_SECCOMP
-	/*
-	 * Do seccomp after ptrace, to catch any tracer changes.
-	 */
-	if (work & _TIF_SECCOMP) {
-		struct seccomp_data sd;
-
-		sd.arch = arch;
-		sd.nr = regs->orig_ax;
-		sd.instruction_pointer = regs->ip;
-#ifdef CONFIG_X86_64
-		if (arch == AUDIT_ARCH_X86_64) {
-			sd.args[0] = regs->di;
-			sd.args[1] = regs->si;
-			sd.args[2] = regs->dx;
-			sd.args[3] = regs->r10;
-			sd.args[4] = regs->r8;
-			sd.args[5] = regs->r9;
-		} else
-#endif
-		{
-			sd.args[0] = regs->bx;
-			sd.args[1] = regs->cx;
-			sd.args[2] = regs->dx;
-			sd.args[3] = regs->si;
-			sd.args[4] = regs->di;
-			sd.args[5] = regs->bp;
-		}
-
-		ret = __secure_computing(&sd);
-		if (ret == -1)
-			return ret;
-	}
-#endif
-
-	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
-		trace_sys_enter(regs, regs->orig_ax);
-
-	do_audit_syscall_entry(regs, arch);
-
-	return ret ?: regs->orig_ax;
-}
-
-#define EXIT_TO_USERMODE_LOOP_FLAGS				\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
-
-static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
-{
-	/*
-	 * In order to return to user mode, we need to have IRQs off with
-	 * none of EXIT_TO_USERMODE_LOOP_FLAGS set.  Several of these flags
-	 * can be set at any time on preemptible kernels if we have IRQs on,
-	 * so we need to loop.  Disabling preemption wouldn't help: doing the
-	 * work to clear some of the flags can sleep.
-	 */
-	while (true) {
-		/* We have work to do. */
-		local_irq_enable();
-
-		if (cached_flags & _TIF_NEED_RESCHED)
-			schedule();
-
-		if (cached_flags & _TIF_UPROBE)
-			uprobe_notify_resume(regs);
-
-		if (cached_flags & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
-		/* deal with pending signal delivery */
-		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
-
-		if (cached_flags & _TIF_NOTIFY_RESUME) {
-			clear_thread_flag(TIF_NOTIFY_RESUME);
-			tracehook_notify_resume(regs);
-			rseq_handle_notify_resume(NULL, regs);
-		}
-
-		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-			fire_user_return_notifiers();
-
-		/* Disable IRQs and retry */
-		local_irq_disable();
-
-		cached_flags = READ_ONCE(current_thread_info()->flags);
-
-		if (!(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
-			break;
-	}
-}
-
-static void __prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	struct thread_info *ti = current_thread_info();
-	u32 cached_flags;
-
-	addr_limit_user_check();
-
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-
-	cached_flags = READ_ONCE(ti->flags);
-
-	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
-		exit_to_usermode_loop(regs, cached_flags);
-
-	/* Reload ti->flags; we may have rescheduled above. */
-	cached_flags = READ_ONCE(ti->flags);
-
-	if (unlikely(cached_flags & _TIF_IO_BITMAP))
-		tss_update_io_bitmap();
-
-	fpregs_assert_state_consistent();
-	if (unlikely(cached_flags & _TIF_NEED_FPU_LOAD))
-		switch_fpu_return();
-
-#ifdef CONFIG_COMPAT
-	/*
-	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
-	 * returning to user mode.  We need to clear it *after* signal
-	 * handling, because syscall restart has a fixup for compat
-	 * syscalls.  The fixup is exercised by the ptrace_syscall_32
-	 * selftest.
-	 *
-	 * We also need to clear TS_REGS_POKED_I386: the 32-bit tracer
-	 * special case only applies after poking regs and before the
-	 * very next return to user mode.
-	 */
-	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
-#endif
-}
-
-static noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__prepare_exit_to_usermode(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
-#define SYSCALL_EXIT_WORK_FLAGS				\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
-
-static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
-{
-	bool step;
-
-	audit_syscall_exit(regs);
-
-	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, regs->ax);
-
-	/*
-	 * If TIF_SYSCALL_EMU is set, we only get here because of
-	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
-	 * We already reported this syscall instruction in
-	 * syscall_trace_enter().
-	 */
-	step = unlikely(
-		(cached_flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU))
-		== _TIF_SINGLESTEP);
-	if (step || cached_flags & _TIF_SYSCALL_TRACE)
-		tracehook_report_syscall_exit(regs, step);
-}
-
-static void __syscall_return_slowpath(struct pt_regs *regs)
-{
-	struct thread_info *ti = current_thread_info();
-	u32 cached_flags = READ_ONCE(ti->flags);
-
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-	    WARN(irqs_disabled(), "syscall %ld left IRQs disabled", regs->orig_ax))
-		local_irq_enable();
-
-	rseq_syscall(regs);
-
-	/*
-	 * First do one-time work.  If these work items are enabled, we
-	 * want to run them exactly once per syscall exit with IRQs on.
-	 */
-	if (unlikely(cached_flags & SYSCALL_EXIT_WORK_FLAGS))
-		syscall_slow_exit_work(regs, cached_flags);
-
-	local_irq_disable();
-	__prepare_exit_to_usermode(regs);
-}
-
-/*
- * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
- * state such that we can immediately switch to user mode.
- */
-__visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__syscall_return_slowpath(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
-	struct thread_info *ti;
+	nr = syscall_enter_from_user_mode(regs, nr);
 
-	check_user_regs(regs);
-
-	enter_from_user_mode();
 	instrumentation_begin();
-
-	local_irq_enable();
-	ti = current_thread_info();
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
-		nr = syscall_trace_enter(regs);
-
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](regs);
@@ -390,66 +52,55 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
-	__syscall_return_slowpath(regs);
-
 	instrumentation_end();
-	exit_to_user_mode();
+	syscall_exit_to_user_mode(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-/*
- * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
- * all entry and exit work and returns with IRQs off.  This function is
- * extremely hot in workloads that use it, and it's usually called from
- * do_fast_syscall_32, so forcibly inline it to improve performance.
- */
-static void do_syscall_32_irqs_on(struct pt_regs *regs)
+static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
 {
-	struct thread_info *ti = current_thread_info();
 	unsigned int nr = (unsigned int)regs->orig_ax;
 
-#ifdef CONFIG_IA32_EMULATION
-	ti->status |= TS_COMPAT;
-#endif
-
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
-		/*
-		 * Subtlety here: if ptrace pokes something larger than
-		 * 2^32-1 into orig_ax, this truncates it.  This may or
-		 * may not be necessary, but it matches the old asm
-		 * behavior.
-		 */
-		nr = syscall_trace_enter(regs);
-	}
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	return (unsigned int)syscall_enter_from_user_mode(regs, nr);
+}
 
+/*
+ * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
+ */
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
+						  unsigned int nr)
+{
 	if (likely(nr < IA32_NR_syscalls)) {
+		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+		instrumentation_end();
 	}
-
-	__syscall_return_slowpath(regs);
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	check_user_regs(regs);
+	unsigned int nr = syscall_32_enter(regs);
 
-	enter_from_user_mode();
-	instrumentation_begin();
-
-	local_irq_enable();
-	do_syscall_32_irqs_on(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_exit_to_user_mode(regs);
 }
 
-static bool __do_fast_syscall_32(struct pt_regs *regs)
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned int nr	= syscall_32_enter(regs);
 	int res;
 
+	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
@@ -462,17 +113,18 @@ static bool __do_fast_syscall_32(struct pt_regs *regs)
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
+	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		local_irq_disable();
-		__prepare_exit_to_usermode(regs);
+		syscall_exit_to_user_mode(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_exit_to_user_mode(regs);
 	return true;
 }
 
@@ -485,9 +137,6 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
-	bool success;
-
-	check_user_regs(regs);
 
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
@@ -496,17 +145,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
-	instrumentation_begin();
-
-	local_irq_enable();
-	success = __do_fast_syscall_32(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
-
-	/* If it failed, keep it simple: use IRET. */
-	if (!success)
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
 		return 0;
 
 #ifdef CONFIG_X86_64
@@ -558,197 +198,38 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-/**
- * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
- *			     RCU handling
- * @regs:	Pointer to pt_regs of interrupted context
- *
- * Invokes:
- *  - lockdep irqflag state tracking as low level ASM entry disabled
- *    interrupts.
- *
- *  - Context tracking if the exception hit user mode.
- *
- *  - The hardirq tracer to keep the state consistent as low level ASM
- *    entry disabled interrupts.
- *
- * For kernel mode entries RCU handling is done conditional. If RCU is
- * watching then the only RCU requirement is to check whether the tick has
- * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
- * invoked on entry and rcu_irq_exit() on exit.
- *
- * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
- * solves the problem of kernel mode pagefaults which can schedule, which
- * is not possible after invoking rcu_irq_enter() without undoing it.
- *
- * For user mode entries enter_from_user_mode() must be invoked to
- * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
- * would not be possible.
- *
- * Returns: True if RCU has been adjusted on a kernel entry
- *	    False otherwise
- *
- * The return value must be fed into the rcu_exit argument of
- * idtentry_exit_cond_rcu().
- */
-bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
+noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		check_user_regs(regs);
-		enter_from_user_mode();
-		return false;
-	}
+	bool irq_state = lockdep_hardirqs_enabled();
 
-	/*
-	 * If this entry hit the idle task invoke rcu_irq_enter() whether
-	 * RCU is watching or not.
-	 *
-	 * Interupts can nest when the first interrupt invokes softirq
-	 * processing on return which enables interrupts.
-	 *
-	 * Scheduler ticks in the idle task can mark quiescent state and
-	 * terminate a grace period, if and only if the timer interrupt is
-	 * not nested into another interrupt.
-	 *
-	 * Checking for __rcu_is_watching() here would prevent the nesting
-	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
-	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
-	 * assume that it is the first interupt and eventually claim
-	 * quiescient state and end grace periods prematurely.
-	 *
-	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
-	 * consistent.
-	 *
-	 * TINY_RCU does not support EQS, so let the compiler eliminate
-	 * this part when enabled.
-	 */
-	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
-		/*
-		 * If RCU is not watching then the same careful
-		 * sequence vs. lockdep and tracing is required
-		 * as in enter_from_user_mode().
-		 */
-		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		instrumentation_end();
-
-		return true;
-	}
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
 
-	/*
-	 * If RCU is watching then RCU only wants to check whether it needs
-	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
-	 * already contains a warning when RCU is not watching, so no point
-	 * in having another one here.
-	 */
 	instrumentation_begin();
-	rcu_irq_enter_check_tick();
-	/* Use the combo lockdep/tracing function */
-	trace_hardirqs_off();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
 	instrumentation_end();
 
-	return false;
-}
-
-static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
-{
-	if (may_sched && !preempt_count()) {
-		/* Sanity check RCU and thread stack */
-		rcu_irq_exit_check_preempt();
-		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
-			preempt_schedule_irq();
-	}
-	/* Covers both tracing and lockdep */
-	trace_hardirqs_on();
+	return irq_state;
 }
 
-/**
- * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
- *			    handling
- * @regs:	Pointer to pt_regs (exception entry regs)
- * @rcu_exit:	Invoke rcu_irq_exit() if true
- *
- * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and reguired and returns to
- * the caller with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
- * function must be fed into the @rcu_exit argument.
- */
-void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
+noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
 {
-	lockdep_assert_irqs_disabled();
-
-	/* Check whether this returns to user mode */
-	if (user_mode(regs)) {
-		prepare_exit_to_usermode(regs);
-	} else if (regs->flags & X86_EFLAGS_IF) {
-		/*
-		 * If RCU was not watching on entry this needs to be done
-		 * carefully and needs the same ordering of lockdep/tracing
-		 * and RCU as the return to user mode path.
-		 */
-		if (rcu_exit) {
-			instrumentation_begin();
-			/* Tell the tracer that IRET will enable interrupts */
-			trace_hardirqs_on_prepare();
-			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-			instrumentation_end();
-			rcu_irq_exit();
-			lockdep_hardirqs_on(CALLER_ADDR0);
-			return;
-		}
-
-		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, IS_ENABLED(CONFIG_PREEMPTION));
-		instrumentation_end();
-	} else {
-		/*
-		 * IRQ flags state is correct already. Just tell RCU if it
-		 * was not watching on entry.
-		 */
-		if (rcu_exit)
-			rcu_irq_exit();
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (restore) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	}
-}
-
-/**
- * idtentry_enter_user - Handle state tracking on idtentry from user mode
- * @regs:	Pointer to pt_regs of interrupted context
- *
- * Invokes enter_from_user_mode() to establish the proper context for
- * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
- */
-void noinstr idtentry_enter_user(struct pt_regs *regs)
-{
-	check_user_regs(regs);
-	enter_from_user_mode();
-}
-
-/**
- * idtentry_exit_user - Handle return from exception to user mode
- * @regs:	Pointer to pt_regs (exception entry regs)
- *
- * Runs the necessary preemption and work checks and returns to the caller
- * with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to idtentry_enter_user().
- */
-void noinstr idtentry_exit_user(struct pt_regs *regs)
-{
-	lockdep_assert_irqs_disabled();
+	instrumentation_end();
 
-	prepare_exit_to_usermode(regs);
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (restore)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
 }
 
 #ifdef CONFIG_XEN_PV
@@ -800,9 +281,10 @@ static void __xen_pv_evtchn_do_upcall(void)
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	bool inhcall, rcu_exit;
+	bool inhcall;
+	irqentry_state_t state;
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = irqentry_enter(regs);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -812,13 +294,13 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 
 	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(rcu_exit)) {
+	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
 		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, true);
+		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		idtentry_exit_cond_rcu(regs, rcu_exit);
+		irqentry_exit(regs, state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2d0bd5d5f032..6addbd1d0775 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -846,7 +846,7 @@ SYM_CODE_START(ret_from_fork)
 2:
 	/* When we fork, we trace the syscall return in the child, too. */
 	movl    %esp, %eax
-	call    syscall_return_slowpath
+	call    syscall_exit_to_user_mode
 	jmp     .Lsyscall_32_done
 
 	/* kernel thread */
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d2a00c97e53f..f423ca9e8a51 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -283,7 +283,7 @@ SYM_CODE_START(ret_from_fork)
 2:
 	UNWIND_HINT_REGS
 	movq	%rsp, %rdi
-	call	syscall_return_slowpath	/* returns with IRQs disabled */
+	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
 	jmp	swapgs_restore_regs_and_return_to_usermode
 
 1:
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
new file mode 100644
index 000000000000..a8f9315b9eae
--- /dev/null
+++ b/arch/x86/include/asm/entry-common.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_ENTRY_COMMON_H
+#define _ASM_X86_ENTRY_COMMON_H
+
+#include <linux/user-return-notifier.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/io_bitmap.h>
+#include <asm/fpu/api.h>
+
+/* Check that the stack and regs on entry from user mode are sane. */
+static __always_inline void arch_check_user_regs(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		/*
+		 * Make sure that the entry code gave us a sensible EFLAGS
+		 * register.  Native because we want to check the actual CPU
+		 * state, not the interrupt state as imagined by Xen.
+		 */
+		unsigned long flags = native_save_fl();
+		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
+				      X86_EFLAGS_NT));
+
+		/* We think we came from user mode. Make sure pt_regs agrees. */
+		WARN_ON_ONCE(!user_mode(regs));
+
+		/*
+		 * All entries from user mode (except #DF) should be on the
+		 * normal thread stack and should have user pt_regs in the
+		 * correct location.
+		 */
+		WARN_ON_ONCE(!on_thread_stack());
+		WARN_ON_ONCE(regs != task_pt_regs(current));
+	}
+}
+#define arch_check_user_regs arch_check_user_regs
+
+#define ARCH_SYSCALL_EXIT_WORK		(_TIF_SINGLESTEP)
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (ti_work & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
+	if (unlikely(ti_work & _TIF_IO_BITMAP))
+		tss_update_io_bitmap();
+
+	fpregs_assert_state_consistent();
+	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
+		switch_fpu_return();
+
+#ifdef CONFIG_COMPAT
+	/*
+	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
+	 * returning to user mode.  We need to clear it *after* signal
+	 * handling, because syscall restart has a fixup for compat
+	 * syscalls.  The fixup is exercised by the ptrace_syscall_32
+	 * selftest.
+	 *
+	 * We also need to clear TS_REGS_POKED_I386: the 32-bit tracer
+	 * special case only applies after poking regs and before the
+	 * very next return to user mode.
+	 */
+	current_thread_info()->status &= ~(TS_COMPAT | TS_I386_REGS_POKED);
+#endif
+}
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
+static __always_inline void arch_exit_to_user_mode(void)
+{
+	mds_user_clear_cpu_buffers();
+}
+#define arch_exit_to_user_mode arch_exit_to_user_mode
+
+#endif
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 80d3b30d3ee3..ff198fc2495e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -6,15 +6,13 @@
 #include <asm/trapnr.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/entry-common.h>
 #include <linux/hardirq.h>
 
 #include <asm/irq_stack.h>
 
-void idtentry_enter_user(struct pt_regs *regs);
-void idtentry_exit_user(struct pt_regs *regs);
-
-bool idtentry_enter_cond_rcu(struct pt_regs *regs);
-void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
+bool idtentry_enter_nmi(struct pt_regs *regs);
+void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
@@ -45,8 +43,8 @@ void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
  * The macro is written so it acts as function definition. Append the
  * body with a pair of curly brackets.
  *
- * idtentry_enter() contains common code which has to be invoked before
- * arbitrary code in the body. idtentry_exit() contains common code
+ * irqentry_enter() contains common code which has to be invoked before
+ * arbitrary code in the body. irqentry_exit() contains common code
  * which has to run before returning to the low level assembly code.
  */
 #define DEFINE_IDTENTRY(func)						\
@@ -54,12 +52,12 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -101,12 +99,12 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -161,7 +159,7 @@ __visible noinstr void func(struct pt_regs *regs)
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */
@@ -187,11 +185,9 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * to the function as error_code argument which needs to be truncated
  * to an u8 because the push is sign extending.
  *
- * On 64-bit idtentry_enter/exit() are invoked in the ASM entry code before
- * and after switching to the interrupt stack. On 32-bit this happens in C.
- *
  * irq_enter/exit_rcu() are invoked before the function body and the
- * KVM L1D flush request is set.
+ * KVM L1D flush request is set. Stack switching to the interrupt stack
+ * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
@@ -199,7 +195,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -207,7 +203,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -231,7 +227,7 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector)
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
  *
- * idtentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
+ * irqentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
  * function body. KVM L1D flush request is set.
  *
  * Runs the function on the interrupt stack if the entry hit kernel mode
@@ -241,7 +237,7 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
@@ -249,7 +245,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -270,7 +266,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	bool rcu_exit = idtentry_enter_cond_rcu(regs);			\
+	irqentry_state_t state = irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
@@ -278,7 +274,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	idtentry_exit_cond_rcu(regs, rcu_exit);				\
+	irqentry_exit(regs, state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 255b2dde2c1b..40aa69d04862 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -209,6 +209,11 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
 	regs->sp = val;
 }
 
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
+{
+	return !(regs->flags & X86_EFLAGS_IF);
+}
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 33d3c88a7225..6fd8410a3910 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -35,7 +35,6 @@ typedef sigset_t compat_sigset_t;
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
-extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..267701ae3d86 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -133,11 +133,6 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/* Work to do before invoking the actual syscall. */
-#define _TIF_WORK_SYSCALL_ENTRY	\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
-
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff74a49..069e77c0a360 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1044,7 +1044,7 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
-int noinstr poke_int3_handler(struct pt_regs *regs)
+noinstr int poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 14e4b4d17ee5..97ff8313544f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1212,7 +1212,7 @@ static void kill_me_maybe(struct callback_head *cb)
  * backing the user stack, tracing that reads the user stack will cause
  * potentially infinite recursion.
  */
-void noinstr do_machine_check(struct pt_regs *regs)
+noinstr void do_machine_check(struct pt_regs *regs)
 {
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
@@ -1927,11 +1927,11 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df63786e7bfa..233c77d056c9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
 	u32 reason = kvm_read_and_reset_apf_flags();
-	bool rcu_exit;
+	irqentry_state_t state;
 
 	switch (reason) {
 	case KVM_PV_REASON_PAGE_NOT_PRESENT:
@@ -243,7 +243,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		return false;
 	}
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -264,7 +264,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	}
 
 	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	irqentry_exit(regs, state);
 	return true;
 }
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index d7c5e44b26f7..4fc9954a9560 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -330,7 +330,6 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	__this_cpu_write(last_nmi_rip, regs->ip);
 
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
@@ -417,8 +416,6 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 		unknown_nmi_error(reason, regs);
 
 out:
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
 }
 
@@ -478,6 +475,8 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
+	bool irq_state;
+
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
@@ -491,14 +490,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 399f97abee02..d5fa494c2304 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
 #include <linux/context_tracking.h>
+#include <linux/entry-common.h>
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
@@ -803,7 +804,7 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void do_signal(struct pt_regs *regs)
+void arch_do_signal(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b7cb3e0716f7..438fc554d48d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -245,7 +245,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
-	bool rcu_exit;
+	irqentry_state_t state;
 
 	/*
 	 * We use UD2 as a short encoding for 'CALL __WARN', as such
@@ -255,11 +255,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = irqentry_enter(regs);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	irqentry_exit(regs, state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
@@ -405,7 +405,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	nmi_enter();
+	idtentry_enter_nmi(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -638,28 +638,25 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
-	 * can trigger INT3, hence poke_int3_handler() must be done
-	 * before. If the entry came from kernel mode, then use nmi_enter()
-	 * because the INT3 could have been hit in any context including
-	 * NMI.
+	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
+	 * and therefore can trigger INT3, hence poke_int3_handler() must
+	 * be done before. If the entry came from kernel mode, then use
+	 * nmi_enter() because the INT3 could have been hit in any context
+	 * including NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter_user(regs);
+		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit_user(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else {
-		nmi_enter();
+		bool irq_state = idtentry_enter_nmi(regs);
 		instrumentation_begin();
-		trace_hardirqs_off_finish();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
 		instrumentation_end();
-		nmi_exit();
+		idtentry_exit_nmi(regs, irq_state);
 	}
 }
 
@@ -867,9 +864,8 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
 static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 					     unsigned long dr6)
 {
-	nmi_enter();
+	bool irq_state = idtentry_enter_nmi(regs);
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
 
 	/*
 	 * If something gets miswired and we end up here for a user mode
@@ -886,10 +882,8 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 
 	handle_debug(regs, dr6, false);
 
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_debug_user(struct pt_regs *regs,
@@ -901,12 +895,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
+
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index b277a2db6267..fbd5bd7a945a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -42,6 +42,7 @@ config KVM
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_NO_POLL
+	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	select SRCU
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 13745f2a5ecd..9909375ee1fd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
+#include <linux/entry-kvm.h>
 
 #include <asm/apic.h>
 #include <asm/asm.h>
@@ -5373,14 +5374,12 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 		}
 
 		/*
-		 * Note, return 1 and not 0, vcpu_run() is responsible for
-		 * morphing the pending signal into the proper return code.
+		 * Note, return 1 and not 0, vcpu_run() will invoke
+		 * xfer_to_guest_mode() which will create a proper return
+		 * code.
 		 */
-		if (signal_pending(current))
+		if (__xfer_to_guest_mode_work_pending())
 			return 1;
-
-		if (need_resched())
-			schedule();
 	}
 
 	return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 88c593f83b28..532597265c50 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -56,6 +56,7 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
+#include <linux/entry-kvm.h>
 
 #include <trace/events/kvm.h>
 
@@ -1587,7 +1588,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
 	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
-		need_resched() || signal_pending(current);
+		xfer_to_guest_mode_work_pending();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
 
@@ -8681,15 +8682,11 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 			break;
 		}
 
-		if (signal_pending(current)) {
-			r = -EINTR;
-			vcpu->run->exit_reason = KVM_EXIT_INTR;
-			++vcpu->stat.signal_exits;
-			break;
-		}
-		if (need_resched()) {
+		if (__xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-			cond_resched();
+			r = xfer_to_guest_mode_handle_work(vcpu);
+			if (r)
+				return r;
 			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ead568c0101..5e5edd2ec893 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1377,7 +1377,7 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
 	unsigned long address = read_cr2();
-	bool rcu_exit;
+	irqentry_state_t state;
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1412,11 +1412,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	rcu_exit = idtentry_enter_cond_rcu(regs);
+	state = irqentry_enter(regs);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	idtentry_exit_cond_rcu(regs, rcu_exit);
+	irqentry_exit(regs, state);
 }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
new file mode 100644
index 000000000000..efebbffcd5cc
--- /dev/null
+++ b/include/linux/entry-common.h
@@ -0,0 +1,372 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_ENTRYCOMMON_H
+#define __LINUX_ENTRYCOMMON_H
+
+#include <linux/tracehook.h>
+#include <linux/syscalls.h>
+#include <linux/seccomp.h>
+#include <linux/sched.h>
+
+#include <asm/entry-common.h>
+
+/*
+ * Define dummy _TIF work flags if not defined by the architecture or for
+ * disabled functionality.
+ */
+#ifndef _TIF_SYSCALL_EMU
+# define _TIF_SYSCALL_EMU		(0)
+#endif
+
+#ifndef _TIF_SYSCALL_TRACEPOINT
+# define _TIF_SYSCALL_TRACEPOINT	(0)
+#endif
+
+#ifndef _TIF_SECCOMP
+# define _TIF_SECCOMP			(0)
+#endif
+
+#ifndef _TIF_SYSCALL_AUDIT
+# define _TIF_SYSCALL_AUDIT		(0)
+#endif
+
+#ifndef _TIF_PATCH_PENDING
+# define _TIF_PATCH_PENDING		(0)
+#endif
+
+#ifndef _TIF_UPROBE
+# define _TIF_UPROBE			(0)
+#endif
+
+/*
+ * TIF flags handled in syscall_enter_from_usermode()
+ */
+#ifndef ARCH_SYSCALL_ENTER_WORK
+# define ARCH_SYSCALL_ENTER_WORK	(0)
+#endif
+
+#define SYSCALL_ENTER_WORK						\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
+	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
+	 ARCH_SYSCALL_ENTER_WORK)
+
+/*
+ * TIF flags handled in syscall_exit_to_user_mode()
+ */
+#ifndef ARCH_SYSCALL_EXIT_WORK
+# define ARCH_SYSCALL_EXIT_WORK		(0)
+#endif
+
+#define SYSCALL_EXIT_WORK						\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
+	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
+
+/*
+ * TIF flags handled in exit_to_user_mode_loop()
+ */
+#ifndef ARCH_EXIT_TO_USER_MODE_WORK
+# define ARCH_EXIT_TO_USER_MODE_WORK		(0)
+#endif
+
+#define EXIT_TO_USER_MODE_WORK						\
+	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
+	 ARCH_EXIT_TO_USER_MODE_WORK)
+
+/**
+ * arch_check_user_regs - Architecture specific sanity check for user mode regs
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Defaults to an empty implementation. Can be replaced by architecture
+ * specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
+ * section. Use __always_inline so the compiler cannot push it out of line
+ * and make it instrumentable.
+ */
+static __always_inline void arch_check_user_regs(struct pt_regs *regs);
+
+#ifndef arch_check_user_regs
+static __always_inline void arch_check_user_regs(struct pt_regs *regs) {}
+#endif
+
+/**
+ * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Returns: 0 on success or an error code to skip the syscall.
+ *
+ * Defaults to tracehook_report_syscall_entry(). Can be replaced by
+ * architecture specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode()
+ */
+static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs);
+
+#ifndef arch_syscall_enter_tracehook
+static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
+{
+	return tracehook_report_syscall_entry(regs);
+}
+#endif
+
+/**
+ * syscall_enter_from_user_mode - Check and handle work before invoking
+ *				 a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and the subsequent functions can be
+ * instrumented.
+ *
+ * Returns: The original or a modified syscall number
+ *
+ * If the returned syscall number is -1 then the syscall should be
+ * skipped. In this case the caller may invoke syscall_set_error() or
+ * syscall_set_return_value() first.  If neither of those are called and -1
+ * is returned, then the syscall will fail with ENOSYS.
+ *
+ * The following functionality is handled here:
+ *
+ *  1) Establish state (lockdep, RCU (context tracking), tracing)
+ *  2) TIF flag dependent invocations of arch_syscall_enter_tracehook(),
+ *     __secure_computing(), trace_sys_enter()
+ *  3) Invocation of audit_syscall_entry()
+ */
+long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+
+/**
+ * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Defaults to local_irq_enable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
+
+#ifndef local_irq_enable_exit_to_user
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+{
+	local_irq_enable();
+}
+#endif
+
+/**
+ * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disable()
+ *
+ * Defaults to local_irq_disable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_disable_exit_to_user(void);
+
+#ifndef local_irq_disable_exit_to_user
+static inline void local_irq_disable_exit_to_user(void)
+{
+	local_irq_disable();
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
+ *				 to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_loop() with interrupt enabled
+ *
+ * Defaults to NOOP. Can be supplied by architecture specific code.
+ */
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_work
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_prepare - Architecture specific preparation for
+ *				    exit to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_prepare() with interrupt disabled as the last
+ * function before return. Defaults to NOOP.
+ */
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_prepare
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode - Architecture specific final work before
+ *			    exit to user mode.
+ *
+ * Invoked from exit_to_user_mode() with interrupt disabled as the last
+ * function before return. Defaults to NOOP.
+ *
+ * This needs to be __always_inline because it is non-instrumentable code
+ * invoked after context tracking switched to user mode.
+ *
+ * An architecture implementation must not do anything complex, no locking
+ * etc. The main purpose is for speculation mitigations.
+ */
+static __always_inline void arch_exit_to_user_mode(void);
+
+#ifndef arch_exit_to_user_mode
+static __always_inline void arch_exit_to_user_mode(void) { }
+#endif
+
+/**
+ * arch_do_signal -  Architecture specific signal delivery function
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from exit_to_user_mode_loop().
+ */
+void arch_do_signal(struct pt_regs *regs);
+
+/**
+ * arch_syscall_exit_tracehook - Wrapper around tracehook_report_syscall_exit()
+ * @regs:	Pointer to currents pt_regs
+ * @step:	Indicator for single step
+ *
+ * Defaults to tracehook_report_syscall_exit(). Can be replaced by
+ * architecture specific code.
+ *
+ * Invoked from syscall_exit_to_user_mode()
+ */
+static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step);
+
+#ifndef arch_syscall_exit_tracehook
+static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
+{
+	tracehook_report_syscall_exit(regs, step);
+}
+#endif
+
+/**
+ * syscall_exit_to_user_mode - Handle work before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked with interrupts enabled and fully valid regs. Returns with all
+ * work handled, interrupts disabled such that the caller can immediately
+ * switch to user mode. Called from architecture specific syscall and ret
+ * from fork code.
+ *
+ * The call order is:
+ *  1) One-time syscall exit work:
+ *	- rseq syscall exit
+ *      - audit
+ *	- syscall tracing
+ *	- tracehook (single stepping)
+ *
+ *  2) Preparatory work
+ *	- Exit to user mode loop (common TIF handling). Invokes
+ *	  arch_exit_to_user_mode_work() for architecture specific TIF work
+ *	- Architecture specific one time work arch_exit_to_user_mode_prepare()
+ *	- Address limit and lockdep checks
+ *
+ *  3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
+ *     arch_exit_to_user_mode() to handle e.g. speculation mitigations
+ */
+void syscall_exit_to_user_mode(struct pt_regs *regs);
+
+/**
+ * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific entry code with interrupts disabled.
+ * Can only be called when the interrupt entry came from user mode. The
+ * calling code must be non-instrumentable.  When the function returns all
+ * state is correct and the subsequent functions can be instrumented.
+ *
+ * The function establishes state (lockdep, RCU (context tracking), tracing)
+ */
+void irqentry_enter_from_user_mode(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_to_user_mode - Interrupt exit work
+ * @regs:	Pointer to current's pt_regs
+ *
+ * Invoked with interrupts disbled and fully valid regs. Returns with all
+ * work handled, interrupts disabled such that the caller can immediately
+ * switch to user mode. Called from architecture specific interrupt
+ * handling code.
+ *
+ * The call order is #2 and #3 as described in syscall_exit_to_user_mode().
+ * Interrupt exit is not invoking #1 which is the syscall specific one time
+ * work.
+ */
+void irqentry_exit_to_user_mode(struct pt_regs *regs);
+
+#ifndef irqentry_state
+typedef struct irqentry_state {
+	bool	exit_rcu;
+} irqentry_state_t;
+#endif
+
+/**
+ * irqentry_enter - Handle state tracking on ordinary interrupt entries
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
+ * invoked on entry and rcu_irq_exit() on exit.
+ *
+ * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking rcu_irq_enter() without undoing it.
+ *
+ * For user mode entries irqentry_enter_from_user_mode() is invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: An opaque object that must be passed to idtentry_exit()
+ */
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ *
+ * Conditional reschedule with additional sanity checks.
+ */
+void irqentry_exit_cond_resched(void);
+
+/**
+ * irqentry_exit - Handle return from exception that used irqentry_enter()
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @state:	Return value from matching call to irqentry_enter()
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and reguired and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to irqentry_enter().
+ */
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+
+#endif
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
new file mode 100644
index 000000000000..0cef17afb41a
--- /dev/null
+++ b/include/linux/entry-kvm.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_ENTRYKVM_H
+#define __LINUX_ENTRYKVM_H
+
+#include <linux/entry-common.h>
+
+/* Transfer to guest mode work */
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+
+#ifndef ARCH_XFER_TO_GUEST_MODE_WORK
+# define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
+#endif
+
+#define XFER_TO_GUEST_MODE_WORK					\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+
+struct kvm_vcpu;
+
+/**
+ * arch_xfer_to_guest_mode_handle_work - Architecture specific xfer to guest
+ *					 mode work handling function.
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in xfer_to_guest_mode_handle_work()
+ *
+ * Invoked from xfer_to_guest_mode_handle_work(). Defaults to NOOP. Can be
+ * replaced by architecture specific code.
+ */
+static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
+						      unsigned long ti_work);
+
+#ifndef arch_xfer_to_guest_mode_work
+static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
+						      unsigned long ti_work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * xfer_to_guest_mode_handle_work - Check and handle pending work which needs
+ *				    to be handled before going to guest mode
+ * @vcpu:	Pointer to current's VCPU data
+ *
+ * Returns: 0 or an error code
+ */
+int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
+
+/**
+ * __xfer_to_guest_mode_work_pending - Check if work is pending
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Bare variant of xfer_to_guest_mode_work_pending(). Can be called from
+ * interrupt enabled code for racy quick checks with care.
+ */
+static inline bool __xfer_to_guest_mode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
+}
+
+/**
+ * xfer_to_guest_mode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Has to be invoked with interrupts disabled before the transition to
+ * guest mode.
+ */
+static inline bool xfer_to_guest_mode_work_pending(void)
+{
+	lockdep_assert_irqs_disabled();
+	return __xfer_to_guest_mode_work_pending();
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
+#endif
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 03c9fece7d43..754f67ac4326 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -111,32 +111,42 @@ extern void rcu_nmi_exit(void);
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
-#define nmi_enter()						\
+#define __nmi_enter()						\
 	do {							\
+		lockdep_off();					\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
-		lockdep_off();					\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		rcu_nmi_enter();				\
+	} while (0)
+
+#define nmi_enter()						\
+	do {							\
+		__nmi_enter();					\
 		lockdep_hardirq_enter();			\
+		rcu_nmi_enter();				\
 		instrumentation_begin();			\
 		ftrace_nmi_enter();				\
 		instrumentation_end();				\
 	} while (0)
 
+#define __nmi_exit()						\
+	do {							\
+		BUG_ON(!in_nmi());				\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		printk_nmi_exit();				\
+		arch_nmi_exit();				\
+		lockdep_on();					\
+	} while (0)
+
 #define nmi_exit()						\
 	do {							\
 		instrumentation_begin();			\
 		ftrace_nmi_exit();				\
 		instrumentation_end();				\
-		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
-		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		lockdep_on();					\
-		printk_nmi_exit();				\
-		arch_nmi_exit();				\
+		lockdep_hardirq_exit();				\
+		__nmi_exit();					\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d564855243d8..ac83e9c1d82c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1439,4 +1439,12 @@ int kvm_vm_create_worker_thread(struct kvm *kvm, kvm_vm_thread_fn_t thread_fn,
 				uintptr_t data, const char *name,
 				struct task_struct **thread_ptr);
 
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_INTR;
+	vcpu->stat.signal_exits++;
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
 #endif
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c98a4b0..3b73cf84f77d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -10,181 +10,20 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#include <linux/lockdep_types.h>
+
 struct task_struct;
-struct lockdep_map;
 
 /* for sysctl */
 extern int prove_locking;
 extern int lock_stat;
 
-#define MAX_LOCKDEP_SUBCLASSES		8UL
-
-#include <linux/types.h>
-
-enum lockdep_wait_type {
-	LD_WAIT_INV = 0,	/* not checked, catch all */
-
-	LD_WAIT_FREE,		/* wait free, rcu etc.. */
-	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
-
-#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
-	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
-#else
-	LD_WAIT_CONFIG = LD_WAIT_SPIN,
-#endif
-	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
-
-	LD_WAIT_MAX,		/* must be last */
-};
-
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
-#include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
-/*
- * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
- * the total number of states... :-(
- */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
-
-/*
- * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
- * cached in the instance of lockdep_map
- *
- * Currently main class (subclass == 0) and signle depth subclass
- * are cached in lockdep_map. This optimization is mainly targeting
- * on rq->lock. double_rq_lock() acquires this highly competitive with
- * single depth.
- */
-#define NR_LOCKDEP_CACHING_CLASSES	2
-
-/*
- * A lockdep key is associated with each lock object. For static locks we use
- * the lock address itself as the key. Dynamically allocated lock objects can
- * have a statically or dynamically allocated key. Dynamically allocated lock
- * keys must be registered before being used and must be unregistered before
- * the key memory is freed.
- */
-struct lockdep_subclass_key {
-	char __one_byte;
-} __attribute__ ((__packed__));
-
-/* hash_entry is used to keep track of dynamically allocated keys. */
-struct lock_class_key {
-	union {
-		struct hlist_node		hash_entry;
-		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
-	};
-};
-
-extern struct lock_class_key __lockdep_no_validate__;
-
-struct lock_trace;
-
-#define LOCKSTAT_POINTS		4
-
-/*
- * The lock-class itself. The order of the structure members matters.
- * reinit_class() zeroes the key member and all subsequent members.
- */
-struct lock_class {
-	/*
-	 * class-hash:
-	 */
-	struct hlist_node		hash_entry;
-
-	/*
-	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
-	 * when not in use. Instances that are being freed are on one of the
-	 * zapped_classes lists.
-	 */
-	struct list_head		lock_entry;
-
-	/*
-	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
-	 */
-	struct list_head		locks_after, locks_before;
-
-	const struct lockdep_subclass_key *key;
-	unsigned int			subclass;
-	unsigned int			dep_gen_id;
-
-	/*
-	 * IRQ/softirq usage tracking bits:
-	 */
-	unsigned long			usage_mask;
-	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
-
-	/*
-	 * Generation counter, when doing certain classes of graph walking,
-	 * to ensure that we check one node only once:
-	 */
-	int				name_version;
-	const char			*name;
-
-	short				wait_type_inner;
-	short				wait_type_outer;
-
-#ifdef CONFIG_LOCK_STAT
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-#endif
-} __no_randomize_layout;
-
-#ifdef CONFIG_LOCK_STAT
-struct lock_time {
-	s64				min;
-	s64				max;
-	s64				total;
-	unsigned long			nr;
-};
-
-enum bounce_type {
-	bounce_acquired_write,
-	bounce_acquired_read,
-	bounce_contended_write,
-	bounce_contended_read,
-	nr_bounce_types,
-
-	bounce_acquired = bounce_acquired_write,
-	bounce_contended = bounce_contended_write,
-};
-
-struct lock_class_stats {
-	unsigned long			contention_point[LOCKSTAT_POINTS];
-	unsigned long			contending_point[LOCKSTAT_POINTS];
-	struct lock_time		read_waittime;
-	struct lock_time		write_waittime;
-	struct lock_time		read_holdtime;
-	struct lock_time		write_holdtime;
-	unsigned long			bounces[nr_bounce_types];
-};
-
-struct lock_class_stats lock_stats(struct lock_class *class);
-void clear_lock_stats(struct lock_class *class);
-#endif
-
-/*
- * Map the lock object (the lock instance) to the lock-class object.
- * This is embedded into specific lock instances:
- */
-struct lockdep_map {
-	struct lock_class_key		*key;
-	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
-	const char			*name;
-	short				wait_type_outer; /* can be taken in this context */
-	short				wait_type_inner; /* presents this context */
-#ifdef CONFIG_LOCK_STAT
-	int				cpu;
-	unsigned long			ip;
-#endif
-};
-
 static inline void lockdep_copy_map(struct lockdep_map *to,
 				    struct lockdep_map *from)
 {
@@ -440,8 +279,6 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 extern void lock_downgrade(struct lockdep_map *lock, unsigned long ip);
 
-struct pin_cookie { unsigned int val; };
-
 #define NIL_COOKIE (struct pin_cookie){ .val = 0U, }
 
 extern struct pin_cookie lock_pin_lock(struct lockdep_map *lock);
@@ -520,10 +357,6 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)
 # define lockdep_sys_exit() 			do { } while (0)
-/*
- * The class key takes no space if lockdep is disabled:
- */
-struct lock_class_key { };
 
 static inline void lockdep_register_key(struct lock_class_key *key)
 {
@@ -533,11 +366,6 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 {
 }
 
-/*
- * The lockdep_map takes no space if lockdep is disabled:
- */
-struct lockdep_map { };
-
 #define lockdep_depth(tsk)	(0)
 
 #define lockdep_is_held_type(l, r)		(1)
@@ -549,8 +377,6 @@ struct lockdep_map { };
 
 #define lockdep_recursing(tsk)			(0)
 
-struct pin_cookie { };
-
 #define NIL_COOKIE (struct pin_cookie){ }
 
 #define lockdep_pin_lock(l)			({ struct pin_cookie cookie = { }; cookie; })
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
new file mode 100644
index 000000000000..7b9350624577
--- /dev/null
+++ b/include/linux/lockdep_types.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Runtime locking correctness validator
+ *
+ *  Copyright (C) 2006,2007 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
+ *
+ * see Documentation/locking/lockdep-design.rst for more details.
+ */
+#ifndef __LINUX_LOCKDEP_TYPES_H
+#define __LINUX_LOCKDEP_TYPES_H
+
+#include <linux/types.h>
+
+#define MAX_LOCKDEP_SUBCLASSES		8UL
+
+enum lockdep_wait_type {
+	LD_WAIT_INV = 0,	/* not checked, catch all */
+
+	LD_WAIT_FREE,		/* wait free, rcu etc.. */
+	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
+
+#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
+#else
+	LD_WAIT_CONFIG = LD_WAIT_SPIN,
+#endif
+	LD_WAIT_SLEEP,		/* sleeping locks, mutex_t etc.. */
+
+	LD_WAIT_MAX,		/* must be last */
+};
+
+#ifdef CONFIG_LOCKDEP
+
+#include <linux/list.h>
+
+/*
+ * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
+ * the total number of states... :-(
+ */
+#define XXX_LOCK_USAGE_STATES		(1+2*4)
+
+/*
+ * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
+ * cached in the instance of lockdep_map
+ *
+ * Currently main class (subclass == 0) and signle depth subclass
+ * are cached in lockdep_map. This optimization is mainly targeting
+ * on rq->lock. double_rq_lock() acquires this highly competitive with
+ * single depth.
+ */
+#define NR_LOCKDEP_CACHING_CLASSES	2
+
+/*
+ * A lockdep key is associated with each lock object. For static locks we use
+ * the lock address itself as the key. Dynamically allocated lock objects can
+ * have a statically or dynamically allocated key. Dynamically allocated lock
+ * keys must be registered before being used and must be unregistered before
+ * the key memory is freed.
+ */
+struct lockdep_subclass_key {
+	char __one_byte;
+} __attribute__ ((__packed__));
+
+/* hash_entry is used to keep track of dynamically allocated keys. */
+struct lock_class_key {
+	union {
+		struct hlist_node		hash_entry;
+		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
+	};
+};
+
+extern struct lock_class_key __lockdep_no_validate__;
+
+struct lock_trace;
+
+#define LOCKSTAT_POINTS		4
+
+/*
+ * The lock-class itself. The order of the structure members matters.
+ * reinit_class() zeroes the key member and all subsequent members.
+ */
+struct lock_class {
+	/*
+	 * class-hash:
+	 */
+	struct hlist_node		hash_entry;
+
+	/*
+	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
+	 * when not in use. Instances that are being freed are on one of the
+	 * zapped_classes lists.
+	 */
+	struct list_head		lock_entry;
+
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
+	const struct lockdep_subclass_key *key;
+	unsigned int			subclass;
+	unsigned int			dep_gen_id;
+
+	/*
+	 * IRQ/softirq usage tracking bits:
+	 */
+	unsigned long			usage_mask;
+	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
+
+	/*
+	 * Generation counter, when doing certain classes of graph walking,
+	 * to ensure that we check one node only once:
+	 */
+	int				name_version;
+	const char			*name;
+
+	short				wait_type_inner;
+	short				wait_type_outer;
+
+#ifdef CONFIG_LOCK_STAT
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+#endif
+} __no_randomize_layout;
+
+#ifdef CONFIG_LOCK_STAT
+struct lock_time {
+	s64				min;
+	s64				max;
+	s64				total;
+	unsigned long			nr;
+};
+
+enum bounce_type {
+	bounce_acquired_write,
+	bounce_acquired_read,
+	bounce_contended_write,
+	bounce_contended_read,
+	nr_bounce_types,
+
+	bounce_acquired = bounce_acquired_write,
+	bounce_contended = bounce_contended_write,
+};
+
+struct lock_class_stats {
+	unsigned long			contention_point[LOCKSTAT_POINTS];
+	unsigned long			contending_point[LOCKSTAT_POINTS];
+	struct lock_time		read_waittime;
+	struct lock_time		write_waittime;
+	struct lock_time		read_holdtime;
+	struct lock_time		write_holdtime;
+	unsigned long			bounces[nr_bounce_types];
+};
+
+struct lock_class_stats lock_stats(struct lock_class *class);
+void clear_lock_stats(struct lock_class *class);
+#endif
+
+/*
+ * Map the lock object (the lock instance) to the lock-class object.
+ * This is embedded into specific lock instances:
+ */
+struct lockdep_map {
+	struct lock_class_key		*key;
+	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
+	const char			*name;
+	short				wait_type_outer; /* can be taken in this context */
+	short				wait_type_inner; /* presents this context */
+#ifdef CONFIG_LOCK_STAT
+	int				cpu;
+	unsigned long			ip;
+#endif
+};
+
+struct pin_cookie { unsigned int val; };
+
+#else /* !CONFIG_LOCKDEP */
+
+/*
+ * The class key takes no space if lockdep is disabled:
+ */
+struct lock_class_key { };
+
+/*
+ * The lockdep_map takes no space if lockdep is disabled:
+ */
+struct lockdep_map { };
+
+struct pin_cookie { };
+
+#endif /* !LOCKDEP */
+
+#endif /* __LINUX_LOCKDEP_TYPES_H */
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4192369b8418..51f234b6d28f 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -58,9 +58,11 @@ static inline int seccomp_mode(struct seccomp *s)
 
 struct seccomp { };
 struct seccomp_filter { };
+struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
+static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3770b3f9d9a..f2f12d746dbd 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -56,6 +56,7 @@
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
+#include <linux/lockdep.h>
 #include <asm/barrier.h>
 #include <asm/mmiowb.h>
 
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 6102e6bff3ae..b981caafe8bf 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -15,7 +15,7 @@
 # include <linux/spinlock_types_up.h>
 #endif
 
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 typedef struct raw_spinlock {
 	arch_spinlock_t raw_lock;
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..fde2000d0d0d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
+obj-y += entry/
 
 obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
new file mode 100644
index 000000000000..34c8a3f1c735
--- /dev/null
+++ b/kernel/entry/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Prevent the noinstr section from being pestered by sanitizer and other goodies
+# as long as these things cannot be disabled per function.
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+
+CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
+CFLAGS_common.o		+= -fno-stack-protector
+
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
new file mode 100644
index 000000000000..9852e0d62d95
--- /dev/null
+++ b/kernel/entry/common.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/context_tracking.h>
+#include <linux/entry-common.h>
+#include <linux/livepatch.h>
+#include <linux/audit.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ */
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_check_user_regs(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+static long syscall_trace_enter(struct pt_regs *regs, long syscall,
+				unsigned long ti_work)
+{
+	long ret = 0;
+
+	/* Handle ptrace */
+	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
+		ret = arch_syscall_enter_tracehook(regs);
+		if (ret || (ti_work & _TIF_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (ti_work & _TIF_SECCOMP) {
+		ret = __secure_computing(NULL);
+		if (ret == -1L)
+			return ret;
+	}
+
+	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall);
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
+
+noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	unsigned long ti_work;
+
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+
+	local_irq_enable();
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (ti_work & SYSCALL_ENTER_WORK)
+		syscall = syscall_trace_enter(regs, syscall, ti_work);
+	instrumentation_end();
+
+	return syscall;
+}
+
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.
+ * 4) Tell lockdep that interrupts are enabled
+ */
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+/* Workaround to allow gradual conversion of architecture code */
+void __weak arch_do_signal(struct pt_regs *regs) { }
+
+static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+					    unsigned long ti_work)
+{
+	/*
+	 * Before returning to user space ensure that all pending work
+	 * items have been completed.
+	 */
+	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+
+		local_irq_enable_exit_to_user(ti_work);
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_UPROBE)
+			uprobe_notify_resume(regs);
+
+		if (ti_work & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
+		if (ti_work & _TIF_SIGPENDING)
+			arch_do_signal(regs);
+
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(regs);
+			rseq_handle_notify_resume(NULL, regs);
+		}
+
+		/* Architecture specific TIF work */
+		arch_exit_to_user_mode_work(regs, ti_work);
+
+		/*
+		 * Disable interrupts and reevaluate the work flags as they
+		 * might have changed while interrupts and preemption was
+		 * enabled above.
+		 */
+		local_irq_disable_exit_to_user();
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	}
+
+	/* Return the latest work state for arch_exit_to_user_mode() */
+	return ti_work;
+}
+
+static void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	lockdep_assert_irqs_disabled();
+
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that the address limit is intact and no locks are held */
+	addr_limit_user_check();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
+#ifndef _TIF_SINGLESTEP
+static inline bool report_single_step(unsigned long ti_work)
+{
+	return false;
+}
+#else
+/*
+ * If TIF_SYSCALL_EMU is set, then the only reason to report is when
+ * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_usermode().
+ */
+#define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
+
+static inline bool report_single_step(unsigned long ti_work)
+{
+	return (ti_work & SYSEMU_STEP) == _TIF_SINGLESTEP;
+}
+#endif
+
+static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
+{
+	bool step;
+
+	audit_syscall_exit(regs);
+
+	if (ti_work & _TIF_SYSCALL_TRACEPOINT)
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
+
+	step = report_single_step(ti_work);
+	if (step || ti_work & _TIF_SYSCALL_TRACE)
+		arch_syscall_exit_tracehook(regs, step);
+}
+
+/*
+ * Syscall specific exit to user mode preparation. Runs with interrupts
+ * enabled.
+ */
+static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(cached_flags & SYSCALL_EXIT_WORK))
+		syscall_exit_work(regs, cached_flags);
+}
+
+__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	syscall_exit_to_user_mode_prepare(regs);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
+
+noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+}
+
+noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
+
+noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
+{
+	irqentry_state_t ret = {
+		.exit_rcu = false,
+	};
+
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+		return ret;
+	}
+
+	/*
+	 * If this entry hit the idle task invoke rcu_irq_enter() whether
+	 * RCU is watching or not.
+	 *
+	 * Interupts can nest when the first interrupt invokes softirq
+	 * processing on return which enables interrupts.
+	 *
+	 * Scheduler ticks in the idle task can mark quiescent state and
+	 * terminate a grace period, if and only if the timer interrupt is
+	 * not nested into another interrupt.
+	 *
+	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
+	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
+	 * assume that it is the first interupt and eventually claim
+	 * quiescient state and end grace periods prematurely.
+	 *
+	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
+	 * consistent.
+	 *
+	 * TINY_RCU does not support EQS, so let the compiler eliminate
+	 * this part when enabled.
+	 */
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+		/*
+		 * If RCU is not watching then the same careful
+		 * sequence vs. lockdep and tracing is required
+		 * as in irq_enter_from_user_mode().
+		 */
+		lockdep_hardirqs_off(CALLER_ADDR0);
+		rcu_irq_enter();
+		instrumentation_begin();
+		trace_hardirqs_off_finish();
+		instrumentation_end();
+
+		ret.exit_rcu = true;
+		return ret;
+	}
+
+	/*
+	 * If RCU is watching then RCU only wants to check whether it needs
+	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
+	 * already contains a warning when RCU is not watching, so no point
+	 * in having another one here.
+	 */
+	instrumentation_begin();
+	rcu_irq_enter_check_tick();
+	/* Use the combo lockdep/tracing function */
+	trace_hardirqs_off();
+	instrumentation_end();
+
+	return ret;
+}
+
+void irqentry_exit_cond_resched(void)
+{
+	if (!preempt_count()) {
+		/* Sanity check RCU and thread stack */
+		rcu_irq_exit_check_preempt();
+		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+			WARN_ON_ONCE(!on_thread_stack());
+		if (need_resched())
+			preempt_schedule_irq();
+	}
+}
+
+noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+{
+	lockdep_assert_irqs_disabled();
+
+	/* Check whether this returns to user mode */
+	if (user_mode(regs)) {
+		irqentry_exit_to_user_mode(regs);
+	} else if (!regs_irqs_disabled(regs)) {
+		/*
+		 * If RCU was not watching on entry this needs to be done
+		 * carefully and needs the same ordering of lockdep/tracing
+		 * and RCU as the return to user mode path.
+		 */
+		if (state.exit_rcu) {
+			instrumentation_begin();
+			/* Tell the tracer that IRET will enable interrupts */
+			trace_hardirqs_on_prepare();
+			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			instrumentation_end();
+			rcu_irq_exit();
+			lockdep_hardirqs_on(CALLER_ADDR0);
+			return;
+		}
+
+		instrumentation_begin();
+		if (IS_ENABLED(CONFIG_PREEMPTION))
+			irqentry_exit_cond_resched();
+		/* Covers both tracing and lockdep */
+		trace_hardirqs_on();
+		instrumentation_end();
+	} else {
+		/*
+		 * IRQ flags state is correct already. Just tell RCU if it
+		 * was not watching on entry.
+		 */
+		if (state.exit_rcu)
+			rcu_irq_exit();
+	}
+}
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
new file mode 100644
index 000000000000..eb1a8a4c867c
--- /dev/null
+++ b/kernel/entry/kvm.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/entry-kvm.h>
+#include <linux/kvm_host.h>
+
+static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+{
+	do {
+		int ret;
+
+		if (ti_work & _TIF_SIGPENDING) {
+			kvm_handle_signal_exit(vcpu);
+			return -EINTR;
+		}
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(NULL);
+		}
+
+		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
+		if (ret)
+			return ret;
+
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	return 0;
+}
+
+int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+{
+	unsigned long ti_work;
+
+	/*
+	 * This is invoked from the outer guest loop with interrupts and
+	 * preemption enabled.
+	 *
+	 * KVM invokes xfer_to_guest_mode_work_pending() with interrupts
+	 * disabled in the inner loop before going into guest mode. No need
+	 * to disable interrupts here.
+	 */
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
+		return 0;
+
+	return xfer_to_guest_mode_work(vcpu, ti_work);
+}
+EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f67949d11e..732623c30359 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -397,8 +397,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	}
 
 	if (!kcsan_interrupt_watcher)
-		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
-		raw_local_irq_save(irq_flags);
+		local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -539,7 +538,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
-		raw_local_irq_restore(irq_flags);
+		local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f8345bae9..6b2fb1a6d8cd 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -606,10 +606,11 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		goto out;
 
 	/*
-	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
-	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a race in utilities used by
-	 * lockdep.
+	 * Because we may generate reports when we're in scheduler code, the use
+	 * of printk() could deadlock. Until such time that all printing code
+	 * called in print_report() is scheduler-safe, accept the risk, and just
+	 * get our message out. As such, also disable lockdep to hide the
+	 * warning, and avoid disabling lockdep for the rest of the kernel.
 	 */
 	lockdep_off();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4c50b9..d595623c4b34 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -395,7 +395,7 @@ void lockdep_init_task(struct task_struct *task)
 
 static __always_inline void lockdep_recursion_finish(void)
 {
-	if (WARN_ON_ONCE(--current->lockdep_recursion))
+	if (WARN_ON_ONCE((--current->lockdep_recursion) & LOCKDEP_RECURSION_MASK))
 		current->lockdep_recursion = 0;
 }
 
@@ -3646,7 +3646,16 @@ static void __trace_hardirqs_on_caller(void)
  */
 void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs do not (and cannot) track lock dependencies, nothing to do.
+	 */
+	if (unlikely(in_nmi()))
+		return;
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (unlikely(current->hardirqs_enabled)) {
@@ -3692,7 +3701,27 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs can happen in the middle of local_irq_{en,dis}able() where the
+	 * tracking state and hardware state are out of sync.
+	 *
+	 * NMIs must save lockdep_hardirqs_enabled() to restore IRQ state from,
+	 * and not rely on hardware state like normal interrupts.
+	 */
+	if (unlikely(in_nmi())) {
+		/*
+		 * Skip:
+		 *  - recursion check, because NMI can hit lockdep;
+		 *  - hardware state check, because above;
+		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
+		 */
+		goto skip_checks;
+	}
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (curr->hardirqs_enabled) {
@@ -3720,6 +3749,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
 			    current->curr_chain_key);
 
+skip_checks:
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
 	curr->hardirq_enable_ip = ip;
@@ -3735,7 +3765,15 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * Matching lockdep_hardirqs_on(), allow NMIs in the middle of lockdep;
+	 * they will restore the software state. This ensures the software
+	 * state is consistent inside NMIs as well.
+	 */
+	if (unlikely(!in_nmi() && (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)))
 		return;
 
 	/*
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index aad9284c043a..1c37ccd5d402 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
 
 config HAVE_KVM_NO_POLL
        bool
+
+config KVM_XFER_TO_GUEST_WORK
+       bool

