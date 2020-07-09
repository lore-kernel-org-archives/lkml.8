Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7496920674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgGIEiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIEiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:38:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96554C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:38:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D82172A21F0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] kernel: Implement selective syscall userspace redirection
Date:   Thu,  9 Jul 2020 00:38:40 -0400
Message-Id: <20200709043840.4189530-1-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a mechanism to quickly disable/enable syscall handling for a
specific process and redirect to userspace via SIGSYS.  This is useful
for processes with parts that require syscall redirection and parts that
don't, but who need to perform this boundary crossing really fast,
without paying the cost of a system call to reconfigure syscall handling
on each boundary transition.  This is particularly important for Windows
games running over Wine.

The proposed interface looks like this:

  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <dispatcher>, [selector])

Dispatcher is the address of a syscall instruction that is allowed to
by-pass the blockage, such that in fast paths you don't need to disable
the trap nor check the selector.  This is essential to return from
SIGSYS to a blocked area without triggering another SIGSYS from the
rt_sigreturn.

selector is an optional pointer to an aligned int-sized userspace memory
region that has a key switch for the mechanism. This key switch can be
PR_SYSCALL_DISPATCH_ENABLE, PR_SYSCALL_DISPATCH_DISABLE.

The feature is meant to be set per-thread and it is disabled on
fork/clone/execv.

Internally, this doesn't add overhead to the syscall hot path, and it
requires very little per-architecture support.  I avoided using seccomp,
even though it duplicates some functionality, due to previous feedback
that maybe it shouldn't mix with seccomp since it is not a security
mechanism.  And obviously, this should never be considered a security
mechanism, since any part of the program can by-pass it by using the
syscall dispatcher.

For the sysinfo benchmark, which measures the overhead added to
executing a native syscall that doesn't require interception, the
overhead using only dispatcher to issue syscalls is pretty much
irrelevant.  The overhead of selector goes around 40ns for a
native (untrapped) syscall in my system, and it is (as expected)
dominated by the supervisor-mode user-address access.  In fact, with
SMAP off, the overhead is consistently less than 5ns on my test box.

Right now, it is only supported by x86_64 and x86, but it should be
easily enabled for other architectures.

An example code using this interface can be found at:
  https://gitlab.collabora.com/krisman/syscall-disable-personality

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Paul Gofman <gofmanp@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
Changes since RFC:
  (Kees Cook suggestions)
  - Don't mention personality while explaining the feature
  - Use syscall_get_nr
  - Remove header guard on several places
  - Convert WARN_ON to WARN_ON_ONCE
  - Explicit check for state values
  - Rename to syscall user dispatcher

RFC/v1: https://lkml.org/lkml/2020/7/8/96

 arch/Kconfig                          | 20 ++++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/common.c               |  5 ++
 arch/x86/include/asm/thread_info.h    |  4 +-
 fs/exec.c                             |  2 +
 include/linux/sched.h                 |  3 +
 include/linux/syscall_user_dispatch.h | 45 ++++++++++++++
 include/uapi/asm-generic/siginfo.h    |  1 +
 include/uapi/linux/prctl.h            |  4 ++
 kernel/Makefile                       |  1 +
 kernel/fork.c                         |  1 +
 kernel/sys.c                          |  8 +++
 kernel/syscall_user_dispatch.c        | 90 +++++++++++++++++++++++++++
 13 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/syscall_user_dispatch.h
 create mode 100644 kernel/syscall_user_dispatch.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..c182344374a1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -465,6 +465,26 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config HAVE_ARCH_SYSCALL_USER_DISPATCH
+	bool
+	help
+	  An arch should select this symbol if it provides all of these things:
+	  - TIF_SYSCALL_USER_DISPATCH
+	  - syscall_get_arch
+	  - syscall_rollback
+	  - syscall_get_nr
+	  - SIGSYS siginfo_t support
+
+config SYSCALL_USER_DISPATCH
+	bool "Support rejecting syscalls not coming from a dispatcher"
+	depends on HAVE_ARCH_SYSCALL_USER_DISPATCH
+	help
+	  Enable tasks to ask the kernel to redirect syscalls not
+	  issued from a predefined dispatcher back to userspace,
+	  depending on a userspace selector.
+
+	  This option is useful to optimize games running over Wine.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 883da0abf779..466a3a9c0708 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,6 +149,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SYSCALL_USER_DISPATCH
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bd3f14175193..6c1360a7f260 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -138,6 +138,11 @@ static long syscall_trace_enter(struct pt_regs *regs)
 			return -1L;
 	}
 
