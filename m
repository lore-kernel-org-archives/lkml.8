Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16897C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCA72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAQKKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:10:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgAQKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYQ-0005Ot-VI; Fri, 17 Jan 2020 11:08:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8EB031C19CD;
        Fri, 17 Jan 2020 11:08:38 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:38 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Constrain Large Increment per Cycle events
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191114183720.19887-2-kim.phillips@amd.com>
References: <20191114183720.19887-2-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <157925571838.396.11399384223092495246.tip-bot2@tip-bot2>
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

Commit-ID:     471af006a747f1c535c8a8c6c0973c320fe01b22
Gitweb:        https://git.kernel.org/tip/471af006a747f1c535c8a8c6c0973c320fe01b22
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Thu, 14 Nov 2019 12:37:19 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:26 +01:00

perf/x86/amd: Constrain Large Increment per Cycle events

AMD Family 17h processors and above gain support for Large Increment
per Cycle events.  Unfortunately there is no CPUID or equivalent bit
that indicates whether the feature exists or not, so we continue to
determine eligibility based on a CPU family number comparison.

For Large Increment per Cycle events, we add a f17h-and-compatibles
get_event_constraints_f17h() that returns an even counter bitmask:
Large Increment per Cycle events can only be placed on PMCs 0, 2,
and 4 out of the currently available 0-5.  The only currently
public event that requires this feature to report valid counts
is PMCx003 "Retired SSE/AVX Operations".

Note that the CPU family logic in amd_core_pmu_init() is changed
so as to be able to selectively add initialization for features
available in ranges of backward-compatible CPU families.  This
Large Increment per Cycle feature is expected to be retained
in future families.

A side-effect of assigning a new get_constraints function for f17h
disables calling the old (prior to f15h) amd_get_event_constraints
implementation left enabled by commit e40ed1542dd7 ("perf/x86: Add perf
support for AMD family-17h processors"), which is no longer
necessary since those North Bridge event codes are obsoleted.

Also fix a spelling mistake whilst in the area (calulating ->
calculating).

Fixes: e40ed1542dd7 ("perf/x86: Add perf support for AMD family-17h processors")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191114183720.19887-2-kim.phillips@amd.com
---
 arch/x86/events/amd/core.c   | 91 +++++++++++++++++++++++------------
 arch/x86/events/perf_event.h |  2 +-
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index a7752cd..571168f 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -301,6 +301,25 @@ static inline int amd_pmu_addr_offset(int index, bool eventsel)
 	return offset;
 }
 
+/*
+ * AMD64 events are detected based on their event codes.
+ */
+static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
+{
+	return ((hwc->config >> 24) & 0x0f00) | (hwc->config & 0x00ff);
+}
+
+static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
+{
+	if (!(x86_pmu.flags & PMU_FL_PAIR))
+		return false;
+
+	switch (amd_get_event_code(hwc)) {
+	case 0x003:	return true;	/* Retired SSE/AVX FLOPs */
+	default:	return false;
+	}
+}
+
 static int amd_core_hw_config(struct perf_event *event)
 {
 	if (event->attr.exclude_host && event->attr.exclude_guest)
@@ -319,14 +338,6 @@ static int amd_core_hw_config(struct perf_event *event)
 	return 0;
 }
 
-/*
- * AMD64 events are detected based on their event codes.
- */
-static inline unsigned int amd_get_event_code(struct hw_perf_event *hwc)
-{
-	return ((hwc->config >> 24) & 0x0f00) | (hwc->config & 0x00ff);
-}
-
 static inline int amd_is_nb_event(struct hw_perf_event *hwc)
 {
 	return (hwc->config & 0xe0) == 0xe0;
@@ -855,6 +866,20 @@ amd_get_event_constraints_f15h(struct cpu_hw_events *cpuc, int idx,
 	}
 }
 
+static struct event_constraint pair_constraint;
+
+static struct event_constraint *
+amd_get_event_constraints_f17h(struct cpu_hw_events *cpuc, int idx,
+			       struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (amd_is_pair_event_code(hwc))
+		return &pair_constraint;
+
+	return &unconstrained;
+}
+
 static ssize_t amd_event_sysfs_show(char *page, u64 config)
 {
 	u64 event = (config & ARCH_PERFMON_EVENTSEL_EVENT) |
@@ -898,33 +923,15 @@ static __initconst const struct x86_pmu amd_pmu = {
 
 static int __init amd_core_pmu_init(void)
 {
+	u64 even_ctr_mask = 0ULL;
+	int i;
+
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
-	/* Avoid calulating the value each time in the NMI handler */
+	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
 
-	switch (boot_cpu_data.x86) {
-	case 0x15:
-		pr_cont("Fam15h ");
-		x86_pmu.get_event_constraints = amd_get_event_constraints_f15h;
-		break;
-	case 0x17:
-		pr_cont("Fam17h ");
-		/*
-		 * In family 17h, there are no event constraints in the PMC hardware.
-		 * We fallback to using default amd_get_event_constraints.
-		 */
-		break;
-	case 0x18:
-		pr_cont("Fam18h ");
-		/* Using default amd_get_event_constraints. */
-		break;
-	default:
-		pr_err("core perfctr but no constraints; unknown hardware!\n");
-		return -ENODEV;
-	}
-
 	/*
 	 * If core performance counter extensions exists, we must use
 	 * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
@@ -939,6 +946,30 @@ static int __init amd_core_pmu_init(void)
 	 */
 	x86_pmu.amd_nb_constraints = 0;
 
+	if (boot_cpu_data.x86 == 0x15) {
+		pr_cont("Fam15h ");
+		x86_pmu.get_event_constraints = amd_get_event_constraints_f15h;
+	}
+	if (boot_cpu_data.x86 >= 0x17) {
+		pr_cont("Fam17h+ ");
+		/*
+		 * Family 17h and compatibles have constraints for Large
+		 * Increment per Cycle events: they may only be assigned an
+		 * even numbered counter that has a consecutive adjacent odd
+		 * numbered counter following it.
+		 */
+		for (i = 0; i < x86_pmu.num_counters - 1; i += 2)
+			even_ctr_mask |= 1 << i;
+
+		pair_constraint = (struct event_constraint)
+				    __EVENT_CONSTRAINT(0, even_ctr_mask, 0,
+				    x86_pmu.num_counters / 2, 0,
+				    PERF_X86_EVENT_PAIR);
+
+		x86_pmu.get_event_constraints = amd_get_event_constraints_f17h;
+		x86_pmu.flags |= PMU_FL_PAIR;
+	}
+
 	pr_cont("core perfctr, ");
 	return 0;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 930611d..e2fd363 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -77,6 +77,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
 #define PERF_X86_EVENT_PEBS_VIA_PT	0x0800 /* use PT buffer for PEBS */
+#define PERF_X86_EVENT_PAIR		0x1000 /* Large Increment per Cycle */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -743,6 +744,7 @@ do {									\
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
 #define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 #define PMU_FL_TFA		0x20 /* deal with TSX force abort */
+#define PMU_FL_PAIR		0x40 /* merge counters for large incr. events */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
