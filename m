Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747ABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5676420829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG3Miq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:38:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:47697 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3Mip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:38:45 -0400
IronPort-SDR: dG0YZNoUPyhbTqHDicRvmtzmhP5bRQtHqmpzqFmdx0lw0Xo1FO2DgzMt/keLIaPqWdJx55x8/G
 Ca+pBuqHfXjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="151563279"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="151563279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 05:38:44 -0700
IronPort-SDR: LxO0L/Emc8Xug75DJZakcEv19XEKGrJHX6uCYvlVDCTvKhkN7JSOY0AstIR+Xmaz8YtuHRrVBn
 ihw9h2toY9WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="321060269"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2020 05:38:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86: Reset the counter to prevent the leak for a RDPMC task
Date:   Thu, 30 Jul 2020 05:38:15 -0700
Message-Id: <20200730123815.18518-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The counter value of a perf task may leak to another RDPMC task.
For example, a perf stat task as below is running on CPU 0.

    perf stat -e 'branches,cycles' -- taskset -c 0 ./workload

In the meantime, an RDPMC task, which is also running on CPU 0, may read
the GP counters periodically. (The RDPMC task creates a fixed event,
but read four GP counters.)

    $ taskset -c 0 ./rdpmc_read_all_counters
    index 0x0 value 0x8001e5970f99
    index 0x1 value 0x8005d750edb6
    index 0x2 value 0x0
    index 0x3 value 0x0

    index 0x0 value 0x8002358e48a5
    index 0x1 value 0x8006bd1e3bc9
    index 0x2 value 0x0
    index 0x3 value 0x0

The counter value of the perf stat task leaks to the RDPMC task because
perf never clears the counter when it's stopped.

A counter/event stops for the following cases:
- Schedule the monitored task, e.g., context switch or task exit;
- Adjust the event period, e.g., Throttle, in frequency mode;
- Update the event's address range filters.

For the first case, following tasks may reuse the counter. To
prevent the leak, the counter has to be reset, when the event is
scheduled out. The del() is eventually invoked for the schedule out.
The counter should be reset in x86_pmu_del().

For the rest of the cases, the counter/event is temporarily stopped and
will be restarted soon. Other tasks don't have a chance to reuse the
counter. Reset the counter is not necessary.

The RDPMC instruction is only available for the X86 platform. Only apply
the fix for the X86 platform.

After applying the patch,

    $ taskset -c 0 ./rdpmc_read_all_counters
    index 0x0 value 0x0
    index 0x1 value 0x0
    index 0x2 value 0x0
    index 0x3 value 0x0

    index 0x0 value 0x0
    index 0x1 value 0x0
    index 0x2 value 0x0
    index 0x3 value 0x0

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 01ba5fec5765..72b2c7e1bb20 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1499,6 +1499,13 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 */
 	x86_pmu_stop(event, PERF_EF_UPDATE);
 
+	/*
+	 * The counter value may leak to an RDPMC task.
+	 * Clear the counter if the userspace RDPMC usage is enabled.
+	 */
+	if (READ_ONCE(x86_pmu.attr_rdpmc))
+		wrmsrl(event->hw.event_base, 0);
+
 	for (i = 0; i < cpuc->n_events; i++) {
 		if (event == cpuc->event_list[i])
 			break;
-- 
2.17.1

