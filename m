Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2C020BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGCMyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:54:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:25720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgGCMxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:37 -0400
IronPort-SDR: 4e51CoRbBILPk34kgr4noGKuwI0x5T430Al2ZGLrDznsGSgCwDunCcpNVF3ADy7SXjkKbcMBUA
 7bIpoL5U3gHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598377"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:37 -0700
IronPort-SDR: rT9rIsAgLF6BHwScu3dW92J6WMcLoq4HPzH0xrFizAW+cM8tl6Z2gKtefEeKhoEB2foeY7WdEz
 uusvEbQyeeiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964001"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:36 -0700
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
Subject: [PATCH V3 10/23] perf/x86/intel/lbr: Unify the stored format of LBR information
Date:   Fri,  3 Jul 2020 05:49:16 -0700
Message-Id: <1593780569-62993-11-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current LBR information in the structure x86_perf_task_context is stored
in a different format from the PEBS LBR record and Architecture LBR,
which prevents the sharing of the common codes.

Use the format of the PEBS LBR record as a unified format. Use a generic
name lbr_entry to replace pebs_lbr_entry.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c        |  4 ++--
 arch/x86/events/intel/lbr.c       | 12 ++++++------
 arch/x86/events/perf_event.h      |  4 +---
 arch/x86/include/asm/perf_event.h |  4 ++--
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index dc43cc1..0d33f85 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -954,7 +954,7 @@ static void adaptive_pebs_record_size_update(void)
 	if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 		sz += sizeof(struct pebs_xmm);
 	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
-		sz += x86_pmu.lbr_nr * sizeof(struct pebs_lbr_entry);
+		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
 
 	cpuc->pebs_record_size = sz;
 }
@@ -1598,7 +1598,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		struct pebs_lbr *lbr = next_record;
 		int num_lbr = ((format_size >> PEBS_DATACFG_LBR_SHIFT)
 					& 0xff) + 1;
-		next_record = next_record + num_lbr*sizeof(struct pebs_lbr_entry);
+		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7742562..815b3ce 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -372,11 +372,11 @@ void intel_pmu_lbr_restore(void *ctx)
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
 		lbr_idx = (tos - i) & mask;
-		wrlbr_from(lbr_idx, task_ctx->lbr_from[i]);
-		wrlbr_to  (lbr_idx, task_ctx->lbr_to[i]);
+		wrlbr_from(lbr_idx, task_ctx->lbr[i].from);
+		wrlbr_to(lbr_idx, task_ctx->lbr[i].to);
 
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
+			wrmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 
 	for (; i < x86_pmu.lbr_nr; i++) {
@@ -440,10 +440,10 @@ void intel_pmu_lbr_save(void *ctx)
 		from = rdlbr_from(lbr_idx);
 		if (!from)
 			break;
-		task_ctx->lbr_from[i] = from;
-		task_ctx->lbr_to[i]   = rdlbr_to(lbr_idx);
+		task_ctx->lbr[i].from = from;
+		task_ctx->lbr[i].to = rdlbr_to(lbr_idx);
 		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
-			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr_info[i]);
+			rdmsrl(MSR_LBR_INFO_0 + lbr_idx, task_ctx->lbr[i].info);
 	}
 	task_ctx->valid_lbrs = i;
 	task_ctx->tos = tos;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ba89e56..5689036 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -765,13 +765,11 @@ struct x86_perf_task_context_opt {
 };
 
 struct x86_perf_task_context {
-	u64 lbr_from[MAX_LBR_ENTRIES];
-	u64 lbr_to[MAX_LBR_ENTRIES];
-	u64 lbr_info[MAX_LBR_ENTRIES];
 	u64 lbr_sel;
 	int tos;
 	int valid_lbrs;
 	struct x86_perf_task_context_opt opt;
+	struct lbr_entry lbr[MAX_LBR_ENTRIES];
 };
 
 #define x86_add_quirk(func_)						\
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 9ffce7d..8aea47a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -282,12 +282,12 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
-struct pebs_lbr_entry {
+struct lbr_entry {
 	u64 from, to, info;
 };
 
 struct pebs_lbr {
-	struct pebs_lbr_entry lbr[0]; /* Variable length */
+	struct lbr_entry lbr[0]; /* Variable length */
 };
 
 /*
-- 
2.7.4

