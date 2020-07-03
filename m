Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF25B20B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGCMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:53:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:25724 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGCMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:31 -0400
IronPort-SDR: e5xaOIY06CEbsykgs1Cguzp3eYC/YlFsjM2ytnuAcdOesq1EfMxkrq24TM0DXEfISI0wIDZJO8
 bQunMqCxVLTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598357"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:30 -0700
IronPort-SDR: BUWgK3zf+2GImsodQPAhvCV3pO80cFrg9tVDVuJnUXyQI85iiF3humW4zwHSncIkcZHGlZ5wFN
 RuNIBsF6Pz9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963980"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:30 -0700
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
Subject: [PATCH V3 05/23] perf/x86/intel/lbr: Factor out a new struct for generic optimization
Date:   Fri,  3 Jul 2020 05:49:11 -0700
Message-Id: <1593780569-62993-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To reduce the overhead of a context switch with LBR enabled, some
generic optimizations were introduced, e.g. avoiding restore LBR if no
one else touched them. The generic optimizations can also be used by
Architecture LBR later. Currently, the fields for the generic
optimizations are part of structure x86_perf_task_context, which will be
deprecated by Architecture LBR. A new structure should be introduced
for the common fields of generic optimization, which can be shared
between Architecture LBR and model-specific LBR.

Both 'valid_lbrs' and 'tos' are also used by the generic optimizations,
but they are not moved into the new structure, because Architecture LBR
is stack-like. The 'valid_lbrs' which records the index of the valid LBR
is not required anymore. The TOS MSR will be removed.

LBR registers may be cleared in the deep Cstate. If so, the generic
optimizations should not be applied. Perf has to unconditionally
restore the LBR registers. A generic function is required to detect the
reset due to the deep Cstate. lbr_is_reset_in_cstate() is introduced.
Currently, for the model-specific LBR, the TOS MSR is used to detect the
reset. There will be another method introduced for Architecture LBR
later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 38 +++++++++++++++++++++-----------------
 arch/x86/events/perf_event.h | 10 +++++++---
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b2b8dc9..bba9939 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -355,33 +355,37 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
+static __always_inline bool
+lbr_is_reset_in_cstate(struct x86_perf_task_context *task_ctx)
+{
+	return !rdlbr_from(task_ctx->tos);
+}
+
 static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 tos;
 
-	if (task_ctx->lbr_callstack_users == 0 ||
-	    task_ctx->lbr_stack_state == LBR_NONE) {
+	if (task_ctx->opt.lbr_callstack_users == 0 ||
+	    task_ctx->opt.lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
 	}
 
-	tos = task_ctx->tos;
 	/*
 	 * Does not restore the LBR registers, if
 	 * - No one else touched them, and
-	 * - Did not enter C6
+	 * - Was not cleared in Cstate
 	 */
 	if ((task_ctx == cpuc->last_task_ctx) &&
-	    (task_ctx->log_id == cpuc->last_log_id) &&
-	    rdlbr_from(tos)) {
-		task_ctx->lbr_stack_state = LBR_NONE;
+	    (task_ctx->opt.log_id == cpuc->last_log_id) &&
+	    !lbr_is_reset_in_cstate(task_ctx)) {
+		task_ctx->opt.lbr_stack_state = LBR_NONE;
 		return;
 	}
 
 	x86_pmu.lbr_restore(task_ctx);
 
-	task_ctx->lbr_stack_state = LBR_NONE;
+	task_ctx->opt.lbr_stack_state = LBR_NONE;
 }
 
 void intel_pmu_lbr_save(void *ctx)
@@ -415,17 +419,17 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_ctx->lbr_callstack_users == 0) {
-		task_ctx->lbr_stack_state = LBR_NONE;
+	if (task_ctx->opt.lbr_callstack_users == 0) {
+		task_ctx->opt.lbr_stack_state = LBR_NONE;
 		return;
 	}
 
 	x86_pmu.lbr_save(task_ctx);
 
-	task_ctx->lbr_stack_state = LBR_VALID;
+	task_ctx->opt.lbr_stack_state = LBR_VALID;
 
 	cpuc->last_task_ctx = task_ctx;
-	cpuc->last_log_id = ++task_ctx->log_id;
+	cpuc->last_log_id = ++task_ctx->opt.log_id;
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
@@ -447,8 +451,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	if (!prev_ctx_data || !next_ctx_data)
 		return;
 
-	swap(prev_ctx_data->lbr_callstack_users,
-	     next_ctx_data->lbr_callstack_users);
+	swap(prev_ctx_data->opt.lbr_callstack_users,
+	     next_ctx_data->opt.lbr_callstack_users);
 }
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
@@ -503,7 +507,7 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
 		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->lbr_callstack_users++;
+		task_ctx->opt.lbr_callstack_users++;
 	}
 
 	/*
@@ -543,7 +547,7 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (branch_user_callstack(cpuc->br_sel) &&
 	    event->ctx->task_ctx_data) {
 		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->lbr_callstack_users--;
+		task_ctx->opt.lbr_callstack_users--;
 	}
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6d11813..96d73cd 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -736,6 +736,12 @@ struct x86_pmu {
 	int (*aux_output_match) (struct perf_event *event);
 };
 
+struct x86_perf_task_context_opt {
+	int lbr_callstack_users;
+	int lbr_stack_state;
+	int log_id;
+};
+
 struct x86_perf_task_context {
 	u64 lbr_from[MAX_LBR_ENTRIES];
 	u64 lbr_to[MAX_LBR_ENTRIES];
@@ -743,9 +749,7 @@ struct x86_perf_task_context {
 	u64 lbr_sel;
 	int tos;
 	int valid_lbrs;
-	int lbr_callstack_users;
-	int lbr_stack_state;
-	int log_id;
+	struct x86_perf_task_context_opt opt;
 };
 
 #define x86_add_quirk(func_)						\
-- 
2.7.4

