Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC43C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF5120752
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KL+7BmK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCMWEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:04:46 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:35640 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584137086; x=1615673086;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=11liy8buHaND+9ZE+tfemFeLsK9P98Nlc+yDaI8HfI8=;
  b=KL+7BmK8YrJZoRlHzKEKr9SYmYBPlHNj8lJQ01odGLU6mmdYbFYYudU/
   TBMNvDlJlmS7UpTnBfBkNttOqGPl2/YkSE8qjsTkOcNeIho/t7mP3DBWj
   cSvpu5UzGIglI4sVnWVuzCH//vW0WIzFJJkIpIX4L3vUc71NUo11mgQYE
   Q=;
IronPort-SDR: 0pWAhPKTM6T6ZfIJiijSk7fg4YpnzcuAKLgnffrU7BLyxYXGs6SzqO+ElzAPM6avCtbbCUcdXX
 RTNqEorcHA4g==
X-IronPort-AV: E=Sophos;i="5.70,550,1574121600"; 
   d="scan'208";a="21445575"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Mar 2020 22:04:33 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 88FBDA2463;
        Fri, 13 Mar 2020 22:04:32 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 22:04:31 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 22:04:30 +0000
Received: from localhost (10.85.3.64) by mail-relay.amazon.com (10.43.162.232)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Fri, 13 Mar
 2020 22:04:29 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Balbir Singh <sblbir@amazon.com>,
        <keescook@chromium.org>, <benh@amazon.com>
Subject: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Date:   Sat, 14 Mar 2020 09:04:15 +1100
Message-ID: <20200313220415.856-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an RFC/PoC to start the discussion on optionally flushing
L1D cache.  The goal is to allow tasks that are paranoid due to the recent
snoop assisted data sampling vulnerabilites, to flush their L1D on being
switched out.  This protects their data from being snooped or leaked via
side channels after the task has context switched out.

There are two scenarios we might want to protect against, a task leaving
the CPU with data still in L1D (which is the main concern of this
patch), the second scenario is a malicious task coming in (not so well
trusted) for which we want to clean up the cache before it starts
execution. The latter was proposed by benh and is not currently
addressed by this patch, but can be easily accommodated by the same
mechanism.

This patch adds an arch specific prctl() to flush L1D cache on context
switch out, the existing mechanisms of tracking prev_mm via cpu_tlbstate
is reused (very similar to the cond_ipbp() changes). The patch has been
lighted tested.

The points of discussion/review are:

1. Discuss the use case and the right approach to address this
2. Does an arch prctl allowing for opt-in flushing make sense, would other
   arches care about something similar?
3. There is a fallback software L1D load, similar to what L1TF does, but
   we don't prefetch the TLB, is that sufficient?
4. The atomics can be improved and we could use a static key like ibpb
   does to optimize the code path
5. The code works with a special hack for 64 bit systems (TIF_L1D_FLUSH
   is bit 32), we could generalize it with some effort
6. Should we consider cleaning up the L1D on arrival of tasks?

In summary, this is an early PoC to start the discussion on the need for
conditional L1D flushing based on the security posture of the
application and the sensitivity of the data it has access to or might
have access to.

Cc: keescook@chromium.org
Cc: benh@amazon.com

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/thread_info.h |  8 +++
 arch/x86/include/asm/tlbflush.h    |  6 ++
 arch/x86/include/uapi/asm/prctl.h  |  3 +
 arch/x86/kernel/process_64.c       | 12 +++-
 arch/x86/mm/tlb.c                  | 89 ++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 8de8ceccb8bc..c48ebfa17805 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -103,6 +103,9 @@ struct thread_info {
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
 #define TIF_X32			30	/* 32-bit native x86-64 binary */
 #define TIF_FSCHECK		31	/* Check FS is USER_DS on return */
+#ifdef CONFIG_64BIT
+#define TIF_L1D_FLUSH           32      /* Flush L1D on mm switches (processes) */
+#endif
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
@@ -132,6 +135,9 @@ struct thread_info {
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+#ifdef CONFIG_64BIT
+#define _TIF_L1D_FLUSH		(1UL << TIF_L1D_FLUSH)
+#endif
 
 /* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
@@ -239,6 +245,8 @@ extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
 extern void arch_setup_new_exec(void);
+extern void enable_l1d_flush_for_task(struct task_struct *tsk);
+extern void disable_l1d_flush_for_task(struct task_struct *tsk);
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
index ffd497804dbc..df9f8775ee94 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -700,7 +700,17 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+#ifdef CONFIG_64BIT
+	case ARCH_GET_L1D_FLUSH:
+		return test_ti_thread_flag(&task->thread_info, TIF_L1D_FLUSH);
+	case ARCH_SET_L1D_FLUSH: {
+		if (arg2 >= 1)
+			enable_l1d_flush_for_task(task);
+		else
+			disable_l1d_flush_for_task(task);
+		break;
+	}
+#endif
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 66f96f21a7b6..35a3970df0ef 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -151,6 +151,92 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+#define L1D_CACHE_ORDER 4
+static void *l1d_flush_pages;
+static DEFINE_MUTEX(l1d_flush_mutex);
+
+void enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	struct page *page;
+
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		goto done;
+
+	mutex_lock(&l1d_flush_mutex);
+	if (l1d_flush_pages)
+		goto done;
+	/*
+	 * These pages are never freed, we use the same
+	 * set of pages across multiple processes/contexts
+	 */
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, L1D_CACHE_ORDER);
+	if (!page)
+		return;
+
+	l1d_flush_pages = page_address(page);
+	/* I don't think we need to worry about KSM */
+done:
+	set_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
+	mutex_unlock(&l1d_flush_mutex);
+}
+
+void disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
+	smp_mb__after_atomic();
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
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	if (this_cpu_read(cpu_tlbstate.last_user_mm_l1d_flush) == 0)
+		goto check_next;
+
+	if (real_prev == next)
+		return;
+
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		goto done;
+	}
+
+	asm volatile(
+		/* Fill the cache */
+		"xorl	%%eax, %%eax\n"
+		".Lfill_cache:\n"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$64, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lfill_cache\n\t"
+		"lfence\n"
+		:: [flush_pages] "r" (l1d_flush_pages),
+		    [size] "r" (size)
+		: "eax", "ecx");
+
+done:
+	this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);
+	/* Make sure we clear the values before we set it again */
+	barrier();
+check_next:
+	if (tsk == NULL)
+		return;
+
+	/* Match the set/clear_bit barriers */
+	smp_rmb();
+
+	/* We don't need stringent checks as we opt-in/opt-out */
+	if (test_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH))
+		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 1);
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -433,6 +519,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
 
+	l1d_flush(next, tsk);
+
 	/* Make sure we write CR3 before loaded_mm. */
 	barrier();
 
@@ -503,6 +591,7 @@ void initialize_tlbstate_and_flush(void)
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
+	this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-- 
2.17.1