+	if (work & _TIF_SYSCALL_USER_DISPATCH) {
+		if (do_syscall_user_dispatch(regs))
+			return -1L;
+	}
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * Do seccomp after ptrace, to catch any tracer changes.
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..b26a9f2f0491 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -93,6 +93,7 @@ struct thread_info {
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
+#define TIF_SYSCALL_USER_DISPATCH 19	/* Redirect syscall for userspace handling */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -123,6 +124,7 @@ struct thread_info {
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
+#define _TIF_SYSCALL_USER_DISPATCH (1 << TIF_SYSCALL_USER_DISPATCH)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
@@ -136,7 +138,7 @@ struct thread_info {
 /* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_USER_DISPATCH)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..44f0ce352a0d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1502,6 +1502,8 @@ void setup_new_exec(struct linux_binprm * bprm)
 
 	arch_setup_new_exec();
 
+	clear_tsk_syscall_user_dispatch(me);
+
 	/* Set the new mm task size. We have to do that late because it may
 	 * depend on TIF_32BIT which is only updated in flush_thread() on
 	 * some architectures like powerpc
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..407b868146e1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
 #include <linux/kcsan.h>
+#include <linux/syscall_user_dispatch.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -953,6 +954,8 @@ struct task_struct {
 #endif
 	struct seccomp			seccomp;
 
+	struct syscall_user_dispatch	syscall_dispatch;
+
 	/* Thread group tracking: */
 	u64				parent_exec_id;
 	u64				self_exec_id;
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
new file mode 100644
index 000000000000..dc7d8bb3ae13
--- /dev/null
+++ b/include/linux/syscall_user_dispatch.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SYSCALL_USER_DISPATCH_H
+#define _SYSCALL_USER_DISPATCH_H
+
+struct task_struct;
+static void clear_tsk_thread_flag(struct task_struct *tsk, int flag);
+
+#ifdef CONFIG_SYSCALL_USER_DISPATCH
+struct syscall_user_dispatch {
+	int __user *selector;
+	unsigned long __user dispatcher;
+};
+
+int do_syscall_user_dispatch(struct pt_regs *regs);
+int set_syscall_user_dispatch(int mode, unsigned long __user dispatcher,
+			      int __user *selector);
+
+static inline void clear_tsk_syscall_user_dispatch(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk, TIF_SYSCALL_USER_DISPATCH);
+}
+
+#else
+struct syscall_user_dispatch {};
+
+static inline int set_syscall_user_dispatch(int mode,
+					    unsigned long __user dispatcher,
+					    int __user *selector)
+{
+	return -EINVAL;
+}
+
+static inline int do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline void clear_tsk_syscall_user_dispatch(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_SYSCALL_USER_DISPATCH */
+
+#endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index cb3d6c267181..16337270467d 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -285,6 +285,7 @@ typedef struct siginfo {
  */
 #define SYS_SECCOMP	1	/* seccomp triggered */
 #define NSIGSYS		1
+#define SYS_USER_REDIRECT 2
 
 /*
  * SIGEMT si_codes
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..335ea1b5785e 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,8 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYSCALL_DISPATCH_DISABLE	0
+# define PR_SYSCALL_DISPATCH_ENABLE	1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index f3218bc5ec69..158b8c61592f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_SYSCALL_USER_DISPATCH) += syscall_user_dispatch.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..c6b64a849fec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -921,6 +921,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
+	clear_tsk_syscall_user_dispatch(tsk);
 
 #ifdef CONFIG_STACKPROTECTOR
 	tsk->stack_canary = get_random_canary();
diff --git a/kernel/sys.c b/kernel/sys.c
index 00a96746e28a..549f4dc9340f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/version.h>
 #include <linux/ctype.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2527,6 +2528,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_SYSCALL_USER_DISPATCH:
+		if (arg5 != 0)
+			return -EINVAL;
+		error = set_syscall_user_dispatch((int) arg2,
+						  (unsigned long __user) arg3,
+						  (int __user *) arg4);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/kernel/syscall_user_dispatch.c b/kernel/syscall_user_dispatch.c
new file mode 100644
index 000000000000..dd0867964a82
--- /dev/null
+++ b/kernel/syscall_user_dispatch.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
+#include <linux/prctl.h>
+#include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess.h>
+#include <linux/signal.h>
+
+#include <asm/syscall.h>
+
+#include <linux/sched/signal.h>
+#include <linux/sched/task_stack.h>
+
+static void trigger_sigsys(struct pt_regs *regs)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGSYS;
+	info.si_code = SYS_USER_REDIRECT;
+	info.si_call_addr = (void __user *)KSTK_EIP(current);
+	info.si_errno = 0;
+	info.si_arch = syscall_get_arch(current);
+	info.si_syscall = syscall_get_nr(current, regs);
+
+	force_sig_info(&info);
+}
+
+int do_syscall_user_dispatch(struct pt_regs *regs)
+{
+	int state;
+
+	if (current->syscall_dispatch.dispatcher == instruction_pointer(regs))
+		return 0;
+
+	if (current->syscall_dispatch.selector) {
+		if (__get_user(state, current->syscall_dispatch.selector))
+			do_exit(SIGSEGV);
+
+		switch (state) {
+		case PR_SYSCALL_DISPATCH_DISABLE:
+			return 0;
+		case PR_SYSCALL_DISPATCH_ENABLE:
+			break;
+		default:
+			do_exit(SIGSEGV);
+		}
+	}
+
+	syscall_rollback(current, regs);
+	trigger_sigsys(regs);
+
+	return 1;
+}
+
+int set_syscall_user_dispatch(int mode, unsigned long __user dispatcher,
+			      int __user *selector)
+{
+	switch (mode) {
+	case PR_SYSCALL_DISPATCH_DISABLE:
+		if (dispatcher || selector)
+			return -EINVAL;
+		break;
+	case PR_SYSCALL_DISPATCH_ENABLE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (selector) {
+		if (!access_ok(selector, sizeof(int)))
+			return -EFAULT;
+	}
+
+	spin_lock_irq(&current->sighand->siglock);
+
+	current->syscall_dispatch.selector = selector;
+	current->syscall_dispatch.dispatcher = dispatcher;
+
+	/* make sure fastlock is committed before setting the flag. */
+	smp_mb__before_atomic();
+
+	if (mode == PR_SYSCALL_DISPATCH_ENABLE)
+		set_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
+	else
+		clear_tsk_thread_flag(current, TIF_SYSCALL_USER_DISPATCH);
+
+	spin_unlock_irq(&current->sighand->siglock);
+
+	return 0;
+}
-- 
2.27.0

