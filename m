Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6445724999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgEHNGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730636AbgEHNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:06:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B98C05BD43;
        Fri,  8 May 2020 06:06:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h6-0007sp-3w; Fri, 08 May 2020 15:05:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 723BF1C0870;
        Fri,  8 May 2020 15:05:12 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:12 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf bench: Add a multi-threaded synthesize benchmark
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415054050.31645-2-irogers@google.com>
References: <20200415054050.31645-2-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158894311235.8414.16349025595253837395.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     13edc237200c75425ab0e3fe4b4c75dafb468c2e
Gitweb:        https://git.kernel.org/tip/13edc237200c75425ab0e3fe4b4c75dafb468c2e
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 14 Apr 2020 22:40:48 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:25 -03:00

perf bench: Add a multi-threaded synthesize benchmark

By default this isn't run as it reads /proc and may not have access.
For consistency, modify the single threaded benchmark to compute an
average time per event.

Committer testing:

  $ grep -m1 "model name" /proc/cpuinfo
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  $ grep "model name" /proc/cpuinfo  | wc -l
  8
  $
  $ perf bench internals synthesize -h
  # Running 'internals/synthesize' benchmark:

   Usage: perf bench internals synthesize <options>

      -I, --multi-iterations <n>
                            Number of iterations used to compute multi-threaded average
      -i, --single-iterations <n>
                            Number of iterations used to compute single-threaded average
      -M, --max-threads <n>
                            Maximum number of threads in multithreaded bench
      -m, --min-threads <n>
                            Minimum number of threads in multithreaded bench
      -s, --st              Run single threaded benchmark
      -t, --mt              Run multi-threaded benchmark

  $
  $ perf bench internals synthesize -t
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 65449.000 usec (+- 586.442 usec)
      Average num. events: 9405.400 (+- 0.306)
      Average time per event 6.959 usec
    Number of synthesis threads: 2
      Average synthesis took: 37838.300 usec (+- 130.259 usec)
      Average num. events: 9501.800 (+- 20.469)
      Average time per event 3.982 usec
    Number of synthesis threads: 3
      Average synthesis took: 48551.400 usec (+- 225.686 usec)
      Average num. events: 9544.000 (+- 0.000)
      Average time per event 5.087 usec
    Number of synthesis threads: 4
      Average synthesis took: 29632.500 usec (+- 50.808 usec)
      Average num. events: 9544.000 (+- 0.000)
      Average time per event 3.105 usec
    Number of synthesis threads: 5
      Average synthesis took: 33920.400 usec (+- 284.509 usec)
      Average num. events: 9544.000 (+- 0.000)
      Average time per event 3.554 usec
    Number of synthesis threads: 6
      Average synthesis took: 27604.100 usec (+- 72.344 usec)
      Average num. events: 9548.000 (+- 0.000)
      Average time per event 2.891 usec
    Number of synthesis threads: 7
      Average synthesis took: 25406.300 usec (+- 933.371 usec)
      Average num. events: 9545.500 (+- 0.167)
      Average time per event 2.662 usec
    Number of synthesis threads: 8
      Average synthesis took: 24110.400 usec (+- 73.229 usec)
      Average num. events: 9551.000 (+- 0.000)
      Average time per event 2.524 usec
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/synthesize.c | 211 +++++++++++++++++++++++++++++----
 1 file changed, 186 insertions(+), 25 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 6291257..8d624ae 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -10,60 +10,105 @@
 #include "bench.h"
 #include "../util/debug.h"
 #include "../util/session.h"
+#include "../util/stat.h"
 #include "../util/synthetic-events.h"
 #include "../util/target.h"
 #include "../util/thread_map.h"
 #include "../util/tool.h"
+#include "../util/util.h"
+#include <linux/atomic.h>
 #include <linux/err.h>
 #include <linux/time64.h>
 #include <subcmd/parse-options.h>
 
