Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B7020CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGCMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:54:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:25759 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgGCMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:56 -0400
IronPort-SDR: R0T/UwHRT4Wiq6PdkYk+5E5ICj/5vfVwLoplTS/u8IjOGcnmysFc51pkZ9Hnv5ISxU+vH1TD2t
 aD398+4BHCoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598419"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:54 -0700
IronPort-SDR: j774a5Cul7EJSoBqP4DSfkfP8h6n0vJ4y9qZDgNG5LUzvE8p3MWx+YoJ0D5CqLLF3YH0HkZCWN
 hDM3gwbRmBPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964065"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:53 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 23/23] perf/x86/intel/lbr: Support XSAVES for arch LBR read
Date:   Fri,  3 Jul 2020 05:49:29 -0700
Message-Id: <1593780569-62993-24-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Reading LBR registers in a perf NMI handler for a non-PEBS event
causes a high overhead because the number of LBR registers is huge.
To reduce the overhead, the XSAVES instruction should be used to replace
the LBR registers' reading method.

The XSAVES buffer used for LBR read has to be per-CPU because the NMI
handler invoked the lbr_read(). The existing task_ctx_data buffer
cannot be used which is per-task and only be allocated for the LBR call
stack mode. A new lbr_xsave pointer is introduced in the cpu_hw_events
as an XSAVES buffer for LBR read.

The XSAVES buffer should be allocated only when LBR is used by a
non-PEBS event on the CPU because the total size of the lbr_xsave is
not small (~1.4KB).

The XSAVES buffer is allocated when a non-PEBS event is added, but it
is lazily released in x86_release_hardware() when perf releases the
entire PMU hardware resource, because perf may frequently schedule the
event, e.g. high context switch. The lazy release method reduces the
overhead of frequently allocate/free the buffer.

If the lbr_xsave fails to be allocated, roll back to normal Arch LBR
lbr_read().

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  1 +
 arch/x86/events/intel/lbr.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  7 +++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6b1228a..1cbf57d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -358,6 +358,7 @@ void x86_release_hardware(void)
 	if (atomic_dec_and_mutex_lock(&pmc_refcount, &pmc_reserve_mutex)) {
 		release_pmc_hardware();
 		release_ds_buffers();
+		release_lbr_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index a98f44c..213e814 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -658,6 +658,7 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
+	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -695,6 +696,29 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
+
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+	    kmem_cache && !cpuc->lbr_xsave &&
+	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
+		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
+}
+
+void release_lbr_buffers(void)
+{
+	struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
+	struct cpu_hw_events *cpuc;
+	int cpu;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		if (kmem_cache && cpuc->lbr_xsave) {
+			kmem_cache_free(kmem_cache, cpuc->lbr_xsave);
+			cpuc->lbr_xsave = NULL;
+		}
+	}
 }
 
 void intel_pmu_lbr_del(struct perf_event *event)
@@ -945,6 +969,19 @@ static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 	intel_pmu_store_lbr(cpuc, NULL);
 }
 
+static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+{
+	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
+
+	if (!xsave) {
+		intel_pmu_store_lbr(cpuc, NULL);
+		return;
+	}
+	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+
+	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1768,14 +1805,15 @@ void __init intel_pmu_arch_lbr_init(void)
 		x86_pmu.lbr_ctl_map = NULL;
 
 	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
-	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
 	if (arch_lbr_xsave) {
 		x86_pmu.lbr_save = intel_pmu_arch_lbr_xsaves;
 		x86_pmu.lbr_restore = intel_pmu_arch_lbr_xrstors;
+		x86_pmu.lbr_read = intel_pmu_arch_lbr_read_xsave;
 		pr_cont("XSAVE ");
 	} else {
 		x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
 		x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+		x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
 	}
 
 	pr_cont("Architectural LBR, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 13dd1e4..ddffdca 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -253,6 +253,7 @@ struct cpu_hw_events {
 	void				*last_task_ctx;
 	int				last_log_id;
 	int				lbr_select;
+	void				*lbr_xsave;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -1068,6 +1069,8 @@ void release_ds_buffers(void);
 
 void reserve_ds_buffers(void);
 
+void release_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 extern struct event_constraint vlbr_constraint;
 
@@ -1209,6 +1212,10 @@ static inline void release_ds_buffers(void)
 {
 }
 
+static inline void release_lbr_buffers(void)
+{
+}
+
 static inline int intel_pmu_init(void)
 {
 	return 0;
-- 
2.7.4

