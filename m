Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F2C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E6F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCMJELLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgD3TgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD3TgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:36:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C66BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k14so9010379ybp.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wnlKCFnUaoiAwoVZEp9MitGrMc25j108TQTIdGLsbOM=;
        b=LCMJELLZI/hAJ7d/XfWxrT4vL+fJiOTgCLU1rXXJTUsWtc/Q1kDuR0fXfLMHdYtnz8
         SzTRhIAigtdhW8L93xR1tDU6AMla8+MZV+hroPGB/zB+/0gyIYv9Nn4TSHjOBFpVxLHi
         PItqG6OzAz31wG8Fdmk/N/AAP5VULYp7XZybQfq+t9KKTjq4VPNe8dthDu846vZfag5o
         Tk0JFjqIu9mkmtvXig8KDbSDiXefs7Xz6Hl55L8cGZjoatw+C7OYpiomafkeb1WWR4A5
         sEHO4Ak9LcJaJb17lPhPzfTsP6zRqwjpm8zvwm2xrc/iJK3MTtJZV6LM4DDhpThoh6U6
         XGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wnlKCFnUaoiAwoVZEp9MitGrMc25j108TQTIdGLsbOM=;
        b=SLQuP2uwDsH7DKKU2tCKChT7EY9v8nipwIoaCZeyLO8kdtg7CbzI0umsZCxo2/J/On
         NmsKDiqyfaj62+nOnHmuc4Y3fw04J8xrqD3cBiDhLq1BBY/DKnKTTp04VcqBEwKIx2KD
         yKRWkxVxYadcYv0/O/Bggu5wT6o2hMYftcHAG054xR3nyHnVAa/dddhwWBi1yK62IISv
         Vsy/+O2dLzKSs5zFEr795kxzbaK9nUFOXIgsi+JEYCS06C1DgnrgZ63uhLJzv1KiDNMb
         Ac+vr+tRubcTtEE+ZjI+OW4qZDjPpqGcuyN8p1JX6w4GT6cT2Eb227YjjrPVjY397boa
         PIcA==
X-Gm-Message-State: AGi0Puab9S0H/iIX7EEyDoh9DqMWI9h+pGMGQF34xwiBVJHZKh9aobVo
        TE7ytHrR4oYSN0p4VkeU7f3qiNSH1j4y
X-Google-Smtp-Source: APiQypJwYlTJcszA8MYTHdsDPDv38tkDbMRrbDcYUqxZUe7Y3ZlySlM5KuSOtZKcqnQ1xrwu6jMQD4dC1nqu
X-Received: by 2002:a5b:783:: with SMTP id b3mr430881ybq.337.1588275362710;
 Thu, 30 Apr 2020 12:36:02 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:35:56 -0700
In-Reply-To: <20200430193557.101831-1-irogers@google.com>
Message-Id: <20200430193557.101831-2-irogers@google.com>
Mime-Version: 1.0
References: <20200430193557.101831-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] perf bench: add kallsyms parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a benchmark for kallsyms parsing. Example output:

  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 103.971 ms (+- 0.121 ms)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/Build            |  1 +
 tools/perf/bench/bench.h          |  1 +
 tools/perf/bench/kallsyms-parse.c | 75 +++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c        |  1 +
 4 files changed, 78 insertions(+)
 create mode 100644 tools/perf/bench/kallsyms-parse.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 042827385c87..768e408757a0 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -9,6 +9,7 @@ perf-y += futex-lock-pi.o
 perf-y += epoll-wait.o
 perf-y += epoll-ctl.o
 perf-y += synthesize.o
+perf-y += kallsyms-parse.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 4d669c803237..61cae4966cae 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -44,6 +44,7 @@ int bench_futex_lock_pi(int argc, const char **argv);
 int bench_epoll_wait(int argc, const char **argv);
 int bench_epoll_ctl(int argc, const char **argv);
 int bench_synthesize(int argc, const char **argv);
+int bench_kallsyms_parse(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/kallsyms-parse.c b/tools/perf/bench/kallsyms-parse.c
new file mode 100644
index 000000000000..e36e11f410c9
--- /dev/null
+++ b/tools/perf/bench/kallsyms-parse.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark synthesis of /proc/kallsyms parsing.
+ *
+ * Copyright 2020 Google LLC.
+ */
+#include <stdlib.h>
+#include "bench.h"
+#include "../util/stat.h"
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+#include <symbol/kallsyms.h>
+
+static unsigned int iterations = 100;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "iterations", &iterations,
+		"Number of iterations used to compute average"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench internals kallsyms-parse <options>",
+	NULL
+};
+
+static int bench_process_symbol(void *arg __maybe_unused,
+				const char *name __maybe_unused,
+				char type __maybe_unused,
+				u64 start __maybe_unused)
+{
+	return 0;
+}
+
+static int do_kallsyms_parse(void)
+{
+	struct timeval start, end, diff;
+	u64 runtime_us;
+	unsigned int i;
+	double time_average, time_stddev;
+	int err;
+	struct stats time_stats;
+
+	init_stats(&time_stats);
+
+	for (i = 0; i < iterations; i++) {
+		gettimeofday(&start, NULL);
+		err = kallsyms__parse("/proc/kallsyms", NULL,
+				bench_process_symbol);
+		if (err)
+			return err;
+
+		gettimeofday(&end, NULL);
+		timersub(&end, &start, &diff);
+		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		update_stats(&time_stats, runtime_us);
+	}
+
+	time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
+	time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
+	printf("  Average kallsyms__parse took: %.3f ms (+- %.3f ms)\n",
+		time_average, time_stddev);
+	return 0;
+}
+
+int bench_kallsyms_parse(int argc, const char **argv)
+{
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	return do_kallsyms_parse();
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 11c79a8d85d6..083273209c88 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -78,6 +78,7 @@ static struct bench epoll_benchmarks[] = {
 
 static struct bench internals_benchmarks[] = {
 	{ "synthesize", "Benchmark perf event synthesis",	bench_synthesize	},
+	{ "kallsyms-parse", "Benchmark kallsyms parsing",	bench_kallsyms_parse	},
 	{ NULL,		NULL,					NULL			}
 };
 
-- 
2.26.2.526.g744177e7f7-goog

