Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7778BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615C020836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFZSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:25:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:59785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgFZSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:33 -0400
IronPort-SDR: 8vRkOh+QnaH65Ek6VVnpLE5MmdHElPXrUn8co/ZwwhX7CAorx3OCEhfITTpt2RG4M6xCJbk1tR
 1IR71S7zGfjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512887"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:32 -0700
IronPort-SDR: f0XsJgTubk+/MvrcpyfD2BlpOsTFd3D5jl7WVrriWaq2u1d6o1WfbX/UY7tGgly4vm53/7UIKs
 G0tMg5gxGJOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153840"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:32 -0700
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
Subject: [PATCH V2 04/23] perf/x86/intel/lbr: Add the function pointers for LBR save and restore
Date:   Fri, 26 Jun 2020 11:20:01 -0700
Message-Id: <1593195620-116988-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The MSRs of Architectural LBR are different from previous model-specific
LBR. Perf has to implement different functions to save and restore them.

The function pointers for LBR save and restore are introduced. Perf
should initialize the corresponding functions at boot time.

The generic optimizations, e.g. avoiding restore LBR if no one else
touched them, still apply for Architectural LBRs. The related codes are
not moved to model-specific functions.

Current model-specific LBR functions are set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  4 +++
 arch/x86/events/intel/lbr.c  | 71 +++++++++++++++++++++++++++-----------------
 arch/x86/events/perf_event.h |  6 ++++
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e08a591..117307a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3954,6 +3954,8 @@ static __initconst const struct x86_pmu core_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4002,6 +4004,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
 	.lbr_read		= intel_pmu_lbr_read_64,
+	.lbr_save		= intel_pmu_lbr_save,
+	.lbr_restore		= intel_pmu_lbr_restore,
 };
 
 static __init void intel_clovertown_quirk(void)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 42466a0..c0312ea 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -323,11 +323,37 @@ static inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
-static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+void intel_pmu_lbr_restore(void *ctx)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
 	unsigned lbr_idx, mask;
+	u64 tos = task_ctx->tos;
+
+	mask = x86_pmu.lbr_nr - 1;
+	for (i = 0; i < task_ctx->valid_lbrs; i++) {
+		lbr_idx = (tos - i) & mask;
+		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
+		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
+
+		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
+	}
+
+	for (; i < x86_pmu.lbr_nr; i++) {
+		lbr_idx = (tos - i) & mask;
+		wrlbr_from(lbr_idx, 0);
+		wrlbr_to(lbr_idx, 0);
+		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+	}
+
+	wrmsrl(x86_pmu.lbr_tos, tos);
+}
+
+static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 tos;
 
 	if (task_ctx->lbr_callstack_users == 0 ||
@@ -349,40 +375,18 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 		return;
 	}
 
-	mask = x86_pmu.lbr_nr - 1;
-	for (i = 0; i < task_ctx->valid_lbrs; i++) {
-		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
-		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
-
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
-	}
-
-	for (; i < x86_pmu.lbr_nr; i++) {
-		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, 0);
-		wrlbr_to(lbr_idx, 0);
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
-	}
+	x86_pmu.lbr_restore(task_ctx);
 
-	wrmsrl(x86_pmu.lbr_tos, tos);
 	task_ctx->lbr_stack_state = LBR_NONE;
 }
 
-static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+void intel_pmu_lbr_save(void *ctx)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct x86_perf_task_context *task_ctx = ctx;
 	unsigned lbr_idx, mask;
 	u64 tos, from;
 	int i;
 
-	if (task_ctx->lbr_callstack_users == 0) {
-		task_ctx->lbr_stack_state = LBR_NONE;
-		return;
-	}
-
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
@@ -397,6 +401,19 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
+}
+
+static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (task_ctx->lbr_callstack_users == 0) {
+		task_ctx->lbr_stack_state = LBR_NONE;
+		return;
+	}
+
+	x86_pmu.lbr_save(task_ctx);
+
 	task_ctx->lbr_stack_state = LBR_VALID;
 
 	cpuc->last_task_ctx = task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 70a0b5e..83ff188 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -693,6 +693,8 @@ struct x86_pmu {
 
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
+	void		(*lbr_save)(void *ctx);
+	void		(*lbr_restore)(void *ctx);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1086,6 +1088,10 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
 
 void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
 
+void intel_pmu_lbr_save(void *ctx);
+
+void intel_pmu_lbr_restore(void *ctx);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);
-- 
2.7.4

