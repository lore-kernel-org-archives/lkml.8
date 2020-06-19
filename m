Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AFFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABF0207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbgFSOIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:54759 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733046AbgFSOIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:16 -0400
IronPort-SDR: iQn801PD5aUDLQY+d6i6WhDQ151Vt6WrtHxL0ggL/Dpqzwygrg/PEUGTvzmLpL704DzT3+KOWk
 KZyDKzP92U4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452852"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:56 -0700
IronPort-SDR: aqsEertNuRHMUv/DwmeUviI/KXV8VdgT5bImkeNwl4l81qffHMCK374AdeQ39+vZmHVnyARUxf
 kByNPcHO0d1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837469"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:55 -0700
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
Subject: [PATCH 11/21] perf/x86/intel/lbr: Support LBR_CTL
Date:   Fri, 19 Jun 2020 07:03:59 -0700
Message-Id: <1592575449-64278-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

An IA32_LBR_CTL is introduced for Architecture LBR to enable and config
LBR registers to replace the previous LBR_SELECT.

All the related members in struct cpu_hw_events and struct x86_pmu
have to be renamed.

Some new macros are added to reflect the layout of LBR_CTL.

The mapping from PERF_SAMPLE_BRANCH_* to the corresponding bits in
LBR_CTL MSR is saved in lbr_ctl_map now, which is not a const value.
The value relies on the CPUID enumeration.

A dedicated HW LBR filter is implemented for Architecture LBR. For the
previous model-specific LBR, most of the bits in LBR_SELECT operate in
the suppressed mode. For the bits in LBR_CTL, the polarity is inverted.

For the previous model-specific LBR format 5 (LBR_FORMAT_INFO), if the
NO_CYCLES and NO_FLAGS type are set, the flag LBR_NO_INFO will be set to
avoid the unnecessary LBR_INFO MSR read. Although Architecture LBR also
has a dedicated LBR_INFO MSR, perf doesn't need to check and set the
flag LBR_NO_INFO. For Architecture LBR, XSAVES instruction will be used
as the default way to read the LBR MSRs all together. The overhead which
the flag tries to avoid doesn't exist anymore. Dropping the flag can
save the extra check for the flag in the lbr_read() later, and make the
code cleaner.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  4 +--
 arch/x86/events/intel/lbr.c  | 73 +++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h | 18 ++++++++---
 3 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c3372bd..6462ef2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3680,7 +3680,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
 
-	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
+	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map || x86_pmu.lbr_ctl_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
 			goto err;
@@ -3778,7 +3778,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		cpuc->shared_regs->refcnt++;
 	}
 
-	if (x86_pmu.lbr_sel_map)
+	if (x86_pmu.lbr_sel_map || x86_pmu.lbr_ctl_map)
 		cpuc->lbr_sel = &cpuc->shared_regs->regs[EXTRA_REG_LBR];
 
 	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1c253ab..b34beb5 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -132,6 +132,44 @@ enum {
 	 X86_BR_IRQ		|\
 	 X86_BR_INT)
 
