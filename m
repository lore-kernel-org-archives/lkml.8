Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07706C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB5C21744
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778601;
	bh=Oa7Ek+3qTeSo5j4Ru0Q6v5FIubzef6T0d75S0O36On4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oGOhWPAK96LETVq8q8EyVQ0u9W4DaB0b51dbrPs9/cjr0rxPNd1JeKK4dPgkBABR6
	 ibFDYle48AJ4pBhrDzrYtA0gWqL98y92v7sUlYC/TRl6G6wBSMwIHuzFK4bDiNGLPk
	 iaWuCOHQYo3hiLPlnjLy3t1gA1P4vqKkXjGzVNBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgEFPXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbgEFPXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39DC24953;
        Wed,  6 May 2020 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778597;
        bh=Oa7Ek+3qTeSo5j4Ru0Q6v5FIubzef6T0d75S0O36On4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Px+/5d7I7Mitdo4Q6eNVHTE2s2/XkPKX5qrJePAlMIJmzOQ8uJzq/Jx6pfGKitoj3
         t5obbsTP1NChEo7GrZrGtQEsZBRLZdPwhjRWa0JKM6Q9r7vXeLm3rC30RGR6EfM1vW
         eSdIsplC+QipB37hXO2o+c39/bfY/4vASELIPrtc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 09/91] perf bench: Add a multi-threaded synthesize benchmark
Date:   Wed,  6 May 2020 12:21:12 -0300
Message-Id: <20200506152234.21977-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

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
 tools/perf/bench/synthesize.c | 211 ++++++++++++++++++++++++++++++----
 1 file changed, 186 insertions(+), 25 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 6291257bc9c9..8d624aea1c5e 100644
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
@@ -99,3 +146,117 @@ int bench_synthesize(int argc, const char **argv)
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
-- 
2.21.1

