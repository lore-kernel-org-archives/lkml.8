Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1C20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgCCU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:29:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:35388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731014AbgCCU3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:29:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 12:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="440731143"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga006.fm.intel.com with ESMTP; 03 Mar 2020 12:29:19 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     irogers@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/core: Fix endless multiplex timer
Date:   Tue,  3 Mar 2020 12:28:19 -0800
Message-Id: <20200303202819.3942-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A lot of time are spent in writing uncore MSRs even though no perf is
running.

  4.66%  swapper      [kernel.kallsyms]        [k] native_write_msr
            |
             --4.56%--native_write_msr
                       |
                       |--1.68%--snbep_uncore_msr_enable_box
                       |          perf_mux_hrtimer_handler
                       |          __hrtimer_run_queues
                       |          hrtimer_interrupt
                       |          smp_apic_timer_interrupt
                       |          apic_timer_interrupt
                       |          cpuidle_enter_state
                       |          cpuidle_enter
                       |          do_idle
                       |          cpu_startup_entry
                       |          start_kernel
                       |          secondary_startup_64

The root cause is that multiplex timer was not stopped when perf stat
finished.
Current perf relies on rotate_necessary to determine whether the
multiplex timer should be stopped. The variable only be reset in
ctx_sched_out(), which is not enough for system-wide event.
Perf stat invokes PERF_EVENT_IOC_DISABLE to stop system-wide event
before closing it.
  perf_ioctl()
    perf_event_disable()
      event_sched_out()
The rotate_necessary will never be reset.

The issue is a generic issue, not just impact the uncore.

Check whether we had been multiplexing. If yes, reset rotate_necessary
for the last active event in __perf_event_disable().

Fixes: fd7d55172d1e ("perf/cgroups: Don't rotate events for cgroups unnecessarily")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f1f77de7247..50688de56181 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2242,6 +2242,16 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	/*
+	 * If we had been multiplexing,
+	 * stop the rotations for the last active event.
+	 * Only need to check system wide events.
+	 * For task events, it will be checked in ctx_sched_out().
+	 */
+	if ((cpuctx->ctx.nr_events != cpuctx->ctx.nr_active) &&
+	    (cpuctx->ctx.nr_active == 1))
+		cpuctx->ctx.rotate_necessary = 0;
+
 	if (event == event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
 	else
-- 
2.17.1

