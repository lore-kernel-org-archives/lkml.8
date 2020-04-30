Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC8C83004
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D4120731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD3AiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:38:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:27133 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgD3AiV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:38:21 -0400
IronPort-SDR: gn3yI0ba676kKI4IIqVnInNpvey8Tq5RCvUSoY1RKw7Ezn/Egl3fDK2G7j8Ts4U25BkvexZHoX
 FU/Z3lugZInQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 17:38:21 -0700
IronPort-SDR: kCupO7Ez+fFu875Tr5wGjEN8LXzgJTL08uPs9G/JLF8I6fnqLbzyxF9Rronaf6prmRNyBbESNJ
 gf65kJJoSp1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="282678294"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2020 17:38:19 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf parse-events: Use strcmp to compare the PMU name
Date:   Thu, 30 Apr 2020 08:36:18 +0800
Message-Id: <20200430003618.17002-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A big uncore event group is split into multiple small groups which
only include the uncore events from the same PMU. This has been
supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
uncore event aliases in small groups properly").

If the event's PMU name starts to repeat, it must be a new event.
That can be used to distinguish the leader from other members.
But now it only compares the pointer of pmu_name
(leader->pmu_name == evsel->pmu_name).

If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
the event list is:

evsel->name					evsel->pmu_name
---------------------------------------------------------------
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_4 (as leader)
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_2
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_0
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_5
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_3
unc_iio_data_req_of_cpu.mem_write.part0		uncore_iio_1
unc_iio_data_req_of_cpu.mem_write.part1		uncore_iio_4
......

For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
"uncore_iio_4", it should be the event from PMU "uncore_iio_4".
It's not a new leader for this PMU.

But if we use "(leader->pmu_name == evsel->pmu_name)", the check
would be failed and the event is stored to leaders[] as a new
PMU leader.

So this patch uses strcmp to compare the PMU name between events.

Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in small groups properly")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/parse-events.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 10107747b361..786eddb6a097 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1629,12 +1629,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 		 * event. That can be used to distinguish the leader from
 		 * other members, even they have the same event name.
 		 */
-		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
+		if ((leader != evsel) &&
+		    !strcmp(leader->pmu_name, evsel->pmu_name)) {
 			is_leader = false;
 			continue;
 		}
-		/* The name is always alias name */
-		WARN_ON(strcmp(leader->name, evsel->name));
 
 		/* Store the leader event for each PMU */
 		leaders[nr_pmu++] = (uintptr_t) evsel;
-- 
2.17.1

