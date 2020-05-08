Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164E420A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHIA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:00:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:29311 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHIAZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:00:25 -0400
IronPort-SDR: 054KfCTVGeWqXB9CTtACAgWPhPjXWc4AdWnycVHO+YMPQJGjmwpXcwuEd13opKSAoA6s+UthI0
 v3RVcWJ01Dug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 01:00:25 -0700
IronPort-SDR: lmlGMWcWgsgBKmf7n/9Aq0VC6spt3fD7aylNqV8hMerjD562aUSpg83lgan+gMKruohm3diw9l
 9V1VJ7aE59CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="370372885"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2020 01:00:22 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/4] perf counts: Reset prev_raw_counts counts
Date:   Fri,  8 May 2020 15:58:15 +0800
Message-Id: <20200508075817.10588-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508075817.10588-1-yao.jin@linux.intel.com>
References: <20200508075817.10588-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to reset the evsel->prev_raw_counts, zeroing the aggr
is not enough, we need to reset the perf_counts too.

The perf_counts__reset zeros the perf_counts, and it should zero
the aggr too. This patch changes perf_counts__reset to non-static,
and calls it in evsel__reset_prev_raw_counts to reset the
prev_raw_counts.

 v4:
 ---
 Zeroing the aggr in perf_counts__reset and use it to reset
 prev_raw_counts.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/counts.c | 4 +++-
 tools/perf/util/counts.h | 1 +
 tools/perf/util/stat.c   | 7 ++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 615c9f3e95cb..582f3aeaf5e4 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 #include "evsel.h"
 #include "counts.h"
 #include <linux/zalloc.h>
@@ -42,10 +43,11 @@ void perf_counts__delete(struct perf_counts *counts)
 	}
 }
 
-static void perf_counts__reset(struct perf_counts *counts)
+void perf_counts__reset(struct perf_counts *counts)
 {
 	xyarray__reset(counts->loaded);
 	xyarray__reset(counts->values);
+	memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
 }
 
 void evsel__reset_counts(struct evsel *evsel)
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 8f556c6d98fa..7ff36bf6d644 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -37,6 +37,7 @@ perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool lo
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
 void perf_counts__delete(struct perf_counts *counts);
+void perf_counts__reset(struct perf_counts *counts);
 
 void evsel__reset_counts(struct evsel *evsel);
 int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index f4a44df9b221..e397815f0dfb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -163,11 +163,8 @@ static void evsel__free_prev_raw_counts(struct evsel *evsel)
 
 static void evsel__reset_prev_raw_counts(struct evsel *evsel)
 {
-	if (evsel->prev_raw_counts) {
-		evsel->prev_raw_counts->aggr.val = 0;
-		evsel->prev_raw_counts->aggr.ena = 0;
-		evsel->prev_raw_counts->aggr.run = 0;
-       }
+	if (evsel->prev_raw_counts)
+		perf_counts__reset(evsel->prev_raw_counts);
 }
 
 static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
-- 
2.17.1

