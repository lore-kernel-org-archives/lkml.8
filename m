Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D8F206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGGS5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:57:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:57502 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGGS5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:57:22 -0400
IronPort-SDR: 4NjP2dxFHpzrleiQudLAPL6cpT9hgrLU9WE46kfxvnwXT421HxkfpyDZhoRFU+0ZoeQcTowLHW
 4ezi6vmteYzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149201696"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="149201696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 11:57:21 -0700
IronPort-SDR: yzKSuZTIuNOS0XG/vdZEpyyl0I+pd9Rip0Jt7utLwe1k62M/6kPVwnvDGIXPDMT3WHLRk/ASkP
 aKISysmdlRHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="483614880"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2020 11:57:20 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        like.xu@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/lbr: Enable NO_{CYCLES,FLAGS} for all LBR formats
Date:   Tue,  7 Jul 2020 11:53:37 -0700
Message-Id: <1594148017-122512-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

An option to disable reading branch flags/cycles was introduced in
commit b16a5b52eb90 ("perf/x86: Add option to disable reading branch
flags/cycles"). Currently, the option is only supported by the
LBR_FORMAT_INFO format. For the other LBR formats, including the legacy
LBR, Architectural LBR, and LBR PEBS record, there is no effect with the
NO_{CYCLES,FLAGS} flag set. The flags/cycles information is still
output, which breaks the ABI.

For all LBR formats, avoid output flags and cycles if the user
explicitly sets PERF_SAMPLE_BRANCH_NO_{CYCLES,FLAGS} branch type.

For Architectural LBR, the branch type information is retrieved from
the LBR_INFO field/MSR. With the NO_{CYCLES,FLAGS} flag set, the
LBR_INFO will not be read. The branch type information will relay on the
software decoding just like the legacy LBR.

Fixes: b16a5b52eb90 ("perf/x86: Add option to disable reading branch flags/cycles")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 130 ++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 52 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 63f58bd..944291a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -799,6 +799,14 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static inline bool lbr_need_info(struct cpu_hw_events *cpuc)
+{
+	if (cpuc->lbr_sel)
+		return !(cpuc->lbr_sel->config & LBR_NO_INFO);
+
+	return false;
+}
+
 /*
  * Due to lack of segmentation in Linux the effective address (offset)
  * is the same as the linear address, allowing us to merge the LIP and EIP
@@ -806,7 +814,8 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  */
 void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
-	bool need_info = false, call_stack = false;
+	bool need_info = lbr_need_info(cpuc);
+	bool call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	u64 tos = intel_pmu_lbr_tos();
@@ -814,11 +823,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	int out = 0;
 	int num = x86_pmu.lbr_nr;
 
-	if (cpuc->lbr_sel) {
-		need_info = !(cpuc->lbr_sel->config & LBR_NO_INFO);
-		if (cpuc->lbr_sel->config & LBR_CALL_STACK)
-			call_stack = true;
-	}
+	if (cpuc->lbr_sel && (cpuc->lbr_sel->config & LBR_CALL_STACK))
+		call_stack = true;
 
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
@@ -849,23 +855,28 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		}
 
 		if (lbr_format == LBR_FORMAT_TIME) {
-			mis = !!(from & LBR_FROM_FLAG_MISPRED);
-			pred = !mis;
 			skip = 1;
-			cycles = ((to >> 48) & LBR_INFO_CYCLES);
-
 			to = (u64)((((s64)to) << 16) >> 16);
+			if (need_info) {
+				mis = !!(from & LBR_FROM_FLAG_MISPRED);
+				pred = !mis;
+				cycles = ((to >> 48) & LBR_INFO_CYCLES);
+			}
 		}
 
 		if (lbr_flags & LBR_EIP_FLAGS) {
-			mis = !!(from & LBR_FROM_FLAG_MISPRED);
-			pred = !mis;
 			skip = 1;
+			if (need_info) {
+				mis = !!(from & LBR_FROM_FLAG_MISPRED);
+				pred = !mis;
+			}
 		}
 		if (lbr_flags & LBR_TSX) {
-			in_tx = !!(from & LBR_FROM_FLAG_IN_TX);
-			abort = !!(from & LBR_FROM_FLAG_ABORT);
 			skip = 3;
+			if (need_info) {
+				in_tx = !!(from & LBR_FROM_FLAG_IN_TX);
+				abort = !!(from & LBR_FROM_FLAG_ABORT);
+			}
 		}
 		from = (u64)((((s64)from) << skip) >> skip);
 
@@ -928,8 +939,21 @@ static __always_inline bool get_lbr_cycles(u64 info)
 	return info & LBR_INFO_CYCLES;
 }
 
