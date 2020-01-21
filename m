Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331D24672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgAUTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:04:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:62583 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgAUTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:04:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 11:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="227431773"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2020 11:04:05 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel: Fix inaccurate period in context switch for auto-reload
Date:   Tue, 21 Jan 2020 11:01:25 -0800
Message-Id: <20200121190125.3389-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf doesn't take the left period into account when auto-reload is
enabled with fixed period sampling mode in context switch.

Here is the MSR trace of the perf command as below.
(The MSR trace is simplified from a ftrace log.)

    #perf record -e cycles:p -c 2000000 -- ./triad_loop

      //The MSR trace of task schedule out
      //perf disable all counters, disable PEBS, disable GP counter 0,
      //read GP counter 0, and re-enable all counters.
      //The counter 0 stops at 0xfffffff82840
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 0
      write_msr: MSR_P6_EVNTSEL0(186), value 40003003c
      rdpmc: 0, value fffffff82840
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff


      //The MSR trace of the same task schedule in again
      //perf disable all counters, enable and set GP counter 0,
      //enable PEBS, and re-enable all counters.
      //0xffffffe17b80 (-2000000) is written to GP counter 0.
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PMC0(4c1), value ffffffe17b80
      write_msr: MSR_P6_EVNTSEL0(186), value 40043003c
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 1
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

When the same task schedule in again, the counter should starts from
previous left. However, it starts from the fixed period -2000000 again.

A special variant of intel_pmu_save_and_restart() is used for
auto-reload, which doesn't update the hwc->period_left.
When the monitored task schedules in again, perf doesn't know the left
period. The fixed period is used, which is inaccurate.

With auto-reload, the counter always has a negative counter value. So
the left period is -value. Update the period_left in
intel_pmu_save_and_restart_reload().

With the patch,
      //The MSR trace of task schedule out
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 0
      write_msr: MSR_P6_EVNTSEL0(186), value 40003003c
      rdpmc: 0, value ffffffe25cbc
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

      //The MSR trace of the same task schedule in again
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PMC0(4c1), value ffffffe25cbc
      write_msr: MSR_P6_EVNTSEL0(186), value 40043003c
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 1
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

Fixes: d31fc13fdcb2 ("perf/x86/intel: Fix event update for auto-reload")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1
- Update description

 arch/x86/events/intel/ds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce83950036c5..e5ad97a82342 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1713,6 +1713,8 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	old = ((s64)(prev_raw_count << shift) >> shift);
 	local64_add(new - old + count * period, &event->count);
 
+	local64_set(&hwc->period_left, -new);
+
 	perf_event_update_userpage(event);
 
 	return 0;
-- 
2.17.1

