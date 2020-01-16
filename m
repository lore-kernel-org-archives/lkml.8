Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A81C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052912053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437291AbgAPTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:01:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:12875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388807AbgAPTB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:01:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 11:01:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,327,1574150400"; 
   d="scan'208";a="220465275"
Received: from otc-lr-04.jf.intel.com ([10.54.39.113])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2020 11:01:13 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V3] perf/x86: Consider pinned events for group validation
Date:   Thu, 16 Jan 2020 11:00:25 -0800
Message-Id: <1579201225-178031-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

perf stat -M metrics relies on weak groups to reject unschedulable
groups and run them as non-groups.
This uses the group validation code in the kernel. Unfortunately
that code doesn't take pinned events, such as the NMI watchdog, into
account. So some groups can pass validation, but then later still
never schedule.

For example,

 $echo 1 > /proc/sys/kernel/nmi_watchdog
 $perf stat -M Page_Walks_Utilization

 Performance counter stats for 'system wide':

     <not counted>      itlb_misses.walk_pending
(0.00%)
     <not counted>      dtlb_load_misses.walk_pending
(0.00%)
     <not counted>      dtlb_store_misses.walk_pending
(0.00%)
     <not counted>      ept.walk_pending
(0.00%)
     <not counted>      cycles
(0.00%)

       1.176613558 seconds time elapsed

Current pinned events are always scheduled first. So the new group must
can be scheduled together with current pinned events. Otherwise, it will
never get a chance to be scheduled later.
The trick is to pretend the current pinned events as part of the new
group, and insert them into the fake_cpuc.
The simulation result will tell if they can be scheduled successfully.
The fake_cpuc never touch event state. The current pinned events will
not be impacted.
Disabling interrupts to prevent the events in current CPU's cpuc going
away and getting freed.

It won't catch all possible cases that cannot be scheduled, such as
events pinned differently on different CPUs, or complicated constraints.
The validation is based on current environment. It doesn't help on the
case, which first create a group and then a pinned event, either.
But for the most common case, the NMI watchdog interacting with the
current perf metrics, it is strong enough.

After applying the patch,

 $echo 1 > /proc/sys/kernel/nmi_watchdog
 $ perf stat -M Page_Walks_Utilization

 Performance counter stats for 'system wide':

         2,491,910      itlb_misses.walk_pending  #      0.0
Page_Walks_Utilization   (79.94%)
        13,630,942      dtlb_load_misses.walk_pending
(80.02%)
           207,255      dtlb_store_misses.walk_pending
(80.04%)
                 0      ept.walk_pending
(80.04%)
       236,204,924      cycles
(79.97%)

       0.901785713 seconds time elapsed

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Update comments (preemption is disabled as well)

The V2 still only check current CPU's cpuc. Because I think we cannot
prevent the cpuc in other CPU without a lock. Adding a lock will
introduce extra overhead in some critical path, e.g. context switch.
The patch is good enough for the common case. We may leave the other
complicated cases as they are.

Changes since V1:
- Disabling interrupts to prevent the events in current CPU's cpuc
  going away and getting freed.
- Update comments and description

 arch/x86/events/core.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 43d0918..c4d9e14 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2032,9 +2032,12 @@ static int validate_event(struct perf_event *event)
  */
 static int validate_group(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *leader = event->group_leader;
 	struct cpu_hw_events *fake_cpuc;
-	int ret = -EINVAL, n;
+	struct perf_event *pinned_event;
+	int ret = -EINVAL, n, i;
+	unsigned long flags;
 
 	fake_cpuc = allocate_fake_cpuc();
 	if (IS_ERR(fake_cpuc))
@@ -2054,9 +2057,38 @@ static int validate_group(struct perf_event *event)
 	if (n < 0)
 		goto out;
 
+	/*
+	 * Disable interrupts and preemption to prevent the events in this
+	 * CPU's cpuc going away and getting freed.
+	 */
+	local_irq_save(flags);
+
+	/*
+	 * The new group must can be scheduled together with current pinned
+	 * events. Otherwise, it will never get a chance to be scheduled later.
+	 *
+	 * It won't catch all possible cases that cannot schedule, such as
+	 * events pinned on CPU1, but the validation for a new CPU1 event
+	 * running on other CPU. However, it's good enough to handle common
+	 * cases like the global NMI watchdog.
+	 */
+	for (i = 0; i < cpuc->n_events; i++) {
+		pinned_event = cpuc->event_list[i];
+		if (WARN_ON_ONCE(!pinned_event))
+			continue;
+		if (!pinned_event->attr.pinned)
+			continue;
+		fake_cpuc->n_events = n;
+		n = collect_events(fake_cpuc, pinned_event, false);
+		if (n < 0)
+			goto irq;
+	}
+
 	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
 
+irq:
+	local_irq_restore(flags);
 out:
 	free_fake_cpuc(fake_cpuc);
 	return ret;
-- 
2.7.4

