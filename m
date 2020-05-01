Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637AEC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3635C2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJHLhKO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgEAWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgEAWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:13:25 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18386C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:13:25 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f11so11609654qkk.16
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C+Al9Z/X3sd4XKf/oz//vbzyBF+S34jh63PtsmVKXPA=;
        b=lJHLhKO4w16yZrte29/J49wFlcgY/ld+4jnAItOPGS+CWK9nBcDFb/6C2G2fnDQ6yk
         CHw2vZ2NSVxJ/ZJEN41gGhEx1G2j1NEw6+dGHAHdkWs9xKxp2FHLFjIIoyvx6qbVmVOB
         r6dv3WZh8QfZSW/XPxR85Gfk5tNamUCCgWN+DpGOiYlngSUDgnh59N/JNHan9OMPvD0P
         oU2U5KdzioZChkQeDc/axId8nZzqot5J+VOpmQ6A/Yi/vn0ht0LBmuWDwhXZsIWPqXSJ
         1WQ0huOcUiKPuwjFupNV688L2x3iIaVqnWFEn9hG/Xl8KrUumnEunJNCVNyJO46YPKME
         Zl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C+Al9Z/X3sd4XKf/oz//vbzyBF+S34jh63PtsmVKXPA=;
        b=hRd7SNR5D1bchp0wS/IBh3pCxo6Ux+RtW0FF2x2R3ewLycvgvVBlPff6cEj6agTZ02
         DCfgIl+V6RVYeMLAUrjDlrCE1ff5fMJkkblX+913bu7m72Uy7TiH6bJ0XUX+OQPEYMnX
         ICiJWvYEnexiCENDT99kWSSrA7brNkBvMsrXM8xQeBdzDeJfnPiNtxFnTT8S/sg+51Ox
         u/G0fc7UwPGVuKejZRvYpinlIzHcwf+0hgIdUqeHvUjMgXhjawsobVQzX8W3GXU88CAu
         aPUoHv/aVCf0KBOSmr+b2vd29OfjPfgv4aENAw5VjmIVY4IngGZ/BWnJPKRqczU7bsJ0
         KGVg==
X-Gm-Message-State: AGi0PubvwRLHy6oWepkbYKaQ1MvpJn57sGvrkWfbb+ZaMeQOXdzv+u0W
        CfPJvNYUMjnkY8rc/1vtT4TnSlA353PU
X-Google-Smtp-Source: APiQypLbAPbZ6vViXxYxjpEjnFEaJBf6LszMJN5K51dPpkvvnHWJev4QnfcR1yn2pdu8zkRMonMAirbUD1Jw
X-Received: by 2002:a0c:e105:: with SMTP id w5mr6280089qvk.118.1588371204229;
 Fri, 01 May 2020 15:13:24 -0700 (PDT)
Date:   Fri,  1 May 2020 15:13:13 -0700
In-Reply-To: <20200501221315.54715-1-irogers@google.com>
Message-Id: <20200501221315.54715-2-irogers@google.com>
Mime-Version: 1.0
References: <20200501221315.54715-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 1/3] perf bench: add kallsyms parsing
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

