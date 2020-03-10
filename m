Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3233CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8D224673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJHDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:03:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:5965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgCJHDb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:03:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 00:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265524518"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 00:03:27 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 00/14] perf: Stream comparison
Date:   Tue, 10 Mar 2020 15:02:31 +0800
Message-Id: <20200310070245.16314-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, a small change in a hot function reducing the cycles of
this function, but the overall workload doesn't get faster. It is
interesting where the cycles are moved to.

What it would like is to diff before/after streams. A stream we think
is a callchain which is aggregated by the branch records from samples.

By browsing the hot streams, we can understand the hot code flow.
By comparing the cycles variation of same streams between old perf
data and new perf data, we can understand if the cycles are moved to
the unchanged code.

The before stream is the stream before source code changed
(e.g. streams in perf.data.old). The after stream is the stream
after source code changed (e.g. streams in perf.data).

Diffing before/after streams compares all streams (or compares top
N hot streams) between two perf data files.

If all entries of one stream in perf.data.old are fully matched with
all entries of another stream in perf.data, we think these two streams
are matched otherwise the streams are not matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
--------------------------              --------------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

It looks that two streams are matched and we can see for the same
streams the cycles are equal and the callchain hit percents are
slightly changed. That's expected in the normal range.

But that's not always true if source code is changed in perf.data
(e.g. source line div.c:39 is changed). If the source line is changed,
they are different streams, we can't compare them. We will think the
stream in perf.data is a new stream.

The challenge is how to identify the changed source lines. The basic
idea is to use linux command "diff" to compare the source file A and
source file A* line by line (assume A is used in perf.data.old
and A* is updated in perf.data). According to "diff" output, we can
create a source line mapping table.

For example,

  Execute 'diff ./before/div.c ./after/div.c'

  25c25
  <       i = rand() % 2;
  ---
  >       i = rand() % 4;
  39c39
  <       for (i = 0; i < 2000000000; i++) {
  ---
  >       for (i = 0; i < 20000000001; i++) {

  div.c (after -> before) lines mapping:
  0 -> 0
  1 -> 1
  2 -> 2
  3 -> 3
  4 -> 4
  5 -> 5
  6 -> 6
  7 -> 7
  8 -> 8
  9 -> 9
  ...
  24 -> 24
  25 -> -1
  26 -> 26
  27 -> 27
  28 -> 28
  29 -> 29
  30 -> 30
  31 -> 31
  32 -> 32
  33 -> 33
  34 -> 34
  35 -> 35
  36 -> 36
  37 -> 37
  38 -> 38
  39 -> -1
  40 -> 40
  ...

From the table, we can easily know div.c:39 is source line changed.
(mapped to -1). So these two streams are not matched.

Besides the hot streams comparison, this patch series also support
the top N hottest blocks comparison.

It's also useful to figure out the top N hottest blocks from old perf
data file and figure out the top N hottest blocks from new perf data file,
and then compare them for the cycles diff. It can let us easily know
how many cycles are moved from one block to another block.

Now let's see examples.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream --percent-limit 2

[ Matched hot chains between old perf data and new perf data) ]

hot chain pair 1:
            cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40
                      main div.c:40                           main div.c:40
                      main div.c:39                           main div.c:39

hot chain pair 3:
            cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40

hot chain pair 4:
             cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot chains in old perf data but source line changed (*) in new perf data ]

[ Hot chains in old perf data only ]

hot chain 1:
             cycles: 2, hits: 4.08%
         --------------------------
                      main div.c:42
              compute_flag div.c:28

[ Hot chains in new perf data only ]

hot chain 1:
                                                    cycles: 36, hits: 3.36%
                                                 --------------------------
                                                  __random_r random_r.c:357
                                                      __random random.c:293
                                                      __random random.c:293
                                                      __random random.c:291
                                                      __random random.c:291
                                                      __random random.c:291
                                                      __random random.c:288
                                                             rand rand.c:27
                                                             rand rand.c:26
                                                                   rand@plt
                                                                   rand@plt
                                                      compute_flag div.c:25
                                                      compute_flag div.c:22
                                                              main div.c:40
                                                              main div.c:40

Ignore the rightmost columns such as '[Program Block Range]' and 'Shared Object' for saving space

# Output based on old perf data:
#
# Sampled Cycles%  Avg Cycles  New Stream Diff(cycles%,cycles)  New Stream Sampled Cycles%  New Stream Avg Cycles
# ...............  ..........  ...............................  ..........................  .....................
#
           25.20%          18                     -0.36%,   -1                           -                      -
           15.24%           7                     -0.45%,    0                           -                      -
            5.07%           2                      0.09%,    0                           -                      -
            4.84%           2                      0.26%,    0                           -                      -
            4.72%           2                      0.30%,    0                           -                      -
            3.91%           1                      0.29%,    0                           -                      -
            3.05%           1                      0.11%,    0                           -                      -
            2.90%           1                      0.08%,    0                           -                      -
            2.71%           1                     -0.11%,    0                           -                      -
            2.44%           1                      0.09%,    0                           -                      -
            2.35%           1                     -0.09%,    0                           -                      -
            2.27%           1                      0.15%,    0                           -                      -
            2.27%           1                      0.06%,    0                           -                      -
            2.17%           1                      0.09%,    0                           -                      -

