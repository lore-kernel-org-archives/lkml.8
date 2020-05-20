Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C88C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D10C20878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgETE3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:29:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:54957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETE3s (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:48 -0400
IronPort-SDR: Prz/lxNdEucVyQj3Uo+01P7k6WfZomr9Y2BQ5eKkfKUGIhyX5xlep1eaqR8N7pUy10eah3KsKb
 TeEct0GBL8gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:29:48 -0700
IronPort-SDR: bRyM4weib+sGrN7RrN9M9MMUKLIAFDgdiiZ/7gd1bxfLCvu1PFrSbNHaDad3XtxMOMwTrOxf7h
 yXF+Slkx5gBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217298"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:29:44 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 2/5] perf counts: Reset prev_raw_counts counts
Date:   Wed, 20 May 2020 12:27:34 +0800
Message-Id: <20200520042737.24160-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520042737.24160-1-yao.jin@linux.intel.com>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
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

