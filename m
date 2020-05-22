Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4297C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F34206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgEVJdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgEVJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:32:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D13FC05BD43;
        Fri, 22 May 2020 02:32:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jc42x-0001OT-S0; Fri, 22 May 2020 11:32:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F2051C0095;
        Fri, 22 May 2020 11:32:55 +0200 (CEST)
Date:   Fri, 22 May 2020 09:32:55 -0000
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Optionally flush L1D on context switch
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200516103430.26527-2-sblbir@amazon.com>
References: <20200516103430.26527-2-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <159013997534.17951.18218280416222743933.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     20fc9f6f9f2fefefb694c9e447f80b4772021e0a
Gitweb:        https://git.kernel.org/tip/20fc9f6f9f2fefefb694c9e447f80b4772021e0a
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Sat, 16 May 2020 20:34:28 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 22 May 2020 10:36:48 +02:00

x86/mm: Optionally flush L1D on context switch

Implement a mechanism to selectively flush the L1D cache. The goal is to
allow tasks that are paranoid due to the recent snoop assisted data sampling
vulnerabilites, to flush their L1D on being switched out.  This protects
their data from being snooped or leaked via side channels after the task
has context switched out.

There are two scenarios we might want to protect against, a task leaving
the CPU with data still in L1D (which is the main concern of this patch),
the second scenario is a malicious task coming in (not so well trusted)
for which we want to clean up the cache before it starts. Only the case
for the former is addressed.

A new thread_info flag TIF_SPEC_L1D_FLUSH is added to track tasks which
opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
the TIF flags into mm state (per cpu via last_user_mm_spec) in
cond_mitigation(), which then used to do decide when to flush the
L1D cache.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200516103430.26527-2-sblbir@amazon.com

---
 arch/x86/include/asm/thread_info.h |  9 +++++--
 arch/x86/mm/tlb.c                  | 40 ++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8cec..1655347 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,7 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -114,7 +115,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -125,6 +126,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
@@ -235,6 +237,9 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
+extern int enable_l1d_flush_for_task(struct task_struct *tsk);
+extern int disable_l1d_flush_for_task(struct task_struct *tsk);
+
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 35017a0..c8524c5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -43,13 +44,19 @@
  */
 
 /*
- * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
  * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
-#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+#define LAST_USER_MM_L1D_FLUSH	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
-/* Bits to set when tlbstate and flush is (re)initialized */
+/*
+ * Bits to set when tlbstate and flush is (re)initialized
+ *
+ * Don't add LAST_USER_MM_L1D_FLUSH to the init bits as the initializaion
+ * is done during early boot and l1d_flush_pages are not yet allocated.
+ */
 #define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
 
 /*
@@ -311,6 +318,23 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+int enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	int ret = l1d_flush_init_once();
+
+	if (ret < 0)
+		return ret;
+
+	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return ret;
+}
+
+int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -354,6 +378,8 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
+
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -431,6 +457,14 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	if (prev_mm & LAST_USER_MM_L1D_FLUSH) {
+		/*
+		 * Don't populate the TLB for the software fallback flush.
+		 * Populate TLB is not needed for this use case.
+		 */
+		arch_l1d_flush(0);
+	}
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