If we enable the source line comparison, the output might be different.

perf diff --stream --before ./before --after ./after

[ Matched hot chains between old perf data and new perf data) ]

hot chain pair 1:
            cycles: 18, hits: 6.10%                 cycles: 19, hits: 6.51%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40

hot chain pair 2:
             cycles: 9, hits: 5.95%                  cycles: 8, hits: 5.03%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot chains in old perf data but source line changed (*) in new perf data ]

hot chain pair 1:
            cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39*
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 35, hits: 21.43%                cycles: 33, hits: 19.37%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40
                      main div.c:40                           main div.c:40
                      main div.c:39                           main div.c:39*

[ Hot chains in old perf data only ]

hot chain 1:
             cycles: 2, hits: 4.08%
         --------------------------
                      main div.c:42
              compute_flag div.c:28

[ Hot chains in new perf data only ]

hot chain 1:
                                                    cycles: 36, hits: 3.36%
                                                 --------------------------
                                                  __random_r random_r.c:357
                                                      __random random.c:293
                                                      __random random.c:293
                                                      __random random.c:291
                                                      __random random.c:291
                                                      __random random.c:291
                                                      __random random.c:288
                                                             rand rand.c:27
                                                             rand rand.c:26
                                                                   rand@plt
                                                                   rand@plt
                                                      compute_flag div.c:25
                                                      compute_flag div.c:22
                                                              main div.c:40
                                                              main div.c:40

# Output based on old perf data:
#
# Sampled Cycles%  Avg Cycles  New Stream Diff(cycles%,cycles)  New Stream Sampled Cycles%  New Stream Avg Cycles
# ...............  ..........  ...............................  ..........................  .....................
#
           25.20%          18    [block changed in new stream]                      24.84%                     17
           15.24%           7                     -0.45%,    0                           -                      -
            5.07%           2                      0.09%,    0                           -                      -
            4.84%           2                      0.26%,    0                           -                      -
            4.72%           2                      0.30%,    0                           -                      -
            3.91%           1                      0.29%,    0                           -                      -
            3.05%           1                      0.11%,    0                           -                      -
            2.90%           1                      0.08%,    0                           -                      -
            2.71%           1                     -0.11%,    0                           -                      -
            2.44%           1                      0.09%,    0                           -                      -
            2.35%           1                     -0.09%,    0                           -                      -
            2.27%           1                      0.15%,    0                           -                      -
            2.27%           1                      0.06%,    0                           -                      -
            2.17%           1                      0.09%,    0                           -                      -

Sometime some changes are not reflected in the source code,
e.g. changing the compiler option. So for this, we can't get
the changes by diffing the source code lines.

This patch series also introduces a new perf-diff option "--changed-func".
It passes the names of changed functions then perf-diff can know what
functions are changed.

For example,
perf diff --stream --changed-func main --changed-func rand

NOTE:
-----
1. For the patches:

  perf util: Create source line mapping table
  perf util: Create streams for managing top N hottest callchains
  perf util: Return per-event callchain streams
  perf util: Compare two streams
  perf util: Calculate the sum of all streams hits
  perf util: Report hot streams
  perf diff: Support hot streams comparison

  These patches support the hot stream comparison.

2. For the patches:
  perf util: Add new block info functions for top N hot blocks comparison
  perf util: Add new block info fmts for showing hot blocks comparison
  perf util: Enable block source line comparison
  perf diff: support hot blocks comparison

  These patches support the hot blocks comparison.

3. For the patches
  perf util: Filter out streams by name of changed functions
  perf util: Filter out blocks by name of changed functions
  perf diff: Filter out streams by changed functions

  These patches support a user specified function name list which let
  perf-diff know these functions are changed.

Jin Yao (14):
  perf util: Create source line mapping table
  perf util: Create streams for managing top N hottest callchains
  perf util: Return per-event callchain streams
  perf util: Compare two streams
  perf util: Calculate the sum of all streams hits
  perf util: Report hot streams
  perf diff: Support hot streams comparison
  perf util: Add new block info functions for top N hot blocks
    comparison
  perf util: Add new block info fmts for showing hot blocks comparison
  perf util: Enable block source line comparison
  perf diff: support hot blocks comparison
  perf util: Filter out streams by name of changed functions
  perf util: Filter out blocks by name of changed functions
  perf diff: Filter out streams by changed functions

 tools/perf/Documentation/perf-diff.txt |  19 +
 tools/perf/builtin-diff.c              | 324 ++++++++++++---
 tools/perf/util/Build                  |   1 +
 tools/perf/util/block-info.c           | 450 +++++++++++++++++++-
 tools/perf/util/block-info.h           |  38 +-
 tools/perf/util/callchain.c            | 521 +++++++++++++++++++++++
 tools/perf/util/callchain.h            |  34 ++
 tools/perf/util/srclist.c              | 552 +++++++++++++++++++++++++
 tools/perf/util/srclist.h              |  74 ++++
 9 files changed, 1953 insertions(+), 60 deletions(-)
 create mode 100644 tools/perf/util/srclist.c
 create mode 100644 tools/perf/util/srclist.h

-- 
2.17.1

