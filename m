Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAC3207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="16f10lr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hdIr0AVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHSIx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgHSIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF1C061757;
        Wed, 19 Aug 2020 01:52:07 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tvoU8qnbQgMjeDxvf/H0rSKhfAc8cpvsPslYm1nEcg=;
        b=16f10lr0CEykN4O7Jx+I5kDtIvX11h+dQzkvHsqprsqfQ33uUsh31zXSEgKJ2xL1jjCf4c
        XFZKzZPIo21HvOx7FA3+FiccyoGPuWBzmK+GdimEoaGaANPAxY06sW1anT4KPHguzbdhiq
        5kY4qU639+JFEXBkYIKmFrC0XkS8apNXWEI9Ip0Jkfafs56yfd8pJFYjKATGpMfHJult/h
        TrJeLRrE4Az3qUI+f0f81Yf6hErHmnKJkKSVNDawmSpOSVfaO+sXPYlwOWklju27wfX7Q1
        zS9MjTP3gQAwm7y4tX3oCLstKSAE/tQLYnZsAGvBfUO53G+HzKpVa9s4qDXDfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827125;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tvoU8qnbQgMjeDxvf/H0rSKhfAc8cpvsPslYm1nEcg=;
        b=hdIr0AVXuHQ7HtSDkhhz60t/yurBNKm4lAlwx46+Wp+npggH5HN+Rj/ScIATEfaVkAh1GT
        gjV6VDzAKXjZcnAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support per-thread RDPMC TopDown metrics
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-12-kan.liang@linux.intel.com>
References: <20200723171117.9918-12-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712493.3192.8387434810923551640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2cb5383b30d47c446ec7d884cd80f93ffcc31817
Gitweb:        https://git.kernel.org/tip/2cb5383b30d47c446ec7d884cd80f93ffcc31817
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:37 +02:00

perf/x86/intel: Support per-thread RDPMC TopDown metrics

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-12-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  5 +-
 arch/x86/events/intel/core.c | 90 ++++++++++++++++++++++++++++++-----
 include/linux/perf_event.h   | 29 +++++++----
 3 files changed, 102 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ebf723f..0f3d015 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2257,7 +2257,10 @@ static int x86_pmu_event_idx(struct perf_event *event)
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
index db83334..c72e490 100644
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
@@ -2318,19 +2368,39 @@ static u64 icl_update_topdown_event(struct perf_event *event)
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
 
-	/* The fixed counter 3 has to be written before the PERF_METRICS. */
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
+		/* The fixed counter 3 has to be written before the PERF_METRICS. */
+		wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
+		wrmsrl(MSR_PERF_METRICS, 0);
+		if (event)
+			update_saved_topdown_regs(event, 0, 0);
+	}
 
 	return slots;
 }
@@ -3578,8 +3648,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			 */
 			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
 			event->hw.flags  |= PERF_X86_EVENT_TOPDOWN;
-
-			event->hw.flags &= ~PERF_X86_EVENT_RDPMC_ALLOWED;
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6048650..46a3974 100644
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
