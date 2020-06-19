Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D8C217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgFSOIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:54759 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbgFSOIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:22 -0400
IronPort-SDR: EZ3jy048xGEXKI6AAnRgmIIKSIUHfwgzO7L3ud8KDc7J4VLDmCnRFK9IgsLcAxCiR3FcS4mNDn
 3qDK761S+dOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452887"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:08:09 -0700
IronPort-SDR: /bdzs3HYzShnCnYC/GlSHli+rnhpjOCEhFmwyZlQrp+Xt9L0upwQxYYwZE6N2x82qk7E69l9AW
 3fwqo5Kqo00g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837539"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:08:08 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 21/21] perf/x86/intel/lbr: Support XSAVES for arch LBR read
Date:   Fri, 19 Jun 2020 07:04:09 -0700
Message-Id: <1592575449-64278-22-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 58 +++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  7 ++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index aeb6e6d..3339347 100644
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
index dc40a76..4b0042f 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -624,6 +624,7 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
+	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -658,6 +659,28 @@ void intel_pmu_lbr_add(struct perf_event *event)
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
@@ -909,6 +932,38 @@ static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.nr = i;
 }
 
+static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
+{
+	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
+	struct arch_lbr_entry *lbr;
+	int i;
+
+	if (!xsave)
+		goto rollback;
+
+	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		lbr = &xsave->lbr.entries[i];
+
+		/*
+		 * Read LBR entries until invalid entry (0s) is detected.
+		 */
+		if (!lbr->lbr_from)
+			break;
+
+		__intel_pmu_arch_lbr_read(cpuc, i, lbr->lbr_from,
+					  lbr->lbr_to, lbr->lbr_info);
+	}
+
+	cpuc->lbr_stack.nr = i;
+
+	return;
+
+rollback:
+	intel_pmu_arch_lbr_read(cpuc);
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1757,14 +1812,15 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_enable = intel_pmu_arch_lbr_enable;
 	x86_pmu.lbr_disable = intel_pmu_arch_lbr_disable;
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
index 812980e..b9dfc55 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -251,6 +251,7 @@ struct cpu_hw_events {
 	u64				br_sel;
 	void				*last_task_ctx;
 	int				last_log_id;
+	void				*lbr_xsave;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -1106,6 +1107,8 @@ void release_ds_buffers(void);
 
 void reserve_ds_buffers(void);
 
+void release_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 
 void intel_pmu_enable_bts(u64 config);
@@ -1250,6 +1253,10 @@ static inline void release_ds_buffers(void)
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

