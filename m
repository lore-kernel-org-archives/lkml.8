Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484ABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E39320836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFZSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:59781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgFZSXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:44 -0400
IronPort-SDR: 2xdUqoUbxpnCxwKe9Nt3HkSNXiCEfXoWKFL/e/GuyXHR585bw9f9+HGWeDErk+BH/IeeHD4ohL
 QxG6WgSM1GsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512940"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512940"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:42 -0700
IronPort-SDR: RcMRyqcc8R7px1FCsQasNWTZmIgXUMeWezXm5U2CxZR5MZ7VJDYWAhv4FC5Y2PwdsDE5bkuuJL
 TLcj6eHw62FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153927"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:42 -0700
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
Subject: [PATCH V2 17/23] perf/x86/intel/lbr: Create kmem_cache for the LBR context data
Date:   Fri, 26 Jun 2020 11:20:14 -0700
Message-Id: <1593195620-116988-18-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new kmem_cache method is introduced to allocate the PMU specific data
task_ctx_data, which requires the PMU specific code to create a
kmem_cache.

Currently, the task_ctx_data is only used by the Intel LBR call stack
feature, which is introduced since Haswell. The kmem_cache should be
only created for Haswell and later platforms. There is no alignment
requirement for the existing platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c426cf7..dba34f4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1507,9 +1507,17 @@ void __init intel_pmu_lbr_init_snb(void)
 	 */
 }
 
+static inline struct kmem_cache *
+create_lbr_kmem_cache(size_t size, size_t align)
+{
+	return kmem_cache_create("x86_lbr", size, align, 0, NULL);
+}
+
 /* haswell */
 void intel_pmu_lbr_init_hsw(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 16;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1518,6 +1526,8 @@ void intel_pmu_lbr_init_hsw(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	if (lbr_from_signext_quirk_needed())
 		static_branch_enable(&lbr_from_quirk_key);
 }
@@ -1525,6 +1535,8 @@ void intel_pmu_lbr_init_hsw(void)
 /* skylake */
 __init void intel_pmu_lbr_init_skl(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 32;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1534,6 +1546,8 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	/*
 	 * SW branch filter usage:
 	 * - support syscall, sysret capture.
@@ -1604,6 +1618,7 @@ void intel_pmu_lbr_init_knl(void)
 void __init intel_pmu_arch_lbr_init(void)
 {
 	unsigned int unused_edx;
+	size_t size;
 	u64 lbr_nr;
 
 	/* Arch LBR Capabilities */
@@ -1619,8 +1634,10 @@ void __init intel_pmu_arch_lbr_init(void)
 		return;
 
 	x86_pmu.lbr_nr = lbr_nr;
-	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
-				       lbr_nr * sizeof(struct lbr_entry);
+	size = sizeof(struct x86_perf_task_context_arch_lbr) +
+	       lbr_nr * sizeof(struct lbr_entry);
+	x86_get_pmu()->task_ctx_size = size;
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
 	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
-- 
2.7.4

