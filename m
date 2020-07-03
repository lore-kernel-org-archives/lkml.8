Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34230C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BDC20C56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGCMx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:53:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:25720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGCMx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:27 -0400
IronPort-SDR: ANDtgV4zl4OqskVi9F3+eZ6kDG/Zt9u/f71KEIU9CE3NEQMk1ujVlI9n1qF57syp4yEWefOKS4
 N5NdOZ2GLfjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598349"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598349"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:26 -0700
IronPort-SDR: E1c6OqbaDFNqegtkZ23kEsJ9ztPwVR6/0T+VYjyvNISU0tHzf4a1jX2Ny1hfq0inS2LlRlAMRK
 kwEhu6TQCxoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963966"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:26 -0700
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
Subject: [PATCH V3 02/23] perf/x86/intel/lbr: Add a function pointer for LBR reset
Date:   Fri,  3 Jul 2020 05:49:08 -0700
Message-Id: <1593780569-62993-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
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
index 582ddff..fe49e99 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3978,6 +3978,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dead		= intel_pmu_cpu_dead,
 
 	.check_period		= intel_pmu_check_period,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4023,6 +4025,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.aux_output_match	= intel_pmu_aux_output_match,
+
+	.lbr_reset		= intel_pmu_lbr_reset_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4649,6 +4653,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index d03de75..7af27a7 100644
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
index 8147596..5c1ad43 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -180,6 +180,17 @@ struct x86_perf_task_context;
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
@@ -682,6 +693,8 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	void		(*lbr_reset)(void);
+
 	/*
 	 * Intel PT/LBR/BTS are exclusive
 	 */
@@ -1058,6 +1071,10 @@ u64 lbr_from_signext_quirk_wr(u64 val);
 
 void intel_pmu_lbr_reset(void);
 
+void intel_pmu_lbr_reset_32(void);
+
+void intel_pmu_lbr_reset_64(void);
+
 void intel_pmu_lbr_add(struct perf_event *event);
 
 void intel_pmu_lbr_del(struct perf_event *event);
-- 
2.7.4

