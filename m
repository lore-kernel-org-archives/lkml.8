Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA43208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEZGL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:11:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:16985 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgEZGL0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:11:26 -0400
IronPort-SDR: aZsdxTGTJrWmyYYcZSpi6a5uefnPhSbiIU/Ki9Bq9Q2e6wQeLN9g0PU/0InK+C9bXs4agmgYmg
 c5gaflRnSQsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 23:11:25 -0700
IronPort-SDR: +zmhc9xuCLCqBLBT3xguOAlET9BGwCBxKJR37kJq/FxDldUMyoEV2EtGTwysjrYvhHw/fOhuTl
 yVI2ON6VqPEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="291068638"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2020 23:11:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/7] perf: Stream comparison
Date:   Tue, 26 May 2020 14:09:13 +0800
Message-Id: <20200526060920.26490-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, a small change in a hot function reducing the cycles of
this function, but the overall workload doesn't get faster. It is
interesting where the cycles are moved to.

What it would like is to diff before/after streams. The stream is the
branch history which is aggregated by the branch records from perf
samples. For example, the callchains aggregated from the branch records.
By browsing the hot stream, we can understand the hot code path.

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

Now let's see examples.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream

[ Matched hot streams ]

hot chain pair 1:
            cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
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
             cycles: 9, hits: 4.48%                  cycles: 6, hits: 4.51%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot streams in old perf data only ]

hot chain 1:
            cycles: 18, hits: 6.75%
         --------------------------
          __random_r random_r.c:360
          __random_r random_r.c:388
          __random_r random_r.c:388
          __random_r random_r.c:380
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

hot chain 2:
            cycles: 29, hits: 2.78%
         --------------------------
              compute_flag div.c:22
                      main div.c:40
                      main div.c:40
                      main div.c:39

[ Hot streams in new perf data only ]

hot chain 1:
                                                     cycles: 4, hits: 4.54%
                                                 --------------------------
                                                              main div.c:42
                                                      compute_flag div.c:28

hot chain 2:
                                                     cycles: 5, hits: 3.51%
                                                 --------------------------
                                                              main div.c:39
                                                              main div.c:44
                                                              main div.c:42
                                                      compute_flag div.c:28

 v4:
 ---
 The previous version is too huge and it's hard for reviewing.

 1. V4 removes the code which supports the source line mapping
    table. Now we only supports the basic functionality for 
    stream comparison.

 2. Refactor the code in a generic way.
 
 v3:
 ---
 v2 has 14 patches, it's hard to review.
 v3 is only 7 patches for basic stream comparison.

Jin Yao (7):
  perf util: Create streams
  perf util: Get the evsel_streams by evsel_idx
  perf util: Compare two streams
  perf util: Link stream pair
  perf util: Calculate the sum of total streams hits
  perf util: Report hot streams
  perf diff: Support hot streams comparison

 tools/perf/Documentation/perf-diff.txt |   4 +
 tools/perf/builtin-diff.c              | 133 +++++++++-
 tools/perf/util/Build                  |   1 +
 tools/perf/util/callchain.c            |  99 +++++++
 tools/perf/util/callchain.h            |   9 +
 tools/perf/util/stream.c               | 343 +++++++++++++++++++++++++
 tools/perf/util/stream.h               |  42 +++
 7 files changed, 618 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h

-- 
2.17.1

