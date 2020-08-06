Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC15AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC34E2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CINhPkcI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmTQPyXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHFXkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHFXij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:39 -0400
Date:   Thu, 06 Aug 2020 23:38:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=l1pWuHDzyytpdYgBsjwfVOClMpeMEUXjiH8WoEORRH0=;
        b=CINhPkcIEbKZXz3I00i4fRVqo0r0/HtJ1SSM6WjE2gOGdyPJCWalcb9KBVSaBcoyNe8tEr
        tKaiMhz1mbdWrHg8iYrVoziXCKNhnX2NF7Ck8KEljkojvUovTSk+FDqH2qYreqrib3cRHL
        8M6gOiEGBDNe7VWfNftQNXLd+iLcpcIzF8Rmqms1mB3MUyLEdW2BkxXhW9FGand4xkKOtL
        /RfIiIJWasDaxvSr0M+g7QnFA3hkQX2Gn6TysCjJf+YOabW/yxz4Zb4VSUWGdxdNlp6dI+
        dvBj3QQLjHjRQnS20css5KcWTHvcZeq56HHBFQGehYWr4StYHUnGuuniw1IYMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=l1pWuHDzyytpdYgBsjwfVOClMpeMEUXjiH8WoEORRH0=;
        b=lmTQPyXRmGuDrdR+oCR0oVO82dGsPL+lPFwN1CMT6qYpwyFW7CNo8yblQtpGFCecP71qn9
        vchazQyN3XGmXsDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking, arch/ia64: Reduce <asm/smp.h> header
 dependencies by moving XTP bits into the new <asm/xtp.h> header
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159675711594.3192.3906972309941027659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b3545192e2b4647234254c5122f8cbfddbcbdaa0
Gitweb:        https://git.kernel.org/tip/b3545192e2b4647234254c5122f8cbfddbcbdaa0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 Aug 2020 14:36:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:13:13 +02:00

locking, arch/ia64: Reduce <asm/smp.h> header dependencies by moving XTP bits into the new <asm/xtp.h> header

We want to remove the #include <asm/io.h> from <asm/smp.h>, but for this
we have to move the XTP bits into a separate header first (as these bits
rely on <asm/io.h> definitions), and include them in the .c files that rely
on those APIs.

Co-developed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/smp.h     | 35 +------------------------
 arch/ia64/include/asm/xtp.h     | 46 ++++++++++++++++++++++++++++++++-
 arch/ia64/kernel/iosapic.c      |  1 +-
 arch/ia64/kernel/irq.c          |  1 +-
 arch/ia64/kernel/process.c      |  1 +-
 arch/ia64/kernel/sal.c          |  1 +-
 arch/ia64/kernel/setup.c        |  1 +-
 arch/ia64/kernel/smp.c          |  1 +-
 arch/parisc/include/asm/timex.h |  1 +-
 9 files changed, 53 insertions(+), 35 deletions(-)
 create mode 100644 arch/ia64/include/asm/xtp.h

diff --git a/arch/ia64/include/asm/smp.h b/arch/ia64/include/asm/smp.h
index 7847ae4..aa92234 100644
--- a/arch/ia64/include/asm/smp.h
+++ b/arch/ia64/include/asm/smp.h
@@ -18,7 +18,6 @@
 #include <linux/bitops.h>
 #include <linux/irqreturn.h>
 
-#include <asm/io.h>
 #include <asm/param.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
@@ -44,11 +43,6 @@ ia64_get_lid (void)
 
 #ifdef CONFIG_SMP
 
-#define XTP_OFFSET		0x1e0008
-
-#define SMP_IRQ_REDIRECTION	(1 << 0)
-#define SMP_IPI_REDIRECTION	(1 << 1)
-
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 extern struct smp_boot_data {
@@ -62,7 +56,6 @@ extern cpumask_t cpu_core_map[NR_CPUS];
 DECLARE_PER_CPU_SHARED_ALIGNED(cpumask_t, cpu_sibling_map);
 extern int smp_num_siblings;
 extern void __iomem *ipi_base_addr;
-extern unsigned char smp_int_redirect;
 
 extern volatile int ia64_cpu_to_sapicid[];
 #define cpu_physical_id(i)	ia64_cpu_to_sapicid[i]
@@ -84,34 +77,6 @@ cpu_logical_id (int cpuid)
 	return i;
 }
 
