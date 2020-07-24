Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB28C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7496206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGCCHSh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPMtHvzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGXUMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgGXULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBFC0619D3;
        Fri, 24 Jul 2020 13:11:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JS+PRk/4LPsRInXEQ0lBk/PsE1yKwtc0u40zuF4apU=;
        b=LGCCHSh+hwnmco0b9eZm3PFAZkLCETdREYqN7Q57yFtv/vsRvlU3Ps+hzdPtpVKvUDZZov
        uPKJsWK5mHEWXbB6OuuCZxyHLrY3rtRFDYAiUX8lAd4m5RZkGgu4KJl4eCHEHTxA9cjaUN
        TTH4ZvjBsXXyRrwEWTqpArxF/nxs4P/rfu1VJJauuuxGqy9YWh7Lax4XcIW24G5A8mgl/O
        XFeHxZlgf1qF4jL1icRjtaS5CDGcdJBIp73+2Q+Z70XjWBvTp+wb8OPQTLih4ccO+kmtCS
        bTIpgEhF0OUUsRbvhF534nEtKgIugJuI+P6qAlB+s3qdDhHI474f1ib3+lXYpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JS+PRk/4LPsRInXEQ0lBk/PsE1yKwtc0u40zuF4apU=;
        b=pPMtHvzdbV6gJxhO2yFlGFv0zFwX9Kv3XLU71TnOw9G1IBGdLbDYKht6ZNjewnpN2dRsIw
        DTku7fuJ5+mTD5Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use generic syscall exit functionality
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.494648601@linutronix.de>
References: <20200722220520.494648601@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562150015.4006.13870335719139670427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     167fd210ec0555d371a20435dac7c2c7052df7ed
Gitweb:        https://git.kernel.org/tip/167fd210ec0555d371a20435dac7c2c7052df7ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:04:59 +02:00

x86/entry: Use generic syscall exit functionality

Replace the x86 variant with the generic version. Provide the relevant
architecture specific helper functions and defines.

Use a temporary define for idtentry_exit_user which will be cleaned up
seperately.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220520.494648601@linutronix.de


---
 arch/x86/entry/common.c             | 221 +---------------------------
 arch/x86/entry/entry_32.S           |   2 +-
 arch/x86/entry/entry_64.S           |   2 +-
 arch/x86/include/asm/entry-common.h |  44 +++++-
 arch/x86/include/asm/idtentry.h     |   3 +-
 arch/x86/include/asm/signal.h       |   1 +-
 arch/x86/kernel/signal.c            |   3 +-
 7 files changed, 54 insertions(+), 222 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index d2fe85f..bc96eb8 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -15,15 +15,8 @@
 #include <linux/smp.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
-#include <linux/audit.h>
-#include <linux/signal.h>
 #include <linux/export.h>
-#include <linux/context_tracking.h>
-#include <linux/user-return-notifier.h>
 #include <linux/nospec.h>
-#include <linux/uprobes.h>
-#include <linux/livepatch.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
@@ -42,191 +35,6 @@
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
 
-#include <trace/events/syscalls.h>
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
-#define EXIT_TO_USERMODE_LOOP_FLAGS				\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
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
-	if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-		fire_user_return_notifiers();
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
@@ -245,7 +53,7 @@ __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 #endif
 	}
 	instrumentation_end();
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 }
 #endif
 
@@ -284,7 +92,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 	unsigned int nr = syscall_32_enter(regs);
 
 	do_syscall_32_irqs_on(regs, nr);
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 }
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
@@ -310,13 +118,13 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		syscall_return_slowpath(regs);
+		syscall_exit_to_user_mode(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
-	syscall_return_slowpath(regs);
+	syscall_exit_to_user_mode(regs);
 	return true;
 }
 
@@ -524,7 +332,7 @@ void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
 
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
-		prepare_exit_to_usermode(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else if (regs->flags & X86_EFLAGS_IF) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
@@ -555,25 +363,6 @@ void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
 	}
 }
 
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
-
-	prepare_exit_to_usermode(regs);
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2d0bd5d..6addbd1 100644
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
index d2a00c9..f423ca9 100644
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
index 7070b90..a8f9315 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,6 +2,12 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
+#include <linux/user-return-notifier.h>
+
+#include <asm/nospec-branch.h>
+#include <asm/io_bitmap.h>
+#include <asm/fpu/api.h>
+
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 {
@@ -29,4 +35,42 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 }
 #define arch_check_user_regs arch_check_user_regs
 
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
 #endif
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 449910f..f7d48ea 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,8 +13,7 @@
 
 /* Temporary define */
 #define idtentry_enter_user	irqentry_enter_from_user_mode
-
-void idtentry_exit_user(struct pt_regs *regs);
+#define idtentry_exit_user	irqentry_exit_to_user_mode
 
 typedef struct idtentry_state {
 	bool exit_rcu;
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 33d3c88..6fd8410 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -35,7 +35,6 @@ typedef sigset_t compat_sigset_t;
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
-extern void do_signal(struct pt_regs *regs);
 
 #define __ARCH_HAS_SA_RESTORER
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 399f97a..d5fa494 100644
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
 
