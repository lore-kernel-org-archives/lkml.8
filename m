Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E2AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7DC20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFZSXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFZSXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:40 -0400
IronPort-SDR: u3XrPKTFQiRkXrkb1lqgb1PrWOXwWepafCl22c6UfmZNe3mcOu/8IBJii5QfFhAwEZgLdm2/Q5
 vzeUiPiLwMtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512922"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512922"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:39 -0700
IronPort-SDR: KBO84G6er8LfMIhGzOGT/0Wr1xlAU1nt1lrb4fanBMcu2vzo7al5fzEvu3P8sZ794dfWyRvO9b
 D1PGW6ytRShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153904"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:38 -0700
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
Subject: [PATCH V2 13/23] perf/x86/intel/lbr: Factor out intel_pmu_store_lbr
Date:   Fri, 26 Jun 2020 11:20:10 -0700
Message-Id: <1593195620-116988-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The way to store the LBR information from a PEBS LBR record can be
reused in Architecture LBR, because
- The LBR information is stored like a stack. Entry 0 is always the
  youngest branch.
- The layout of the LBR INFO MSR is similar.

The LBR information may be retrieved from either the LBR registers
(non-PEBS event) or a buffer (PEBS event). Extend rdlbr_*() to support
both methods.

Explicitly check the invalid entry (0s), which can avoid unnecessary MSR
access if using a non-PEBS event. For a PEBS event, the check should
slightly improve the performance as well. The invalid entries are cut.
The intel_pmu_lbr_filter() doesn't need to check and filter them out.

Cannot share the function with current model-specific LBR read, because
the direction of the LBR growth is opposite.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 81 +++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 459f1a5..bac18c4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -348,28 +348,37 @@ static inline void wrlbr_info(unsigned int idx, u64 val)
 	wrmsrl(x86_pmu.lbr_info + idx, val);
 }
 
-static inline u64 rdlbr_from(unsigned int idx)
+static inline u64 rdlbr_from(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->from;
+
 	rdmsrl(x86_pmu.lbr_from + idx, val);
 
 	return lbr_from_signext_quirk_rd(val);
 }
 
-static inline u64 rdlbr_to(unsigned int idx)
+static inline u64 rdlbr_to(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->to;
+
 	rdmsrl(x86_pmu.lbr_to + idx, val);
 
 	return val;
 }
 
-static inline u64 rdlbr_info(unsigned int idx)
+static inline u64 rdlbr_info(unsigned int idx, struct lbr_entry *lbr)
 {
 	u64 val;
 
+	if (lbr)
+		return lbr->info;
+
 	rdmsrl(x86_pmu.lbr_info + idx, val);
 
 	return val;
@@ -387,16 +396,16 @@ wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 static inline bool
 rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 {
-	u64 from = rdlbr_from(idx);
+	u64 from = rdlbr_from(idx, NULL);
 
 	/* Don't read invalid entry */
 	if (!from)
 		return false;
 
 	lbr->from = from;
-	lbr->to = rdlbr_to(idx);
+	lbr->to = rdlbr_to(idx, NULL);
 	if (need_info)
-		lbr->info = rdlbr_info(idx);
+		lbr->info = rdlbr_info(idx, NULL);
 
 	return true;
 }
@@ -428,7 +437,7 @@ void intel_pmu_lbr_restore(void *ctx)
 
 static bool lbr_is_reset_in_cstate(void *ctx)
 {
-	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos);
+	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
 static void __intel_pmu_lbr_restore(void *ctx)
@@ -687,8 +696,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		u16 cycles = 0;
 		int lbr_flags = lbr_desc[lbr_format];
 
-		from = rdlbr_from(lbr_idx);
-		to   = rdlbr_to(lbr_idx);
+		from = rdlbr_from(lbr_idx, NULL);
+		to   = rdlbr_to(lbr_idx, NULL);
 
 		/*
 		 * Read LBR call stack entries
@@ -700,7 +709,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
-			info = rdlbr_info(lbr_idx);
+			info = rdlbr_info(lbr_idx, NULL);
 			mis = !!(info & LBR_INFO_MISPRED);
 			pred = !mis;
 			in_tx = !!(info & LBR_INFO_IN_TX);
@@ -755,6 +764,42 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
+				struct lbr_entry *entries)
+{
+	struct perf_branch_entry *e;
+	struct lbr_entry *lbr;
+	u64 from, to, info;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		lbr = entries ? &entries[i] : NULL;
+		e = &cpuc->lbr_entries[i];
+
+		from = rdlbr_from(i, lbr);
+		/*
+		 * Read LBR entries until invalid entry (0s) is detected.
+		 */
+		if (!from)
+			break;
+
+		to = rdlbr_to(i, lbr);
+		info = rdlbr_info(i, lbr);
+
+		e->from		= from;
+		e->to		= to;
+		e->mispred	= !!(info & LBR_INFO_MISPRED);
+		e->predicted	= !(info & LBR_INFO_MISPRED);
+		e->in_tx	= !!(info & LBR_INFO_IN_TX);
+		e->abort	= !!(info & LBR_INFO_ABORT);
+		e->cycles	= info & LBR_INFO_CYCLES;
+		e->type		= 0;
+		e->reserved	= 0;
+	}
+
+	cpuc->lbr_stack.nr = i;
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1192,9 +1237,6 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int i;
-
-	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
 
 	/* Cannot get TOS for large PEBS */
 	if (cpuc->n_pebs == cpuc->n_large_pebs)
@@ -1202,19 +1244,8 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	for (i = 0; i < x86_pmu.lbr_nr; i++) {
-		u64 info = lbr->lbr[i].info;
-		struct perf_branch_entry *e = &cpuc->lbr_entries[i];
+	intel_pmu_store_lbr(cpuc, lbr->lbr);
 
-		e->from		= lbr->lbr[i].from;
-		e->to		= lbr->lbr[i].to;
-		e->mispred	= !!(info & LBR_INFO_MISPRED);
-		e->predicted	= !(info & LBR_INFO_MISPRED);
-		e->in_tx	= !!(info & LBR_INFO_IN_TX);
-		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= info & LBR_INFO_CYCLES;
-		e->reserved	= 0;
-	}
 	intel_pmu_lbr_filter(cpuc);
 }
 
-- 
2.7.4

