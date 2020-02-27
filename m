Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA9C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D11E24688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgB0PNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:13:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34617 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgB0PNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:13:40 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7Kqk-00086t-J5; Thu, 27 Feb 2020 16:13:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3A3391C2173;
        Thu, 27 Feb 2020 16:13:18 +0100 (CET)
Date:   Thu, 27 Feb 2020 15:13:17 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] context-tracking: Introduce CONFIG_HAVE_TIF_NOHZ
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158281639798.28353.13967034155674049325.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     490f561b783dac2c4825e288e6dbbf83481eea34
Gitweb:        https://git.kernel.org/tip/490f561b783dac2c4825e288e6dbbf83481eea34
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 27 Jan 2020 16:41:52 +01:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Fri, 14 Feb 2020 16:05:04 +01:00

context-tracking: Introduce CONFIG_HAVE_TIF_NOHZ

A few archs (x86, arm, arm64) don't rely anymore on TIF_NOHZ to call
into context tracking on user entry/exit but instead use static keys
(or not) to optimize those calls. Ideally every arch should migrate to
that behaviour in the long run.

Settle a config option to let those archs remove their TIF_NOHZ
definitions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: David S. Miller <davem@davemloft.net>
---
 arch/Kconfig              | 16 +++++++++++-----
 arch/arm/Kconfig          |  1 +
 arch/arm64/Kconfig        |  1 +
 arch/mips/Kconfig         |  1 +
 arch/powerpc/Kconfig      |  1 +
 arch/sparc/Kconfig        |  1 +
 arch/x86/Kconfig          |  1 +
 kernel/context_tracking.c |  2 ++
 8 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 98de654..dbf420a 100644
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
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aa..38b764c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -72,6 +72,7 @@ config ARM
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_TIF_NOHZ
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e88..5c945fa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,6 +140,7 @@ config ARM64
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_TIF_NOHZ
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797d7f1..2589d47 100644
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
index 497b7d0..6f40af2 100644
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
index c1dd6dd..9cc9ab0 100644
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea770..549eed3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -211,6 +211,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_TIF_NOHZ			if X86_64
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 0296b4b..ce43088 100644
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
