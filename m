Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C68C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F47B20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzKshWiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGXHUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:20:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0829C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:20:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7so9551736ybk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=POXlS+qT9R9AKcROkDEZvf/10TDY75vKdOyi/dPct08=;
        b=QzKshWiIrCbYcSmJDUXo2OV9fLJxqhO8kX8zvLKgxoYj7sjGxQNJUTEF9NG/tcTtES
         MI931/1CFPXE4cyF4CERizq8dDm7SkdSc3y7JDD95Ftg886kV2wYm1H1QRwI8V7CKsLK
         L8N6e83ZyQ6K7cpu9JhbF52U64b+ERXZiDjYwNks5gJidLwGl/AiJ/sJCdaTDjXRygXo
         sQxnALD5VyI3nJ0BzLHytDCG9RrqjQr9skp+euwY4qUkO1ipM43AyxHj6tyvv9yITH0u
         ygQeTverLNrb5IFwq03tl6344hHewoJ8gMDCxTWVS7CJLjLrOd21BnXg+BhYjMmfap+C
         3JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=POXlS+qT9R9AKcROkDEZvf/10TDY75vKdOyi/dPct08=;
        b=KTeacRVjjVAAvD7sis0crMtF4TS7iA5eOGC+qywwicE0+pfaL/5cU3LKrik+fLTNfM
         XU2oOvhhYPMmVX4rgcc3l/W3hPnfEOGzjyaM7RPI8l2pRZgadSvnWGxQjfqSclgheyl2
         +DxKbPNomvXYLLAqeqmmvmhIBLR1ZDphp6Q86XLglWn2MNqIGaE40RISoBk8P98z4S+M
         Pe7lhOcr/lshFXxcUY1VIp87mBOuk/DkvGouKfIh2N2rYufdeWwCE2OnSeODwAq4R2YT
         xaFMlOCiEyXpv870nBAJSFevKuQplzTIjE3jC2tO0O4VdujhUy7QdCwfWw+3qjGMRDp0
         zvGA==
X-Gm-Message-State: AOAM532WOeF6ss6uoqRFc8no7cIpR3vmbPO5uV9i71BMlyQ/IY8RsniX
        AU+OtzaEcT+kWM2kU2NHuRWOQwYWv4I4
X-Google-Smtp-Source: ABdhPJwTgVAmuKeTglX613zE2/z68nnGMZvgkSwpMc5V9tl0tCR0Lu75COiHwWQI0T8ici3bibZejkZQ/Ykl
X-Received: by 2002:a25:7c45:: with SMTP id x66mr12605043ybc.325.1595575204895;
 Fri, 24 Jul 2020 00:20:04 -0700 (PDT)
Date:   Fri, 24 Jul 2020 00:19:59 -0700
Message-Id: <20200724071959.3110510-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] perf bench: Add benchmark of find_next_bit
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_set_bit, or similar functions like for_each_cpu, may be hot
within the kernel. If many bits were set then one could imagine on
Intel a "bt" instruction with every bit may be faster than the function
call and word length find_next_bit logic. Add a benchmark to measure
this.

This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
option except for very small bitmaps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/Build            |   1 +
 tools/perf/bench/bench.h          |   1 +
 tools/perf/bench/find-bit-bench.c | 135 ++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c        |   1 +
 4 files changed, 138 insertions(+)
 create mode 100644 tools/perf/bench/find-bit-bench.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 768e408757a0..fb114bca3a8d 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -10,6 +10,7 @@ perf-y += epoll-wait.o
 perf-y += epoll-ctl.o
 perf-y += synthesize.o
 perf-y += kallsyms-parse.o
