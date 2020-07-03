Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA945C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A7720BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGCMxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:53:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:25720 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgGCMx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:28 -0400
IronPort-SDR: Wgn20ychc3VK3sx8q6ZypnKf2lmujmr6MuJ15AWTZDUnKtend8Zuu3T10AbhJ+cMUtz3Mmpfc8
 lqZ5SB2vjkZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598352"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:28 -0700
IronPort-SDR: FBJ4Y81y7XIC7ErVhpKMCc/CUzebOP97HbYsT67DpF0zs7B/qPnUd7RFXreIiGfvnEzATYCeHK
 /08ZG0UAYnkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265963972"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:27 -0700
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
Subject: [PATCH V3 03/23] perf/x86/intel/lbr: Add a function pointer for LBR read
Date:   Fri,  3 Jul 2020 05:49:09 -0700
Message-Id: <1593780569-62993-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The method to read Architectural LBRs is different from previous
model-specific LBR. Perf has to implement a different function.

A function pointer for LBR read is introduced. Perf should initialize
the corresponding function at boot time, and avoid checking lbr_format
at run time.

The current 64-bit LBR read function is set as default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 6 +++++-
 arch/x86/events/intel/lbr.c  | 9 +++------
 arch/x86/events/perf_event.h | 5 +++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fe49e99..6414b47 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3980,6 +3980,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.check_period		= intel_pmu_check_period,
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4027,6 +4028,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.aux_output_match	= intel_pmu_aux_output_match,
 
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4653,8 +4655,10 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32) {
 		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
+	}
 
 	intel_ds_init();
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 7af27a7..b8943f4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -562,7 +562,7 @@ void intel_pmu_lbr_disable_all(void)
 		__intel_pmu_lbr_disable();
 }
 
-static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	u64 tos = intel_pmu_lbr_tos();
@@ -599,7 +599,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -704,10 +704,7 @@ void intel_pmu_lbr_read(void)
 	    cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
-		intel_pmu_lbr_read_32(cpuc);
-	else
-		intel_pmu_lbr_read_64(cpuc);
+	x86_pmu.lbr_read(cpuc);
 
 	intel_pmu_lbr_filter(cpuc);
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5c1ad43..312d27f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -694,6 +694,7 @@ struct x86_pmu {
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
 	void		(*lbr_reset)(void);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1085,6 +1086,10 @@ void intel_pmu_lbr_disable_all(void);
 
 void intel_pmu_lbr_read(void);
 
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);
-- 
2.7.4

