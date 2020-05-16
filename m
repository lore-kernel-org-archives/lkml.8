Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31EE1206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SMK8vTvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgEPKfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:35:08 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:18565 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589625306; x=1621161306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aPJuXLX9lgvxlrGZFQKnHkJraAnLXlyBnW9VF2i1EsE=;
  b=SMK8vTvGGkzbbsDNIYy+/6dUbL7qZcY9C5+2q93S6EKZFI5oT2eo1BJH
   ByAKK/RJu8Q70uuFY0+y2ryxbj/tRN8fwIR34+ksWXJfv4tWFNC3evGCp
   k8eWljhfNWD/6GApUxNxYdhXiA0pRSu58MXJGHsPZr0+F3Mj7822kOQfA
   c=;
IronPort-SDR: EvLQQiEbO6vuoS7sYOAwvvENqifmAavAu3VYgqHMtHU24vCRHBGsSapf/+PBBaRqx0p/A3vPl3
 SL99lv25XbmA==
X-IronPort-AV: E=Sophos;i="5.73,398,1583193600"; 
   d="scan'208";a="31944232"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 16 May 2020 10:34:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 3DE1DA1BD2;
        Sat, 16 May 2020 10:34:51 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 16 May 2020 10:34:50 +0000
Received: from localhost (10.85.1.185) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 May 2020 10:34:49 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v7 1/3] x86/mm: Optionally flush L1D on context switch
Date:   Sat, 16 May 2020 20:34:28 +1000
Message-ID: <20200516103430.26527-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516103430.26527-1-sblbir@amazon.com>
References: <20200516103430.26527-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/thread_info.h |  9 +++++--
 arch/x86/mm/tlb.c                  | 39 +++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..1655347f11b9 100644
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
index 35017a040ec9..03166f7c2f16 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -43,11 +44,12 @@
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
 
 /* Bits to set when tlbstate and flush is (re)initialized */
 #define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
@@ -311,6 +313,23 @@ void leave_mm(int cpu)
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
@@ -354,6 +373,7 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -431,6 +451,13 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
+		/*
+		 * Don't populate the TLB for the software fallback flush.
+		 * Populate TLB is not needed for our this use case.
+		 */
+		arch_l1d_flush(0);
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
@@ -681,7 +708,13 @@ void initialize_tlbstate_and_flush(void)
 	/* Force ASID 0 and force a TLB flush. */
 	write_cr3(build_cr3(mm->pgd, 0));
 
-	/* Reinitialize tlbstate. */
+	/*
+	 * Reinitialize tlbstate.
+	 *
+	 * Don't add LAST_USER_MM_L1D_FLUSH to last_user_mm_spec,
+	 * this is also called during early boot and l1d_flush_pages
+	 * are not yet allocated.
+	 */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
-- 
2.17.1

