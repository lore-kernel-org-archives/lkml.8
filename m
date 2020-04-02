Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FECC2BA18
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CC621707
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR2GEpE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbgDBPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:44:10 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44229 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgDBPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:44:08 -0400
Received: by mail-pj1-f74.google.com with SMTP id t7so3545754pjb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nz7MdrDBr2ynj5YVIzaPxP2bykXgmAQXaYm8pWbXWe4=;
        b=RR2GEpE7gSyDUnOPDAOOGXQJStCq6J8LkQzI2IsErU0FIEQg+NCYzDhcIn4a+onR0Q
         gie4aHp4OMCJ5mo/przZdMEGsfoLetKT8MVdMMSpPYYJjOWwS8dUf1byL6uqqbmR1vau
         Qpw5dvAbnbm5wBfNraFQIcM1BaXKGTHcOlNLI9DuAHQm/ekxFchW9IqBSvAmiZvOjfPc
         tsFB+EgIJ68XrYkeR05P3b+ulMJiSvnMTk/kmL0nwPFfMNCfy3/i+ctrtuES68GnXbRK
         eWDMtwSTLe6Pge4fpBim+TCds8RjvhrkfUNtIyDjAgSiWRbnR5WyUuthLowHwsWiHsbs
         UszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nz7MdrDBr2ynj5YVIzaPxP2bykXgmAQXaYm8pWbXWe4=;
        b=i9p/7In/9r/Gg8afNni6JWdkbO2dW8dxZ7J3zlSIB2W6CBChINe0kPMBk6nlFNFX3L
         AODKje78xvaDr6Pma0+tLByY2NUPtZOVnhUL5LzoD1kMEDT9o0mM+tjuxwpq/xbR8yEP
         yW4XXkw4qLszjdHv2vSTaDio5lIQbF0XNyHObuOTv36wyY20T1cO9OuWfHTnGrlJAxsj
         OboenEs0ecBVvoZptuxjnEvss3iwmJIlaQH374ptNUkusj1t6mq8LakuItHlu56UECr4
         rHO0xzpNSa0qowWvYuWafjziwSSwegSvJ7pQDfxjRNbLwGHYBypXMIDzPhhg4fvER6Za
         zy3g==
X-Gm-Message-State: AGi0PuZCofkKdCDxcgGfmaYyF8sOSdHIRwB3L9QMf1uy3wV4f8iXenXj
        Oov6DgTPx66Ek55MzxOGT+38eHfWZM73
X-Google-Smtp-Source: APiQypKjNR3Ln5D3nYQcJeGcK2/CpKss37Ga8D2TVTb3OHtWmJBcm1h31EKOnI/bZoxnI5biYQq3WALA4HVs
X-Received: by 2002:a17:90a:ac18:: with SMTP id o24mr4475369pjq.62.1585842244846;
 Thu, 02 Apr 2020 08:44:04 -0700 (PDT)
Date:   Thu,  2 Apr 2020 08:43:53 -0700
In-Reply-To: <20200402154357.107873-1-irogers@google.com>
Message-Id: <20200402154357.107873-2-irogers@google.com>
Mime-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 1/5] perf bench: add event synthesis benchmark
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
2.26.0.rc2.310.g2932bb562d-goog

