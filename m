Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40BB20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFZSYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:59814 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgFZSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:48 -0400
IronPort-SDR: kRNjowz5aH1/Q3dmIZBfayuIj4o7vPUwhxG0Ztr2pgN7gffP22n3b1Vom90wGvTd5tbP0WvJkq
 prbTkzWTzi8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512962"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:47 -0700
IronPort-SDR: uvXWVxq89d4m6U51UFw9aiRqUfjVEGzf0CGVjTZVeLAwP7wn7z8u/HwI9i10xNBC6lPeTQMAY8
 CsyAl2AErGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153978"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:47 -0700
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
Subject: [PATCH V2 23/23] perf/x86/intel/lbr: Support XSAVES for arch LBR read
Date:   Fri, 26 Jun 2020 11:20:20 -0700
Message-Id: <1593195620-116988-24-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  7 +++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 70af3be..01ba5fe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -359,6 +359,7 @@ void x86_release_hardware(void)
 	if (atomic_dec_and_mutex_lock(&pmc_refcount, &pmc_reserve_mutex)) {
 		release_pmc_hardware();
 		release_ds_buffers();
+		release_lbr_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 419e880..c50c027 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -650,6 +650,7 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
+	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -684,6 +685,28 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
+
+	if (x86_pmu.arch_lbr && kmem_cache && !cpuc->lbr_xsave &&
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
+	if (!x86_pmu.arch_lbr)
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
@@ -923,6 +946,19 @@ static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
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
@@ -1731,14 +1767,15 @@ void __init intel_pmu_arch_lbr_init(void)
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
 
 	x86_pmu.arch_lbr = true;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 637f4cd..61154d2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -251,6 +251,7 @@ struct cpu_hw_events {
 	u64				br_sel;
 	void				*last_task_ctx;
 	int				last_log_id;
+	void				*lbr_xsave;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -1063,6 +1064,8 @@ void release_ds_buffers(void);
 
 void reserve_ds_buffers(void);
 
+void release_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 
 void intel_pmu_enable_bts(u64 config);
@@ -1203,6 +1206,10 @@ static inline void release_ds_buffers(void)
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