-/*
- * XTP control functions:
- *	min_xtp   : route all interrupts to this CPU
- *	normal_xtp: nominal XTP value
- *	max_xtp   : never deliver interrupts to this CPU.
- */
-
-static inline void
-min_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x00, ipi_base_addr + XTP_OFFSET); /* XTP to min */
-}
-
-static inline void
-normal_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x08, ipi_base_addr + XTP_OFFSET); /* XTP normal */
-}
-
-static inline void
-max_xtp (void)
-{
-	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
-		writeb(0x0f, ipi_base_addr + XTP_OFFSET); /* Set XTP to max */
-}
-
 /* Upping and downing of CPUs */
 extern int __cpu_disable (void);
 extern void __cpu_die (unsigned int cpu);
diff --git a/arch/ia64/include/asm/xtp.h b/arch/ia64/include/asm/xtp.h
new file mode 100644
index 0000000..5bf1d70
--- /dev/null
+++ b/arch/ia64/include/asm/xtp.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_IA64_XTP_H
+#define _ASM_IA64_XTP_H
+
+#include <asm/io.h>
+
+#ifdef CONFIG_SMP
+
+#define XTP_OFFSET		0x1e0008
+
+#define SMP_IRQ_REDIRECTION	(1 << 0)
+#define SMP_IPI_REDIRECTION	(1 << 1)
+
+extern unsigned char smp_int_redirect;
+
+/*
+ * XTP control functions:
+ *	min_xtp   : route all interrupts to this CPU
+ *	normal_xtp: nominal XTP value
+ *	max_xtp   : never deliver interrupts to this CPU.
+ */
+
+static inline void
+min_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x00, ipi_base_addr + XTP_OFFSET); /* XTP to min */
+}
+
+static inline void
+normal_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x08, ipi_base_addr + XTP_OFFSET); /* XTP normal */
+}
+
+static inline void
+max_xtp (void)
+{
+	if (smp_int_redirect & SMP_IRQ_REDIRECTION)
+		writeb(0x0f, ipi_base_addr + XTP_OFFSET); /* Set XTP to max */
+}
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_IA64_XTP_Hy */
diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index fad4db2..35adcf8 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -95,6 +95,7 @@
 #include <asm/iosapic.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/xtp.h>
 
 #undef DEBUG_INTERRUPT_ROUTING
 
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index 0a8e5e5..ecef17c 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 
 #include <asm/mca.h>
+#include <asm/xtp.h>
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 96dfb9e..4562a1a 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <linux/uaccess.h>
 #include <asm/unwind.h>
 #include <asm/user.h>
+#include <asm/xtp.h>
 
 #include "entry.h"
 
diff --git a/arch/ia64/kernel/sal.c b/arch/ia64/kernel/sal.c
index c455ece..e4f0705 100644
--- a/arch/ia64/kernel/sal.c
+++ b/arch/ia64/kernel/sal.c
@@ -18,6 +18,7 @@
 #include <asm/page.h>
 #include <asm/sal.h>
 #include <asm/pal.h>
+#include <asm/xtp.h>
 
  __cacheline_aligned DEFINE_SPINLOCK(sal_lock);
 unsigned long sal_platform_features;
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index d2d440f..dd595fb 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -65,6 +65,7 @@
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 #include <asm/uv/uv.h>
+#include <asm/xtp.h>
 
 #if defined(CONFIG_SMP) && (IA64_CPU_SIZE > PAGE_SIZE)
 # error "struct cpuinfo_ia64 too big!"
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index bbfd421..1cf7b9b 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -46,6 +46,7 @@
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 #include <asm/mca.h>
+#include <asm/xtp.h>
 
 /*
  * Note: alignment of 4 entries/cacheline was empirically determined
diff --git a/arch/parisc/include/asm/timex.h b/arch/parisc/include/asm/timex.h
index 45537cd..06b510f 100644
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -7,6 +7,7 @@
 #ifndef _ASMPARISC_TIMEX_H
 #define _ASMPARISC_TIMEX_H
 
+#include <asm/special_insns.h>
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
 
