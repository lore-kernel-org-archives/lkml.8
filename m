Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E3BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01D9208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBVIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:08:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:24474 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBVIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 17:08:01 -0400
IronPort-SDR: 0GgcbtCZLhXuPFDQ3ebZC7TT2b9e3he1PHJ9NVwgKztk9CCoUG+tQtjY1IeBTFiVFqjJGO3n6L
 G/cIHUAdZ/YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="156748838"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="156748838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 14:07:59 -0700
IronPort-SDR: 4BMMIE6/WtWsNus5Edcz+RenNV0g0upgqa5nYQbQbQZWS/YUu9ZSkNhsZQf/22Urw8mIoaxUQK
 cc2tToA5r+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="502810709"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2020 14:07:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, like.xu@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel/ds: Fix x86_pmu_stop warning for large PEBS
Date:   Wed,  2 Sep 2020 14:06:49 -0700
Message-Id: <20200902210649.2743-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A warning as below may be triggered when sampling with large PEBS.

[  410.411250] perf: interrupt took too long (72145 > 71975), lowering
kernel.perf_event_max_sample_rate to 2000
[  410.724923] ------------[ cut here ]------------
[  410.729822] WARNING: CPU: 0 PID: 16397 at arch/x86/events/core.c:1422
x86_pmu_stop+0x95/0xa0
[  410.933811]  x86_pmu_del+0x50/0x150
[  410.937304]  event_sched_out.isra.0+0xbc/0x210
[  410.941751]  group_sched_out.part.0+0x53/0xd0
[  410.946111]  ctx_sched_out+0x193/0x270
[  410.949862]  __perf_event_task_sched_out+0x32c/0x890
[  410.954827]  ? set_next_entity+0x98/0x2d0
[  410.958841]  __schedule+0x592/0x9c0
[  410.962332]  schedule+0x5f/0xd0
[  410.965477]  exit_to_usermode_loop+0x73/0x120
[  410.969837]  prepare_exit_to_usermode+0xcd/0xf0
[  410.974369]  ret_from_intr+0x2a/0x3a
[  410.977946] RIP: 0033:0x40123c
[  411.079661] ---[ end trace bc83adaea7bb664a ]---

In the non-overflow context, e.g., context switch, with large PEBS, perf
may stop an event twice. An example is below.

  //max_samples_per_tick is adjusted to 2
  //NMI is triggered
  intel_pmu_handle_irq()
     handle_pmi_common()
       drain_pebs()
         __intel_pmu_pebs_event()
           perf_event_overflow()
             __perf_event_account_interrupt()
               hwc->interrupts = 1
               return 0
  //A context switch happens right after the NMI.
  //In the same tick, the perf_throttled_seq is not changed.
  perf_event_task_sched_out()
     perf_pmu_sched_task()
       intel_pmu_drain_pebs_buffer()
         __intel_pmu_pebs_event()
           perf_event_overflow()
             __perf_event_account_interrupt()
               ++hwc->interrupts >= max_samples_per_tick
               return 1
           x86_pmu_stop();  # First stop
     perf_event_context_sched_out()
       task_ctx_sched_out()
         ctx_sched_out()
           event_sched_out()
             x86_pmu_del()
               x86_pmu_stop();  # Second stop and trigger the warning

Perf should only invoke the perf_event_overflow() in the overflow
context.

Current drain_pebs() is called from:
- handle_pmi_common()			-- overflow context
- intel_pmu_pebs_sched_task()		-- non-overflow context
- intel_pmu_pebs_disable()		-- non-overflow context
- intel_pmu_auto_reload_read()		-- possible overflow context
  With PERF_SAMPLE_READ + PERF_FORMAT_GROUP, the function may be
  invoked in the NMI handler. But, before calling the function, the
  PEBS buffer has already been drained. The __intel_pmu_pebs_event()
  will not be called in the possible overflow context.

To fix the issue, an indicator is required to distinguish between the
overflow context aka handle_pmi_common() and other cases.
The dummy regs pointer can be used as the indicator.

In the non-overflow context, perf should treat the last record the same
as other PEBS records, and doesn't invoke the generic overflow handler.

Fixes: 21509084f999 ("perf/x86/intel: Handle multiple records in the PEBS buffer")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Like Xu <like.xu@linux.intel.com>
Tested-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

The V1 patch can be found here.
https://lore.kernel.org/lkml/20200113140935.3474-1-kan.liang@linux.intel.com/
The V1 patch used in_nmi() as an indicator, which is replaced by the
dummy regs pointer in V2.

 arch/x86/events/intel/ds.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 86848c57b55e..404315df1e16 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -670,9 +670,7 @@ int intel_pmu_drain_bts_buffer(void)
 
 static inline void intel_pmu_drain_pebs_buffer(void)
 {
-	struct pt_regs regs;
-
-	x86_pmu.drain_pebs(&regs);
+	x86_pmu.drain_pebs(NULL);
 }
 
 /*
@@ -1737,6 +1735,7 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
+	struct pt_regs dummy_iregs;
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
 		/*
@@ -1749,6 +1748,9 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	} else if (!intel_pmu_save_and_restart(event))
 		return;
 
+	if (!iregs)
+		iregs = &dummy_iregs;
+
 	while (count > 1) {
 		setup_sample(event, iregs, at, &data, regs);
 		perf_event_output(event, &data, regs);
@@ -1758,16 +1760,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	}
 
 	setup_sample(event, iregs, at, &data, regs);
-
-	/*
-	 * All but the last records are processed.
-	 * The last one is left to be able to call the overflow handler.
-	 */
-	if (perf_event_overflow(event, &data, regs)) {
-		x86_pmu_stop(event, 0);
-		return;
+	if (iregs == &dummy_iregs) {
+		/*
+		 * The PEBS records may be drained in the non-overflow context,
+		 * e.g., large PEBS + context switch. Perf should treat the
+		 * last record the same as other PEBS records, and doesn't
+		 * invoke the generic overflow handler.
+		 */
+		perf_event_output(event, &data, regs);
+	} else {
+		/*
+		 * All but the last records are processed.
+		 * The last one is left to be able to call the overflow handler.
+		 */
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
 	}
-
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
-- 
2.17.1

