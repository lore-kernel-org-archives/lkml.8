Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFFC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B620A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgEGHAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:00:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:18356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGHAd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:00:33 -0400
IronPort-SDR: eMBpNqGwBw7xxkqJ6Xo+o1nXsS8FUjL57ymwSmMrJijOiq6BmtAmSILUSUC8z/97Lnz9d02IBJ
 QHCu67xKueOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 00:00:33 -0700
IronPort-SDR: Jnby8VGG1gs8G1OnlPkCyxVNUe84yxX0zzSEvENBp3TJFi3jfE5C2z/ycH6HP4gwf76w1AzF3p
 /LAd9sLllsWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="370026124"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 00:00:31 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/4] perf stat: Copy counts from prev_raw_counts to evsel->counts
Date:   Thu,  7 May 2020 14:58:21 +0800
Message-Id: <20200507065822.8255-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507065822.8255-1-yao.jin@linux.intel.com>
References: <20200507065822.8255-1-yao.jin@linux.intel.com>
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

The idea is to use 'evsel->prev_raw_counts' which is updated in
each interval and it's saved with the latest counts. Before reporting
the summary, we copy the counts from evsel->prev_raw_counts to
evsel->counts, and next we just follow non-interval processing.

In evsel__compute_deltas, this patch saves counts to the position
of [cpu0,thread0] for AGGR_GLOBAL. After copying counts from
evsel->prev_raw_counts to evsel->counts, we don't need to
modify process_counter_maps in perf_stat_process_counter to let it
work well.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c |  1 +
 tools/perf/util/stat.c  | 24 ++++++++++++++++++++++++
 tools/perf/util/stat.h  |  1 +
 3 files changed, 26 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f3e60c45d59a..898a697c7cdd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1288,6 +1288,7 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 	if (cpu == -1) {
 		tmp = evsel->prev_raw_counts->aggr;
 		evsel->prev_raw_counts->aggr = *count;
+		*perf_counts(evsel->prev_raw_counts, 0, 0) = *count;
 	} else {
 		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
 		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 89e541564ed5..ede113805ecd 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -230,6 +230,30 @@ void perf_evlist__reset_prev_raw_counts(struct evlist *evlist)
 		perf_evsel__reset_prev_raw_counts(evsel);
 }
 
+static void perf_evsel__copy_prev_raw_counts(struct evsel *evsel)
+{
+	int ncpus = evsel__nr_cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
+
+	for (int thread = 0; thread < nthreads; thread++) {
+		for (int cpu = 0; cpu < ncpus; cpu++) {
+			*perf_counts(evsel->counts, cpu, thread) =
+				*perf_counts(evsel->prev_raw_counts, cpu,
+					     thread);
+		}
+	}
+
+	evsel->counts->aggr = evsel->prev_raw_counts->aggr;
+}
+
+void perf_evlist__copy_prev_raw_counts(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		perf_evsel__copy_prev_raw_counts(evsel);
+}
+
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..62cf72c71869 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -198,6 +198,7 @@ int perf_evlist__alloc_stats(struct evlist *evlist, bool alloc_raw);
 void perf_evlist__free_stats(struct evlist *evlist);
 void perf_evlist__reset_stats(struct evlist *evlist);
 void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
+void perf_evlist__copy_prev_raw_counts(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.17.1

