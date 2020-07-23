Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F73C433FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0799922CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgGWRLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:6574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgGWRLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:43 -0400
IronPort-SDR: eSjrtCnLYs3vXStYAiUy94h9Ji+D/YNcnlXdlD/vhVG+KocfgD4skiz+bGYMOfrvXF+OCpJ4DP
 VZ9n/xzQTbrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456703"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:42 -0700
IronPort-SDR: DdeuHP9R2xys/LK3Opt+DuxuXEjAFS5Hx5ZCwkufOVv/MP53SyebAKsLoAqSoIk+CvgD6nC+2L
 x7nD7O1kPphg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904251"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 03/14] perf/x86/intel: Introduce the fourth fixed counter
Date:   Thu, 23 Jul 2020 10:11:06 -0700
Message-Id: <20200723171117.9918-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The fourth fixed counter, TOPDOWN.SLOTS, is introduced in Ice Lake to
measure the level 1 TopDown events.

Add MSR address and macros for the new fixed counter, which will be used
in a later patch.

Add comments to explain the event encoding rules for the fixed counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/perf_event.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fd3eba65337f..fe8110a8c75b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -197,12 +197,24 @@ struct x86_pmu_capability {
  */
 
 /*
- * All 3 fixed-mode PMCs are configured via this single MSR:
+ * All the fixed-mode PMCs are configured via this single MSR:
  */
 #define MSR_ARCH_PERFMON_FIXED_CTR_CTRL	0x38d
 
 /*
- * The counts are available in three separate MSRs:
+ * There is no event-code assigned to the fixed-mode PMCs.
+ *
+ * For a fixed-mode PMC, which has an equivalent event on a general-purpose
+ * PMC, the event-code of the equivalent event is used for the fixed-mode PMC,
+ * e.g., Instr_Retired.Any and CPU_CLK_Unhalted.Core.
+ *
+ * For a fixed-mode PMC, which doesn't have an equivalent event, a
+ * pseudo-encoding is used, e.g., CPU_CLK_Unhalted.Ref and TOPDOWN.SLOTS.
+ * The pseudo event-code for a fixed-mode PMC must be 0x00.
+ * The pseudo umask-code is 0xX. The X equals the index of the fixed
+ * counter + 1, e.g., the fixed counter 2 has the pseudo-encoding 0x0300.
+ *
+ * The counts are available in separate MSRs:
  */
 
 /* Instr_Retired.Any: */
@@ -213,11 +225,16 @@ struct x86_pmu_capability {
 #define MSR_ARCH_PERFMON_FIXED_CTR1	0x30a
 #define INTEL_PMC_IDX_FIXED_CPU_CYCLES	(INTEL_PMC_IDX_FIXED + 1)
 
-/* CPU_CLK_Unhalted.Ref: */
+/* CPU_CLK_Unhalted.Ref: event=0x00,umask=0x3 (pseudo-encoding) */
 #define MSR_ARCH_PERFMON_FIXED_CTR2	0x30b
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+/* TOPDOWN.SLOTS: event=0x00,umask=0x4 (pseudo-encoding) */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
-- 
2.17.1

