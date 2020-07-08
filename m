Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E2E20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGRcUCaT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4glEeouD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgGHJwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgGHJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A637C08C5DC;
        Wed,  8 Jul 2020 02:51:55 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BABtt8JPWN3rlBBH1ciPbHtmLH2BeaW9FXl0cKPKMWQ=;
        b=fGRcUCaTgxBI6/ho064O1Gg2i6RgTbrFJQbe8tq4VXs3dAuBpa0dC67fMSnLGJu/pc9U1H
        82I/9IZplq4bJ+KVkNyKvzA1bxzP65POXxFCokEbr0EC1rt18k5eDrE0yPiOAR16sc7c7Y
        0xJDUk1icfpQp4Zg1dodkJBUBnn8gYUKtGnYavcUFmoWD/+BSFx/JF7h59mCMnj+Uhh8kv
        EhXIU2bWnn5pEhxAsG2u8H2G+icqVRlX+f3lYzTOS/Oh7Y6DYS37nY5zE3M8LUVQXtqGOo
        GNee8Pn2KA5nt2mz21WnIm6NuKfxHv0bYEAfwrFC9L2z2pmhKzZU8/FVCHHN6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BABtt8JPWN3rlBBH1ciPbHtmLH2BeaW9FXl0cKPKMWQ=;
        b=4glEeouDUUNJfjZOlj5bYtOGFHmDPNQykfGExTEZDlwOtLohpFezBFT2yuOY8/4wcPx8mp
        Ut/OF7KJVRCaXGBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Factor out a new struct for
 generic optimization
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-6-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191352.4006.2167850556977785186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     530bfff6480307d210734222a54d56af7f908957
Gitweb:        https://git.kernel.org/tip/530bfff6480307d210734222a54d56af7f908957
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:52 +02:00

perf/x86/intel/lbr: Factor out a new struct for generic optimization

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c  | 38 +++++++++++++++++++----------------
 arch/x86/events/perf_event.h | 10 ++++++---
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
