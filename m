Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F0C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6811207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgAMOKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:10:39 -0500
Received: from mga01.intel.com ([192.55.52.88]:61824 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMOKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:10:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 06:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="242107020"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.46])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2020 06:10:37 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, like.xu@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/ds: Fix x86_pmu_stop warning for large PEBS
Date:   Mon, 13 Jan 2020 06:09:35 -0800
Message-Id: <20200113140935.3474-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A warning as below may be triggered when sampling large PEBS.

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

For large PEBS, the PEBS buffer can be drained from either NMI handler
or !NMI e.g. context switch. Current implementation doesn't handle them
differently. For !nmi, perf also call the generic overflow handler for
the last PEBS record. That may trigger the interrupt throttle, and stop
the event. That's wrong.

Here is an example for !NMI scenario, context switch.
Let's say the max_samples_per_tick is adjusted to 2 for some reason.
A context switch happens right after a NMI.
When an old task is scheduled out, it will drain the PEBS buffer, and
then delete the event.
When draining the PEBS buffer, perf_event_overflow() will be called for
the last PEBS record. Since the max_samples_per_tick is only 2, the
interrupt throttle must be triggered. The event will be stopped.
After the draining, the scheduler will delete the event, which stops the
event again. The warning is triggered.

Perf should handle the NMI and !NMI differently for large PEBS.
For NMI, the generic overflow handler is required for the last PEBS
record.
But, for !NMI, there is no overflow. The generic overflow handler should
not be invoked. Perf should treat the last record exactly the same as
the rest of PEBS records.

Fixes: 21509084f999 ("perf/x86/intel: Handle multiple records in the PEBS buffer")
Reported-by: Like Xu <like.xu@linux.intel.com>
Tested-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7c896d7e8b6c..51baff083938 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1780,15 +1780,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 
 	setup_sample(event, iregs, at, &data, regs);
 
-	/*
-	 * All but the last records are processed.
-	 * The last one is left to be able to call the overflow handler.
-	 */
-	if (perf_event_overflow(event, &data, regs)) {
-		x86_pmu_stop(event, 0);
-		return;
+	if (in_nmi()) {
+		/*
+		 * All but the last records are processed.
+		 * The last one is left to be able to call the overflow handler.
+		 */
+		if (perf_event_overflow(event, &data, regs))
+			x86_pmu_stop(event, 0);
+	} else {
+		/*
+		 * For !NMI, e.g context switch, there is no overflow.
+		 * The generic overflow handler should not be invoked.
+		 * Perf should treat the last record exactly the same as the
+		 * rest of PEBS records.
+		 */
+		perf_event_output(event, &data, regs);
 	}
-
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
-- 
2.17.1

