Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFFBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E45F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNLMDfdS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nMj1pWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgG0MqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbgG0MqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F5C061794;
        Mon, 27 Jul 2020 05:46:21 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy9Twu5TgmQ8MNzsPMdqM0AK4cD5qvZDO0BcLwWksQk=;
        b=pNLMDfdSC28d3b2lJnw2YsxSCb5+WUMgTV+sMt19DwERs9vBBKXK19TN5sgBnO62Focqu/
        a8TUUxWqNcai6LhTLTKP3Auy6OJbVByeRJHlcrL6tpHBqr3RSZKv0FfnsyDIo84w1e3+2v
        dr0jGGGD849ECcwHNodTPBr5l3vY775jdPMI/ubYnwLmoE9i+iM0Mb+Mjl6bIQna6LHDF7
        Q/6N7gu0q5YH1Bl0GlcC1GcvrZQ5AvuyKCh+QehHIkNaMoCZfM9hoRJRE6GJPHCsIcLTnh
        QkWmwxMgYrrRJn4bJGHc6EfSFmyLs6dJt1QCQyh+kNMaokTqKs0rs9KxAr5GkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853977;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy9Twu5TgmQ8MNzsPMdqM0AK4cD5qvZDO0BcLwWksQk=;
        b=3nMj1pWO2iahmc3m9UYO8pnrLyp1Op40mrA4m4WeK0Yhlp0sBJnjPFjguJ45ZwR++ut3jK
        UW9NC2esbjnwxxAw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Relocate sync_core() to sync_core.h
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727043132.15082-3-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159585397690.4006.7139034000798801882.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     9998a9832c4027e907353e5e05fde730cf624b77
Gitweb:        https://git.kernel.org/tip/9998a9832c4027e907353e5e05fde730cf624b77
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Sun, 26 Jul 2020 21:31:30 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:42:06 +02:00

x86/cpu: Relocate sync_core() to sync_core.h

Having sync_core() in processor.h is problematic since it is not possible
to check for hardware capabilities via the *cpu_has() family of macros.
The latter needs the definitions in processor.h.

It also looks more intuitive to relocate the function to sync_core.h.

This changeset does not make changes in functionality.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20200727043132.15082-3-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/include/asm/processor.h    | 64 +----------------------------
 arch/x86/include/asm/sync_core.h    | 64 ++++++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c       |  1 +-
 arch/x86/kernel/cpu/mce/core.c      |  1 +-
 drivers/misc/sgi-gru/grufault.c     |  1 +-
 drivers/misc/sgi-gru/gruhandles.c   |  1 +-
 drivers/misc/sgi-gru/grukservices.c |  1 +-
 7 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 03b7c4c..68ba42f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -678,70 +678,6 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
