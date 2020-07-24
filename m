Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECAC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816FC20771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVZBypqh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaMfQeV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGXTJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:09:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXTJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:09:00 -0400
Date:   Fri, 24 Jul 2020 19:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wj8AtmuPyKN4qkVmEcphhbVqNaBzn8jpW/sa8WGQnx0=;
        b=eVZBypqh/jC0iqZaYVzPFdT4I5dH2RoJs8UEOzIILb5+mNo9ub8m8s43IlmBwA5mMoXkvw
        L0T6+YstToFfedcWgp9OQKmBwoT2fqxZ0KLOM0YL0Nf5Ho8+49+AzbZT0pmKYdzmfm6k3d
        1jW5usCILAc8zPPN7sofijlBpg6JY/2EVWE67Fq7OcQNYxOecWM9+wBf/3tt8HklKVRoeu
        P/ORzGIDO3ot2tm/uoNVABNe7D3UXEVA2wzoEtpKWFcQWPMGsV2VEM7zyk6E2eMyi1CL0q
        h1eOBmTZEj/X5z1B7DnaZB7ELxo90RDNfNkkFJbvwleb/ZLo4RkjiH9LuxS5Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617736;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wj8AtmuPyKN4qkVmEcphhbVqNaBzn8jpW/sa8WGQnx0=;
        b=RaMfQeV/HxmiSsnpsRWrX9KN7STo4+Z1DqN9bltdivt2a+nIf2dTxtoUyJXsnA+0RT4M5A
        ZtceOqw/Z1TjldCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Provide generic syscall exit function
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.613977173@linutronix.de>
References: <20200722220519.613977173@linutronix.de>
MIME-Version: 1.0
Message-ID: <159561773570.4006.4039127200218460277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a9f3a74a29af095f3e1b89e9176f8127912ae0f0
Gitweb:        https://git.kernel.org/tip/a9f3a74a29af095f3e1b89e9176f8127912ae0f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 23:59:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 14:59:03 +02:00

entry: Provide generic syscall exit function

Like syscall entry all architectures have similar and pointlessly different
code to handle pending work before returning from a syscall to user space.

  1) One-time syscall exit work:
      - rseq syscall exit
      - audit
      - syscall tracing
      - tracehook (single stepping)

  2) Preparatory work
      - Exit to user mode loop (common TIF handling).
      - Architecture specific one time work arch_exit_to_user_mode_prepare()
      - Address limit and lockdep checks
     
  3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
     arch_exit_to_user_mode() to handle e.g. speculation mitigations

Provide a generic version based on the x86 code which has all the RCU and
instrumentation protections right.

Provide a variant for interrupt return to user mode as well which shares
the above #2 and #3 work items.

After syscall_exit_to_user_mode() and irqentry_exit_to_user_mode() the
architecture code just has to return to user space. The code after
returning from these functions must not be instrumented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220519.613977173@linutronix.de


---
 include/linux/entry-common.h | 189 ++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 169 ++++++++++++++++++++++++++++++-
 2 files changed, 358 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 42fc8e4..c4a57be 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -29,6 +29,14 @@
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
 
+#ifndef _TIF_PATCH_PENDING
+# define _TIF_PATCH_PENDING		(0)
+#endif
+
+#ifndef _TIF_UPROBE
+# define _TIF_UPROBE			(0)
+#endif
+
 /*
  * TIF flags handled in syscall_enter_from_usermode()
  */
@@ -41,6 +49,29 @@
 	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
 	 ARCH_SYSCALL_ENTER_WORK)
 
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
 /**
  * arch_check_user_regs - Architecture specific sanity check for user mode regs
  * @regs:	Pointer to currents pt_regs
@@ -106,6 +137,149 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
 
 /**
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
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
  * @regs:	Pointer to currents pt_regs
  *
@@ -118,4 +292,19 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
  */
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 
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
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1d636de..0a051bb 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,8 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/livepatch.h>
+#include <linux/audit.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -82,7 +84,174 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 	return syscall;
 }
 
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
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 }
+
+noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
