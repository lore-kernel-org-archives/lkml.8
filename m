Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94367C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CA1217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581693994;
	bh=KYwPMvDEV3XtBM2fDFyocr2Ioaq9g5FNtGjGvxMoPUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CGh8vzlp1/16DXM6YOQmS9f5cmWoPLe6gclmNk+8B9zNLScfRCQCjO7J+Jr0pVmXQ
	 kzDHRUxfPX+nooIeYFyCaVrb4hysm1u9u1y7FpQYZZ9vFylgt6ur2i8jQv9LeOnm/K
	 R/n9ewnyZl7JkDbv7ns+/OfBMndfTTHZBI9p3gIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgBNP0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgBNP0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:31 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F5724654;
        Fri, 14 Feb 2020 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581693990;
        bh=KYwPMvDEV3XtBM2fDFyocr2Ioaq9g5FNtGjGvxMoPUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv3tsM20Sr6r9orNWjQokYf3Jt1kCrHCJAPFLbHWU/YfOXhQ4ZHCFPnVx4YT4GCm/
         YK++KMP3PNIQFFLPbeg8ldokmoOBguk2Al0UO1GAq7pRTQRwMIQVbhjZ3H7FMk2UJd
         HsmUbBHga3MrDEkuRUJgRU2WWSXw7n8r7X21fklo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/5] context-tracking: Introduce CONFIG_HAVE_TIF_NOHZ
Date:   Fri, 14 Feb 2020 16:26:12 +0100
Message-Id: <20200214152615.25447-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214152615.25447-1-frederic@kernel.org>
References: <20200214152615.25447-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aabc2a6..38b764cae559 100644
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
index 0b30e884e088..5c945fa3df26 100644
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..549eed3460c9 100644
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
-- 
2.25.0

