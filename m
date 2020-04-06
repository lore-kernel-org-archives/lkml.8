Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150DC2D0F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7520780
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jEnpNIHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFDWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:22:20 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:26123 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgDFDWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586143338; x=1617679338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=YeBOlEd8oDwLjv5FslUb8BlrPM6w6GMPfmhIY2qXAfk=;
  b=jEnpNIHlZibeavbgSQB69qjS+scmHSRYIWZSqY2V+WX282sA+1e4VeNv
   Pfk1q/foLbXrRfca6DJ2MBF7mpx1ucibfE5rjG/i9J+fqrY4qj6fDxW4Q
   LMKH6uxG/3/dHP1lwufRobYjU3E62DiECjWhCp1LGuOr2NiBa55VxJVNv
   k=;
IronPort-SDR: NXtJrZjbst7TabA0fCb18OlLfjAFDCYhjgMVEfNCEiDDPJ9jAPyfbO9R7zzhWwxVtQeRqdNxDk
 VMLd+Qwx9uCg==
X-IronPort-AV: E=Sophos;i="5.72,349,1580774400"; 
   d="scan'208";a="25641510"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Apr 2020 03:22:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 10605A23BB;
        Mon,  6 Apr 2020 03:22:15 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:22:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:22:13 +0000
Received: from localhost (10.85.6.171) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Apr 2020 03:22:13 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Date:   Mon, 6 Apr 2020 13:19:45 +1000
Message-ID: <20200406031946.11815-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406031946.11815-1-sblbir@amazon.com>
References: <20200406031946.11815-1-sblbir@amazon.com>
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

Add arch specific prctl()'s to opt-in to the L1D cache on context switch
out, the existing mechanisms of tracking prev_mm via cpu_tlbstate is
reused. cond_ibpb() is refactored and renamed into cond_mitigation().

A new thread_info flag TIF_SPEC_FLUSH_L1D is added to track tasks which
opt-into L1D flushing. cpu_tlbstate.last_user_mm_ibpb is renamed to
cpu_tlbstate.last_user_mm_spec, this is used to convert the TIF flags
into mm state (per cpu via last_user_mm_spec) in cond_mitigation(),
which then used to do decide when to call flush_l1d().

The current version benefited from discussions with Kees and Thomas.
Thomas suggested and provided the code snippet for refactoring the
existing cond_ibpb() code.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/thread_info.h |  6 +-
 arch/x86/include/asm/tlbflush.h    |  2 +-
 arch/x86/include/uapi/asm/prctl.h  |  3 +
 arch/x86/kernel/process_64.c       | 10 +++-
 arch/x86/mm/tlb.c                  | 94 +++++++++++++++++++++++-------
 5 files changed, 91 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..5cb250872643 100644
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
+extern int enable_l1d_flush_for_task(struct task_struct *tsk);
+extern int disable_l1d_flush_for_task(struct task_struct *tsk);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d841262d..69e6ea20679c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -172,7 +172,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
 
 	u16 loaded_mm_asid;
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f..1361e5e25791 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -14,4 +14,7 @@
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#define ARCH_SET_L1D_FLUSH	0x3001
+#define ARCH_GET_L1D_FLUSH	0x3002
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f25b0e..ecf542f13572 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -699,7 +699,15 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_GET_L1D_FLUSH:
+		return test_ti_thread_flag(&task->thread_info, TIF_SPEC_FLUSH_L1D);
+	case ARCH_SET_L1D_FLUSH: {
+		if (arg2 >= 1)
+			return enable_l1d_flush_for_task(task);
+		else
+			return disable_l1d_flush_for_task(task);
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 66f96f21a7b6..71ef9fb941b8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -33,10 +34,12 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_FLUSH_L1D	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_FLUSH_L1D)
 
 /*
  * We get here when we do something requiring a TLB invalidation
@@ -151,6 +154,52 @@ void leave_mm(int cpu)
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
+	/* I don't think we need to worry about KSM */
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
+/*
+ * Flush the L1D cache for this CPU. We want to this at switch mm time,
+ * this is a pessimistic security measure and an opt-in for those tasks
+ * that host sensitive information.
+ */
+static void flush_l1d(void)
+{
+	if (!flush_l1d_cache_hw())
+		flush_l1d_cache_sw(l1d_flush_pages);
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -189,19 +238,26 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 	}
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
+
+	BUILD_BUG_ON(TIF_SPEC_FLUSH_L1D != TIF_SPEC_IB + 1);
 
-	return (unsigned long)next->mm | ibpb;
+	return (unsigned long)next->mm | spec_bits;
 }
 
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigation(struct task_struct *next)
 {
+	unsigned long prev_mm, next_mm;
+
 	if (!next || !next->mm)
 		return;
 
+	next_mm = mm_mangle_tif_spec_bits(next);
+	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+
 	/*
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
@@ -212,8 +268,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -243,20 +297,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -265,11 +313,15 @@ static void cond_ibpb(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
+					(unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	if (prev_mm & LAST_USER_MM_FLUSH_L1D)
+		flush_l1d();
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
@@ -375,7 +427,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * predictor when switching between processes. This stops
 		 * one process from doing Spectre-v2 attacks on another.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -501,7 +553,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
-- 
2.17.1

