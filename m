Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D7CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8553F20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgFSOH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:07:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:54733 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgFSOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:48 -0400
IronPort-SDR: kJW5Sj09VQyX7yhAL2ifjgMvO7Mvy25gZQPafl78a5uAcFPArPLepCLGm0V9M0QnG0uNQ9QbXj
 djC60C197nZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452815"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:47 -0700
IronPort-SDR: D9GMaQJDooqoed3r3H2IaGPg0wNvRGMCrn/OIMJyg6xv33KIFz7kfvLke1/+0k2qZndOcU8QfE
 +YBaz7DF/J4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837423"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:46 -0700
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
Subject: [PATCH 04/21] perf/x86/intel/lbr: Add pointer for LBR read
Date:   Fri, 19 Jun 2020 07:03:52 -0700
Message-Id: <1592575449-64278-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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
index 995acdb..03b17d5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3955,6 +3955,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.lbr_enable		= intel_pmu_lbr_enable,
 	.lbr_disable		= intel_pmu_lbr_disable,
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -4004,6 +4005,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.lbr_enable		= intel_pmu_lbr_enable,
 	.lbr_disable		= intel_pmu_lbr_disable,
 	.lbr_reset		= intel_pmu_lbr_reset_64,
+	.lbr_read		= intel_pmu_lbr_read_64,
 };
 
 static __init void intel_clovertown_quirk(void)
@@ -4630,8 +4632,10 @@ __init int intel_pmu_init(void)
 		x86_pmu.intel_cap.capabilities = capabilities;
 	}
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32) {
 		x86_pmu.lbr_reset = intel_pmu_lbr_reset_32;
+		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
+	}
 
 	intel_ds_init();
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index ff320d1..d762c76 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -542,7 +542,7 @@ void intel_pmu_lbr_disable_all(void)
 		x86_pmu.lbr_disable();
 }
 
-static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
 	u64 tos = intel_pmu_lbr_tos();
@@ -579,7 +579,7 @@ static void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
  * is the same as the linear address, allowing us to merge the LIP and EIP
  * LBR formats.
  */
-static void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
@@ -683,10 +683,7 @@ void intel_pmu_lbr_read(void)
 	if (!cpuc->lbr_users || cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
-	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
-		intel_pmu_lbr_read_32(cpuc);
-	else
-		intel_pmu_lbr_read_64(cpuc);
+	x86_pmu.lbr_read(cpuc);
 
 	intel_pmu_lbr_filter(cpuc);
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index abf95ef..e2e086c0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -693,6 +693,7 @@ struct x86_pmu {
 	void		(*lbr_enable)(bool pmi);
 	void		(*lbr_disable)(void);
 	void		(*lbr_reset)(void);
+	void		(*lbr_read)(struct cpu_hw_events *cpuc);
 
 	/*
 	 * Intel PT/LBR/BTS are exclusive
@@ -1086,6 +1087,10 @@ void intel_pmu_lbr_disable(void);
 
 void intel_pmu_lbr_read(void);
 
+void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
+
+void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc);
+
 void intel_pmu_lbr_init_core(void);
 
 void intel_pmu_lbr_init_nhm(void);
-- 
2.7.4

