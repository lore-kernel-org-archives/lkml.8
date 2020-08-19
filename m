Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAFDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66366206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gu4lCLZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="diOnhVLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgHSIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:55:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgHSIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:11 -0400
Date:   Wed, 19 Aug 2020 08:52:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEmp1dCGS2iHgtJ4L7r0DUbF4zfDD8HiadE5pe2z+lU=;
        b=Gu4lCLZ8FzapLSKi62pzCUFUNcn317YXv87JkOuPE8bC67ZE/6EfdwM9l4waZtHS2gEZWw
        X1G/iViEqtSGcg5pWSJBGSvKIS0ZdczDBmRrf69V/eUDsC3uYeAARbOveNUBweGb7dyi7o
        P4Am9iRNlnvO3Fwv8Dg9TZgpltPPcli2OEyBkMvNLRHWiKzanRxapyrlv0epCzReMLFjIG
        wwRBKm1Qbz1UvsJrTyKsY5vLteqhsY7svwgQXqrKD2Ez0wwK3M2Zc0vzNqtgQaNMskejf3
        DnIt/PeiVmqRQw2yydONDG/rGxV7u1c2Kbb5NuojUIK9oSO1QtIoVznsvd+IMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEmp1dCGS2iHgtJ4L7r0DUbF4zfDD8HiadE5pe2z+lU=;
        b=diOnhVLoxRjTpvJ/6j4NV0fTw/rG72kmoXSkMDf8aCh+fpm3N/V7j56WS+pWB0NaTUF8yQ
        z3emW0B3SWrQIyBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Use switch in intel_pmu_disable/enable_event
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-7-kan.liang@linux.intel.com>
References: <20200723171117.9918-7-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712833.3192.4230490784691479050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     58da7dbe6f036fefe504a4bb452afbd39bba73f7
Gitweb:        https://git.kernel.org/tip/58da7dbe6f036fefe504a4bb452afbd39bba73f7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:36 +02:00

perf/x86/intel: Use switch in intel_pmu_disable/enable_event

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-7-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac1408f..76eab81 100644
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