+perf-y += find-bit-bench.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 61cae4966cae..3291b0ddddfe 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -35,6 +35,7 @@ int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
+int bench_mem_find_bit(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
 int bench_futex_wake_parallel(int argc, const char **argv);
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
new file mode 100644
index 000000000000..1aadbd9d7e86
--- /dev/null
+++ b/tools/perf/bench/find-bit-bench.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Benchmark find_next_bit and related bit operations.
+ *
+ * Copyright 2020 Google LLC.
+ */
+#include <stdlib.h>
+#include "bench.h"
+#include "../util/stat.h"
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/time64.h>
+#include <subcmd/parse-options.h>
+
+static unsigned int outer_iterations = 5;
+static unsigned int inner_iterations = 100000;
+
+static const struct option options[] = {
+	OPT_UINTEGER('i', "outer-iterations", &outer_iterations,
+		"Number of outerer iterations used"),
+	OPT_UINTEGER('j', "inner-iterations", &inner_iterations,
+		"Number of outerer iterations used"),
+	OPT_END()
+};
+
+static const char *const bench_usage[] = {
+	"perf bench mem find_bit <options>",
+	NULL
+};
+
+static unsigned int accumulator;
+static unsigned int use_of_val;
+
+static noinline void workload(int val)
+{
+	use_of_val += val;
+	accumulator++;
+}
+
+#if defined(__i386__) || defined(__x86_64__)
+static bool asm_test_bit(long nr, const unsigned long *addr)
+{
+	bool oldbit;
+
+	asm volatile("bt %2,%1"
+		     : "=@ccc" (oldbit)
+		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
+
+	return oldbit;
+}
+#else
+#define asm_test_bit test_bit
+#endif
+
+static int do_for_each_set_bit(unsigned int num_bits)
+{
+	unsigned long *to_test = bitmap_alloc(num_bits);
+	struct timeval start, end, diff;
+	u64 runtime_us;
+	struct stats fb_time_stats, tb_time_stats;
+	double time_average, time_stddev;
+	unsigned int bit, i, j;
+	unsigned int set_bits, skip;
+	unsigned int old;
+
+	init_stats(&fb_time_stats);
+	init_stats(&tb_time_stats);
+
+	for (set_bits = 1; set_bits <= num_bits; set_bits <<= 1) {
+		bitmap_zero(to_test, num_bits);
+		skip = num_bits / set_bits;
+		for (i = 0; i < num_bits; i += skip)
+			set_bit(i, to_test);
+
+		for (i = 0; i < outer_iterations; i++) {
+			old = accumulator;
+			gettimeofday(&start, NULL);
+			for (j = 0; j < inner_iterations; j++) {
+				for_each_set_bit(bit, to_test, num_bits)
+					workload(bit);
+			}
+			gettimeofday(&end, NULL);
+			assert(old + (inner_iterations * set_bits) == accumulator);
+			timersub(&end, &start, &diff);
+			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+			update_stats(&fb_time_stats, runtime_us);
+
+			old = accumulator;
+			gettimeofday(&start, NULL);
+			for (j = 0; j < inner_iterations; j++) {
+				for (bit = 0; bit < num_bits; bit++) {
+					if (asm_test_bit(bit, to_test))
+						workload(bit);
+				}
+			}
+			gettimeofday(&end, NULL);
+			assert(old + (inner_iterations * set_bits) == accumulator);
+			timersub(&end, &start, &diff);
+			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+			update_stats(&tb_time_stats, runtime_us);
+		}
+
+		printf("%d operations %d bits set of %d bits\n",
+			inner_iterations, set_bits, num_bits);
+		time_average = avg_stats(&fb_time_stats);
+		time_stddev = stddev_stats(&fb_time_stats);
+		printf("  Average for_each_set_bit took: %.3f usec (+- %.3f usec)\n",
+			time_average, time_stddev);
+		time_average = avg_stats(&tb_time_stats);
+		time_stddev = stddev_stats(&tb_time_stats);
+		printf("  Average test_bit loop took:    %.3f usec (+- %.3f usec)\n",
+			time_average, time_stddev);
+
+		if (use_of_val == accumulator)  /* Try to avoid compiler tricks. */
+			printf("\n");
+	}
+	bitmap_free(to_test);
+	return 0;
+}
+
+int bench_mem_find_bit(int argc, const char **argv)
+{
+	int err = 0, i;
+
+	argc = parse_options(argc, argv, options, bench_usage, 0);
+	if (argc) {
+		usage_with_options(bench_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 1; i <= 2048; i <<= 1)
+		do_for_each_set_bit(i);
+
+	return err;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index cad31b1d3438..690eee1120a7 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -52,6 +52,7 @@ static struct bench sched_benchmarks[] = {
 static struct bench mem_benchmarks[] = {
 	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
 	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
+	{ "find_bit",	"Benchmark for find_bit() functions",		bench_mem_find_bit	},
 	{ "all",	"Run all memory access benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.28.0.rc0.142.g3c755180ce-goog

