Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88DF2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgC3OuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:50:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgC3Ot6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:49:58 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jIvjf-0006u3-GL; Mon, 30 Mar 2020 16:49:55 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 155071040EC;
        Mon, 30 Mar 2020 16:49:55 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:47:13 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/nohz for v5.7
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
Message-ID: <158557963316.22376.738267793153757956.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/nohz branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-nohz-2020-03-30

up to:  e4970c9c54d7: Merge branch 'arch/nohz' of git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into timers/nohz


NOHZ full updates:

  - Remove TIF_NOHZ from 3 architectures

    These architectures use a static key to decide whether context tracking
    needs to be invoked and the TIF_NOHZ flag just causes a pointless
    slowpath execution for nothing.

Thanks,

	tglx

------------------>
Frederic Weisbecker (4):
      context-tracking: Introduce CONFIG_HAVE_TIF_NOHZ
      x86: Remove TIF_NOHZ
      arm: Remove TIF_NOHZ
      arm64: Remove TIF_NOHZ

Thomas Gleixner (1):
      x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY


 arch/Kconfig                         | 16 +++++++++++-----
 arch/arm/include/asm/thread_info.h   |  1 -
 arch/arm64/include/asm/thread_info.h |  4 +---
 arch/mips/Kconfig                    |  1 +
 arch/powerpc/Kconfig                 |  1 +
 arch/sparc/Kconfig                   |  1 +
 arch/x86/include/asm/thread_info.h   | 10 ++--------
 kernel/context_tracking.c            |  2 ++
 8 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 98de654b79b3..dbf420a9f87b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -540,11 +540,17 @@ config HAVE_CONTEXT_TRACKING
 	help
 	  Provide kernel/user boundaries probes necessary for subsystems
 	  that need it, such as userspace RCU extended quiescent state.
-	  Syscalls need to be wrapped inside user_exit()-user_enter() through
-	  the slow path using TIF_NOHZ flag. Exceptions handlers must be
-	  wrapped as well. Irqs are already protected inside
-	  rcu_irq_enter/rcu_irq_exit() but preemption or signal handling on
-	  irq exit still need to be protected.
+	  Syscalls need to be wrapped inside user_exit()-user_enter(), either
+	  optimized behind static key or through the slow path using TIF_NOHZ
+	  flag. Exceptions handlers must be wrapped as well. Irqs are already
+	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
+	  handling on irq exit still need to be protected.
+
+config HAVE_TIF_NOHZ
+	bool
+	help
+	  Arch relies on TIF_NOHZ and syscall slow path to implement context
+	  tracking calls to user_enter()/user_exit().
 
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 0d0d5178e2c3..3609a6980c34 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -141,7 +141,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
 #define TIF_SECCOMP		7	/* seccomp syscall filtering active */
 
-#define TIF_NOHZ		12	/* in adaptive nohz mode */
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f0cec4160136..512174a8e789 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -63,7 +63,6 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
-#define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -83,7 +82,6 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
@@ -100,7 +98,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_NOHZ | _TIF_SYSCALL_EMU)
+				 _TIF_SYSCALL_EMU)
 
 #define INIT_THREAD_INFO(tsk)						\
 {									\
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797d7f1ad5fe..2589d4760e45 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,6 +51,7 @@ config MIPS
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CBPF_JIT if !64BIT && !CPU_MICROMIPS
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_TIF_NOHZ
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 497b7d0b2d7e..6f40af294685 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -182,6 +182,7 @@ config PPC
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
 	select HAVE_CONTEXT_TRACKING		if PPC64
+	select HAVE_TIF_NOHZ			if PPC64
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c1dd6dd642f4..9cc9ab04bd99 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -71,6 +71,7 @@ config SPARC64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_TIF_NOHZ
 	select HAVE_DEBUG_KMEMLEAK
 	select IOMMU_HELPER
 	select SPARSE_IRQ
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf4327986e98..384cdde10680 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,7 +92,6 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
-#define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -122,7 +121,6 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
-#define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
@@ -133,14 +131,10 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/*
- * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
- * enter_from_user_mode()
- */
+/* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_NOHZ)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 0296b4bda8f1..ce430885c26c 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -198,11 +198,13 @@ void __init context_tracking_cpu_set(int cpu)
 	if (initialized)
 		return;
 
+#ifdef CONFIG_HAVE_TIF_NOHZ
 	/*
 	 * Set TIF_NOHZ to init/0 and let it propagate to all tasks through fork
 	 * This assumes that init is the only task at this early boot stage.
 	 */
 	set_tsk_thread_flag(&init_task, TIF_NOHZ);
+#endif
 	WARN_ON_ONCE(!tasklist_empty());
 
 	initialized = true;

