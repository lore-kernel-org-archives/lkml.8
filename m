Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DBF20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgETE3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:29:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:54957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETE3m (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:42 -0400
IronPort-SDR: 8clVySg12lH1KDgQrXuxuhvRRpmVoxGdqh8nCVH+z55NAVPxt5WzoHIWnwKxO/Te+OK6XRULYn
 99XoBb1ENwSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:29:41 -0700
IronPort-SDR: W+kMUcQes0TR/lgkk254tlp1t6f53rsjy2YvoMBGNm4jVX33Q6pJZl0n1tG/n7ozex6tA7uO1m
 oqD7urS0UYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217283"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:29:38 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 0/5] perf stat: Support overall statistics for interval mode
Date:   Wed, 20 May 2020 12:27:32 +0800
Message-Id: <20200520042737.24160-1-yao.jin@linux.intel.com>
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

 v6:
 ---
 1. Add comments in perf_evlist__save_aggr_prev_raw_counts.
 2. Move init_stats(&walltime_nsecs_stats) under interval condition check.

 Following patches are changed in v6.
    perf stat: Save aggr value to first member of prev_raw_counts
    perf stat: Report summary for interval mode

 v5:
 ---
 1. Create new patch "perf stat: Save aggr value to first member
    of prev_raw_counts".

 2. Call perf_evlist__save_aggr_prev_raw_counts to save aggr value
    to first member of prev_raw_counts for AGGR_GLOBAL. Then next,
    perf_stat_process_counter can create aggr values from per cpu
    values.

 Following patches are impacted in v5:
    perf stat: Copy counts from prev_raw_counts to evsel->counts
    perf stat: Save aggr value to first member of prev_raw_counts
    perf stat: Report summary for interval mode

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

Jin Yao (5):
  perf stat: Fix wrong per-thread runtime stat for interval mode
  perf counts: Reset prev_raw_counts counts
  perf stat: Copy counts from prev_raw_counts to evsel->counts
  perf stat: Save aggr value to first member of prev_raw_counts
  perf stat: Report summary for interval mode

 tools/perf/builtin-stat.c | 101 +++++++++++++++++++++++++-------------
 tools/perf/util/counts.c  |   4 +-
 tools/perf/util/counts.h  |   1 +
 tools/perf/util/stat.c    |  53 +++++++++++++++++---
 tools/perf/util/stat.h    |   3 ++
 5 files changed, 122 insertions(+), 40 deletions(-)

-- 
2.17.1

