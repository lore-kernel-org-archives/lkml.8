Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B923124695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583838970;
	bh=ouE7GIvcya1CXOFCUQCkdXTYHS0XJZ+NyEy2zndiOlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oViGpKZGJj0K9QrYpA6nzXBS2dD4TVVgREVT/HwQgC2TUGhO1jIitD6f84Uctle5i
	 gVZs3oJwdE606K42aLyVBHV/K6EuMUerLztPqCUy06akn2ENVIWo2Fd/DkVJQcnIKm
	 O2JgLoQLyH5hw1CxlVI+Mwr1DZUgzmM5JwLNJAkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCJLQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJLQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4949E24694;
        Tue, 10 Mar 2020 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838967;
        bh=ouE7GIvcya1CXOFCUQCkdXTYHS0XJZ+NyEy2zndiOlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ou1guWx8yc7XSQ3/U8fQgQAT6GNqtmtbtaN72c2vDSQWcBpTbJxf4pvJrw8OBguL7
         kdub1wtUdL7Khyfs17fW/lqnIyk6aL/P1Pfk6EH0TWngThOtZ8sz0St9VvxGuWQzxM
         9cho4rXtLgyDhvUpnuGxtQUhOXT6gJFicSYnybzk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/19] perf stat: Show percore counts in per CPU output
Date:   Tue, 10 Mar 2020 08:15:34 -0300
Message-Id: <20200310111551.25160-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We have supported the event modifier "percore" which sums up the event
counts for all hardware threads in a core and show the counts per core.

For example,

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A -- sleep 1

  Performance counter stats for 'system wide':

 S0-D0-C0                395,072      cpu/event=cpu-cycles,percore/
 S0-D0-C1                851,248      cpu/event=cpu-cycles,percore/
 S0-D0-C2                954,226      cpu/event=cpu-cycles,percore/
 S0-D0-C3              1,233,659      cpu/event=cpu-cycles,percore/

This patch provides a new option "--percore-show-thread". It is used
with event modifier "percore" together to sum up the event counts for
all hardware threads in a core but show the counts per hardware thread.

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

We can see counts are duplicated in CPU pairs (CPU0/CPU4, CPU1/CPU5,
CPU2/CPU6, CPU3/CPU7).

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

If we offline CPU5, the result is:

 # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread -- sleep 1

  Performance counter stats for 'system wide':

 CPU0               2,752,148      cpu/event=cpu-cycles,percore/
 CPU1               1,009,312      cpu/event=cpu-cycles,percore/
 CPU2               2,784,072      cpu/event=cpu-cycles,percore/
 CPU3               2,427,922      cpu/event=cpu-cycles,percore/
 CPU4               2,752,148      cpu/event=cpu-cycles,percore/
 CPU6               2,784,072      cpu/event=cpu-cycles,percore/
 CPU7               2,427,922      cpu/event=cpu-cycles,percore/

        1.001416041 seconds time elapsed

 v4:
 ---
 Ravi Bangoria reports an issue in v3. Once we offline a CPU,
 the output is not correct. The issue is we should use the cpu
 idx in print_percore_thread rather than using the cpu value.

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
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200214080452.26402-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  9 +++++++
 tools/perf/builtin-stat.c              |  4 ++++
 tools/perf/util/stat-display.c         | 33 ++++++++++++++++++++++----
 tools/perf/util/stat.h                 |  1 +
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 9431b8066fb4..4d56586b2fb9 100644
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
+convenient for post processing.
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
index bc31fccc0057..d89cb0da90f8 100644
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
@@ -1146,6 +1146,26 @@ static void print_footer(struct perf_stat_config *config)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
+static void print_percore_thread(struct perf_stat_config *config,
+				 struct evsel *counter, char *prefix)
+{
+	int s, s2, id;
+	bool first = true;
+
+	for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
+		for (s = 0; s < config->aggr_map->nr; s++) {
+			id = config->aggr_map->map[s];
+			if (s2 == id)
+				break;
+		}
+
+		print_counter_aggrdata(config, counter, s,
+				       prefix, false,
+				       &first, i);
+	}
+}
+
 static void print_percore(struct perf_stat_config *config,
 			  struct evsel *counter, char *prefix)
 {
@@ -1157,13 +1177,16 @@ static void print_percore(struct perf_stat_config *config,
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
2.21.1

