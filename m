Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B53DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BFF206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r7qfMZ01";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cG+dYnX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGCIBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:01:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57394 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgGCIBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:01:31 -0400
Date:   Fri, 03 Jul 2020 08:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593763288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+EOf4ghmSHvy38jI0Ooj7OEVAUc9M2kU2mJVgBXnCQ=;
        b=r7qfMZ01hETV7KqQ48Vil62aLtX5RJfBB/jJUPBMKPX9Rh895S2zJy+xNR1oOi7T2qhs9P
        3KEgm0ZqrJxnwRFO/iCWHFx0EE9r4IW5Hyt4siAUgjUm5yH5L+uTLcGHyrUA1EeT/uirLM
        oadKtL5RibBoVJpfB3F0eZJipev7IMYASBnVdrySBrLgJzrqmchkiurl6SBwSanwNDxk6Z
        ZB0tqfiR20wFkXVxqqL+gJiiwctymL8GIsOq/qOigyb/UCxm3ic3/G7fb9zarBGMFJQjAq
        GObjp5kNMKuPNTrE9pqIz51vWL7lCIIwk9weVhXgb9oa8Ntk624eRaf/Q5IKzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593763288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+EOf4ghmSHvy38jI0Ooj7OEVAUc9M2kU2mJVgBXnCQ=;
        b=cG+dYnX8UTqwA9gXflnO5xnizpmRLVNctYwQm4G87L/QmJPmQPDDAGfi7351I6RETJAYwK
        DYbe1oJIKin7OPAg==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/core: Refactor hw->idx checks and cleanup
Cc:     Like Xu <like.xu@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200613080958.132489-3-like.xu@linux.intel.com>
References: <20200613080958.132489-3-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159376328782.4006.14997679073110012561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     027440b5d426a51f33b515bbd236cc479d1e051f
Gitweb:        https://git.kernel.org/tip/027440b5d426a51f33b515bbd236cc479d1e051f
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Sat, 13 Jun 2020 16:09:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 02 Jul 2020 15:51:46 +02:00

perf/x86/core: Refactor hw->idx checks and cleanup

For intel_pmu_en/disable_event(), reorder the branches checks for hw->idx
and make them sorted by probability: gp,fixed,bts,others.

Clean up the x86_assign_hw_event() by converting multiple if-else
statements to a switch statement.

To skip x86_perf_event_update() and x86_perf_event_set_period(),
it's generic to replace "idx == INTEL_PMC_IDX_FIXED_BTS" check with
'!hwc->event_base' because that should be 0 for all non-gp/fixed cases.

Wrap related bit operations into intel_set/clear_masks() and make the main
path more cleaner and readable.

