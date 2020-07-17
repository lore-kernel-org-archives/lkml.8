Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B6CC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D76322D0B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgGQOHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:07:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:11832 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgGQOHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:31 -0400
IronPort-SDR: i1p1dsnttScvKesA1TcHBL3Am32S11iflqO17bS3H5ivcvnIofmMPUNOpRMiTOIhvxzN1fp1Kg
 nP+Wcz0lsUxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722804"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:26 -0700
IronPort-SDR: BnwYwanXDrBIbk82kfbUzJcZ/yxA6mmab3B/vAHvkmjRYW4FGRtgodY5PWAgNMAu0dSMObPAVo
 f967NO/AAdZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856489"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:26 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 07/14] perf/x86/intel: Generic support for hardware TopDown metrics
Date:   Fri, 17 Jul 2020 07:05:47 -0700
Message-Id: <20200717140554.22863-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intro
=====

The TopDown Microarchitecture Analysis (TMA) Method is a structured
analysis methodology to identify critical performance bottlenecks in
out-of-order processors. Current perf has supported the method.

The method works well, but there is one problem. To collect the TopDown
events, several GP counters have to be used. If a user wants to collect
other events at the same time, the multiplexing probably be triggered,
which impacts the accuracy.

To free up the scarce GP counters, the hardware TopDown metrics feature
is introduced from Ice Lake. The hardware implements an additional
"metrics" register and a new Fixed Counter 3 that measures pipeline
"slots". The TopDown events can be calculated from them instead.

Events
======

The level 1 TopDown has four metrics. There is no event-code assigned to
the TopDown metrics. Four metric events are exported as separate perf
events, which map to the internal "metrics" counter register. Those
events do not exist in hardware, but can be allocated by the scheduler.

For the event mapping, a special 0x00 event code is used, which is
reserved for fake events. The metric events start from umask 0x10.

When setting up the metric events, they point to the Fixed Counter 3.
They have to be specially handled.
- Add the update_topdown_event() callback to read the additional metrics
  MSR and generate the metrics.
- Add the set_topdown_event_period() callback to initialize metrics MSR
  and the fixed counter 3.
- Add a variable n_metric_event to track the number of the accepted
  metrics events. The sharing between multiple users of the same metric
  without multiplexing is not allowed.
- Only enable/disable the fixed counter 3 when there are no other active
  TopDown events, which avoid the unnecessary writing of the fixed
  control register.
- Disable the PMU when reading the metrics event. The metrics MSR and
  the fixed counter 3 are read separately. The values may be modified by
  an NMI.

All four metric events don't support sampling. Since they will be
handled specially for event update, a flag PERF_X86_EVENT_TOPDOWN is
introduced to indicate this case.

The slots event can support both sampling and counting.
For counting, the flag is also applied.
For sampling, it will be handled normally as other normal events.

Groups
======

The slots event is required in a Topdown group.
To avoid reading the METRICS register multiple times, the metrics and
slots value can only be updated by slots event in a group.
All active slots and metrics events will be updated one time.

NMI
======

The METRICS related register may be overflow. The bit 48 of the STATUS
register will be set. If so, PERF_METRICS and Fixed counter 3 are
required to be reset. The patch also update all active slots and
metrics events in the NMI handler.

The update_topdown_event() has to read two registers separately. The
values may be modified by an NMI. PMU has to be disabled before calling
the function.

RDPMC
======

