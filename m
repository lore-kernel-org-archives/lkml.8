Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B698C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69DC2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCC4HkAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgG2WAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:00:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC705C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:00:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e135so31349642ybf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1VcquGcUliPDZVaM/Fn7rmb+6W0/28WHDw0fGkhqmqQ=;
        b=jCC4HkAVb1T0aSqCHgNzaYRiJRHeJjplkzEUAvbwPIFDbfVOeWXqYsMyTDHtHIoGby
         F85PgrijrYPk69txUOe1O6vFhzcx45PaBiyKU/ChB6p2rQPRebumdqbBjEZiTJvOvWfW
         EZxojf0c0jYlkM7aJwftVUtld9oUwRbr9zVDzbjK8GesboMLuMmGH3Eb5KDMv7uTHoL7
         Q6yY9MvxDUexex4ejCCVJc1NO20J2DjdQgCb3TPr4NERf3nQPAoNTF1fnw48Iitufxyi
         /UX62rzUXmxV3c63Vm4pL34dPKZmqYEMM4b0d1vGC1ByWbfHdvA4kSA7CmQ4c/ggmPRD
         70Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1VcquGcUliPDZVaM/Fn7rmb+6W0/28WHDw0fGkhqmqQ=;
        b=TtN4QAfqwRkwbdwb6bfkBUR/ORsaij3NsVjp9q+hxzKfFNv6vV0YlUNVAawTgBPzDc
         RdqIxDaG0rd1OoNlVcWwucAi4zZZvhYzl8dSgrv4THhmQ7xcQ/Y3VhrbG5HUSgMerpN1
         gLTqeMks4PfHab1p3hup44DYf5IsSga7AY8NEKTp3MUZcr5lVk4CAjEVEosNO+FSLqIc
         7u2Srkt+ZAbMISVZKtZOAruK60gn9+i/HE5GqupVKH1OubZjuaZISTQ6FR4/YK9ehgXT
         8q/C8ePM49WSn4+MZx/sUURgze6TfoDthZJdqGLrDewWigLL7LTREITwXZgh3zYTUxdk
         DZIA==
X-Gm-Message-State: AOAM530bT0sE7cqEGFEhaeFLkHJi8/eQUKWcjCANSbZSySXzmgiJyo2b
        DspbtMsyExrMkwClWOhGH8KfVl9l+33x
X-Google-Smtp-Source: ABdhPJxfjHeVsRWiO2exMHmJj4Nxjo9oW+uVzIy0N9ikhTeQ7zcgKQq7gfDIAVQV2Ie/ffCVV5cUAD97jRLy
X-Received: by 2002:a25:7908:: with SMTP id u8mr871768ybc.144.1596060039051;
 Wed, 29 Jul 2020 15:00:39 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:00:34 -0700
Message-Id: <20200729220034.1337168-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2] perf bench: Add benchmark of find_next_bit
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
index 000000000000..fa90f3e9d368
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
+#if (defined(__i386__) || defined(__x86_64__)) && defined(__GCC_ASM_FLAG_OUTPUTS__)
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
2.28.0.163.g6104cc2f0b6-goog