No functional changes.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Original-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200613080958.132489-3-like.xu@linux.intel.com
---
 arch/x86/events/core.c       | 25 ++++++----
 arch/x86/events/intel/core.c | 85 ++++++++++++++++++-----------------
 2 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4103665..15cb7af 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -71,10 +71,9 @@ u64 x86_perf_event_update(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int shift = 64 - x86_pmu.cntval_bits;
 	u64 prev_raw_count, new_raw_count;
-	int idx = hwc->idx;
 	u64 delta;
 
-	if (idx == INTEL_PMC_IDX_FIXED_BTS)
+	if (unlikely(!hwc->event_base))
 		return 0;
 
 	/*
@@ -1097,22 +1096,30 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 				struct cpu_hw_events *cpuc, int i)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	int idx;
 
-	hwc->idx = cpuc->assign[i];
+	idx = hwc->idx = cpuc->assign[i];
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
-	if (hwc->idx == INTEL_PMC_IDX_FIXED_BTS) {
+	switch (hwc->idx) {
+	case INTEL_PMC_IDX_FIXED_BTS:
 		hwc->config_base = 0;
 		hwc->event_base	= 0;
-	} else if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+		break;
+
+	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 + (hwc->idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (hwc->idx - INTEL_PMC_IDX_FIXED) | 1<<30;
-	} else {
+		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
+				(idx - INTEL_PMC_IDX_FIXED);
+		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		break;
+
+	default:
 		hwc->config_base = x86_pmu_config_addr(hwc->idx);
 		hwc->event_base  = x86_pmu_event_addr(hwc->idx);
 		hwc->event_base_rdpmc = x86_pmu_rdpmc_index(hwc->idx);
+		break;
 	}
 }
 
@@ -1233,7 +1240,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 	s64 period = hwc->sample_period;
 	int ret = 0, idx = hwc->idx;
 
-	if (idx == INTEL_PMC_IDX_FIXED_BTS)
+	if (unlikely(!hwc->event_base))
 		return 0;
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ca35c8b..8dac4c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2136,8 +2136,35 @@ static inline void intel_pmu_ack_status(u64 ack)
 	wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, ack);
 }
 
-static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
+static inline bool event_is_checkpointed(struct perf_event *event)
+{
+	return unlikely(event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
+}
+
+static inline void intel_set_masks(struct perf_event *event, int idx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (event->attr.exclude_host)
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+	if (event->attr.exclude_guest)
+		__set_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	if (event_is_checkpointed(event))
+		__set_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
+}
+
+static inline void intel_clear_masks(struct perf_event *event, int idx)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_guest_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_ctrl_host_mask);
+	__clear_bit(idx, (unsigned long *)&cpuc->intel_cp_status);
+}
+
+static void intel_pmu_disable_fixed(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, mask;
 
@@ -2148,31 +2175,22 @@ static void intel_pmu_disable_fixed(struct hw_perf_event *hwc)
 	wrmsrl(hwc->config_base, ctrl_val);
 }
 
-static inline bool event_is_checkpointed(struct perf_event *event)
-{
-	return (event->hw.config & HSW_IN_TX_CHECKPOINTED) != 0;
-}
-
 static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int idx = hwc->idx;
 
-	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		intel_clear_masks(event, idx);
+		x86_pmu_disable_event(event);
+	} else if (idx < INTEL_PMC_IDX_FIXED_BTS) {
+		intel_clear_masks(event, idx);
+		intel_pmu_disable_fixed(event);
+	} else if (idx == INTEL_PMC_IDX_FIXED_BTS) {
 		intel_pmu_disable_bts();
 		intel_pmu_drain_bts_buffer();
-		return;
 	}
 
-	cpuc->intel_ctrl_guest_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
-	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
-
-	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL))
-		intel_pmu_disable_fixed(hwc);
-	else
-		x86_pmu_disable_event(event);
-
 	/*
 	 * Needs to be called after x86_pmu_disable_event,
 	 * so we don't trigger the event without PEBS bit set.
@@ -2238,33 +2256,22 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-
-	if (unlikely(hwc->idx == INTEL_PMC_IDX_FIXED_BTS)) {
-		if (!__this_cpu_read(cpu_hw_events.enabled))
-			return;
-
-		intel_pmu_enable_bts(hwc->config);
-		return;
-	}
-
-	if (event->attr.exclude_host)
-		cpuc->intel_ctrl_guest_mask |= (1ull << hwc->idx);
-	if (event->attr.exclude_guest)
-		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
-
-	if (unlikely(event_is_checkpointed(event)))
-		cpuc->intel_cp_status |= (1ull << hwc->idx);
+	int idx = hwc->idx;
 
 	if (unlikely(event->attr.precise_ip))
 		intel_pmu_pebs_enable(event);
 
-	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		intel_set_masks(event, idx);
+		__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
+	} else if (idx < INTEL_PMC_IDX_FIXED_BTS) {
+		intel_set_masks(event, idx);
 		intel_pmu_enable_fixed(event);
-		return;
+	} else if (idx == INTEL_PMC_IDX_FIXED_BTS) {
+		if (!__this_cpu_read(cpu_hw_events.enabled))
+			return;
+		intel_pmu_enable_bts(hwc->config);
 	}
-
-	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
 static void intel_pmu_add_event(struct perf_event *event)
