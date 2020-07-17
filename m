Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E6C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8056622D07
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgGQOHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:07:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:11837 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgGQOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:30 -0400
IronPort-SDR: lQ1heSK+8gJNNXgZge4L2wL0ZQD7YpemAje2QTM94EfU+CIh7a1YpN4T6RBpk1X9k22SqA9Q/V
 31vBsPajLQfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722819"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:28 -0700
IronPort-SDR: 1Uc6MtwBQKPfzMnO/Vl+fdhnOyRFJKJsusCQ1CW5cVOSYNUPqSCjDLbnh9JTtZNxL9hVx5jv0U
 qZpys82RotPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856496"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 10/14] perf/x86/intel: Support per-thread RDPMC TopDown metrics
Date:   Fri, 17 Jul 2020 07:05:50 -0700
Message-Id: <20200717140554.22863-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Starts from Ice Lake, the TopDown metrics are directly available as
fixed counters and do not require generic counters. Also, the TopDown
metrics can be collected per thread. Extend the RDPMC usage to support
per-thread TopDown metrics.

The RDPMC index of the PERF_METRICS will be output if RDPMC users ask
for the RDPMC index of the metrics events.

To support per thread RDPMC TopDown, the metrics and slots counters have
to be saved/restored during the context switching.

The last_period and period_left are not used in the counting mode. Use
the fields for saved_metric and saved_slots.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |   5 +-
 arch/x86/events/intel/core.c | 103 +++++++++++++++++++++++++++++------
 include/linux/perf_event.h   |  29 ++++++----
 3 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ace21b133015..c25dde095bca 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2264,7 +2264,10 @@ static int x86_pmu_event_idx(struct perf_event *event)
 	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	return hwc->event_base_rdpmc + 1;
+	if (is_metric_idx(hwc->idx))
+		return INTEL_PMC_FIXED_RDPMC_METRICS + 1;
+	else
+		return hwc->event_base_rdpmc + 1;
 }
 
 static ssize_t get_attr_rdpmc(struct device *cdev,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd622b69e882..dd3d9f3f2162 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2258,7 +2258,13 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	if (left == x86_pmu.max_period) {
 		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
 		wrmsrl(MSR_PERF_METRICS, 0);
-		local64_set(&hwc->period_left, 0);
+		hwc->saved_slots = 0;
+		hwc->saved_metric = 0;
+	}
+
+	if ((hwc->saved_slots) && is_slots_event(event)) {
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, hwc->saved_slots);
+		wrmsrl(MSR_PERF_METRICS, hwc->saved_metric);
 	}
 
 	perf_event_update_userpage(event);
@@ -2279,7 +2285,7 @@ static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 	return  mul_u64_u32_div(slots, val, 0xff);
 }
 
