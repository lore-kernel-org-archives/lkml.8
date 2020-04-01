Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5383F20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EugKDJO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgDAXk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:40:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53391 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbgDAXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:28 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so1161853pfk.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ymmERmMm+j5xAdQXe+HYzyfyXOHg/uCxElmqFqbzLsM=;
        b=EugKDJO6sYmAjpE7bY2KkmMsOhK1mtgyiSn+gqWYMRkHUlVrqBn/4XcwEbtSvd6RQu
         38PI1uLqz/2ZGAyJyizHFN2hwXLduL1akY44VxPztMJCdFfLGqKFkA1O0ICWHKNlOfeY
         L+qE/NAUOsgOdU2utqMBiHm2SbyLtjNWzmIoVwcIz7Cm+nTMUGZBlCVuxV+6E87+dpoL
         txuwGc8uUsDVQRAGNLFkGEY/Drb7RnrsoCDbudr+af6y4fVw6p1uRJ5fCl+4nLgA/vC9
         Dj1URVSvg1+LbVvuaT90WcZZ08JgyVfA6dvyUgRjodVgsu9GpvU1PHCtT7bkVzbkcyRC
         Uv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ymmERmMm+j5xAdQXe+HYzyfyXOHg/uCxElmqFqbzLsM=;
        b=eZd0BvE5n264KHBMIARqKJegZywgDe9ARxxdFKNtdUMK3kDKyaU4AxgdX2VoiB16Lq
         XiApSMBdJiMIBYPsspj8nBn0Zp/Who9knLrcS+BIIZmVm92sqBNWTVpijNJVUFrBaTL3
         xw3JBcyudEM+h4qkhU1eOOK3Z4faHIcpAm7rj0SIPqbOdXqH3P5VIHsUQaWbGh+o2+fR
         z+gC6dA/zEMS5ZMjwsfL5iz8N1vyDDsKZBI60OBN0auDzJPFcsrsYiuxtbIWtvbyP3Wy
         fwPFwTQ27PM1VZELO/ErVCw/fO/6wYnF8HPJJkuiepmfVZwcSZxub5gvFEb6Id+aPFqk
         gAMg==
X-Gm-Message-State: AGi0PuaJyGNU/48s2Ybs/RizE7OQqZsKfpnjpqREBo4rpAWLs4nCR4ny
        dn1bTACZsdxPalVPLsmtwH/2AiMeTQXC
X-Google-Smtp-Source: APiQypLiQNOHP8l/bl8Q0ykCXYrs864C1qaRCpyJFfw0JXykZ9pujL0C42J03sG2CsG3ImrntkYGjWts+WAJ
X-Received: by 2002:a17:90b:4c81:: with SMTP id my1mr600052pjb.30.1585784427599;
 Wed, 01 Apr 2020 16:40:27 -0700 (PDT)
Date:   Wed,  1 Apr 2020 16:39:41 -0700
In-Reply-To: <20200401233945.133550-1-irogers@google.com>
Message-Id: <20200401233945.133550-2-irogers@google.com>
Mime-Version: 1.0
References: <20200401233945.133550-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 1/5] perf bench: add event synthesis benchmark
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/Build        |   2 +-
 tools/perf/bench/bench.h      |   2 +-
 tools/perf/bench/synthesize.c | 101 ++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c    |   6 ++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/bench/synthesize.c

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

