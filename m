Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31516C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF4120BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgGCMzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:55:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:25720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgGCMxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:32 -0400
IronPort-SDR: zIcFegxIcQbo4r5bHj//yy+MOUt79hh0bhCj4jZEb0uMsL8FRIbuYUn7kKAa+TcSi+vWz/nkgd
 M59HcRDFTL4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598362"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:32 -0700
IronPort-SDR: lhz7ssSAs0zrD9cuZJwkksYBAI3tSb6dCoKWRdWal6tV4j0PyrOvf+L88OX0vsFO6ABaEI2kzL
 NNXAwvgeWJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963985"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:31 -0700
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
Subject: [PATCH V3 06/23] perf/x86/intel/lbr: Use dynamic data structure for task_ctx
Date:   Fri,  3 Jul 2020 05:49:12 -0700
Message-Id: <1593780569-62993-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The type of task_ctx is hardcoded as struct x86_perf_task_context,
which doesn't apply for Architecture LBR. For example, Architecture LBR
doesn't have the TOS MSR. The number of LBR entries is variable. A new
struct will be introduced for Architecture LBR. Perf has to determine
the type of task_ctx at run time.

The type of task_ctx pointer is changed to 'void *', which will be
determined at run time.

The generic LBR optimization can be shared between Architecture LBR and
model-specific LBR. Both need to access the structure for the generic
LBR optimization. A helper task_context_opt() is introduced to retrieve
the pointer of the structure at run time.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 59 +++++++++++++++++++-------------------------
 arch/x86/events/perf_event.h |  7 +++++-
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bba9939..e62baa9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -355,18 +355,17 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static __always_inline bool
-lbr_is_reset_in_cstate(struct x86_perf_task_context *task_ctx)
+static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 {
-	return !rdlbr_from(task_ctx->tos);
+	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos);
 }
 
-static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_ctx->opt.lbr_callstack_users == 0 ||
-	    task_ctx->opt.lbr_stack_state == LBR_NONE) {
+	if (task_context_opt(ctx)->lbr_callstack_users == 0 ||
+	    task_context_opt(ctx)->lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
 	}
@@ -376,16 +375,16 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 	 * - No one else touched them, and
 	 * - Was not cleared in Cstate
 	 */
-	if ((task_ctx == cpuc->last_task_ctx) &&
-	    (task_ctx->opt.log_id == cpuc->last_log_id) &&
-	    !lbr_is_reset_in_cstate(task_ctx)) {
-		task_ctx->opt.lbr_stack_state = LBR_NONE;
+	if ((ctx == cpuc->last_task_ctx) &&
+	    (task_context_opt(ctx)->log_id == cpuc->last_log_id) &&
+	    !lbr_is_reset_in_cstate(ctx)) {
+		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
-	x86_pmu.lbr_restore(task_ctx);
+	x86_pmu.lbr_restore(ctx);
 
-	task_ctx->opt.lbr_stack_state = LBR_NONE;
+	task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 }
 
 void intel_pmu_lbr_save(void *ctx)
@@ -415,27 +414,27 @@ void intel_pmu_lbr_save(void *ctx)
 		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_ctx->opt.lbr_callstack_users == 0) {
-		task_ctx->opt.lbr_stack_state = LBR_NONE;
+	if (task_context_opt(ctx)->lbr_callstack_users == 0) {
+		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
-	x86_pmu.lbr_save(task_ctx);
+	x86_pmu.lbr_save(ctx);
 
-	task_ctx->opt.lbr_stack_state = LBR_VALID;
+	task_context_opt(ctx)->lbr_stack_state = LBR_VALID;
 
-	cpuc->last_task_ctx = task_ctx;
-	cpuc->last_log_id = ++task_ctx->opt.log_id;
+	cpuc->last_task_ctx = ctx;
+	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 				 struct perf_event_context *next)
 {
-	struct x86_perf_task_context *prev_ctx_data, *next_ctx_data;
+	void *prev_ctx_data, *next_ctx_data;
 
 	swap(prev->task_ctx_data, next->task_ctx_data);
 
@@ -451,14 +450,14 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	if (!prev_ctx_data || !next_ctx_data)
 		return;
 
-	swap(prev_ctx_data->opt.lbr_callstack_users,
-	     next_ctx_data->opt.lbr_callstack_users);
+	swap(task_context_opt(prev_ctx_data)->lbr_callstack_users,
+	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
+	void *task_ctx;
 
 	if (!cpuc->lbr_users)
 		return;
@@ -495,7 +494,6 @@ static inline bool branch_user_callstack(unsigned br_sel)
 void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
@@ -505,10 +503,8 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->opt.lbr_callstack_users++;
-	}
+	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data)
+		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users++;
 
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
@@ -539,16 +535,13 @@ void intel_pmu_lbr_add(struct perf_event *event)
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->opt.lbr_callstack_users--;
-	}
+	    event->ctx->task_ctx_data)
+		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users--;
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 96d73cd..7dbf148 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -247,7 +247,7 @@ struct cpu_hw_events {
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
 	u64				br_sel;
-	struct x86_perf_task_context	*last_task_ctx;
+	void				*last_task_ctx;
 	int				last_log_id;
 	int				lbr_select;
 
@@ -800,6 +800,11 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
+{
+	return &((struct x86_perf_task_context *)ctx)->opt;
+}
+
 static inline bool x86_pmu_has_lbr_callstack(void)
 {
 	return  x86_pmu.lbr_sel_map &&
-- 
2.7.4

