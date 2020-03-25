Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD3C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A322137B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YGM9CdxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYHL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:11:28 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:43309 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585120287; x=1616656287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Uq0QP6TDZtBIGqllGAzCfpX5HzWqNlPgguNdSU/FyAQ=;
  b=YGM9CdxOusr/yjfkFbuiKcCpwl2ymn0L6c379tn92fvU/4UqyITqrN40
   +37lOMFHspeQE2Qc/Q/FdY9s1gy8fhE6IcKEnEcBkWg5OPgt6S9Vz0M5u
   Zq04VGlRYXG1BJXXsYC32SGg9FmqcEjHTYc9FUDyWiTauqKL7ptNQitto
   s=;
IronPort-SDR: TWGm4FM2jyJOYAw/AG+Vy2b9QOqg6wGtFgXxVl+H4MZJX4RXiMJwzDoMiYRO0mB+XWAUR2iqR+
 5kUAbYEUOSxw==
X-IronPort-AV: E=Sophos;i="5.72,303,1580774400"; 
   d="scan'208";a="22635716"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Mar 2020 07:11:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 7AB8CA2AC0;
        Wed, 25 Mar 2020 07:11:22 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 07:11:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 07:11:21 +0000
Received: from localhost (10.85.0.131) by mail-relay.amazon.com (10.43.61.169)
 with Microsoft SMTP Server id 15.0.1236.3 via Frontend Transport; Wed, 25 Mar
 2020 07:11:20 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Date:   Wed, 25 Mar 2020 18:11:00 +1100
Message-ID: <20200325071101.29556-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325071101.29556-1-sblbir@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a mechanisn to selectively flush the L1D cache.
The goal is to allow tasks that are paranoid due to the recent
snoop assisted data sampling vulnerabilites, to flush their L1D on being
switched out.  This protects their data from being snooped or leaked via
side channels after the task has context switched out.

There are two scenarios we might want to protect against, a task leaving
the CPU with data still in L1D (which is the main concern of this
patch), the second scenario is a malicious task coming in (not so well
trusted) for which we want to clean up the cache before it starts

This patch adds an arch specific prctl() to flush L1D cache on context
switch out, the existing mechanisms of tracking prev_mm via cpu_tlbstate
is reused (very similar to the cond_ipbp() changes). The patch has been
lighted tested.

The current version benefited from discussions with Kees and Thomas.

Cc: keescook@chromium.org

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/thread_info.h |  4 ++
 arch/x86/include/asm/tlbflush.h    |  6 +++
 arch/x86/include/uapi/asm/prctl.h  |  3 ++
 arch/x86/kernel/process_64.c       | 10 ++++-
 arch/x86/mm/tlb.c                  | 72 ++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..2a626a6a9ea6 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_L1D_FLUSH		23	/* Flush L1D on mm switches (processes) */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -132,6 +133,7 @@ struct thread_info {
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+#define _TIF_L1D_FLUSH		(1 << TIF_L1D_FLUSH)
 
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
index 6f66d841262d..1d535059b358 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -219,6 +219,12 @@ struct tlb_state {
 	 */
 	unsigned long cr4;
 
+	/*
+	 * Flush the L1D cache on switch_mm_irqs_off() for a
+	 * task getting off the CPU, if it opted in to do so
+	 */
+	bool last_user_mm_l1d_flush;
+
 	/*
 	 * This is a list of all contexts that might exist in the TLB.
 	 * There is one per ASID that we use, and the ASID (what the
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
index ffd497804dbc..555fa3fd102e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -700,7 +700,15 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_GET_L1D_FLUSH:
+		return test_ti_thread_flag(&task->thread_info, TIF_L1D_FLUSH);
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
index 66f96f21a7b6..22f96c5f74f0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -151,6 +152,74 @@ void leave_mm(int cpu)
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
+			if (!l1d_flush_pages)
+				return -ENOMEM;
+		}
+		mutex_unlock(&l1d_flush_mutex);
+	}
+	/* I don't think we need to worry about KSM */
+done:
+	set_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
+	return ret;
+}
+
+int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
+	return 0;
+}
+
+/*
+ * Flush the L1D cache for this CPU. We want to this at switch mm time,
+ * this is a pessimistic security measure and an opt-in for those tasks
+ * that host sensitive information and there are concerns about spills
+ * from fill buffers.
+ */
+static void l1d_flush(struct mm_struct *next, struct task_struct *tsk)
+{
+	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
+
+	/*
+	 * If we are not really switching mm's, we can just return
+	 */
+	if (real_prev == next)
+		return;
+
+	/*
+	 * Do we need flushing for by the previous task
+	 */
+	if (this_cpu_read(cpu_tlbstate.last_user_mm_l1d_flush) != 0) {
+		if (!flush_l1d_cache_hw())
+			flush_l1d_cache_sw(l1d_flush_pages);
+		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);
+		/* Make sure we clear the values before we set it again */
+		barrier();
+	}
+
+	if (tsk == NULL)
+		return;
+
+	/* We don't need stringent checks as we opt-in/opt-out */
+	if (test_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH))
+		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 1);
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -433,6 +502,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
+	l1d_flush(next, tsk);
+
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
@@ -503,6 +574,7 @@ void initialize_tlbstate_and_flush(void)
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
+	this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-- 
2.17.1

