Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AC420BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGCMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:54:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:25732 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGCMxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:36 -0400
IronPort-SDR: yG85CS6Z/hI50V/FpqkObwT/w1h84XTau9OeEb5o/Afw2T/PbLjE+RDIdRMn58jL7k4GzGDRUn
 CDS87ZRgTrpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598374"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:36 -0700
IronPort-SDR: HpnbEePxVyM5xpUNnBbW83B3tSJAUe7JGhpwu/+SyCkd+o/zZ4f3kyrKxKmLhUg0ls4qTAGtfb
 W1tpysj/OQhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963996"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:35 -0700
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
Subject: [PATCH V3 09/23] perf/x86/intel/lbr: Support LBR_CTL
Date:   Fri,  3 Jul 2020 05:49:15 -0700
Message-Id: <1593780569-62993-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
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
index e62baa9..7742562 100644
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
@@ -820,6 +858,11 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 	reg = &event->hw.branch_reg;
 	reg->idx = EXTRA_REG_LBR;
 
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
+		reg->config = mask;
+		return 0;
+	}
+
 	/*
 	 * The first 9 bits (LBR_SEL_MASK) in LBR_SELECT operate
 	 * in suppress mode. So LBR_SELECT should be set to
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cc81177..ba89e56 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -245,7 +245,10 @@ struct cpu_hw_events {
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
@@ -688,8 +691,14 @@ struct x86_pmu {
 	 */
 	unsigned int	lbr_tos, lbr_from, lbr_to,
 			lbr_nr;			   /* LBR base regs and size */
-	u64		lbr_sel_mask;		   /* LBR_SELECT valid bits */
-	const int	*lbr_sel_map;		   /* lbr_select mappings */
+	union {
+		u64	lbr_sel_mask;		   /* LBR_SELECT valid bits */
+		u64	lbr_ctl_mask;		   /* LBR_CTL valid bits */
+	};
+	union {
+		const int	*lbr_sel_map;	   /* lbr_select mappings */
+		int		*lbr_ctl_map;	   /* LBR_CTL mappings */
+	};
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
-- 
2.7.4