-static unsigned int iterations = 10000;
+static unsigned int min_threads = 1;
+static unsigned int max_threads = UINT_MAX;
+static unsigned int single_iterations = 10000;
+static unsigned int multi_iterations = 10;
+static bool run_st;
+static bool run_mt;
 
 static const struct option options[] = {
-	OPT_UINTEGER('i', "iterations", &iterations,
-		"Number of iterations used to compute average"),
+	OPT_BOOLEAN('s', "st", &run_st, "Run single threaded benchmark"),
+	OPT_BOOLEAN('t', "mt", &run_mt, "Run multi-threaded benchmark"),
+	OPT_UINTEGER('m', "min-threads", &min_threads,
+		"Minimum number of threads in multithreaded bench"),
+	OPT_UINTEGER('M', "max-threads", &max_threads,
+		"Maximum number of threads in multithreaded bench"),
+	OPT_UINTEGER('i', "single-iterations", &single_iterations,
+		"Number of iterations used to compute single-threaded average"),
+	OPT_UINTEGER('I', "multi-iterations", &multi_iterations,
+		"Number of iterations used to compute multi-threaded average"),
 	OPT_END()
 };
 
-static const char *const usage[] = {
+static const char *const bench_usage[] = {
 	"perf bench internals synthesize <options>",
 	NULL
 };
 
+static atomic_t event_count;
 
-static int do_synthesize(struct perf_session *session,
-			struct perf_thread_map *threads,
-			struct target *target, bool data_mmap)
+static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
+				     union perf_event *event __maybe_unused,
+				     struct perf_sample *sample __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	atomic_inc(&event_count);
+	return 0;
+}
+
+static int do_run_single_threaded(struct perf_session *session,
+				struct perf_thread_map *threads,
+				struct target *target, bool data_mmap)
 {
 	const unsigned int nr_threads_synthesize = 1;
 	struct timeval start, end, diff;
 	u64 runtime_us;
 	unsigned int i;
-	double average;
+	double time_average, time_stddev, event_average, event_stddev;
 	int err;
+	struct stats time_stats, event_stats;
 
-	gettimeofday(&start, NULL);
-	for (i = 0; i < iterations; i++) {
-		err = machine__synthesize_threads(&session->machines.host,
-						target, threads, data_mmap,
+	init_stats(&time_stats);
+	init_stats(&event_stats);
+
+	for (i = 0; i < single_iterations; i++) {
+		atomic_set(&event_count, 0);
+		gettimeofday(&start, NULL);
+		err = __machine__synthesize_threads(&session->machines.host,
+						NULL,
+						target, threads,
+						process_synthesized_event,
+						data_mmap,
 						nr_threads_synthesize);
 		if (err)
 			return err;
+
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+		update_stats(&event_stats, atomic_read(&event_count));
 	}
 
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &diff);
-	runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
-	average = (double)runtime_us/(double)iterations;
-	printf("Average %ssynthesis took: %f usec\n",
-		data_mmap ? "data " : "", average);
+	time_average = avg_stats(&time_stats);
+	time_stddev = stddev_stats(&time_stats);
+	printf("  Average %ssynthesis took: %.3f usec (+- %.3f usec)\n",
+		data_mmap ? "data " : "", time_average, time_stddev);
+
+	event_average = avg_stats(&event_stats);
+	event_stddev = stddev_stats(&event_stats);
+	printf("  Average num. events: %.3f (+- %.3f)\n",
+		event_average, event_stddev);
+
+	printf("  Average time per event %.3f usec\n",
+		time_average / event_average);
 	return 0;
 }
 
-int bench_synthesize(int argc, const char **argv)
+static int run_single_threaded(void)
 {
-	struct perf_tool tool;
 	struct perf_session *session;
 	struct target target = {
 		.pid = "self",
@@ -71,8 +116,7 @@ int bench_synthesize(int argc, const char **argv)
 	struct perf_thread_map *threads;
 	int err;
 
-	argc = parse_options(argc, argv, options, usage, 0);
-
+	perf_set_singlethreaded();
 	session = perf_session__new(NULL, false, NULL);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
@@ -84,13 +128,16 @@ int bench_synthesize(int argc, const char **argv)
 		err = -ENOMEM;
 		goto err_out;
 	}
-	perf_tool__fill_defaults(&tool);
 
-	err = do_synthesize(session, threads, &target, false);
+	puts(
+"Computing performance of single threaded perf event synthesis by\n"
+"synthesizing events on the perf process itself:");
+
+	err = do_run_single_threaded(session, threads, &target, false);
 	if (err)
 		goto err_out;
 
-	err = do_synthesize(session, threads, &target, true);
+	err = do_run_single_threaded(session, threads, &target, true);
 
 err_out:
 	if (threads)
@@ -99,3 +146,117 @@ err_out:
 	perf_session__delete(session);
 	return err;
 }
+
+static int do_run_multi_threaded(struct target *target,
+				unsigned int nr_threads_synthesize)
+{
+	struct timeval start, end, diff;
+	u64 runtime_us;
+	unsigned int i;
+	double time_average, time_stddev, event_average, event_stddev;
+	int err;
+	struct stats time_stats, event_stats;
+	struct perf_session *session;
+
+	init_stats(&time_stats);
+	init_stats(&event_stats);
+	for (i = 0; i < multi_iterations; i++) {
+		session = perf_session__new(NULL, false, NULL);
+		if (!session)
+			return -ENOMEM;
+
+		atomic_set(&event_count, 0);
+		gettimeofday(&start, NULL);
+		err = __machine__synthesize_threads(&session->machines.host,
+						NULL,
+						target, NULL,
+						process_synthesized_event,
+						false,
+						nr_threads_synthesize);
+		if (err) {
+			perf_session__delete(session);
+			return err;
+		}
+
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+		update_stats(&event_stats, atomic_read(&event_count));
+		perf_session__delete(session);
+	}
+
+	time_average = avg_stats(&time_stats);
+	time_stddev = stddev_stats(&time_stats);
+	printf("    Average synthesis took: %.3f usec (+- %.3f usec)\n",
+		time_average, time_stddev);
+
+	event_average = avg_stats(&event_stats);
+	event_stddev = stddev_stats(&event_stats);
+	printf("    Average num. events: %.3f (+- %.3f)\n",
+		event_average, event_stddev);
+
+	printf("    Average time per event %.3f usec\n",
+		time_average / event_average);
+	return 0;
+}
+
+static int run_multi_threaded(void)
+{
+	struct target target = {
+		.cpu_list = "0"
+	};
+	unsigned int nr_threads_synthesize;
+	int err;
+
+	if (max_threads == UINT_MAX)
+		max_threads = sysconf(_SC_NPROCESSORS_ONLN);
+
+	puts(
+"Computing performance of multi threaded perf event synthesis by\n"
+"synthesizing events on CPU 0:");
+
+	for (nr_threads_synthesize = min_threads;
+	     nr_threads_synthesize <= max_threads;
+	     nr_threads_synthesize++) {
+		if (nr_threads_synthesize == 1)
+			perf_set_singlethreaded();
+		else
+			perf_set_multithreaded();
+
+		printf("  Number of synthesis threads: %u\n",
+			nr_threads_synthesize);
+
+		err = do_run_multi_threaded(&target, nr_threads_synthesize);
+		if (err)
+			return err;
+	}
+	perf_set_singlethreaded();
+	return 0;
+}
+
+int bench_synthesize(int argc, const char **argv)
+{
+	int err = 0;
+
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * If neither single threaded or multi-threaded are specified, default
+	 * to running just single threaded.
+	 */
+	if (!run_st && !run_mt)
+		run_st = true;
+
+	if (run_st)
+		err = run_single_threaded();
+
+	if (!err && run_mt)
+		err = run_multi_threaded();
+
+	return err;
+}
