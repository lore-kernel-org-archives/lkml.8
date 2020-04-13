Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA1C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D29D20739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796840;
	bh=7u1UGDhnVePV+qW7cNom8G+AZ8jZWB+9/jX9rjgUVbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2wDOO/uCeFTsvL7murXFyESl94PclQieRrHS9SBgqCksJvPZAagWaELs+zg8KVGV
	 dm2QbFWHYV1rHSM6P/u243aGxxwHRifO1uB6Zg1pqXlwDJSF0bNrmhPtjNtmsRRoAs
	 oDAxdMu/iehwgdpXSv8s6nfzh9TW7ZE9kwTsCX5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgDMQx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732049AbgDMQxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:53:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4478B2078B;
        Mon, 13 Apr 2020 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796828;
        bh=7u1UGDhnVePV+qW7cNom8G+AZ8jZWB+9/jX9rjgUVbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLphPcbdO4wHzl62wkh1eocRPsrlEO/2PSgvX7SMMh4zeY6fbemgX9gSKYC2DURQZ
         ++P87pqeoyIwVzWcrxVCLsHN79ljKOvEx14EfC+9NQ/vXzw6Bmq6Y26bCMTcYdHqOw
         1VaS1ChM2XTASjMnfpvRXMaN7TzSqnSonec2rM9c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 19/26] perf bench: Add event synthesis benchmark
Date:   Mon, 13 Apr 2020 13:51:56 -0300
Message-Id: <20200413165203.1816-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Event synthesis may occur at the start or end (tail) of a perf command.
In system-wide mode it can scan every process in /proc, which may add
seconds of latency before event recording. Add a new benchmark that
times how long event synthesis takes with and without data synthesis.

An example execution looks like:

 $ perf bench internals synthesize
 # Running 'internals/synthesize' benchmark:
 Average synthesis took: 168.253800 usec
 Average data synthesis took: 208.104700 usec

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200402154357.107873-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-bench.txt |   8 ++
 tools/perf/bench/Build                  |   2 +-
 tools/perf/bench/bench.h                |   2 +-
 tools/perf/bench/synthesize.c           | 101 ++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   6 ++
 5 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/bench/synthesize.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 0921a3c67381..bad16512c48d 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -61,6 +61,9 @@ SUBSYSTEM
 'epoll'::
 	Eventpoll (epoll) stressing benchmarks.
 
+'internals'::
+	Benchmark internal perf functionality.
+
 'all'::
 	All benchmark subsystems.
 
@@ -214,6 +217,11 @@ Suite for evaluating concurrent epoll_wait calls.
 *ctl*::
 Suite for evaluating multiple epoll_ctl calls.
 
+SUITES FOR 'internals'
+~~~~~~~~~~~~~~~~~~~~~~
+*synthesize*::
+Suite for evaluating perf's event synthesis performance.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index e4e321b6f883..042827385c87 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -6,9 +6,9 @@ perf-y += futex-wake.o
 perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
-
 perf-y += epoll-wait.o
 perf-y += epoll-ctl.o
+perf-y += synthesize.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 4aa6de1aa67d..4d669c803237 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -41,9 +41,9 @@ int bench_futex_wake_parallel(int argc, const char **argv);
 int bench_futex_requeue(int argc, const char **argv);
 /* pi futexes */
 int bench_futex_lock_pi(int argc, const char **argv);
-
 int bench_epoll_wait(int argc, const char **argv);
 int bench_epoll_ctl(int argc, const char **argv);
+int bench_synthesize(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
new file mode 100644
index 000000000000..6291257bc9c9
--- /dev/null
+++ b/tools/perf/bench/synthesize.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark synthesis of perf events such as at the start of a 'perf
+ * record'. Synthesis is done on the current process and the 'dummy' event
+ * handlers are invoked that support dump_trace but otherwise do nothing.
+ *
+ * Copyright 2019 Google LLC.
+ */
+#include <stdio.h>
+#include "bench.h"
+#include "../util/debug.h"
+#include "../util/session.h"
+#include "../util/synthetic-events.h"
+#include "../util/target.h"
+#include "../util/thread_map.h"
+#include "../util/tool.h"
+#include <linux/err.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+
+static unsigned int iterations = 10000;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		"Number of iterations used to compute average"),
+	OPT_END()
+};
+
+static const char *const usage[] = {
+	"perf bench internals synthesize <options>",
+	NULL
+};
+
+
+static int do_synthesize(struct perf_session *session,
+			struct perf_thread_map *threads,
+			struct target *target, bool data_mmap)
+{
+	const unsigned int nr_threads_synthesize = 1;
+	struct timeval start, end, diff;
+	u64 runtime_us;
+	unsigned int i;
+	double average;
+	int err;
+
+	gettimeofday(&start, NULL);
+	for (i = 0; i < iterations; i++) {
+		err = machine__synthesize_threads(&session->machines.host,
+						target, threads, data_mmap,
+						nr_threads_synthesize);
+		if (err)
+			return err;
+	}
+
+	gettimeofday(&end, NULL);
+	timersub(&end, &start, &diff);
+	runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+	average = (double)runtime_us/(double)iterations;
+	printf("Average %ssynthesis took: %f usec\n",
+		data_mmap ? "data " : "", average);
+	return 0;
+}
+
+int bench_synthesize(int argc, const char **argv)
+{
+	struct perf_tool tool;
+	struct perf_session *session;
+	struct target target = {
+		.pid = "self",
+	};
+	struct perf_thread_map *threads;
+	int err;
+
+	argc = parse_options(argc, argv, options, usage, 0);
+
+	session = perf_session__new(NULL, false, NULL);
+	if (IS_ERR(session)) {
+		pr_err("Session creation failed.\n");
+		return PTR_ERR(session);
+	}
+	threads = thread_map__new_by_pid(getpid());
+	if (!threads) {
+		pr_err("Thread map creation failed.\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+	perf_tool__fill_defaults(&tool);
+
+	err = do_synthesize(session, threads, &target, false);
+	if (err)
+		goto err_out;
+
+	err = do_synthesize(session, threads, &target, true);
+
+err_out:
+	if (threads)
+		perf_thread_map__put(threads);
+
+	perf_session__delete(session);
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index c06fe21c8613..11c79a8d85d6 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -76,6 +76,11 @@ static struct bench epoll_benchmarks[] = {
 };
 #endif // HAVE_EVENTFD
 
+static struct bench internals_benchmarks[] = {
+	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
+	{ NULL,		NULL,					NULL			}
+};
+
 struct collection {
 	const char	*name;
 	const char	*summary;
@@ -92,6 +97,7 @@ static struct collection collections[] = {
 #ifdef HAVE_EVENTFD
 	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
 #endif
+	{ "internals",	"Perf-internals benchmarks",			internals_benchmarks	},
 	{ "all",	"All benchmarks",				NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.21.1