+/*
+ * Intel LBR_CTL bits
+ *
+ * Hardware branch filter for Arch LBR
+ */
+#define ARCH_LBR_KERNEL_BIT		1  /* capture at ring0 */
+#define ARCH_LBR_USER_BIT		2  /* capture at ring > 0 */
+#define ARCH_LBR_CALL_STACK_BIT		3  /* enable call stack */
+#define ARCH_LBR_JCC_BIT		16 /* capture conditional branches */
+#define ARCH_LBR_REL_JMP_BIT		17 /* capture relative jumps */
+#define ARCH_LBR_IND_JMP_BIT		18 /* capture indirect jumps */
+#define ARCH_LBR_REL_CALL_BIT		19 /* capture relative calls */
+#define ARCH_LBR_IND_CALL_BIT		20 /* capture indirect calls */
+#define ARCH_LBR_RETURN_BIT		21 /* capture near returns */
+#define ARCH_LBR_OTHER_BRANCH_BIT	22 /* capture other branches */
+
+#define ARCH_LBR_KERNEL			(1ULL << ARCH_LBR_KERNEL_BIT)
+#define ARCH_LBR_USER			(1ULL << ARCH_LBR_USER_BIT)
+#define ARCH_LBR_CALL_STACK		(1ULL << ARCH_LBR_CALL_STACK_BIT)
+#define ARCH_LBR_JCC			(1ULL << ARCH_LBR_JCC_BIT)
+#define ARCH_LBR_REL_JMP		(1ULL << ARCH_LBR_REL_JMP_BIT)
+#define ARCH_LBR_IND_JMP		(1ULL << ARCH_LBR_IND_JMP_BIT)
+#define ARCH_LBR_REL_CALL		(1ULL << ARCH_LBR_REL_CALL_BIT)
+#define ARCH_LBR_IND_CALL		(1ULL << ARCH_LBR_IND_CALL_BIT)
+#define ARCH_LBR_RETURN			(1ULL << ARCH_LBR_RETURN_BIT)
+#define ARCH_LBR_OTHER_BRANCH		(1ULL << ARCH_LBR_OTHER_BRANCH_BIT)
+
+#define ARCH_LBR_ANY			 \
+	(ARCH_LBR_JCC			|\
+	 ARCH_LBR_REL_JMP		|\
+	 ARCH_LBR_IND_JMP		|\
+	 ARCH_LBR_REL_CALL		|\
+	 ARCH_LBR_IND_CALL		|\
+	 ARCH_LBR_RETURN		|\
+	 ARCH_LBR_OTHER_BRANCH)
+
+#define ARCH_LBR_CTL_MASK			0x7f000e
+
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
 /*
@@ -814,6 +852,37 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 	return 0;
 }
 
+/*
+ * Setup the HW LBR filter for arch LBR
+ * Used only when available, may not be enough to disambiguate
+ * all branches, may need the help of the SW filter
+ */
+static int intel_pmu_setup_hw_arch_lbr_filter(struct perf_event *event)
+{
+	struct hw_perf_event_extra *reg;
+	u64 br_type = event->attr.branch_sample_type;
+	u64 mask = 0, v;
+	int i;
+
+	for (i = 0; i < PERF_SAMPLE_BRANCH_MAX_SHIFT; i++) {
+		if (!(br_type & (1ULL << i)))
+			continue;
+
+		v = x86_pmu.lbr_ctl_map[i];
+		if (v == LBR_NOT_SUPP)
+			return -EOPNOTSUPP;
+
+		if (v != LBR_IGN)
+			mask |= v;
+	}
+
+	reg = &event->hw.branch_reg;
+	reg->idx = EXTRA_REG_LBR;
+	reg->config = mask;
+
+	return 0;
+}
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event)
 {
 	int ret = 0;
@@ -834,7 +903,9 @@ int intel_pmu_setup_lbr_filter(struct perf_event *event)
 	/*
 	 * setup HW LBR filter, if any
 	 */
-	if (x86_pmu.lbr_sel_map)
+	if (x86_pmu.lbr_ctl_map)
+		ret = intel_pmu_setup_hw_arch_lbr_filter(event);
+	else if (x86_pmu.lbr_sel_map)
 		ret = intel_pmu_setup_hw_lbr_filter(event);
 
 	return ret;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7112c51..1b91f2b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -244,7 +244,10 @@ struct cpu_hw_events {
 	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
-	struct er_account		*lbr_sel;
+	union {
+		struct er_account		*lbr_sel;
+		struct er_account		*lbr_ctl;
+	};
 	u64				br_sel;
 	void				*last_task_ctx;
 	int				last_log_id;
@@ -685,8 +688,12 @@ struct x86_pmu {
 	 */
 	unsigned long	lbr_tos, lbr_from, lbr_to; /* MSR base regs       */
 	int		lbr_nr;			   /* hardware stack size */
-	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
+	union {
+		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
+		u64		lbr_ctl_mask;		   /* LBR_CTL valid bits */
+	};
 	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	int		*lbr_ctl_map;		   /* LBR_CTL mappings */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 	bool		arch_lbr;		   /* Arch LBR supported */
@@ -849,8 +856,11 @@ static inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 
 static inline bool x86_pmu_has_lbr_callstack(void)
 {
-	return  x86_pmu.lbr_sel_map &&
-		x86_pmu.lbr_sel_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] > 0;
+	if (x86_pmu.lbr_ctl_map)
+		return x86_pmu.lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] > 0;
+	if (x86_pmu.lbr_sel_map)
+		return x86_pmu.lbr_sel_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] > 0;
+	return false;
 }
 
 static inline int x86_pmu_get_max_arch_lbr_nr(void)
-- 
2.7.4