RDPMC is temporarily disabled. A later patch will enable it.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            |  50 ++++++++++++++
 arch/x86/events/intel/core.c      | 105 ++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h      |  39 ++++++++++-
 arch/x86/include/asm/msr-index.h  |   1 +
 arch/x86/include/asm/perf_event.h |  46 +++++++++++++
 5 files changed, 235 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e108ea378e3..8aa7da80f5d6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -76,6 +76,9 @@ u64 x86_perf_event_update(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
+	if (unlikely(is_topdown_count(event)) && x86_pmu.update_topdown_event)
+		return x86_pmu.update_topdown_event(event);
+
 	/*
 	 * Careful: an NMI might modify the previous event value.
 	 *
@@ -1031,6 +1034,35 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	return unsched ? -EINVAL : 0;
 }
 
+static int add_nr_metric_event(struct cpu_hw_events *cpuc,
+			       struct perf_event *event,
+			       int *max_count, bool sibling)
+{
+	/* The TopDown metrics events cannot be shared. */
+	if (is_metric_event(event) &&
+	    (++cpuc->n_metric_event > INTEL_TD_METRIC_NUM)) {
+		cpuc->n_metric_event--;
+		return -EINVAL;
+	}
+
+	/*
+	 * Take the accepted metrics events into account for leader event.
+	 */
+	if (!sibling)
+		*max_count += cpuc->n_metric_event;
+	else if (is_metric_event(event))
+		(*max_count)++;
+
+	return 0;
+}
+
+static void del_nr_metric_event(struct cpu_hw_events *cpuc,
+				struct perf_event *event)
+{
+	if (is_metric_event(event))
+		cpuc->n_metric_event--;
+}
+
 /*
  * dogrp: true if must collect siblings events (group)
  * returns total number of events and error code
@@ -1066,6 +1098,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 		cpuc->pebs_output = is_pebs_pt(leader) + 1;
 	}
 
+	if (x86_pmu.intel_cap.perf_metrics &&
+	    add_nr_metric_event(cpuc, leader, &max_count, false))
+		return -EINVAL;
+
 	if (is_x86_event(leader)) {
 		if (n >= max_count)
 			return -EINVAL;
@@ -1082,6 +1118,10 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 		    event->state <= PERF_EVENT_STATE_OFF)
 			continue;
 
+		if (x86_pmu.intel_cap.perf_metrics &&
+		    add_nr_metric_event(cpuc, event, &max_count, true))
+			return -EINVAL;
+
 		if (n >= max_count)
 			return -EINVAL;
 
@@ -1110,6 +1150,10 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		hwc->event_base	= 0;
 		break;
 
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_BASE + 3:
+		/* All the metric events are mapped onto the fixed counter 3. */
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+		/* fall through */
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
@@ -1245,6 +1289,10 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (unlikely(!hwc->event_base))
 		return 0;
 
+	if (unlikely(is_topdown_count(event)) &&
+	    x86_pmu.set_topdown_event_period)
+		return x86_pmu.set_topdown_event_period(event);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
@@ -1529,6 +1577,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
+	if (x86_pmu.intel_cap.perf_metrics)
+		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2b1701c08f46..bc0f9dcb552c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2165,11 +2165,24 @@ static inline void intel_clear_masks(struct perf_event *event, int idx)
 static void intel_pmu_disable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
+	int idx = hwc->idx;
 
-	mask = 0xfULL << (idx * 4);
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+		/*
+		 * When there are other active TopDown events,
+		 * don't disable the fixed counter 3.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
+
+	intel_clear_masks(event, idx);
 
+	mask = 0xfULL << ((idx - INTEL_PMC_IDX_FIXED) * 4);
 	rdmsrl(hwc->config_base, ctrl_val);
 	ctrl_val &= ~mask;
 	wrmsrl(hwc->config_base, ctrl_val);
@@ -2186,7 +2199,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 		x86_pmu_disable_event(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
-		intel_clear_masks(event, idx);
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_disable_fixed(event);
 		break;
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -2219,10 +2232,26 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static void intel_pmu_read_topdown_event(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/* Only need to call update_topdown_event() once for group read. */
+	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
+	    !is_slots_event(event))
+		return;
+
+	perf_pmu_disable(event->pmu);
+	x86_pmu.update_topdown_event(event);
+	perf_pmu_enable(event->pmu);
+}
+
 static void intel_pmu_read_event(struct perf_event *event)
 {
 	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 		intel_pmu_auto_reload_read(event);
+	else if (is_topdown_count(event) && x86_pmu.update_topdown_event)
+		intel_pmu_read_topdown_event(event);
 	else
 		x86_perf_event_update(event);
 }