-static void __icl_update_topdown_event(struct perf_event *event,
+static u64 icl_get_topdown_value(struct perf_event *event,
 				       u64 slots, u64 metrics)
 {
 	int idx = event->hw.idx;
@@ -2290,7 +2296,50 @@ static void __icl_update_topdown_event(struct perf_event *event,
 	else
 		delta = slots;
 
-	local64_add(delta, &event->count);
+	return delta;
+}
+
+static void __icl_update_topdown_event(struct perf_event *event,
+				       u64 slots, u64 metrics,
+				       u64 last_slots, u64 last_metrics)
+{
+	u64 delta, last = 0;
+
+	delta = icl_get_topdown_value(event, slots, metrics);
+	if (last_slots)
+		last = icl_get_topdown_value(event, last_slots, last_metrics);
+
+	/*
+	 * The 8bit integer fraction of metric may be not accurate,
+	 * especially when the changes is very small.
+	 * For example, if only a few bad_spec happens, the fraction
+	 * may be reduced from 1 to 0. If so, the bad_spec event value
+	 * will be 0 which is definitely less than the last value.
+	 * Avoid update event->count for this case.
+	 */
+	if (delta > last) {
+		delta -= last;
+		local64_add(delta, &event->count);
+	}
+}
+
+static void update_saved_topdown_regs(struct perf_event *event,
+				      u64 slots, u64 metrics)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *other;
+	int idx;
+
+	event->hw.saved_slots = slots;
+	event->hw.saved_metric = metrics;
+
+	for_each_set_bit(idx, cpuc->active_mask, INTEL_PMC_IDX_TD_BE_BOUND + 1) {
+		if (!is_topdown_idx(idx))
+			continue;
+		other = cpuc->events[idx];
+		other->hw.saved_slots = slots;
+		other->hw.saved_metric = metrics;
+	}
 }
 
 /*
@@ -2304,6 +2353,7 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
 	u64 slots, metrics;
+	bool reset = true;
 	int idx;
 
 	/* read Fixed counter 3 */
@@ -2318,25 +2368,45 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 		if (!is_topdown_idx(idx))
 			continue;
 		other = cpuc->events[idx];
-		__icl_update_topdown_event(other, slots, metrics);
+		__icl_update_topdown_event(other, slots, metrics,
+					   event ? event->hw.saved_slots : 0,
+					   event ? event->hw.saved_metric : 0);
 	}
 
 	/*
 	 * Check and update this event, which may have been cleared
 	 * in active_mask e.g. x86_pmu_stop()
 	 */
-	if (event && !test_bit(event->hw.idx, cpuc->active_mask))
-		__icl_update_topdown_event(event, slots, metrics);
+	if (event && !test_bit(event->hw.idx, cpuc->active_mask)) {
+		__icl_update_topdown_event(event, slots, metrics,
+					   event->hw.saved_slots,
+					   event->hw.saved_metric);
 
-	/*
-	 * Software is recommended to periodically clear both registers
-	 * in order to maintain accurate measurements, which is required for
-	 * certain scenarios that involve sampling metrics at high rates.
-	 * Software should always write fixed counter 3 before write to
-	 * PERF_METRICS.
-	 */
-	wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
-	wrmsrl(MSR_PERF_METRICS, 0);
+		/*
+		 * In x86_pmu_stop(), the event is cleared in active_mask first,
+		 * then drain the delta, which indicates context switch for
+		 * counting.
+		 * Save metric and slots for context switch.
+		 * Don't need to reset the PERF_METRICS and Fixed counter 3.
+		 * Because the values will be restored in next schedule in.
+		 */
+		update_saved_topdown_regs(event, slots, metrics);
+		reset = false;
+	}
+
+	if (reset) {
+		/*
+		 * Software is recommended to periodically clear both registers
+		 * in order to maintain accurate measurements, which is required
+		 * for certain scenarios that involve sampling metrics at high
+		 * rates. Software should always write fixed counter 3 before
+		 * write to PERF_METRICS.
+		 */
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		if (event)
+			update_saved_topdown_regs(event, 0, 0);
+	}
 
 	return slots;
 }
@@ -3564,9 +3634,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 				return -EINVAL;
 
 			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
-
-			if (is_metric_event(event))
-				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3b22db08b6fb..a26f3c9589b7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -212,17 +212,26 @@ struct hw_perf_event {
 	 */
 	u64				sample_period;
 
-	/*
-	 * The period we started this sample with.
-	 */
-	u64				last_period;
+	union {
+		struct { /* Sampling */
+			/*
+			 * The period we started this sample with.
+			 */
+			u64				last_period;
 
-	/*
-	 * However much is left of the current period; note that this is
-	 * a full 64bit value and allows for generation of periods longer
-	 * than hardware might allow.
-	 */
-	local64_t			period_left;
+			/*
+			 * However much is left of the current period;
+			 * note that this is a full 64bit value and
+			 * allows for generation of periods longer
+			 * than hardware might allow.
+			 */
+			local64_t			period_left;
+		};
+		struct { /* Topdown events counting for context switch */
+			u64				saved_metric;
+			u64				saved_slots;
+		};
+	};
 
 	/*
 	 * State for throttling the event, see __perf_event_overflow() and
-- 
2.17.1

