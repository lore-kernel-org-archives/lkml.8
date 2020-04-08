Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A95C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99C20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W9rognKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDHJDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:03:05 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26841 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586336584; x=1617872584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pEw2umdM6xySQG+judEpictwMxpH0NTNUJEkjHpSyPA=;
  b=W9rognKhiCRD5vsIfh2c4fLTnHyMGs0jnS8TMgDvLaaKj7jjhDLLnIkJ
   4dSyRaaWyYEnMrsyLpOujSYN7dSdQ85GBrS19LAq9WDX4neyBM4918dsV
   AOJP9a19LRsMcRqW+26VNE5hXaGlfKpRLcBlizipDbVb184iN64u6OAky
   4=;
IronPort-SDR: obq0RhYmh+bhwbAlzkjHfI35BYRoOwrKzNB08zTdM24dLAoj1Mxfgapjauc+4VpqR3Fq1oemu8
 hX+Ql9iV7eMQ==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="37342109"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 08 Apr 2020 09:03:04 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 88FF6A2319;
        Wed,  8 Apr 2020 09:03:02 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:53 +0000
Received: from localhost (10.85.0.235) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Wed, 8 Apr
 2020 09:02:52 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 4/5] arch/x86: Optionally flush L1D on context switch
Date:   Wed, 8 Apr 2020 19:02:28 +1000
Message-ID: <20200408090229.16467-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408090229.16467-1-sblbir@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
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

Add prctl()'s to opt-in to the L1D cache on context switch out, the
existing mechanisms of tracking prev_mm via cpu_tlbstate is
reused.

A new thread_info flag TIF_SPEC_FLUSH_L1D is added to track tasks which
opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
the TIF flags into mm state (per cpu via last_user_mm_spec) in
cond_mitigation(), which then used to do decide when to call flush_l1d().

The current version benefited from discussions with Kees and Thomas.
Thomas suggested and provided the code snippet for refactoring the
existing cond_ibpb() code.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/thread_info.h |  6 ++-
 arch/x86/mm/tlb.c                  | 69 +++++++++++++++++++++++++++++-
 include/uapi/linux/prctl.h         |  4 ++
 kernel/sys.c                       | 20 +++++++++
 4 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..be25cc0c677d 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,7 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_FLUSH_L1D	10	/* Flush L1D on mm switches (processes) */
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
@@ -132,6 +133,7 @@ struct thread_info {
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+#define _TIF_SPEC_FLUSH_L1D	(1 << TIF_SPEC_FLUSH_L1D)
 
 /* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
@@ -239,6 +241,8 @@ extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
 extern void arch_setup_new_exec(void);
+extern int arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable);
+extern int arch_prctl_l1d_flush_get(struct task_struct *tsk);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index da5c94286c7d..85b8eec0ff07 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -33,11 +34,12 @@
  */
 
 /*
- * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
  * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
-#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+#define LAST_USER_MM_FLUSH_L1D	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_FLUSH_L1D)
 
 /*
  * We get here when we do something requiring a TLB invalidation
@@ -152,6 +154,64 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+static void *l1d_flush_pages;
+static DEFINE_MUTEX(l1d_flush_mutex);
+
+int enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	struct page *page;
+	int ret = 0;
+
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		goto done;
+
+	page = READ_ONCE(l1d_flush_pages);
+	if (unlikely(!page)) {
+		mutex_lock(&l1d_flush_mutex);
+		if (!l1d_flush_pages) {
+			l1d_flush_pages = alloc_l1d_flush_pages();
+			if (!l1d_flush_pages) {
+				mutex_unlock(&l1d_flush_mutex);
+				return -ENOMEM;
+			}
+		}
+		mutex_unlock(&l1d_flush_mutex);
+	}
+done:
+	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
+	return ret;
+}
+
+int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
+	return 0;
+}
+
+int arch_prctl_l1d_flush_get(struct task_struct *tsk)
+{
+	return test_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
+}
+
+int arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
+{
+	if (enable)
+		return enable_l1d_flush_for_task(tsk);
+	return disable_l1d_flush_for_task(tsk);
+}
+
+/*
+ * Flush the L1D cache for this CPU. We want to this at switch mm time,
+ * this is a pessimistic security measure and an opt-in for those tasks
+ * that host sensitive information.
+ */
+static void flush_l1d(void)
+{
+	if (flush_l1d_cache_hw() == 0)
+		return;
+	flush_l1d_cache_sw(l1d_flush_pages);
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -195,6 +255,8 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_FLUSH_L1D != TIF_SPEC_IB + 1);
+
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -268,6 +330,9 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	if (prev_mm & LAST_USER_MM_FLUSH_L1D)
+		flush_l1d();
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..42cb3038c81a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,8 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Flush L1D on context switch (mm) */
+#define PR_SET_L1D_FLUSH		59
+#define PR_GET_L1D_FLUSH		60
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..578aa8b6d87e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2262,6 +2262,16 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
+{
+	return -EINVAL;
+}
+
+int __weak arch_prctl_l1d_flush_get(struct task_struct *t)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
 
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
@@ -2514,6 +2524,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+	case PR_SET_L1D_FLUSH:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_l1d_flush_set(me, arg2);
+		break;
+	case PR_GET_L1D_FLUSH:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_l1d_flush_get(me);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.17.1