@@ -2230,8 +2259,22 @@ static void intel_pmu_read_event(struct perf_event *event)
 static void intel_pmu_enable_fixed(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask, bits = 0;
+	int idx = hwc->idx;
+
+	if (is_topdown_idx(idx)) {
+		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+		/*
+		 * When there are other active TopDown events,
+		 * don't enable the fixed counter 3 again.
+		 */
+		if (*(u64 *)cpuc->active_mask & INTEL_PMC_OTHER_TOPDOWN_BITS(idx))
+			return;
+
+		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+	}
+
+	intel_set_masks(event, idx);
 
 	/*
 	 * Enable IRQ generation (0x8), if not PEBS,
@@ -2251,6 +2294,7 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	if (x86_pmu.version > 2 && hwc->config & ARCH_PERFMON_EVENTSEL_ANY)
 		bits |= 0x4;
 
+	idx -= INTEL_PMC_IDX_FIXED;
 	bits <<= (idx * 4);
 	mask = 0xfULL << (idx * 4);
 
@@ -2279,7 +2323,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
-		intel_set_masks(event, idx);
+	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
 		break;
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -2439,6 +2483,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 			intel_pt_interrupt();
 	}
 
+	/*
+	 * Intel Perf mertrics
+	 */
+	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
+		handled++;
+		if (x86_pmu.update_topdown_event)
+			x86_pmu.update_topdown_event(NULL);
+	}
+
 	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status
@@ -3375,6 +3428,39 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type != PERF_TYPE_RAW)
 		return 0;
 
+	/*
+	 * Config Topdown slots and metric events
+	 *
+	 * The slots event on Fixed Counter 3 can support sampling,
+	 * which will be handled normally in x86_perf_event_update().
+	 *
+	 * The metric events don't support sampling.
+	 *
+	 * For counting, topdown slots and metric events will be
+	 * handled specially for event update.
+	 * A flag PERF_X86_EVENT_TOPDOWN is applied for the case.
+	 */
+	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+		if (is_metric_event(event) && is_sampling_event(event))
+			return -EINVAL;
+
+		if (!is_sampling_event(event)) {
+			if (event->attr.config1 != 0)
+				return -EINVAL;
+			/*
+			 * The TopDown metrics events and slots event don't
+			 * support any filters.
+			 */
+			if (event->attr.config & X86_ALL_EVENT_FLAGS)
+				return -EINVAL;
+
+			event->hw.flags |= PERF_X86_EVENT_TOPDOWN;
+
+			if (is_metric_event(event))
+				event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
+		}
+	}
+
 	if (!(event->attr.config & ARCH_PERFMON_EVENTSEL_ANY))
 		return 0;
 
