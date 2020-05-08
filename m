Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE84C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53780206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHIAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:00:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:29311 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHIAU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:00:20 -0400
IronPort-SDR: J5dDvhkQrLcR2mbXcoq8VR5harylMKgaTfYPFTzEBk8hHBVAWq6oWtl5uyZu0jpOzAGlQQCtzT
 C0cnfaVb2HfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 01:00:19 -0700
IronPort-SDR: OAyBWq89jgKfvN/wyB3/GF3ydnMqhn1SvlN7O1DFv0Gqc7aFzChEgldv6KxKuGYNs3DT9pNa4H
 lXILOP1vR/uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370372861"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 01:00:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/4] perf stat: Support overall statistics for interval mode
Date:   Fri,  8 May 2020 15:58:13 +0800
Message-Id: <20200508075817.10588-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf-stat supports to print counts at regular interval (-I),
but it's not very easy for user to get the overall statistics.

With this patchset, it supports to report the summary at the end of
interval output.

For example,

 root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
 #           time             counts unit events
      1.000412064          2,281,114      cycles
      2.001383658          2,547,880      cycles

  Performance counter stats for 'system wide':

          4,828,994      cycles

        2.002860349 seconds time elapsed

 root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
 #           time             counts unit events
      1.000389902          1,536,093      cycles
      1.000389902            420,226      instructions              #    0.27  insn per cycle
      2.001433453          2,213,952      cycles
      2.001433453            735,465      instructions              #    0.33  insn per cycle

  Performance counter stats for 'system wide':

          3,750,045      cycles
          1,155,691      instructions              #    0.31  insn per cycle

        2.003023361 seconds time elapsed

 root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
 #           time             counts unit events
      1.000435121            905,303      inst_retired.any          #      2.9 CPI
      1.000435121          2,663,333      cycles
      1.000435121            914,702      inst_retired.any          #      0.3 IPC
      1.000435121          2,676,559      cpu_clk_unhalted.thread
      2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
      2.001615941          3,551,357      cycles
      2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
      2.001615941          3,551,044      cpu_clk_unhalted.thread

  Performance counter stats for 'system wide':

          2,856,395      inst_retired.any          #      2.2 CPI
          6,214,690      cycles
          2,865,539      inst_retired.any          #      0.5 IPC
          6,227,603      cpu_clk_unhalted.thread

        2.003403078 seconds time elapsed

 v4:
 ---
 1. Create runtime_stat_reset.

 2. Zero the aggr in perf_counts__reset and use it to reset
    prev_raw_counts.

 3. Move affinity setup and read_counter_cpu to a new function
    read_affinity_counters. It's only called when stat_config.summary
    is not set.

 v3:
 ---
 1. 'perf stat: Fix wrong per-thread runtime stat for interval mode'
    is a new patch which fixes an existing issue found in test.

 2. We use the prev_raw_counts for summary counts. Drop the summary_counts in v2.

 3. Fix some issues.

 v2:
 ---
 Rebase to perf/core branch

Jin Yao (4):
  perf stat: Fix wrong per-thread runtime stat for interval mode
  perf counts: Reset prev_raw_counts counts
  perf stat: Copy counts from prev_raw_counts to evsel->counts
  perf stat: Report summary for interval mode

 tools/perf/builtin-stat.c | 97 ++++++++++++++++++++++++++-------------
 tools/perf/util/counts.c  |  4 +-
 tools/perf/util/counts.h  |  1 +
 tools/perf/util/evsel.c   |  1 +
 tools/perf/util/stat.c    | 33 ++++++++++---
 tools/perf/util/stat.h    |  2 +
 6 files changed, 99 insertions(+), 39 deletions(-)

-- 
2.17.1

