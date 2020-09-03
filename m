Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4210A2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgICBCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:02:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:28323 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgICBCF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:02:05 -0400
IronPort-SDR: BBBM3Gtyuvagn/1fGo+YMVvzYTOT60+c/6si9wIg4m3jnM8eQ1JZ8GGHFYMms+PdaqzLtsvTFx
 8L4ozkMZwdnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158488272"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="158488272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 18:02:04 -0700
IronPort-SDR: CK9Le5pdTXpzh6+1EFmiV27W/e1+nwzMR0KtPkhoRFmAjh8/faaW9Hk6KaMxerQYU9k218AWf9
 jMWd4325LETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="405328931"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2020 18:02:01 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Turn off summary for interval mode by default
Date:   Thu,  3 Sep 2020 09:01:13 +0800
Message-Id: <20200903010113.32232-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a risk that outputting interval mode summaries by default
breaks CSV consumers. It already broke pmu-tools/toplev.

So now we turn off the summary by default but we create a new
option '--summary' to enable the summary. This is active even
when not using CSV mode.

Before:

  root@kbl-ppc:~# perf stat -I1000 --interval-count 2
  #           time             counts unit events
       1.000265904           8,005.73 msec cpu-clock                 #    8.006 CPUs utilized
       1.000265904                601      context-switches          #    0.075 K/sec
       1.000265904                 10      cpu-migrations            #    0.001 K/sec
       1.000265904                  0      page-faults               #    0.000 K/sec
       1.000265904         66,746,521      cycles                    #    0.008 GHz
       1.000265904         71,874,398      instructions              #    1.08  insn per cycle
       1.000265904         13,356,781      branches                  #    1.668 M/sec
       1.000265904            298,756      branch-misses             #    2.24% of all branches
       2.001857667           8,012.52 msec cpu-clock                 #    8.013 CPUs utilized
       2.001857667                164      context-switches          #    0.020 K/sec
       2.001857667                 10      cpu-migrations            #    0.001 K/sec
       2.001857667                  2      page-faults               #    0.000 K/sec
       2.001857667          5,822,188      cycles                    #    0.001 GHz
       2.001857667          2,186,170      instructions              #    0.38  insn per cycle
       2.001857667            442,378      branches                  #    0.055 M/sec
       2.001857667             44,750      branch-misses             #   10.12% of all branches

   Performance counter stats for 'system wide':

           16,018.25 msec cpu-clock                 #    7.993 CPUs utilized
                 765      context-switches          #    0.048 K/sec
                  20      cpu-migrations            #    0.001 K/sec
                   2      page-faults               #    0.000 K/sec
          72,568,709      cycles                    #    0.005 GHz
          74,060,568      instructions              #    1.02  insn per cycle
          13,799,159      branches                  #    0.861 M/sec
             343,506      branch-misses             #    2.49% of all branches

         2.004118489 seconds time elapsed

After:

  root@kbl-ppc:~# perf stat -I1000 --interval-count 2
  #           time             counts unit events
       1.001336393           8,013.28 msec cpu-clock                 #    8.013 CPUs utilized
       1.001336393                 82      context-switches          #    0.010 K/sec
       1.001336393                  8      cpu-migrations            #    0.001 K/sec
       1.001336393                  0      page-faults               #    0.000 K/sec
       1.001336393          4,199,121      cycles                    #    0.001 GHz
       1.001336393          1,373,991      instructions              #    0.33  insn per cycle
       1.001336393            270,681      branches                  #    0.034 M/sec
       1.001336393             31,659      branch-misses             #   11.70% of all branches
       2.003905006           8,020.52 msec cpu-clock                 #    8.021 CPUs utilized
       2.003905006                184      context-switches          #    0.023 K/sec
       2.003905006                  8      cpu-migrations            #    0.001 K/sec
       2.003905006                  2      page-faults               #    0.000 K/sec
       2.003905006          5,446,190      cycles                    #    0.001 GHz
       2.003905006          2,312,547      instructions              #    0.42  insn per cycle
       2.003905006            451,691      branches                  #    0.056 M/sec
       2.003905006             37,925      branch-misses             #    8.40% of all branches

  root@kbl-ppc:~# perf stat -I1000 --interval-count 2 --summary
  #           time             counts unit events
       1.001313128           8,013.20 msec cpu-clock                 #    8.013 CPUs utilized
       1.001313128                 83      context-switches          #    0.010 K/sec
       1.001313128                  8      cpu-migrations            #    0.001 K/sec
       1.001313128                  0      page-faults               #    0.000 K/sec
       1.001313128          4,470,950      cycles                    #    0.001 GHz
       1.001313128          1,440,045      instructions              #    0.32  insn per cycle
       1.001313128            283,222      branches                  #    0.035 M/sec
       1.001313128             33,576      branch-misses             #   11.86% of all branches
       2.003857385           8,020.34 msec cpu-clock                 #    8.020 CPUs utilized
       2.003857385                154      context-switches          #    0.019 K/sec
       2.003857385                  8      cpu-migrations            #    0.001 K/sec
       2.003857385                  2      page-faults               #    0.000 K/sec
       2.003857385          4,515,676      cycles                    #    0.001 GHz
       2.003857385          2,180,449      instructions              #    0.48  insn per cycle
       2.003857385            435,254      branches                  #    0.054 M/sec
       2.003857385             31,179      branch-misses             #    7.16% of all branches

   Performance counter stats for 'system wide':

           16,033.53 msec cpu-clock                 #    7.992 CPUs utilized
                 237      context-switches          #    0.015 K/sec
                  16      cpu-migrations            #    0.001 K/sec
                   2      page-faults               #    0.000 K/sec
           8,986,626      cycles                    #    0.001 GHz
           3,620,494      instructions              #    0.40  insn per cycle
             718,476      branches                  #    0.045 M/sec
              64,755      branch-misses             #    9.01% of all branches

         2.006124542 seconds time elapsed

Fixes: c7e5b328a8d4 ("perf stat: Report summary for interval mode")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 3 +++
 tools/perf/builtin-stat.c              | 8 +++++---
 tools/perf/util/stat.h                 | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index c9bfefc051fb..947672fd9c70 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -416,6 +416,9 @@ counts for all hardware threads in a core but show the sum counts per
 hardware thread. This is essentially a replacement for the any bit and
 convenient for post processing.
 
+--summary::
+Print summary for interval mode (-I).
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..fddc97cac984 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -404,7 +404,7 @@ static void read_counters(struct timespec *rs)
 {
 	struct evsel *counter;
 
-	if (!stat_config.summary && (read_affinity_counters(rs) < 0))
+	if (!stat_config.stop_read_counter && (read_affinity_counters(rs) < 0))
 		return;
 
 	evlist__for_each_entry(evsel_list, counter) {
@@ -897,9 +897,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
-	if (interval) {
+	if (interval && stat_config.summary) {
 		stat_config.interval = 0;
-		stat_config.summary = true;
+		stat_config.stop_read_counter = true;
 		init_stats(&walltime_nsecs_stats);
 		update_stats(&walltime_nsecs_stats, t1 - t0);
 
@@ -1164,6 +1164,8 @@ static struct option stat_options[] = {
 		    "Use with 'percore' event qualifier to show the event "
 		    "counts of one hardware thread by sum up total hardware "
 		    "threads of same physical core"),
+	OPT_BOOLEAN(0, "summary", &stat_config.summary,
+		       "print summary for interval mode"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 		"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f8778cffd941..aa3bed48511b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -113,6 +113,7 @@ struct perf_stat_config {
 	bool			 summary;
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
+	bool			 stop_read_counter;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

