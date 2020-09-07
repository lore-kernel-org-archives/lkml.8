Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48931C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC23214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgIGEQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:16:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:58703 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgIGEQn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:16:43 -0400
IronPort-SDR: vprzxsMGtkzqdZXqSDoLzRibNzJrbMFc/oAGEbqIZXBEGnrbKTiWLgBkqK1jencUYeIayFn51+
 2TGqWqknG5Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157215542"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157215542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 21:16:43 -0700
IronPort-SDR: 9r/VohMXlKyC6id03redCzvjQ3nRcVdaNC/e/rpClweElny6hsyLGZ+W4+7ci7vu5R/vcuLIfl
 /JF4ztFroEJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="406709911"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2020 21:16:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 0/7] perf: Stream comparison
Date:   Mon,  7 Sep 2020 12:15:59 +0800
Message-Id: <20200907041606.14500-1-yao.jin@linux.intel.com>
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

 v5:
 ---
 1. Remove enum stream_type
 2. Rebase to perf/core

 v4:
 ---
 The previous version is too big and very hard for review.

 1. v4 removes the code which supports the source line mapping
    table and remove the source line based comparison. Now we
    only supports the basic functionality of stream comparison.

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
 tools/perf/util/callchain.c            |  99 ++++++++
 tools/perf/util/callchain.h            |   8 +
 tools/perf/util/stream.c               | 324 +++++++++++++++++++++++++
 tools/perf/util/stream.h               |  34 +++
 7 files changed, 590 insertions(+), 13 deletions(-)
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h

-- 
2.17.1

