Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE120C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB009207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgFSOIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:54739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbgFSOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:51 -0400
IronPort-SDR: G3hkeoufchvTxJgfoo97wm24Gqr7QDpkMbx4XXWRiUrXdr7R/iZwYns8+Tv2BdiTlSt+cxC7BI
 bXIL/qEibBkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452831"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:51 -0700
IronPort-SDR: eLkZPB/d/jHocSOKdqk+Ni6quioXNGIyjefyXx+cdbJbqOpd5El14w1dGJepIZHI9HC/5j0/P7
 sUJ+NSWJJYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837442"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:50 -0700
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
Subject: [PATCH 07/21] perf/x86/intel/lbr: Use dynamic data structure for task_ctx
Date:   Fri, 19 Jun 2020 07:03:55 -0700
Message-Id: <1592575449-64278-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 58 ++++++++++++++++++++------------------------
 arch/x86/events/perf_event.h |  7 +++++-
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f220a4c..1c253ab 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -351,17 +351,17 @@ void intel_pmu_lbr_restore(void *ctx)
 	wrmsrl(x86_pmu.lbr_tos, tos);
 }
 
-static bool lbr_is_reset_in_cstate(struct x86_perf_task_context *task_ctx)
+static bool lbr_is_reset_in_cstate(void *ctx)
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
@@ -371,16 +371,16 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
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
@@ -406,27 +406,27 @@ void intel_pmu_lbr_save(void *ctx)
 	task_ctx->tos = tos;
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
 
@@ -442,14 +442,14 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
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
@@ -486,17 +486,14 @@ static inline bool branch_user_callstack(unsigned br_sel)
 void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->opt.lbr_callstack_users++;
-	}
+	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data)
+		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users++;
 
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
@@ -527,16 +524,13 @@ void intel_pmu_lbr_add(struct perf_event *event)
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
 
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users--;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fd73c6c..e33d348 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -246,7 +246,7 @@ struct cpu_hw_events {
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
 	u64				br_sel;
-	struct x86_perf_task_context	*last_task_ctx;
+	void				*last_task_ctx;
 	int				last_log_id;
 
 	/*
@@ -798,6 +798,11 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+static inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
+{
+	return &((struct x86_perf_task_context *)ctx)->opt;
+}
+
 static inline bool x86_pmu_has_lbr_callstack(void)
 {
 	return  x86_pmu.lbr_sel_map &&
-- 
2.7.4

