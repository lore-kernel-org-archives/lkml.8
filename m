Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE7C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFFE206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgD0Ond (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:43:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:46451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgD0Ond (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:43:33 -0400
IronPort-SDR: JSv5fgXHHrvlMechHgTw3G2Xapa1l8MyqzoCoG+rmpIRNDJfG079pcCfJTb6Jz3c/cLwOwYvUA
 7o2LmbxZLl+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 07:43:33 -0700
IronPort-SDR: avov4jYLsqvRw1lDKGFI5vjqnxWCOZDUGz1gRGSU00MhtwsACznDXo5+K2NaJqO21ourWFoHZI
 6FvJBfMbTFxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="404326643"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2020 07:43:30 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Fix uncore event mixed metric with workload error issue
Date:   Mon, 27 Apr 2020 22:41:16 +0800
Message-Id: <20200427144116.27330-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metric mixed with uncore event is failed with workload.

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -- sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
/bin/dmesg | grep -i perf may provide additional information.

But it works without workload.

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use
^C
 Performance counter stats for 'system wide':

              5.38 MiB  uncore_imc/cas_count_read/
              3.98 MiB  uncore_imc/cas_count_write/
        1550285007 ns   duration_time

       1.550285007 seconds time elapsed

The uncore events (e.g. uncore_imc/cas_count_read/ and
uncore_imc/cas_count_write/) have been forced to system wide but duration_time
is not.

Currently, the target system wide is set according to:

1. there's no workload specified
2. there is workload specified but all requested events are system wide events.

For DRAM_BW_Use, the target is not set to system wide since 2 is not
met. Next, the counter creation on CPU will run into some issues.

It should make sense to set the target system wide if there is workload
specified and at least one required event is system wide event.

With this patch,

root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -- sleep 1

 Performance counter stats for 'system wide':

              4.81 MiB  uncore_imc/cas_count_read/
              2.89 MiB  uncore_imc/cas_count_write/
        1002019036 ns   duration_time

       1.002019036 seconds time elapsed

Fixes: e3ba76deef23 ("perf tools: Force uncore events to system wide monitoring")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9207b6c45475..b01ee06b1965 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1841,8 +1841,8 @@ static void setup_system_wide(int forks)
 	 * conditions is met:
 	 *
 	 *   - there's no workload specified
-	 *   - there is workload specified but all requested
-	 *     events are system wide events
+	 *   - there is workload specified but at least one requested
+	 *     event is system wide event
 	 */
 	if (!target__none(&target))
 		return;
@@ -1851,13 +1851,16 @@ static void setup_system_wide(int forks)
 		target.system_wide = true;
 	else {
 		struct evsel *counter;
+		bool system_wide = false;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->core.system_wide)
-				return;
+			if (counter->core.system_wide) {
+				system_wide = true;
+				break;
+			}
 		}
 
-		if (evsel_list->core.nr_entries)
+		if (evsel_list->core.nr_entries && system_wide)
 			target.system_wide = true;
 	}
 }
-- 
2.17.1

