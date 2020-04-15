Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1166C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71ACA206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVrNuKD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408011AbgDOFlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393363AbgDOFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:41:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A11C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:41:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id e18so1946707pfl.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c7+W7OYNvwVSNgXY3eNe6fCfBf5xGmJ1r13LW66pCnw=;
        b=gVrNuKD/jlzd46wibqv3phUsUGHkwRDhFzEKDzKWtBO5xNwAQc5m2EtWSYI18PUJSe
         P2SSha9NVpcvlPgbN3NJahvBC+rpcFL+LdsHiLmNvaqKUhNxrNtL0HEf+u/CTPqvt2y0
         wQOYHluhPYGgNmrqWaDJ8asar4G+UaYImncKI0zMuH1okLgXgx2SWfC48FPzGt4Z33+m
         P3kw2kbJEGWIz7M7b5Bt6Z+hCpsxUqTh/ennxXJVspxfMJJQCKtyo8t9pJsAnVIwrGI1
         kcqa3AHGE1T7EFRM/ca1Yds2JfjSMQm06rWooCj2Meao4w4rvmVpEMZTqxstFh+t+wmE
         tQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c7+W7OYNvwVSNgXY3eNe6fCfBf5xGmJ1r13LW66pCnw=;
        b=oR3TMS+PDT0SqCZYKa/BcGkcLIdcnV8NC8FyWRNSUNPnzc7R0lOUctUZwqeeatL/v3
         dqQp+nf+Vx/vZz8rIjkuI+76GVixA0zkjCQYgZHO8U94SvSorboLIqhUuxKvSLa4aJnz
         yQHVqnNLF2ML0aeYo1j8v++QXxUxIGUOS3gEfQcDP8uLFeXuh3WT69UtbfsdWjV7ty34
         dyGUEqOW2/MN9oWQGaoxQzP3Oj1TrART5Wl6FwT54ehD3iM0VCLhxenwuzYXoLOXhDYW
         QHmy65QCmHUw6CJjxGzWjsK2wjEGEC1RAOURSI+Tt8chQ3Yhc4bLjDn/spDAjEGxR+5/
         UhDg==
X-Gm-Message-State: AGi0PuZRt2iylVWd/ThCr4Wkj33JWyyT8e3iykbVwN68nD1V6tkbtbBI
        aew7k9epTxZcXGrIn06XCoYODueiz6Nk
X-Google-Smtp-Source: APiQypLQOqPTRJc54v7X1TF6C3YRufjhJKSMYop2YEruvo9EAqxEsyo8kOp2S1XY0waRgujhfcWHrVacpb8x
X-Received: by 2002:a17:90b:109:: with SMTP id p9mr4329677pjz.18.1586929259800;
 Tue, 14 Apr 2020 22:40:59 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:40:48 -0700
In-Reply-To: <20200415054050.31645-1-irogers@google.com>
Message-Id: <20200415054050.31645-2-irogers@google.com>
Mime-Version: 1.0
References: <20200415054050.31645-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 1/3] perf bench: add a multi-threaded synthesize benchmark
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default this isn't run as it reads /proc and may not have access.
For consistency, modify the single threaded benchmark to compute an
average time per event.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.26.0.110.g2183baf09c-goog

