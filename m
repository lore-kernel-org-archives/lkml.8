Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C93C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17D120836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgFZSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgFZSXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:39 -0400
IronPort-SDR: FXO/5fn0kuyu0N9wtRwvvE1Rb/a+GlhCdpYxVtIFQ9LsI+e+3vaRij2Pq3s4fYdTjb42oOdmHj
 l4So4a/KpZLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512913"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:36 -0700
IronPort-SDR: OEbTHr/L/MvJaIvKteoWjS+qBzVl583ZlyXGJSYBlm6Ca8gFJ9L45m7rqd1dl7C15TZA7Tfqyc
 +3Ysoms87ouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153867"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:36 -0700
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
Subject: [PATCH V2 10/23] perf/x86/intel/lbr: Support LBR_CTL
Date:   Fri, 26 Jun 2020 11:20:07 -0700
Message-Id: <1593195620-116988-11-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
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

For the previous model-specific LBR, most of the bits in LBR_SELECT
operate in the suppressed mode. For the bits in LBR_CTL, the polarity is
inverted.

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
 arch/x86/events/intel/lbr.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/perf_event.h | 15 ++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0cc5ed2d..918f89d 100644
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
@@ -797,6 +835,11 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 	reg = &event->hw.branch_reg;
 	reg->idx = EXTRA_REG_LBR;
 
+	if (x86_pmu.arch_lbr) {
+		reg->config = mask;
+		return 0;
+	}
+
 	/*
 	 * The first 9 bits (LBR_SEL_MASK) in LBR_SELECT operate
 	 * in suppress mode. So LBR_SELECT should be set to
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f333c83..62fba45 100644
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
@@ -686,8 +689,14 @@ struct x86_pmu {
 	 */
 	unsigned long	lbr_tos, lbr_from, lbr_to; /* MSR base regs       */
 	int		lbr_nr;			   /* hardware stack size */
-	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
-	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	union {
+		u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
+		u64		lbr_ctl_mask;		   /* LBR_CTL valid bits */
+	};
+	union {
+		const int	*lbr_sel_map;		   /* lbr_select mappings */
+		int		*lbr_ctl_map;		   /* LBR_CTL mappings */
+	};
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 	bool		arch_lbr;		   /* Arch LBR supported */
-- 
2.7.4

