Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5FF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778855;
	bh=a3OTCDv00SmTgNXoEnE0LION6/b25IMWv2cDonKdNqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4qvofjjXx8qznpJRIz4D1HlEDwOHeTdlQXtKhaX417H++SpoW59lUrPXJG9bfRBy
	 1J+Znb2rg1MEo673qwX2AcrgpNZegjrNeIcZDn3Ng5S3LqcRXi0im64A0we7NBOy4A
	 rx3ppju1jCSCiRcN4lYcjE4d956eg58MCKLoAmig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgEFP1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbgEFP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D7721655;
        Wed,  6 May 2020 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778850;
        bh=a3OTCDv00SmTgNXoEnE0LION6/b25IMWv2cDonKdNqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igkY5c/hP/kBfxOpHj/Ex/bA/zRA+ck7M9KS0d1km76uCdXvlNbC+ofkjUfBDt5EX
         YhfqptbJd5/1YKMgKXNLmsoR4p3N4vprTORHbIcjFNaogX6SAc9mklD1qsywO3Wfas
         6XjNaVlElsdbAbAisniROaD3zFLfQbY5my+9+4rs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 87/91] perf bench: Add kallsyms parsing
Date:   Wed,  6 May 2020 12:22:30 -0300
Message-Id: <20200506152234.21977-88-acme@kernel.org>
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

Add a benchmark for kallsyms parsing. Example output:

  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 103.971 ms (+- 0.121 ms)

Committer testing:

Test Machine: AMD Ryzen 5 3600X 6-Core Processor

  [root@five ~]# perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 79.692 ms (+- 0.101 ms)
  [root@five ~]# perf stat -r5 perf bench internals kallsyms-parse
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.563 ms (+- 0.079 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.046 ms (+- 0.155 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 80.874 ms (+- 0.104 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.173 ms (+- 0.133 ms)
  # Running 'internals/kallsyms-parse' benchmark:
    Average kallsyms__parse took: 81.169 ms (+- 0.074 ms)

   Performance counter stats for 'perf bench internals kallsyms-parse' (5 runs):

            8,093.54 msec task-clock                #    0.999 CPUs utilized            ( +-  0.14% )
               3,165      context-switches          #    0.391 K/sec                    ( +-  0.18% )
                  10      cpu-migrations            #    0.001 K/sec                    ( +- 23.13% )
                 744      page-faults               #    0.092 K/sec                    ( +-  0.21% )
      34,551,564,954      cycles                    #    4.269 GHz                      ( +-  0.05% )  (83.33%)
       1,160,584,308      stalled-cycles-frontend   #    3.36% frontend cycles idle     ( +-  1.60% )  (83.33%)
      14,974,323,985      stalled-cycles-backend    #   43.34% backend cycles idle      ( +-  0.24% )  (83.33%)
      58,712,905,705      instructions              #    1.70  insn per cycle
                                                    #    0.26  stalled cycles per insn  ( +-  0.01% )  (83.34%)
      14,136,433,778      branches                  # 1746.632 M/sec                    ( +-  0.01% )  (83.33%)
         141,943,217      branch-misses             #    1.00% of all branches          ( +-  0.04% )  (83.33%)

              8.1040 +- 0.0115 seconds time elapsed  ( +-  0.14% )

  [root@five ~]#

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200501221315.54715-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.1

