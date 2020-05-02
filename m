Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21288C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071EE2192A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEBCJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 22:09:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:30459 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgEBCJG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 22:09:06 -0400
IronPort-SDR: iWA0gV7byvhxcGy5dLKYR75VMSGcWEqowpsvDKYuFMQJ6AzxG67dBKg+lmAEsr8PHoQqfKAqbm
 375+iWY/EnyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 19:09:06 -0700
IronPort-SDR: 9n1qSW/HNJQaVZ2rcb7orTUdxlGC60AlmEb1GDtTt65EqczMA+kEvdeY/jfXrdDbuS768jfptL
 NBVVDvWnwabQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="283348212"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 19:09:03 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/2] perf evsel: Create counts for collecting summary data
Date:   Sat,  2 May 2020 10:07:04 +0800
Message-Id: <20200502020705.19295-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200502020705.19295-1-yao.jin@linux.intel.com>
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to support the overall statistics for perf-stat
interval mode. For example, report the summary at the end of
"perf-stat -I" output.

But since perf-stat can support many aggregation modes, such as
--per-thread, --per-socket, -M and etc, we need a solution which
doesn't bring much complexity.

The idea is to create new 'evsel->summary_counts' which sums up the
counts delta per interval. Before reporting the summary, we copy the
data from evsel->summary_counts to evsel->counts, and next we just
follow current code.

 v2:
 ---
 Rebase to perf/core branch

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c | 10 ++++++++--
 tools/perf/util/evsel.h |  1 +
 tools/perf/util/stat.c  | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a75bcb95bf23..abc503dd6eda 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1280,22 +1280,28 @@ void evsel__delete(struct evsel *evsel)
 void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 			   struct perf_counts_values *count)
 {
-	struct perf_counts_values tmp;
+	struct perf_counts_values tmp, *summary;
 
-	if (!evsel->prev_raw_counts)
+	if (!evsel->prev_raw_counts || !evsel->summary_counts)
 		return;
 
 	if (cpu == -1) {
 		tmp = evsel->prev_raw_counts->aggr;
 		evsel->prev_raw_counts->aggr = *count;
+		summary = &evsel->summary_counts->aggr;
 	} else {
 		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
 		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
+		summary = perf_counts(evsel->summary_counts, cpu, thread);
 	}
 
 	count->val = count->val - tmp.val;
 	count->ena = count->ena - tmp.ena;
 	count->run = count->run - tmp.run;
+
+	summary->val += count->val;
+	summary->ena += count->ena;
+	summary->run += count->run;
 }
 
 void perf_counts_values__scale(struct perf_counts_values *count,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 783246bf8d0d..430639c99d04 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -46,6 +46,7 @@ struct evsel {
 	char			*filter;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
+	struct perf_counts	*summary_counts;
 	int			idx;
 	unsigned long		max_events;
 	unsigned long		nr_events_printed;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 774468341851..c3fd008b4e84 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -171,6 +171,24 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
        }
 }
 
+static int perf_evsel__alloc_summary_counts(struct evsel *evsel,
+					    int ncpus, int nthreads)
+{
+	struct perf_counts *counts;
+
+	counts = perf_counts__new(ncpus, nthreads);
+	if (counts)
+		evsel->summary_counts = counts;
+
+	return counts ? 0 : -ENOMEM;
+}
+
+static void perf_evsel__free_summary_counts(struct evsel *evsel)
+{
+	perf_counts__delete(evsel->summary_counts);
+	evsel->summary_counts = NULL;
+}
+
 static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
 	int ncpus = evsel__nr_cpus(evsel);
@@ -178,6 +196,7 @@ static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 
 	if (perf_evsel__alloc_stat_priv(evsel) < 0 ||
 	    perf_evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
+	    perf_evsel__alloc_summary_counts(evsel, ncpus, nthreads) < 0 ||
 	    (alloc_raw && perf_evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
 		return -ENOMEM;
 
@@ -208,6 +227,7 @@ void perf_evlist__free_stats(struct evlist *evlist)
 		perf_evsel__free_stat_priv(evsel);
 		perf_evsel__free_counts(evsel);
 		perf_evsel__free_prev_raw_counts(evsel);
+		perf_evsel__free_summary_counts(evsel);
 	}
 }
 
-- 
2.17.1

