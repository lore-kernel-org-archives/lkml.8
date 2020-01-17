Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C211CC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F822525
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgAQKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:08:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgAQKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYQ-0005Os-N9; Fri, 17 Jan 2020 11:08:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4FADB1C19CC;
        Fri, 17 Jan 2020 11:08:38 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:38 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Add support for Large Increment per
 Cycle Events
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157925571816.396.8962445824411820955.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5738891229a25e9e678122a843cbf0466a456d0c
Gitweb:        https://git.kernel.org/tip/5738891229a25e9e678122a843cbf0466a456d0c
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Thu, 14 Nov 2019 12:37:20 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:26 +01:00

perf/x86/amd: Add support for Large Increment per Cycle Events

Description of hardware operation
---------------------------------

The core AMD PMU has a 4-bit wide per-cycle increment for each
performance monitor counter.  That works for most events, but
now with AMD Family 17h and above processors, some events can
occur more than 15 times in a cycle.  Those events are called
"Large Increment per Cycle" events. In order to count these
events, two adjacent h/w PMCs get their count signals merged
to form 8 bits per cycle total.  In addition, the PERF_CTR count
registers are merged to be able to count up to 64 bits.

Normally, events like instructions retired, get programmed on a single
counter like so:

PERF_CTL0 (MSR 0xc0010200) 0x000000000053ff0c # event 0x0c, umask 0xff
PERF_CTR0 (MSR 0xc0010201) 0x0000800000000001 # r/w 48-bit count

The next counter at MSRs 0xc0010202-3 remains unused, or can be used
independently to count something else.

When counting Large Increment per Cycle events, such as FLOPs,
however, we now have to reserve the next counter and program the
PERF_CTL (config) register with the Merge event (0xFFF), like so:

PERF_CTL0 (msr 0xc0010200) 0x000000000053ff03 # FLOPs event, umask 0xff
PERF_CTR0 (msr 0xc0010201) 0x0000800000000001 # rd 64-bit cnt, wr lo 48b
PERF_CTL1 (msr 0xc0010202) 0x0000000f004000ff # Merge event, enable bit
PERF_CTR1 (msr 0xc0010203) 0x0000000000000000 # wr hi 16-bits count

The count is widened from the normal 48-bits to 64 bits by having the
second counter carry the higher 16 bits of the count in its lower 16
bits of its counter register.

The odd counter, e.g., PERF_CTL1, is programmed with the enabled Merge
event before the even counter, PERF_CTL0.

The Large Increment feature is available starting with Family 17h.
For more details, search any Family 17h PPR for the "Large Increment
per Cycle Events" section, e.g., section 2.1.15.3 on p. 173 in this
version:

https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

Description of software operation
---------------------------------

The following steps are taken in order to support reserving and
enabling the extra counter for Large Increment per Cycle events:

1. In the main x86 scheduler, we reduce the number of available
counters by the number of Large Increment per Cycle events being
scheduled, tracked by a new cpuc variable 'n_pair' and a new
amd_put_event_constraints_f17h().  This improves the counter
scheduler success rate.

2. In perf_assign_events(), if a counter is assigned to a Large
Increment event, we increment the current counter variable, so the
counter used for the Merge event is removed from assignment
consideration by upcoming event assignments.

3. In find_counter(), if a counter has been found for the Large
Increment event, we set the next counter as used, to prevent other
events from using it.

4. We perform steps 2 & 3 also in the x86 scheduler fastpath, i.e.,
we add Merge event accounting to the existing used_mask logic.

5. Finally, we add on the programming of Merge event to the
neighbouring PMC counters in the counter enable/disable{_all}
code paths.

Currently, software does not support a single PMU with mixed 48- and
64-bit counting, so Large increment event counts are limited to 48
bits.  In set_period, we zero-out the upper 16 bits of the count, so
the hardware doesn't copy them to the even counter's higher bits.

Simple invocation example showing counting 8 FLOPs per 256-bit/%ymm
vaddps instruction executed in a loop 100 million times:

perf stat -e cpu/fp_ret_sse_avx_ops.all/,cpu/instructions/ <workload>

 Performance counter stats for '<workload>':

       800,000,000      cpu/fp_ret_sse_avx_ops.all/u
       300,042,101      cpu/instructions/u

