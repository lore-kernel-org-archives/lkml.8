Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5CBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260ED20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFZSXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:59781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgFZSXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:39 -0400
IronPort-SDR: dUj4O923k+p294vMPkcAb9LwdFRdctaonnrhSDiehbUngO/IjPhpIepCINQCZM6bsrhVMaAskz
 TuSuSR5MN33w==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512919"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:38 -0700
IronPort-SDR: JiV/ej9fcO0nsDHxpYG0xSTXSInW+OikIwXC/M+ORU7IdcDnQjm25EFVwereaex9A1PiCtNdyw
 S8ZpMODXCxgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153897"
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
Subject: [PATCH V2 12/23] perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()
Date:   Fri, 26 Jun 2020 11:20:09 -0700
Message-Id: <1593195620-116988-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 64 +++++++++++++++++++++++++++++++++-----------
 arch/x86/events/perf_event.h |  3 ++-
 2 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 3d5fec4..459f1a5 100644
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
 
@@ -343,6 +343,11 @@ static inline void wrlbr_to(unsigned int idx, u64 val)
 	wrmsrl(x86_pmu.lbr_to + idx, val);
 }
 
+static inline void wrlbr_info(unsigned int idx, u64 val)
+{
+	wrmsrl(x86_pmu.lbr_info + idx, val);
+}
+
 static inline u64 rdlbr_from(unsigned int idx)
 {
 	u64 val;
@@ -361,8 +366,44 @@ static inline u64 rdlbr_to(unsigned int idx)
 	return val;
 }
 
+static inline u64 rdlbr_info(unsigned int idx)
+{
+	u64 val;
+
+	rdmsrl(x86_pmu.lbr_info + idx, val);
+
+	return val;
+}
+
+static inline void
+wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
+{
+	wrlbr_from(idx, lbr->from);
+	wrlbr_to(idx, lbr->to);
+	if (need_info)
+		wrlbr_info(idx, lbr->info);
+}
+
+static inline bool
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
 	struct x86_perf_task_context *task_ctx = ctx;
 	int i;
 	unsigned lbr_idx, mask;
@@ -371,11 +412,7 @@ void intel_pmu_lbr_restore(void *ctx)
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
@@ -383,7 +420,7 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrlbr_from(lbr_idx, 0);
 		wrlbr_to(lbr_idx, 0);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, 0);
+			wrlbr_info(lbr_idx, 0);
 	}
 
 	wrmsrl(x86_pmu.lbr_tos, tos);
@@ -423,22 +460,18 @@ static void __intel_pmu_lbr_restore(void *ctx)
 
 void intel_pmu_lbr_save(void *ctx)
 {
+	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
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
@@ -667,7 +700,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (lbr_format == LBR_FORMAT_INFO && need_info) {
 			u64 info;
 
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, info);
+			info = rdlbr_info(lbr_idx);
 			mis = !!(info & LBR_INFO_MISPRED);
 			pred = !mis;
 			in_tx = !!(info & LBR_INFO_IN_TX);
@@ -1313,6 +1346,7 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
 	x86_pmu.lbr_to   = MSR_LBR_NHM_TO;
+	x86_pmu.lbr_info = MSR_LBR_INFO_0;
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fd16ed3..5649838 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -687,7 +687,8 @@ struct x86_pmu {
 	/*
 	 * Intel LBR
 	 */
-	unsigned long	lbr_tos, lbr_from, lbr_to; /* MSR base regs       */
+	unsigned long	lbr_tos, lbr_from;	   /* MSR base regs       */
+	unsigned long	lbr_to, lbr_info;	   /* MSR base regs cont. */
 	int		lbr_nr;			   /* hardware stack size */
 	union {
 		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
-- 
2.7.4

