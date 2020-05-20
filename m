Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E650720873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgETE3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:29:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:54957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETE3u (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:50 -0400
IronPort-SDR: WEjVP/+16NpNdKlWnp0zsTZ0TMsCP2B2xjF9bI0gHQmkwAG87+92PbqNyYKhCCXCwtol7LLlTW
 bSqJsfUFG7aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:29:50 -0700
IronPort-SDR: LPHUu01Cv8g70OpbqZwdWgE3P9uBJXeex05vJobTk3A4fobkzfNR0gknf55xcBO6wuuqUH9YWx
 fnFOhEWJJLpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217306"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:29:48 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 3/5] perf stat: Copy counts from prev_raw_counts to evsel->counts
Date:   Wed, 20 May 2020 12:27:35 +0800
Message-Id: <20200520042737.24160-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520042737.24160-1-yao.jin@linux.intel.com>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
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

 v5:
 ---
 Don't save the previous aggr value to the member of [cpu0,thread0]
 in perf_counts. Originally that was a trick because the
 perf_stat_process_counter would create aggr values from per cpu
 values. But we don't need to do that all the time. We will
 handle it in next patch.

 v4:
 ---
 Change the commit message.
 No functional change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat.c | 24 ++++++++++++++++++++++++
 tools/perf/util/stat.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index e397815f0dfb..aadc723ce871 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -225,6 +225,30 @@ void perf_evlist__reset_prev_raw_counts(struct evlist *evlist)
 		evsel__reset_prev_raw_counts(evsel);
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