-/*
- * This function forces the icache and prefetched instruction stream to
- * catch up with reality in two very specific cases:
- *
- *  a) Text was modified using one virtual address and is about to be executed
- *     from the same physical page at a different virtual address.
- *
- *  b) Text was modified on a different CPU, may subsequently be
- *     executed on this CPU, and you want to make sure the new version
- *     gets executed.  This generally means you're calling this in a IPI.
- *
- * If you're calling this for a different reason, you're probably doing
- * it wrong.
- */
-static inline void sync_core(void)
-{
-	/*
-	 * There are quite a few ways to do this.  IRET-to-self is nice
-	 * because it works on every CPU, at any CPL (so it's compatible
-	 * with paravirtualization), and it never exits to a hypervisor.
-	 * The only down sides are that it's a bit slow (it seems to be
-	 * a bit more than 2x slower than the fastest options) and that
-	 * it unmasks NMIs.  The "push %cs" is needed because, in
-	 * paravirtual environments, __KERNEL_CS may not be a valid CS
-	 * value when we do IRET directly.
-	 *
-	 * In case NMI unmasking or performance ever becomes a problem,
-	 * the next best option appears to be MOV-to-CR2 and an
-	 * unconditional jump.  That sequence also works on all CPUs,
-	 * but it will fault at CPL3 (i.e. Xen PV).
-	 *
-	 * CPUID is the conventional way, but it's nasty: it doesn't
-	 * exist on some 486-like CPUs, and it usually exits to a
-	 * hypervisor.
-	 *
-	 * Like all of Linux's memory ordering operations, this is a
-	 * compiler barrier as well.
-	 */
-#ifdef CONFIG_X86_32
-	asm volatile (
-		"pushfl\n\t"
-		"pushl %%cs\n\t"
-		"pushl $1f\n\t"
-		"iret\n\t"
-		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
-#else
-	unsigned int tmp;
-
-	asm volatile (
-		"mov %%ss, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq %%rsp\n\t"
-		"addq $8, (%%rsp)\n\t"
-		"pushfq\n\t"
-		"mov %%cs, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq $1f\n\t"
-		"iretq\n\t"
-		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-#endif
-}
-
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void amd_e400_c1e_apic_setup(void);
 
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index c67caaf..9c5573f 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -7,6 +7,70 @@
 #include <asm/cpufeature.h>
 
 /*
+ * This function forces the icache and prefetched instruction stream to
+ * catch up with reality in two very specific cases:
+ *
+ *  a) Text was modified using one virtual address and is about to be executed
+ *     from the same physical page at a different virtual address.
+ *
+ *  b) Text was modified on a different CPU, may subsequently be
+ *     executed on this CPU, and you want to make sure the new version
+ *     gets executed.  This generally means you're calling this in a IPI.
+ *
+ * If you're calling this for a different reason, you're probably doing
+ * it wrong.
+ */
+static inline void sync_core(void)
+{
+	/*
+	 * There are quite a few ways to do this.  IRET-to-self is nice
+	 * because it works on every CPU, at any CPL (so it's compatible
+	 * with paravirtualization), and it never exits to a hypervisor.
+	 * The only down sides are that it's a bit slow (it seems to be
+	 * a bit more than 2x slower than the fastest options) and that
+	 * it unmasks NMIs.  The "push %cs" is needed because, in
+	 * paravirtual environments, __KERNEL_CS may not be a valid CS
+	 * value when we do IRET directly.
+	 *
+	 * In case NMI unmasking or performance ever becomes a problem,
+	 * the next best option appears to be MOV-to-CR2 and an
+	 * unconditional jump.  That sequence also works on all CPUs,
+	 * but it will fault at CPL3 (i.e. Xen PV).
+	 *
+	 * CPUID is the conventional way, but it's nasty: it doesn't
+	 * exist on some 486-like CPUs, and it usually exits to a
+	 * hypervisor.
+	 *
+	 * Like all of Linux's memory ordering operations, this is a
+	 * compiler barrier as well.
+	 */
+#ifdef CONFIG_X86_32
+	asm volatile (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $1f\n\t"
+		"iret\n\t"
+		"1:"
+		: ASM_CALL_CONSTRAINT : : "memory");
+#else
+	unsigned int tmp;
+
+	asm volatile (
+		"mov %%ss, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq %%rsp\n\t"
+		"addq $8, (%%rsp)\n\t"
+		"pushfq\n\t"
+		"mov %%cs, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq $1f\n\t"
+		"iretq\n\t"
+		"1:"
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+#endif
+}
+
+/*
  * Ensure that a core serializing instruction is issued before returning
  * to user-mode. x86 implements return to user-space through sysexit,
  * sysrel, and sysretq, which are not core serializing.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff..6e63231 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -15,6 +15,7 @@
 #include <linux/kprobes.h>
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
+#include <linux/sync_core.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 14e4b4d..9246595 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 
diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index b152111..7238255 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/sync_core.h>
 #include <linux/prefetch.h>
 #include "gru.h"
 #include "grutables.h"
diff --git a/drivers/misc/sgi-gru/gruhandles.c b/drivers/misc/sgi-gru/gruhandles.c
index f7224f9..1d75d5e 100644
--- a/drivers/misc/sgi-gru/gruhandles.c
+++ b/drivers/misc/sgi-gru/gruhandles.c
@@ -16,6 +16,7 @@
 #define GRU_OPERATION_TIMEOUT	(((cycles_t) local_cpu_data->itc_freq)*10)
 #define CLKS2NSEC(c)		((c) *1000000000 / local_cpu_data->itc_freq)
 #else
+#include <linux/sync_core.h>
 #include <asm/tsc.h>
 #define GRU_OPERATION_TIMEOUT	((cycles_t) tsc_khz*10*1000)
 #define CLKS2NSEC(c)		((c) * 1000000 / tsc_khz)
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0197441..f6e600b 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -16,6 +16,7 @@
 #include <linux/miscdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
+#include <linux/sync_core.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/export.h>
