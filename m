Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B0FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12A5206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSaBsYk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgEEOgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729123AbgEEOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:36:35 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B907BC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:36:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x24so1884121qta.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+Al9Z/X3sd4XKf/oz//vbzyBF+S34jh63PtsmVKXPA=;
        b=SSaBsYk+NMptl5lB9PsTZw4/Myq5rt0O6FQOyK0gER7/G3jQaoM4xfEMgtLU8zVs4t
         8RRB1qefVhdRD7/gBHSFDDtFpPFkKeCpNIxAva4HFQbA/zE5aF5dGQqO4ypoJMKq37u4
         PK/H1wwO0etbHSHaoRKwdXqwYGdPraGHcIDAkbCweNo4jg5kIC2T4IzZtNDnlODaP7pD
         mZuocODHWBJqjwPluXBmKRin5BvpbBf4gQdnGWWUbjHXLKZtyKWLTIPqMPKCTbE20RDM
         csexSucW/uuGUSSSCndcvyteNPjnJRkjfr8gq36lvZpUsMBdP++zSd7HhxFBfFYNSYpH
         kTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+Al9Z/X3sd4XKf/oz//vbzyBF+S34jh63PtsmVKXPA=;
        b=ZzPF+G3i2U9KIXMfCuiMyI5jXfTRwElWAK/BarCVwQDJW+dBxqklSmJSTa2XCq91ri
         bOlW8APha4PvDE2GAvoC5MPYxqgnJf+g+bu0Tm6/bsOKEycnNfyyKfBDO1wGIJ0x2yFn
         0Vaexu2CIMLAAizvW9p694Le3gAnpbo8PwDEeeq/UsTeq6QEKS7DExpCOIUe6C14U3pJ
         n8GSidsIvyJ9sqDrs2KU2MjQ87TyJe9eh4A7EH2VKMHJJ7vYuAUfqbHQrvFuUHwUXlBz
         k5mgCtiEfpga9DSkVetv4atYS9H3ANvDSi2x8mR5gbwZtFrQIeV1uPZVnYBw3/k2h577
         dMrQ==
X-Gm-Message-State: AGi0PuaCdTDc7OAeFCUgH+AsWXO24mFPz/xbPKmzS4/8mV5XAXbeEi3H
        ebpFC9zKGLEcVq8/90YHzjdF+KNqrIfd
X-Google-Smtp-Source: APiQypLNXoN6iYcCPNGunSiGJQB7DISRNY2U6zb8vieQS2La2DDgqE0rMVczj7UDKvhDn7PUfzQVtJmR0Uu2
X-Received: by 2002:ad4:44ab:: with SMTP id n11mr2989371qvt.147.1588689392859;
 Tue, 05 May 2020 07:36:32 -0700 (PDT)
Date:   Tue,  5 May 2020 07:36:23 -0700
In-Reply-To: <20200505143625.147832-1-irogers@google.com>
Message-Id: <20200505143625.147832-2-irogers@google.com>
Mime-Version: 1.0
References: <20200505143625.147832-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v3 1/3] perf bench: add kallsyms parsing
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
index 000000000000..2b0d0f980ae9
--- /dev/null
+++ b/tools/perf/bench/kallsyms-parse.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark of /proc/kallsyms parsing.
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

