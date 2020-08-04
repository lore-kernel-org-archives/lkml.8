Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122222070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouY8dBaN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hv1Q8VP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgHDIaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:30:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgHDIaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:30:04 -0400
Date:   Tue, 04 Aug 2020 08:21:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596529800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lajKpia0fE54EEiqEw825AGqK1UoHyjOiiMjVSWfZIw=;
        b=ouY8dBaNtzES2PWuC9MIRMOVdQnjM2xVxcN7aygC2yMYrhrXXKRHAnWLAb8IDZi3mCs7Bw
        rzwSTVEzrAi6v+CuZjrfFCA5N1uI5FsBRpmHjltqYdj9YIhi7qmVv8DyId3Gi6W2tJocbB
        FH6/nv0nfK/tt3kEVLSNOajk3Xs22JUPZII8VnJjL6uhLy1qujnBoc7Y9nHE9FKS8Xzylt
        fEFJ/S82eZ8u6Tn0XEiXsYbjOwMuf789ZOuv/xVza74qNLYT1AUo28AMkkInAyDmjkyqUr
        JNYzq2sE8nBq37aaXm/DUQ7WXVWweU/PF4s5H+1WuXMUWk8KcT5Fa21yYWSb0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596529800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lajKpia0fE54EEiqEw825AGqK1UoHyjOiiMjVSWfZIw=;
        b=Hv1Q8VP443IxtG5sdEIZ2l3tPuLr311GNRl5akhJbVwIP5FPNRIRQ6Ty5c3LdpFBwlosf2
        PNsk9VqW9IXL5ABA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v5.9
Message-ID: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2020-08-04

up to:  3135f5b73592: entry: Correct __secure_computing() stub

Generic implementation of common syscall, interrupt and exception
entry/exit functionality based on the recent X86 effort to ensure
correctness of entry/exit vs. RCU and instrumentation.

As this functionality and the required entry/exit sequences are not
architecture specific, sharing them allows other architectures to benefit
instead of copying the same code over and over again.

This branch was kept standalone to allow others to work on it. The
conversion of x86 comes in a seperate pull request which obviously is based
on this branch.

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      entry: Correct 'noinstr' attributes

Thomas Gleixner (6):
      seccomp: Provide stub for __secure_computing()
      entry: Provide generic syscall entry functionality
      entry: Provide generic syscall exit function
      entry: Provide generic interrupt entry/exit code
      entry: Provide infrastructure for work before transitioning to guest mode
      entry: Correct __secure_computing() stub


 arch/Kconfig                 |   3 +
 include/linux/entry-common.h | 372 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/entry-kvm.h    |  80 +++++++++
 include/linux/kvm_host.h     |   8 +
 include/linux/seccomp.h      |   2 +
 kernel/Makefile              |   1 +
 kernel/entry/Makefile        |  13 ++
 kernel/entry/common.c        | 374 +++++++++++++++++++++++++++++++++++++++++++
 kernel/entry/kvm.c           |  51 ++++++
 virt/kvm/Kconfig             |   3 +
 10 files changed, 907 insertions(+)
 create mode 100644 include/linux/entry-common.h
 create mode 100644 include/linux/entry-kvm.h
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