Prior to this patch, the reported SSE/AVX FLOPs retired count would
be wrong.

[peterz: lots of renames and edits to the code]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/core.c   | 18 +++++++++-
 arch/x86/events/core.c       | 74 +++++++++++++++++++++++++++--------
 arch/x86/events/perf_event.h | 18 +++++++++-
 3 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 571168f..1f22b6b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -14,6 +14,10 @@
 static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
 static unsigned long perf_nmi_window;
 
+/* AMD Event 0xFFF: Merge.  Used with Large Increment per Cycle events */
+#define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
+#define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -335,6 +339,9 @@ static int amd_core_hw_config(struct perf_event *event)
 	else if (event->attr.exclude_guest)
 		event->hw.config |= AMD64_EVENTSEL_HOSTONLY;
 
+	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
+		event->hw.flags |= PERF_X86_EVENT_PAIR;
+
 	return 0;
 }
 
@@ -880,6 +887,15 @@ amd_get_event_constraints_f17h(struct cpu_hw_events *cpuc, int idx,
 	return &unconstrained;
 }
 
+static void amd_put_event_constraints_f17h(struct cpu_hw_events *cpuc,
+					   struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (is_counter_pair(hwc))
+		--cpuc->n_pair;
+}
+
 static ssize_t amd_event_sysfs_show(char *page, u64 config)
 {
 	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT) |
@@ -967,6 +983,8 @@ static int __init amd_core_pmu_init(void)
 				    PERF_X86_EVENT_PAIR);
 
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
+		x86_pmu.put_event_constraints = amd_put_event_constraints_f17h;
+		x86_pmu.perf_ctr_pair_en = AMD_MERGE_EVENT_ENABLE;
 		x86_pmu.flags |= PMU_FL_PAIR;
 	}
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f118af9..3bb738f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -618,6 +618,7 @@ void x86_pmu_disable_all(void)
 	int idx;
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+		struct hw_perf_event *hwc = &cpuc->events[idx]->hw;
 		u64 val;
 
 		if (!test_bit(idx, cpuc->active_mask))
@@ -627,6 +628,8 @@ void x86_pmu_disable_all(void)
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
 		wrmsrl(x86_pmu_config_addr(idx), val);
+		if (is_counter_pair(hwc))
+			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
 	}
 }
 
@@ -699,7 +702,7 @@ struct sched_state {
 	int	counter;	/* counter index */
 	int	unassigned;	/* number of events to be assigned left */
 	int	nr_gp;		/* number of GP counters used */
-	unsigned long used[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	u64	used;
 };
 
 /* Total max is X86_PMC_IDX_MAX, but we are O(n!) limited */
@@ -756,8 +759,12 @@ static bool perf_sched_restore_state(struct perf_sched *sched)
 	sched->saved_states--;
 	sched->state = sched->saved[sched->saved_states];
 
-	/* continue with next counter: */
-	clear_bit(sched->state.counter++, sched->state.used);
+	/* this assignment didn't work out */
+	/* XXX broken vs EVENT_PAIR */
+	sched->state.used &= ~BIT_ULL(sched->state.counter);
+
+	/* try the next one */
+	sched->state.counter++;
 
 	return true;
 }
@@ -782,20 +789,32 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 	if (c->idxmsk64 & (~0ULL << INTEL_PMC_IDX_FIXED)) {
 		idx = INTEL_PMC_IDX_FIXED;
 		for_each_set_bit_from(idx, c->idxmsk, X86_PMC_IDX_MAX) {
-			if (!__test_and_set_bit(idx, sched->state.used))
-				goto done;
+			u64 mask = BIT_ULL(idx);
+
+			if (sched->state.used & mask)
+				continue;
+
+			sched->state.used |= mask;
+			goto done;
 		}
 	}
 
 	/* Grab the first unused counter starting with idx */
 	idx = sched->state.counter;
 	for_each_set_bit_from(idx, c->idxmsk, INTEL_PMC_IDX_FIXED) {
-		if (!__test_and_set_bit(idx, sched->state.used)) {
-			if (sched->state.nr_gp++ >= sched->max_gp)
-				return false;
+		u64 mask = BIT_ULL(idx);
 
-			goto done;
-		}
+		if (c->flags & PERF_X86_EVENT_PAIR)
+			mask |= mask << 1;
+
+		if (sched->state.used & mask)
+			continue;
+
+		if (sched->state.nr_gp++ >= sched->max_gp)
+			return false;
+
+		sched->state.used |= mask;
+		goto done;
 	}
 
 	return false;
