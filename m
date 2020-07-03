Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5AC20BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGCMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:54:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:25737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgGCMxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:41 -0400
IronPort-SDR: Bo/hlnEZDLc3AM10q7RE7P1fNAcXIezzFMebrKGs+XtSEF2kfP6GQlH4XWwWfXJrJ2Q42id1vx
 w4nZ0ZrOS6kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598381"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:39 -0700
IronPort-SDR: GsdvwcRlBDvX+uzXFljDrM/2iLKi9EUuJtmXeheISW4VMgA5dgZ7wwO1xUPC2bwAwYsQgBY7+e
 VheKNQi69y1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964010"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:39 -0700
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
Subject: [PATCH V3 12/23] perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()
Date:   Fri,  3 Jul 2020 05:49:18 -0700
Message-Id: <1593780569-62993-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The previous model-specific LBR and Architecture LBR (legacy way) use a
similar method to save/restore the LBR information, which directly
accesses the LBR registers. The codes which read/write a set of LBR
registers can be shared between them.

Factor out two functions which are used to read/write a set of LBR
registers.

Add lbr_info into structure x86_pmu, and use it to replace the hardcoded
LBR INFO MSR, because the LBR INFO MSR address of the previous
model-specific LBR is different from Architecture LBR. The MSR address
should be assigned at boot time. For now, only Sky Lake and later
platforms have the LBR INFO MSR.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c  | 66 +++++++++++++++++++++++++++++++++-----------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e3574a8..f47f41e 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -237,7 +237,7 @@ void intel_pmu_lbr_reset_64(void)
 		wrmsrl(x86_pmu.lbr_from + i, 0);
 		wrmsrl(x86_pmu.lbr_to   + i, 0);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + i, 0);
+			wrmsrl(x86_pmu.lbr_info + i, 0);
 	}
 }
 
@@ -343,6 +343,11 @@ static __always_inline void wrlbr_to(unsigned int idx, u64 val)
 	wrmsrl(x86_pmu.lbr_to + idx, val);
 }
 
+static __always_inline void wrlbr_info(unsigned int idx, u64 val)
+{
+	wrmsrl(x86_pmu.lbr_info + idx, val);
+}
+
 static __always_inline u64 rdlbr_from(unsigned int idx)
 {
 	u64 val;
@@ -361,8 +366,44 @@ static __always_inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
+static __always_inline u64 rdlbr_info(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(x86_pmu.lbr_info + idx, val);
+
+	return val;
+}
+
+static __always_inline void
+wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
+{
+	wrlbr_from(idx, lbr->from);
+	wrlbr_to(idx, lbr->to);
+	if (need_info)
+		wrlbr_info(idx, lbr->info);
+}
+
+static __always_inline bool
+rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
+{
+	u64 from = rdlbr_from(idx);
+
+	/* Don't read invalid entry */
+	if (!from)
+		return false;
+
+	lbr->from = from;
+	lbr->to = rdlbr_to(idx);
+	if (need_info)
+		lbr->info = rdlbr_info(idx);
+
+	return true;
+}
+
 void intel_pmu_lbr_restore(void *ctx)
 {
+	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
@@ -372,11 +413,7 @@ void intel_pmu_lbr_restore(void *ctx)
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, task_ctx->lbr[i].from);
-		wrlbr_to(lbr_idx, task_ctx->lbr[i].to);
-
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
+		wrlbr_all(&task_ctx->lbr[i], lbr_idx, need_info);
 	}
 
 	for (; i < x86_pmu.lbr_nr; i++) {
@@ -384,7 +421,7 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrlbr_from(lbr_idx, 0);
 		wrlbr_to(lbr_idx, 0);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+			wrlbr_info(lbr_idx, 0);
 	}
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
@@ -427,23 +464,19 @@ static void __intel_pmu_lbr_restore(void *ctx)
 
 void intel_pmu_lbr_save(void *ctx)
 {
+	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
 	unsigned lbr_idx, mask;
-	u64 tos, from;
+	u64 tos;
 	int i;
 
 	mask = x86_pmu.lbr_nr - 1;
 	tos = intel_pmu_lbr_tos();
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		lbr_idx = (tos - i) & mask;
-		from = rdlbr_from(lbr_idx);
-		if (!from)
+		if (!rdlbr_all(&task_ctx->lbr[i], lbr_idx, need_info))
 			break;
-		task_ctx->lbr[i].from = from;
-		task_ctx->lbr[i].to = rdlbr_to(lbr_idx);
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
@@ -689,7 +722,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, info);
+			info = rdlbr_info(lbr_idx);
 			mis = !!(info & LBR_INFO_MISPRED);
 			pred = !mis;
 			in_tx = !!(info & LBR_INFO_IN_TX);
@@ -1336,6 +1369,7 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
 	x86_pmu.lbr_to   = MSR_LBR_NHM_TO;
+	x86_pmu.lbr_info = MSR_LBR_INFO_0;
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
@@ -1421,7 +1455,7 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->nr = x86_pmu.lbr_nr;
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
-	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? MSR_LBR_INFO_0 : 0;
+	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
 
 	return 0;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5689036..06c1fd0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -690,7 +690,7 @@ struct x86_pmu {
 	 * Intel LBR
 	 */
 	unsigned int	lbr_tos, lbr_from, lbr_to,
-			lbr_nr;			   /* LBR base regs and size */
+			lbr_info, lbr_nr;	   /* LBR base regs and size */
 	union {
 		u64	lbr_sel_mask;		   /* LBR_SELECT valid bits */
 		u64	lbr_ctl_mask;		   /* LBR_CTL valid bits */
-- 
2.7.4

