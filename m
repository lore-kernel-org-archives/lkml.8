Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B280C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF8B22D05
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgGWRLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:6599 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbgGWRLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:46 -0400
IronPort-SDR: f7jsEArrrDrRCJJycYjX/wCQLxrkPqKOv+0wMHOxfipTHyi5rdIGdSOg4B3NHU00Lub8bkhs3j
 0+tEEwfQdIZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456754"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:45 -0700
IronPort-SDR: SjmMeKoVuiRdJtnv7FKtDH3R0eCiInT47v96kCXic08kQ7UWZliX7OLkeIsW6uaRX/9DRD8m5S
 GDaWIQWtLNVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904271"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 06/14] perf/x86/intel: Use switch in intel_pmu_disable/enable_event
Date:   Thu, 23 Jul 2020 10:11:09 -0700
Message-Id: <20200723171117.9918-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Currently, the if-else is used in the intel_pmu_disable/enable_event to
check the type of an event. It works well, but with more and more types
added later, e.g., perf metrics, compared to the switch statement, the
if-else may impair the readability of the code.

There is no harm to use the switch statement to replace the if-else
here. Also, some optimizing compilers may compile a switch statement
into a jump-table which is more efficient than if-else for a large
number of cases. The performance gain may not be observed for now,
because the number of cases is only 5, but the benefits may be observed
with more and more types added in the future.

Use switch to replace the if-else in the intel_pmu_disable/enable_event.

If the idx is invalid, print a warning.

For the case INTEL_PMC_IDX_FIXED_BTS in intel_pmu_disable_event, don't
need to check the event->attr.precise_ip. Use return for the case.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac1408fe1aee..76eab8178047 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2180,17 +2180,28 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
-	if (idx < INTEL_PMC_IDX_FIXED) {
+	switch (idx) {
+	case 0 ... INTEL_PMC_IDX_FIXED - 1:
 		intel_clear_masks(event, idx);
 		x86_pmu_disable_event(event);
-	} else if (idx < INTEL_PMC_IDX_FIXED_BTS) {
+		break;
+	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		intel_clear_masks(event, idx);
 		intel_pmu_disable_fixed(event);
-	} else if (idx == INTEL_PMC_IDX_FIXED_BTS) {
+		break;
+	case INTEL_PMC_IDX_FIXED_BTS:
 		intel_pmu_disable_bts();
 		intel_pmu_drain_bts_buffer();
-	} else if (idx == INTEL_PMC_IDX_FIXED_VLBR)
+		return;
+	case INTEL_PMC_IDX_FIXED_VLBR:
 		intel_clear_masks(event, idx);
+		break;
+	default:
+		intel_clear_masks(event, idx);
+		pr_warn("Failed to disable the event with invalid index %d\n",
+			idx);
+		return;
+	}
 
 	/*
 	 * Needs to be called after x86_pmu_disable_event,
@@ -2262,18 +2273,27 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_enable(event);
 
-	if (idx < INTEL_PMC_IDX_FIXED) {
+	switch (idx) {
+	case 0 ... INTEL_PMC_IDX_FIXED - 1:
 		intel_set_masks(event, idx);
 		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
-	} else if (idx < INTEL_PMC_IDX_FIXED_BTS) {
+		break;
+	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		intel_set_masks(event, idx);
 		intel_pmu_enable_fixed(event);
-	} else if (idx == INTEL_PMC_IDX_FIXED_BTS) {
+		break;
+	case INTEL_PMC_IDX_FIXED_BTS:
 		if (!__this_cpu_read(cpu_hw_events.enabled))
 			return;
 		intel_pmu_enable_bts(hwc->config);
-	} else if (idx == INTEL_PMC_IDX_FIXED_VLBR)
+		break;
+	case INTEL_PMC_IDX_FIXED_VLBR:
 		intel_set_masks(event, idx);
+		break;
+	default:
+		pr_warn("Failed to enable the event with invalid index %d\n",
+			idx);
+	}
 }
 
 static void intel_pmu_add_event(struct perf_event *event)
-- 
2.17.1

