Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAA9C5321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B2214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDTBG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:06:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:62984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDTBG4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:06:56 -0400
IronPort-SDR: Fo2oSmfMd1e4rdhed80PkPiej7SfEg97Qk5JBTD/oAbGfSr0Oz+3gJM4GL19QCcJ4Y+d7XjcCY
 CEthalPZF+nQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:06:55 -0700
IronPort-SDR: z2SdDtIXcY6onlSh49WG7ZgTDt+OfdmjAn/U5Ni7rxV4Ytie1xjT2qOw/JEghzJOwVF7suIGNc
 HH7i4lq6godw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="364854980"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2020 18:06:53 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 0/7] perf: Stream comparison
Date:   Mon, 20 Apr 2020 09:04:44 +0800
Message-Id: <20200420010451.24405-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, a small change in a hot function reducing the cycles of
this function, but the overall workload doesn't get faster. It is
interesting where the cycles are moved to.

What it would like is to diff before/after streams. A stream we think
is a callchain which is aggregated by the branch records from perf
samples.

By browsing the hot streams, we can understand the hot code path.
By comparing the cycles variation of same streams between old perf
data and new perf data, we can understand if the cycles are moved
to other codes.

The before stream is the stream in perf.data.old. The after stream
is the stream in perf.data.

Diffing before/after streams compares top N hottest streams between
two perf data files.

If all entries of one stream in perf.data.old are fully matched with
all entries of another stream in perf.data, we think two streams
are matched, otherwise the streams are not matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
--------------------------              --------------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

The above streams are matched and we can see for the same streams the
cycles (1) are equal and the callchain hit percents are slightly changed
(26.80% vs. 27.30%). That's expected.

But that's not always true if source code is changed in perf.data
(e.g. div.c:39 is changed). If div.c:39 is changed, they are different
streams, we can't compare them. We will think the stream in perf.data
is a new stream.

The challenge is how to identify the changed source lines. The basic
idea is to use linux command "diff" to compare the source file A and
source file A* line by line (assume file A is used in perf.data.old
and file A* is used in perf.data). According to "diff" output,
we can generate a source line mapping table.

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
(it's mapped to -1). So following two streams are not matched.

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
--------------------------              --------------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

Now let's see examples.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream

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

If we enable the source line comparison option, the output may be different.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
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

Now we can see, following streams pair is moved to another section
"[ Hot chains in old perf data but source line changed (*) in new perf data ]"

            cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39*
                      main div.c:44                           main div.c:44

v3:
---
v2 has 14 patches, it's hard to review.
v3 is only 7 patches for basic stream comparison.

Jin Yao (7):
  perf util: Create source line mapping table
  perf util: Create streams for managing top N hottest callchains
  perf util: Return per-event callchain streams
  perf util: Compare two streams
  perf util: Calculate the sum of all streams hits
  perf util: Report hot streams
  perf diff: Support hot streams comparison

 tools/perf/Documentation/perf-diff.txt |  14 +
 tools/perf/builtin-diff.c              | 170 +++++++-
 tools/perf/util/Build                  |   1 +
 tools/perf/util/callchain.c            | 495 ++++++++++++++++++++++
 tools/perf/util/callchain.h            |  32 ++
 tools/perf/util/srclist.c              | 555 +++++++++++++++++++++++++
 tools/perf/util/srclist.h              |  65 +++
 7 files changed, 1319 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/util/srclist.c
 create mode 100644 tools/perf/util/srclist.h

-- 
2.17.1