+enum {
+	ARCH_LBR_BR_TYPE_JCC			= 0,
+	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
+	ARCH_LBR_BR_TYPE_NEAR_REL_JMP		= 2,
+	ARCH_LBR_BR_TYPE_NEAR_IND_CALL		= 3,
+	ARCH_LBR_BR_TYPE_NEAR_REL_CALL		= 4,
+	ARCH_LBR_BR_TYPE_NEAR_RET		= 5,
+	ARCH_LBR_BR_TYPE_KNOWN_MAX		= ARCH_LBR_BR_TYPE_NEAR_RET,
+
+	ARCH_LBR_BR_TYPE_MAP_MAX		= 16,
+};
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
-				struct lbr_entry *entries)
+				struct lbr_entry *entries,
+				bool need_info)
 {
 	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
@@ -948,16 +972,33 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 			break;
 
 		to = rdlbr_to(i, lbr);
-		info = rdlbr_info(i, lbr);
 
 		e->from		= from;
 		e->to		= to;
-		e->mispred	= get_lbr_mispred(info);
-		e->predicted	= get_lbr_predicted(info);
-		e->in_tx	= !!(info & LBR_INFO_IN_TX);
-		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= get_lbr_cycles(info);
-		e->type		= get_lbr_br_type(info);
+		if (need_info) {
+			info = rdlbr_info(i, lbr);
+			e->mispred	= get_lbr_mispred(info);
+			e->predicted	= get_lbr_predicted(info);
+			e->in_tx	= !!(info & LBR_INFO_IN_TX);
+			e->abort	= !!(info & LBR_INFO_ABORT);
+			e->cycles	= get_lbr_cycles(info);
+			e->type		= get_lbr_br_type(info);
+		} else {
+			e->mispred	= 0;
+			e->predicted	= 0;
+			e->in_tx	= 0;
+			e->abort	= 0;
+			e->cycles	= 0;
+			/*
+			 * For Architectural LBR, 0 means X86_BR_JCC. Assign an
+			 * invalid branch type, which will be ignored in the
+			 * intel_pmu_lbr_filter().
+			 *
+			 * For the legacy LBR, there is no branch type
+			 * information available. The field is always ignored.
+			 */
+			e->type		= ARCH_LBR_BR_TYPE_KNOWN_MAX + 1;
+		}
 		e->reserved	= 0;
 	}
 
@@ -966,7 +1007,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
 {
-	intel_pmu_store_lbr(cpuc, NULL);
+	intel_pmu_store_lbr(cpuc, NULL, lbr_need_info(cpuc));
 }
 
 static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
@@ -974,12 +1015,12 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(cpuc, NULL);
+		intel_pmu_store_lbr(cpuc, NULL, lbr_need_info(cpuc));
 		return;
 	}
 	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
 
-	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
+	intel_pmu_store_lbr(cpuc, xsave->lbr.entries, lbr_need_info(cpuc));
 }
 
 void intel_pmu_lbr_read(void)
@@ -1096,23 +1137,20 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 	reg = &event->hw.branch_reg;
 	reg->idx = EXTRA_REG_LBR;
 
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
 		reg->config = mask;
-		return 0;
+	else {
+		/*
+		 * The first 9 bits (LBR_SEL_MASK) in LBR_SELECT operate
+		 * in suppress mode. So LBR_SELECT should be set to
+		 * (~mask & LBR_SEL_MASK) | (mask & ~LBR_SEL_MASK)
+		 * But the 10th bit LBR_CALL_STACK does not operate
+		 * in suppress mode.
+		 */
+		reg->config = mask ^ (x86_pmu.lbr_sel_mask & ~LBR_CALL_STACK);
 	}
-
-	/*
-	 * The first 9 bits (LBR_SEL_MASK) in LBR_SELECT operate
-	 * in suppress mode. So LBR_SELECT should be set to
-	 * (~mask & LBR_SEL_MASK) | (mask & ~LBR_SEL_MASK)
-	 * But the 10th bit LBR_CALL_STACK does not operate
-	 * in suppress mode.
-	 */
-	reg->config = mask ^ (x86_pmu.lbr_sel_mask & ~LBR_CALL_STACK);
-
 	if ((br_type & PERF_SAMPLE_BRANCH_NO_CYCLES) &&
-	    (br_type & PERF_SAMPLE_BRANCH_NO_FLAGS) &&
-	    (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO))
+	    (br_type & PERF_SAMPLE_BRANCH_NO_FLAGS))
 		reg->config |= LBR_NO_INFO;
 
 	return 0;
@@ -1357,18 +1395,6 @@ common_branch_type(int type)
 	return PERF_BR_UNKNOWN;
 }
 
-enum {
-	ARCH_LBR_BR_TYPE_JCC			= 0,
-	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
-	ARCH_LBR_BR_TYPE_NEAR_REL_JMP		= 2,
-	ARCH_LBR_BR_TYPE_NEAR_IND_CALL		= 3,
-	ARCH_LBR_BR_TYPE_NEAR_REL_CALL		= 4,
-	ARCH_LBR_BR_TYPE_NEAR_RET		= 5,
-	ARCH_LBR_BR_TYPE_KNOWN_MAX		= ARCH_LBR_BR_TYPE_NEAR_RET,
-
-	ARCH_LBR_BR_TYPE_MAP_MAX		= 16,
-};
-
 static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
 	[ARCH_LBR_BR_TYPE_JCC]			= X86_BR_JCC,
 	[ARCH_LBR_BR_TYPE_NEAR_IND_JMP]		= X86_BR_IND_JMP,
@@ -1460,7 +1486,7 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(cpuc, lbr);
+	intel_pmu_store_lbr(cpuc, lbr, lbr_need_info(cpuc));
 	intel_pmu_lbr_filter(cpuc);
 }
 
-- 
2.7.4

