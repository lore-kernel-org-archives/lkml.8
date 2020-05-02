Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FADDC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B29C24957
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 02:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEBCJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 22:09:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:30459 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgEBCJI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 22:09:08 -0400
IronPort-SDR: /gh/cnUJcoXMcGIOiyT2rYjzpJh0mPNbIbKC9f74DPqEBj2tyLubYRYq+Z+4RQYFYEMwn1muPr
 4OjE6BsYcqNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 19:09:08 -0700
IronPort-SDR: 2sOHvxdHBKuNRTAGg2idbBC8+X/4D9m7bh7GMRRI4AFJ635Vn9pmyoRohptDWVDA+o80bpeA5K
 a3W6LgAYlc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="283348217"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 19:09:06 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf stat: Report summary for interval mode
Date:   Sat,  2 May 2020 10:07:05 +0800
Message-Id: <20200502020705.19295-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200502020705.19295-1-yao.jin@linux.intel.com>
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf-stat supports to print counts at regular interval (-I),
but it's not very easy for user to get the overall statistics.

The patch uses 'evsel->summary_counts' to sum up the per interval counts
and copy the counts to 'evsel->counts' after printing the interval results.
Next, we just follow the non-interval processing.

Let's see some examples,

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

 v2:
 ---
 Rebase to perf/core branch

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c | 14 ++++++++--
 tools/perf/util/stat.c    | 57 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  5 ++++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 92a59f08db71..8f3441f794d5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -355,6 +355,7 @@ static void read_counters(struct timespec *rs)
 static void process_interval(void)
 {
 	struct timespec ts, rs;
+	struct stats walltime_nsecs_stats_bak;
 
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
@@ -367,9 +368,11 @@ static void process_interval(void)
 			pr_err("failed to write stat round event\n");
 	}
 
+	walltime_nsecs_stats_bak = walltime_nsecs_stats;
 	init_stats(&walltime_nsecs_stats);
 	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
 	print_counters(&rs, 0, NULL);
+	walltime_nsecs_stats = walltime_nsecs_stats_bak;
 }
 
 static void enable_counters(void)
@@ -732,7 +735,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * avoid arbitrary skew, we must read all counters before closing any
 	 * group leaders.
 	 */
-	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
+	if (!interval)
+		read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
+	else {
+		stat_config.interval = 0;
+		stat_config.summary = true;
+		perf_evlist__copy_summary_counts(evsel_list);
+		perf_evlist__process_summary_counts(&stat_config, evsel_list);
+	}
 
 	/*
 	 * We need to keep evsel_list alive, because it's processed
@@ -2149,7 +2159,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (!forever && status != -1 && !interval)
+	if (!forever && status != -1 && (!interval || stat_config.summary))
 		print_counters(NULL, argc, argv);
 
 	if (STAT_RECORD) {
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c3fd008b4e84..fdd1930c219c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -249,6 +249,63 @@ void perf_evlist__reset_prev_raw_counts(struct evlist *evlist)
 		perf_evsel__reset_prev_raw_counts(evsel);
 }
 
+static void perf_evsel__copy_summary_counts(struct evsel *evsel)
+{
+	int ncpus = evsel__nr_cpus(evsel);
+	int nthreads = perf_thread_map__nr(evsel->core.threads);
+
+	for (int thread = 0; thread < nthreads; thread++) {
+		for (int cpu = 0; cpu < ncpus; cpu++) {
+			*perf_counts(evsel->counts, cpu, thread) =
+				*perf_counts(evsel->summary_counts, cpu, thread);
+		}
+	}
+
+	evsel->prev_raw_counts->aggr = evsel->summary_counts->aggr;
+}
+
+void perf_evlist__copy_summary_counts(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel)
+		perf_evsel__copy_summary_counts(evsel);
+}
+
+static void perf_stat_process_summary_counts(struct perf_stat_config *config,
+					     struct evsel *evsel)
+{
+	struct perf_counts_values *summary = &evsel->summary_counts->aggr;
+	struct perf_stat_evsel *ps = evsel->stats;
+	u64 *count = evsel->summary_counts->aggr.values;
+	int i;
+
+	if (!config->summary || config->aggr_mode != AGGR_GLOBAL)
+		return;
+
+	for (i = 0; i < 3; i++)
+		init_stats(&ps->res_stats[i]);
+
+	perf_counts_values__scale(summary, config->scale,
+				  &evsel->summary_counts->scaled);
+
+	for (i = 0; i < 3; i++)
+		update_stats(&ps->res_stats[i], count[i]);
+
+	perf_stat__update_shadow_stats(evsel, *count, 0, &rt_stat);
+}
+
+void perf_evlist__process_summary_counts(struct perf_stat_config *config,
+					 struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	perf_stat__reset_shadow_per_stat(&rt_stat);
+
+	evlist__for_each_entry(evlist, evsel)
+		perf_stat_process_summary_counts(config, evsel);
+}
+
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b4fdfaa7f2c0..bad7d7678148 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -110,6 +110,7 @@ struct perf_stat_config {
 	bool			 all_kernel;
 	bool			 all_user;
 	bool			 percore_show_thread;
+	bool			 summary;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -199,6 +200,10 @@ void perf_evlist__free_stats(struct evlist *evlist);
 void perf_evlist__reset_stats(struct evlist *evlist);
 void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
 
+void perf_evlist__copy_summary_counts(struct evlist *evlist);
+void perf_evlist__process_summary_counts(struct perf_stat_config *config,
+					 struct evlist *evlist);
+
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
 struct perf_tool;
-- 
2.17.1