@@ -5218,6 +5304,15 @@ __init int intel_pmu_init(void)
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			/*
+			 * Don't extend the topdown slots and metrics
+			 * events to the generic counters.
+			 */
+			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+				c->weight = hweight64(c->idxmsk64);
+				continue;
+			}
+
 			if (c->cmask == FIXED_EVENT_FLAGS
 			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
 				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5d453da8cfa6..b947244da943 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -79,6 +79,31 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
 #define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
 #define PERF_X86_EVENT_LBR_SELECT	0x2000 /* Save/Restore MSR_LBR_SELECT */
+#define PERF_X86_EVENT_TOPDOWN		0x4000 /* Count Topdown slots/metrics events */
+
+static inline bool is_topdown_count(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
+}
+
+static inline bool is_metric_event(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+
+	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
+		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
+		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
+}
+
+static inline bool is_slots_event(struct perf_event *event)
+{
+	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_TD_SLOTS;
+}
+
+static inline bool is_topdown_event(struct perf_event *event)
+{
+	return is_metric_event(event) || is_slots_event(event);
+}
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -284,6 +309,12 @@ struct cpu_hw_events {
 	 */
 	u64				tfa_shadow;
 
+	/*
+	 * Perf Metrics
+	 */
+	/* number of accepted metrics events */
+	int				n_metric_event;
+
 	/*
 	 * AMD specific bits
 	 */
@@ -726,6 +757,12 @@ struct x86_pmu {
 	 */
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
+	/*
+	 * Intel perf metrics
+	 */
+	u64		(*update_topdown_event)(struct perf_event *event);
+	int		(*set_topdown_event_period)(struct perf_event *event);
+
 	/*
 	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
 	 * switch helper to bridge calls from perf/core to perf/x86.
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index bdc07fc6e517..d8c6cb82866d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -853,6 +853,7 @@
 #define MSR_CORE_PERF_FIXED_CTR0	0x00000309
 #define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
 #define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
+#define MSR_CORE_PERF_FIXED_CTR3	0x0000030c
 #define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 08e4de8802fe..8870eb1c3b17 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -244,6 +244,51 @@ struct x86_pmu_capability {
  */
 #define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 15)
 
+/*
+ * The PERF_METRICS MSR is modeled as several magic fixed-mode PMCs, one for
+ * each TopDown metric event.
+ *
+ * Internally the TopDown metric events are mapped to the FxCtr 3 (SLOTS).
+ */
+#define INTEL_PMC_IDX_METRIC_BASE		(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_TD_RETIRING		(INTEL_PMC_IDX_METRIC_BASE + 0)
+#define INTEL_PMC_IDX_TD_BAD_SPEC		(INTEL_PMC_IDX_METRIC_BASE + 1)
+#define INTEL_PMC_IDX_TD_FE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 2)
+#define INTEL_PMC_IDX_TD_BE_BOUND		(INTEL_PMC_IDX_METRIC_BASE + 3)
+#define INTEL_PMC_IDX_METRIC_END		INTEL_PMC_IDX_TD_BE_BOUND
+#define INTEL_PMC_MSK_TOPDOWN			((0xfull << INTEL_PMC_IDX_METRIC_BASE) | \
+						INTEL_PMC_MSK_FIXED_SLOTS)
+
+/*
+ * There is no event-code assigned to the TopDown events.
+ *
+ * For the slots event, use the pseudo code of the fixed counter 3.
+ *
+ * For the metric events, the pseudo event-code is 0x00.
+ * The pseudo umask-code starts from 0x10.
+ */
+#define INTEL_TD_SLOTS				0x0400	/* TOPDOWN.SLOTS */
+/* Level 1 metrics */
+#define INTEL_TD_METRIC_RETIRING		0x1000	/* Retiring metric */
+#define INTEL_TD_METRIC_BAD_SPEC		0x1100	/* Bad speculation metric */
+#define INTEL_TD_METRIC_FE_BOUND		0x1200	/* FE bound metric */
+#define INTEL_TD_METRIC_BE_BOUND		0x1300	/* BE bound metric */
+#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
+#define INTEL_TD_METRIC_NUM			4
+
+static inline bool is_metric_idx(int idx)
+{
+	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;
+}
+
+static inline bool is_topdown_idx(int idx)
+{
+	return is_metric_idx(idx) || idx == INTEL_PMC_IDX_FIXED_SLOTS;
+}
+
+#define INTEL_PMC_OTHER_TOPDOWN_BITS(bit)	\
+			(~(0x1ull << bit) & INTEL_PMC_MSK_TOPDOWN)
+
 #define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF_BIT		62
 #define GLOBAL_STATUS_BUFFER_OVF		BIT_ULL(GLOBAL_STATUS_BUFFER_OVF_BIT)
@@ -254,6 +299,7 @@ struct x86_pmu_capability {
 #define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
-- 
2.17.1

