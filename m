Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40885C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127AE2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7msE5L3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dF3EnJGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCIBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:01:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57374 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:01:30 -0400
Date:   Fri, 03 Jul 2020 08:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF3GVvbA0Xwh4O4iVZAo7zDq2zNDBwU7REYi0w55ZXI=;
        b=w7msE5L3YsqoYsSVPkggZUWGPoy+o4eSUFaAZTl5OaygyWd4M/L1ctgqLUwI5MreD0x5jD
        YDUAY19F+2hTB1KfpTVSZIk40KmbAorEo0g7G5kuk+YKkVmBkiF+F5b5ddYepJkv8udmzs
        1yk76NwLJWl1LWLlxPqgja6N0IHld2DBft52QtMOMaepY5bbe46wd+0A5zG+9Z5cjyjyv/
        AP7sHXETMRyXXa4otmPfihZbaWZTsh04EFWZvd7bgXDzrJlZ7/U2u3Pmtw+XZbKvcpS7RE
        dJaHNzfbMHD1IriR2a5b6+VZ+f7KspOOOAuHQzDQpsxQ6QMmW3Tn1CGcZxqpPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF3GVvbA0Xwh4O4iVZAo7zDq2zNDBwU7REYi0w55ZXI=;
        b=dF3EnJGdWu775OqOiiAvsrmsq1vcdGz6W58WsQf+SyQJyCqqnCI6OA6lE8Qf1/T9BwmW1r
        /vaF1qQcO9RiSECA==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Keep LBR records unchanged in host context
 for guest usage
Cc:     Like Xu <like.xu@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200514083054.62538-6-like.xu@linux.intel.com>
References: <20200514083054.62538-6-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159376328596.4006.5641044935018971853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e1ad1ac2deb8f90af9f12ff316989dd5675dec11
Gitweb:        https://git.kernel.org/tip/e1ad1ac2deb8f90af9f12ff316989dd5675dec11
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Sat, 13 Jun 2020 16:09:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 02 Jul 2020 15:51:46 +02:00

perf/x86: Keep LBR records unchanged in host context for guest usage

When a guest wants to use the LBR registers, its hypervisor creates a guest
LBR event and let host perf schedules it. The LBR records msrs are
accessible to the guest when its guest LBR event is scheduled on
by the perf subsystem.

Before scheduling this event out, we should avoid host changes on
IA32_DEBUGCTLMSR or LBR_SELECT. Otherwise, some unexpected branch
operations may interfere with guest behavior, pollute LBR records, and even
cause host branches leakage. In addition, the read operation
on host is also avoidable.

To ensure that guest LBR records are not lost during the context switch,
the guest LBR event would enable the callstack mode which could
save/restore guest unread LBR records with the help of
intel_pmu_lbr_sched_task() naturally.

However, the guest LBR_SELECT may changes for its own use and the host
LBR event doesn't save/restore it. To ensure that we doesn't lost the guest
LBR_SELECT value when the guest LBR event is running, the vlbr_constraint
is bound up with a new constraint flag PERF_X86_EVENT_LBR_SELECT.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200514083054.62538-6-like.xu@linux.intel.com
---
 arch/x86/events/intel/core.c |  6 ++++--
 arch/x86/events/intel/lbr.c  | 31 ++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h |  3 +++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 51e1fba..582ddff 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2189,7 +2189,8 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	} else if (idx == INTEL_PMC_IDX_FIXED_BTS) {
 		intel_pmu_disable_bts();
 		intel_pmu_drain_bts_buffer();
-	}
+	} else if (idx == INTEL_PMC_IDX_FIXED_VLBR)
+		intel_clear_masks(event, idx);
 
 	/*
 	 * Needs to be called after x86_pmu_disable_event,
@@ -2271,7 +2272,8 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		if (!__this_cpu_read(cpu_hw_events.enabled))
 			return;
 		intel_pmu_enable_bts(hwc->config);
-	}
+	} else if (idx == INTEL_PMC_IDX_FIXED_VLBR)
+		intel_set_masks(event, idx);
 }
 
 static void intel_pmu_add_event(struct perf_event *event)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index d285d26..d03de75 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -383,6 +383,9 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
 	task_ctx->lbr_stack_state = LBR_NONE;
+
+	if (cpuc->lbr_select)
+		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
@@ -415,6 +418,9 @@ static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
 
 	cpuc->last_task_ctx = task_ctx;
 	cpuc->last_log_id = ++task_ctx->log_id;
+
+	if (cpuc->lbr_select)
+		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
@@ -485,6 +491,9 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
+	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
+		cpuc->lbr_select = 1;
+
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
 	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
@@ -532,6 +541,9 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		task_ctx->lbr_callstack_users--;
 	}
 
+	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
+		cpuc->lbr_select = 0;
+
 	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
 		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
@@ -540,11 +552,19 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	perf_sched_cb_dec(event->ctx->pmu);
 }
 
+static inline bool vlbr_exclude_host(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	return test_bit(INTEL_PMC_IDX_FIXED_VLBR,
+		(unsigned long *)&cpuc->intel_ctrl_guest_mask);
+}
+
 void intel_pmu_lbr_enable_all(bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !vlbr_exclude_host())
 		__intel_pmu_lbr_enable(pmi);
 }
 
@@ -552,7 +572,7 @@ void intel_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->lbr_users)
+	if (cpuc->lbr_users && !vlbr_exclude_host())
 		__intel_pmu_lbr_disable();
 }
 
@@ -694,7 +714,8 @@ void intel_pmu_lbr_read(void)
 	 * This could be smarter and actually check the event,
 	 * but this simple approach seems to work for now.
 	 */
-	if (!cpuc->lbr_users || cpuc->lbr_users == cpuc->lbr_pebs_users)
+	if (!cpuc->lbr_users || vlbr_exclude_host() ||
+	    cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
@@ -1365,5 +1386,5 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
 struct event_constraint vlbr_constraint =
-	FIXED_EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT,
-			       (INTEL_PMC_IDX_FIXED_VLBR - INTEL_PMC_IDX_FIXED));
+	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED_VLBR),
+			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 77a6dd6..8147596 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -78,6 +78,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
 #define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
+#define PERF_X86_EVENT_LBR_SELECT	0x2000 /* Save/Restore MSR_LBR_SELECT */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -237,6 +238,7 @@ struct cpu_hw_events {
 	u64				br_sel;
 	struct x86_perf_task_context	*last_task_ctx;
 	int				last_log_id;
+	int				lbr_select;
 
 	/*
 	 * Intel host/guest exclude bits
@@ -722,6 +724,7 @@ struct x86_perf_task_context {
 	u64 lbr_from[MAX_LBR_ENTRIES];
 	u64 lbr_to[MAX_LBR_ENTRIES];
 	u64 lbr_info[MAX_LBR_ENTRIES];
+	u64 lbr_sel;
 	int tos;
 	int valid_lbrs;
 	int lbr_callstack_users;
