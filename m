Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56977C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DF420771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgFSOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:07:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:54728 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732664AbgFSOHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:47 -0400
IronPort-SDR: GCH0xTuu+cvMVWt38MIajuIpGjt2fkG2tarFmSJqnHjEKlapZveb/1cjRMJwIxoDXQRt8APK+5
 648IgMmG4keQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452808"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:45 -0700
IronPort-SDR: CwpXNLPoUOB6kGVB4Dq+i/h2KE9GWq7NHf0aX307ZQ1VHPwp8RKyCzwaaJz5xVvp5KbvSBAI0Y
 Hnqt7T2p3vRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837419"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:45 -0700
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
Subject: [PATCH 03/21] perf/x86/intel/lbr: Add pointer for LBR reset
Date:   Fri, 19 Jun 2020 07:03:51 -0700
Message-Id: <1592575449-64278-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/intel/core.c |  5 +++++
 arch/x86/events/intel/lbr.c  | 20 +++-----------------
 arch/x86/events/perf_event.h | 16 ++++++++++++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 56966fc..995acdb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3954,6 +3954,7 @@ static __initconst const struct x86_pmu core_pmu = {
 
 	.lbr_enable		= intel_pmu_lbr_enable,
 	.lbr_disable		= intel_pmu_lbr_disable,
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4002,6 +4003,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.lbr_enable		= intel_pmu_lbr_enable,
 	.lbr_disable		= intel_pmu_lbr_disable,
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4628,6 +4630,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bdd38b6..ff320d1 100644
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
@@ -194,7 +183,7 @@ void intel_pmu_lbr_disable(void)
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
index a61a076..abf95ef 100644
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
@@ -681,6 +692,7 @@ struct x86_pmu {
 
 	void		(*lbr_enable)(bool pmi);
 	void		(*lbr_disable)(void);
+	void		(*lbr_reset)(void);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1056,6 +1068,10 @@ u64 lbr_from_signext_quirk_wr(u64 val);
 
 void intel_pmu_lbr_reset(void);
 
+void intel_pmu_lbr_reset_32(void);
+
+void intel_pmu_lbr_reset_64(void);
+
 void intel_pmu_lbr_add(struct perf_event *event);
 
 void intel_pmu_lbr_del(struct perf_event *event);
-- 
2.7.4

