Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC55C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05A420707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFZSXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFZSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:31 -0400
IronPort-SDR: wFCTAebeApKR4rq8bWzOjsfW+de2Ls2ZasdgXoseuIu6FQFIVeDW2huy0s5/Yl/kprJkFg2o0d
 jXrtBH2SDVOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512879"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:30 -0700
IronPort-SDR: guAGan8EnTodES1DrWLKFLFUnICSnpXuXZwsdmoU3paIG7KH0ENOm7PHCp9Dl/o7LZvBGexArg
 yYY42FJeDtMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153819"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:30 -0700
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
Subject: [PATCH V2 02/23] perf/x86/intel/lbr: Add a function pointer for LBR reset
Date:   Fri, 26 Jun 2020 11:19:59 -0700
Message-Id: <1593195620-116988-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The method to reset Architectural LBRs is different from previous
model-specific LBR. Perf has to implement a different function.

A function pointer is introduced for LBR reset. The enum of
LBR_FORMAT_* is also moved to perf_event.h. Perf should initialize the
corresponding functions at boot time, and avoid checking lbr_format at
run time.

The current 64-bit LBR reset function is set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c |  7 +++++++
 arch/x86/events/intel/lbr.c  | 20 +++-----------------
 arch/x86/events/perf_event.h | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ca35c8b..c2ab13a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3951,6 +3951,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dead		= intel_pmu_cpu_dead,
 
 	.check_period		= intel_pmu_check_period,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -3996,6 +3998,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.aux_output_match	= intel_pmu_aux_output_match,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4622,6 +4626,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 65113b1..abca269 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -8,17 +8,6 @@
 
 #include "../perf_event.h"
 
-enum {
-	LBR_FORMAT_32		= 0x00,
-	LBR_FORMAT_LIP		= 0x01,
-	LBR_FORMAT_EIP		= 0x02,
-	LBR_FORMAT_EIP_FLAGS	= 0x03,
-	LBR_FORMAT_EIP_FLAGS2	= 0x04,
-	LBR_FORMAT_INFO		= 0x05,
-	LBR_FORMAT_TIME		= 0x06,
-	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
-};
-
 static const enum {
 	LBR_EIP_FLAGS		= 1,
 	LBR_TSX			= 2,
@@ -194,7 +183,7 @@ static void __intel_pmu_lbr_disable(void)
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
-static void intel_pmu_lbr_reset_32(void)
+void intel_pmu_lbr_reset_32(void)
 {
 	int i;
 
@@ -202,7 +191,7 @@ static void intel_pmu_lbr_reset_32(void)
 		wrmsrl(x86_pmu.lbr_from + i, 0);
 }
 
-static void intel_pmu_lbr_reset_64(void)
+void intel_pmu_lbr_reset_64(void)
 {
 	int i;
 
@@ -221,10 +210,7 @@ void intel_pmu_lbr_reset(void)
 	if (!x86_pmu.lbr_nr)
 		return;
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
-		intel_pmu_lbr_reset_32();
-	else
-		intel_pmu_lbr_reset_64();
+	x86_pmu.lbr_reset();
 
 	cpuc->last_task_ctx = NULL;
 	cpuc->last_log_id = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e17a3d8..97e1457 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -179,6 +179,17 @@ struct x86_perf_task_context;
 #define MAX_LBR_ENTRIES		32
 
 enum {
+	LBR_FORMAT_32		= 0x00,
+	LBR_FORMAT_LIP		= 0x01,
+	LBR_FORMAT_EIP		= 0x02,
+	LBR_FORMAT_EIP_FLAGS	= 0x03,
+	LBR_FORMAT_EIP_FLAGS2	= 0x04,
+	LBR_FORMAT_INFO		= 0x05,
+	LBR_FORMAT_TIME		= 0x06,
+	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
+};
+
+enum {
 	X86_PERF_KFREE_SHARED = 0,
 	X86_PERF_KFREE_EXCL   = 1,
 	X86_PERF_KFREE_MAX
@@ -680,6 +691,8 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	void		(*lbr_reset)(void);
+
 	/*
 	 * Intel PT/LBR/BTS are exclusive
 	 */
@@ -1054,6 +1067,10 @@ u64 lbr_from_signext_quirk_wr(u64 val);
 
 void intel_pmu_lbr_reset(void);
 
+void intel_pmu_lbr_reset_32(void);
+
+void intel_pmu_lbr_reset_64(void);
+
 void intel_pmu_lbr_add(struct perf_event *event);
 
 void intel_pmu_lbr_del(struct perf_event *event);
-- 
2.7.4

