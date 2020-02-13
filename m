Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E76EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333652073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgBMHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:16:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:27920 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbgBMHQV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:16:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 23:16:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,435,1574150400"; 
   d="scan'208";a="257080480"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2020 23:16:18 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3] perf stat: Show percore counts in per CPU output
Date:   Thu, 13 Feb 2020 15:15:55 +0800
Message-Id: <20200213071555.17239-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have supported the event modifier "percore" which sums up the
event counts for all hardware threads in a core and show the counts
per core.

For example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A -- sleep 1

  Performance counter stats for 'system wide':

 S0-D0-C0                395,072      cpu/event=cpu-cycles,percore/
 S0-D0-C1                851,248      cpu/event=cpu-cycles,percore/
 S0-D0-C2                954,226      cpu/event=cpu-cycles,percore/
 S0-D0-C3              1,233,659      cpu/event=cpu-cycles,percore/

This patch provides a new option "--percore-show-thread". It is
used with event modifier "percore" together to sum up the event counts
for all hardware threads in a core but show the counts per hardware
thread.

This is essentially a replacement for the any bit (which is gone in
Icelake). Per core counts are useful for some formulas, e.g. CoreIPC.
The original percore version was inconvenient to post process. This
variant matches the output of the any bit.

With this patch, for example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1

  Performance counter stats for 'system wide':

 CPU0               2,453,061      cpu/event=cpu-cycles,percore/
 CPU1               1,823,921      cpu/event=cpu-cycles,percore/
 CPU2               1,383,166      cpu/event=cpu-cycles,percore/
 CPU3               1,102,652      cpu/event=cpu-cycles,percore/
 CPU4               2,453,061      cpu/event=cpu-cycles,percore/
 CPU5               1,823,921      cpu/event=cpu-cycles,percore/
 CPU6               1,383,166      cpu/event=cpu-cycles,percore/
 CPU7               1,102,652      cpu/event=cpu-cycles,percore/

We can see counts are duplicated in CPU pairs
(CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).

The interval mode also works. For example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -I 1000
 #           time CPU                    counts unit events
      1.000425421 CPU0                 925,032      cpu/event=cpu-cycles,percore/
      1.000425421 CPU1                 430,202      cpu/event=cpu-cycles,percore/
      1.000425421 CPU2                 436,843      cpu/event=cpu-cycles,percore/
      1.000425421 CPU3               1,192,504      cpu/event=cpu-cycles,percore/
      1.000425421 CPU4                 925,032      cpu/event=cpu-cycles,percore/
      1.000425421 CPU5                 430,202      cpu/event=cpu-cycles,percore/
      1.000425421 CPU6                 436,843      cpu/event=cpu-cycles,percore/
      1.000425421 CPU7               1,192,504      cpu/event=cpu-cycles,percore/

 v3:
 ---
 1. Fix the interval mode output error
 2. Use cpu value (not cpu index) in config->aggr_get_id().
 3. Refine the code according to Jiri's comments.

 v2:
 ---
 Add the explanation in change log. This is essentially a replacement
 for the any bit. No code change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt |  9 +++++++
 tools/perf/builtin-stat.c              |  4 +++
 tools/perf/util/stat-display.c         | 35 ++++++++++++++++++++++----
 tools/perf/util/stat.h                 |  1 +
 4 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9431b8066fb4..86d1fd92f017 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -334,6 +334,15 @@ Configure all used events to run in kernel space.
 --all-user::
 Configure all used events to run in user space.
 
+--percore-show-thread::
+The event modifier "percore" has supported to sum up the event counts
+for all hardware threads in a core and show the counts per core.
+
+This option with event modifier "percore" enabled also sums up the event
+counts for all hardware threads in a core but show the sum counts per
+hardware thread. This is essentially a replacement for the any bit and
+convenient for posting process.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a098c2ebf4ea..ec053dc1e35c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -929,6 +929,10 @@ static struct option stat_options[] = {
 	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
 			 "Configure all used events to run in user space.",
 			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
+		    "Use with 'percore' event qualifier to show the event "
+		    "counts of one hardware thread by sum up total hardware "
+		    "threads of same physical core"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bc31fccc0057..7eb3643a97ae 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -110,7 +110,7 @@ static void aggr_printout(struct perf_stat_config *config,
 			config->csv_sep);
 			break;
 	case AGGR_NONE:
-		if (evsel->percore) {
+		if (evsel->percore && !config->percore_show_thread) {
 			fprintf(config->output, "S%d-D%d-C%*d%s",
 				cpu_map__id_to_socket(id),
 				cpu_map__id_to_die(id),
@@ -628,7 +628,7 @@ static void aggr_cb(struct perf_stat_config *config,
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
-				   bool *first)
+				   bool *first, int cpu)
 {
 	struct aggr_data ad;
 	FILE *output = config->output;
@@ -654,7 +654,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	printout(config, id, nr, counter, uval, prefix,
+	printout(config, cpu != -1 ? cpu : id, nr, counter, uval, prefix,
 		 run, ena, 1.0, &rt_stat);
 	if (!metric_only)
 		fputc('\n', output);
@@ -687,7 +687,7 @@ static void print_aggr(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
 					       prefix, metric_only,
-					       &first);
+					       &first, -1);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -1146,6 +1146,28 @@ static void print_footer(struct perf_stat_config *config)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
+static void print_percore_thread(struct perf_stat_config *config,
+				 struct evsel *counter, char *prefix)
+{
+	int cpu, s, s2, id;
+	bool first = true;
+
+	for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
+		cpu = perf_cpu_map__cpu(evsel__cpus(counter), i);
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+
+		for (s = 0; s < config->aggr_map->nr; s++) {
+			id = config->aggr_map->map[s];
+			if (s2 == id)
+				break;
+		}
+
+		print_counter_aggrdata(config, counter, s,
+				       prefix, false,
+				       &first, cpu);
+	}
+}
+
 static void print_percore(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
@@ -1157,13 +1179,16 @@ static void print_percore(struct perf_stat_config *config,
 	if (!(config->aggr_map || config->aggr_get_id))
 		return;
 
+	if (config->percore_show_thread)
+		return print_percore_thread(config, counter, prefix);
+
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only,
-				       &first);
+				       &first, -1);
 	}
 
 	if (metric_only)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fb990efa54a8..b4fdfaa7f2c0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -109,6 +109,7 @@ struct perf_stat_config {
 	bool			 walltime_run_table;
 	bool			 all_kernel;
 	bool			 all_user;
+	bool			 percore_show_thread;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

