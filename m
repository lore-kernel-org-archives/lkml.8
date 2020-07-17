Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6EC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903F122CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGQOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:08:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:11825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgGQOHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:23 -0400
IronPort-SDR: hAhLJLqH+sb/+u2I0IsWL0Ucatslb3TRJdrxclnolQbElAwwGW8S/poVVmr9qjuNrY76K/mPwk
 LRg/IUPFwamA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722777"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:22 -0700
IronPort-SDR: LrUZU2x3uBruCrcHtg9rR+dIV9foOtx0aqC79PdYn3EO5e22wHvVhJ5FDOIjhuTka3RhdGrta0
 NrOFIYL5/r+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856469"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 02/14] perf/x86/intel: Name the global status bit in NMI handler
Date:   Fri, 17 Jul 2020 07:05:42 -0700
Message-Id: <20200717140554.22863-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Magic numbers are used in the current NMI handler for the global status
bit. Use a meaningful name to replace the magic numbers to improve the
readability of the code.

Remove a Tab for all GLOBAL_STATUS_* and INTEL_PMC_IDX_FIXED_BTS macros
to reduce the length of the line.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      |  4 ++--
 arch/x86/include/asm/perf_event.h | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 50963472ee85..ac1408fe1aee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2389,7 +2389,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * PEBS overflow sets bit 62 in the global status register
 	 */
-	if (__test_and_clear_bit(62, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
 		handled++;
@@ -2410,7 +2410,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * Intel PT
 	 */
-	if (__test_and_clear_bit(55, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
 		handled++;
 		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
 			perf_guest_cbs->handle_intel_pt_intr))
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0c1b13720525..fd3eba65337f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -225,16 +225,18 @@ struct x86_pmu_capability {
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
-
-#define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
-#define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
-#define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
-#define GLOBAL_STATUS_ASIF				BIT_ULL(60)
-#define GLOBAL_STATUS_COUNTERS_FROZEN			BIT_ULL(59)
-#define GLOBAL_STATUS_LBRS_FROZEN_BIT			58
-#define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
-#define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(55)
+#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 16)
+
+#define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
+#define GLOBAL_STATUS_BUFFER_OVF_BIT		62
+#define GLOBAL_STATUS_BUFFER_OVF		BIT_ULL(GLOBAL_STATUS_BUFFER_OVF_BIT)
+#define GLOBAL_STATUS_UNC_OVF			BIT_ULL(61)
+#define GLOBAL_STATUS_ASIF			BIT_ULL(60)
+#define GLOBAL_STATUS_COUNTERS_FROZEN		BIT_ULL(59)
+#define GLOBAL_STATUS_LBRS_FROZEN_BIT		58
+#define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+#define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
+#define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
-- 
2.17.1