@@ -872,12 +891,10 @@ EXPORT_SYMBOL_GPL(perf_assign_events);
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
 	struct event_constraint *c;
-	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
 	struct hw_perf_event *hwc;
-
-	bitmap_zero(used_mask, X86_PMC_IDX_MAX);
+	u64 used_mask = 0;
 
 	/*
 	 * Compute the number of events already present; see x86_pmu_add(),
@@ -920,6 +937,8 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 * fastpath, try to reuse previous register
 	 */
 	for (i = 0; i < n; i++) {
+		u64 mask;
+
 		hwc = &cpuc->event_list[i]->hw;
 		c = cpuc->event_constraint[i];
 
@@ -931,11 +950,16 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		if (!test_bit(hwc->idx, c->idxmsk))
 			break;
 
+		mask = BIT_ULL(hwc->idx);
+		if (is_counter_pair(hwc))
+			mask |= mask << 1;
+
 		/* not already used */
-		if (test_bit(hwc->idx, used_mask))
+		if (used_mask & mask)
 			break;
 
-		__set_bit(hwc->idx, used_mask);
+		used_mask |= mask;
+
 		if (assign)
 			assign[i] = hwc->idx;
 	}
@@ -958,6 +982,15 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
 			gpmax /= 2;
 
+		/*
+		 * Reduce the amount of available counters to allow fitting
+		 * the extra Merge events needed by large increment events.
+		 */
+		if (x86_pmu.flags & PMU_FL_PAIR) {
+			gpmax = x86_pmu.num_counters - cpuc->n_pair;
+			WARN_ON(gpmax <= 0);
+		}
+
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
 					     wmax, gpmax, assign);
 	}
@@ -1038,6 +1071,8 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 			return -EINVAL;
 		cpuc->event_list[n] = leader;
 		n++;
+		if (is_counter_pair(&leader->hw))
+			cpuc->n_pair++;
 	}
 	if (!dogrp)
 		return n;
@@ -1052,6 +1087,8 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
 
 		cpuc->event_list[n] = event;
 		n++;
+		if (is_counter_pair(&event->hw))
+			cpuc->n_pair++;
 	}
 	return n;
 }
@@ -1238,6 +1275,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 	wrmsrl(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
+	 * Clear the Merge event counter's upper 16 bits since
+	 * we currently declare a 48-bit counter width
+	 */
+	if (is_counter_pair(hwc))
+		wrmsrl(x86_pmu_event_addr(idx + 1), 0);
+
+	/*
 	 * Due to erratum on certan cpu we need
 	 * a second write to be sure the register
 	 * is updated properly
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e2fd363..f1cd1ca 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -273,6 +273,7 @@ struct cpu_hw_events {
 	struct amd_nb			*amd_nb;
 	/* Inverted mask of bits to clear in the perf_ctr ctrl registers */
 	u64				perf_ctr_virt_mask;
+	int				n_pair; /* Large increment events */
 
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
 };
@@ -695,6 +696,7 @@ struct x86_pmu {
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
+	u64		perf_ctr_pair_en;
 
 	/*
 	 * Extra registers for events
@@ -840,6 +842,11 @@ int x86_pmu_hw_config(struct perf_event *event);
 
 void x86_pmu_disable_all(void);
 
+static inline bool is_counter_pair(struct hw_perf_event *hwc)
+{
+	return hwc->flags & PERF_X86_EVENT_PAIR;
+}
+
 static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 					  u64 enable_mask)
 {
@@ -847,6 +854,14 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 
 	if (hwc->extra_reg.reg)
 		wrmsrl(hwc->extra_reg.reg, hwc->extra_reg.config);
+
+	/*
+	 * Add enabled Merge event on next counter
+	 * if large increment event being enabled on this counter
+	 */
+	if (is_counter_pair(hwc))
+		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
+
 	wrmsrl(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
 }
 
@@ -863,6 +878,9 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 
 	wrmsrl(hwc->config_base, hwc->config);
+
+	if (is_counter_pair(hwc))
+		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
