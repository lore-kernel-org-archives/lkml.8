Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82235C433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F48722CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgGQOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:08:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:11830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgGQOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:26 -0400
IronPort-SDR: pCPqOp+L8zyIZj/Mm3AR3enXFotUBuR1GieClsvFMznMS1NEJ/uVhRp4olkHvzTH1mdC4FC/iR
 xxOy0/EQUoTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722799"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:25 -0700
IronPort-SDR: klQPCNxU4nA66QsgoSNHXZOeMN8bTgLYTTeaUHeFQbrcBlc7mWBkNNkAE5JK/X314VxbhlY3+/
 A+VBLsPArstw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856484"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 06/14] perf/x86/intel: Use switch in intel_pmu_disable/enable_event
Date:   Fri, 17 Jul 2020 07:05:46 -0700
Message-Id: <20200717140554.22863-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Many items are checked in the intel_pmu_disable/enable_event. More items
will be added later, e.g. perf metrics events.

Use switch, which is more efficient, to replace the if-else.

If the idx is invalid, print a warning.

For the case INTEL_PMC_IDX_FIXED_BTS in intel_pmu_disable_event, don't
need to check the event->attr.precise_ip. Use return for the case.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac1408fe1aee..2b1701c08f46 100644
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

