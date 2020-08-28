Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F3C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297AB2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648221;
	bh=/yc2hh8Xn/qoaJO3eNr/zbny9N9YvXq8VczRmxSvWQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaD7GYIdFq1PwWHj5X+rzyfEPTnrBZYhbQLVbVjeDq1843KS0AkRt4SAmkZR++cqD
	 krnkDUN89i+VO7/5Rxpw8aJ4nvQhpHsuU+pMuOyEpK5+rwHc1lhUZ/AnkgJ55h9ybq
	 WEdx00LjR8/OXDCbMoeMJUoyt0ATFIWfyyEGP5bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgH1U47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35479 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgH1U4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:35 -0400
Received: by mail-io1-f66.google.com with SMTP id l8so430035ios.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPZFL/7y5I5kGHvP0roH88e8RweLKgu5ardwJtO3aSo=;
        b=sd5318ycZzGlG+ubUFfylARy0onRlXpl+UwFoQk5PYRZKEO6H2c4Zt7UkmbKC2ziMT
         vPaBka+4RKAKUAl06MwsFDH9bcAMzyfwu6e0hN/hXmxJSk0sm20G1TIf1lsi51R60c0v
         X3C1zz89I7/78E33eKYVtMVXFYbd+1tCTvEC+94lJExWvg6VcvMmQtvIL3nmRVnxRTIE
         Bq1P4pmkgnxa774kAxzFW5jnC9BHO59zQj6eOK7MIQZ6286xIFvz1XxmNmyFdrbdh3X0
         UYV0VG0AZfRCpTV19KgAqIrjEQGwkM5hdWA+8FjuJmx5FeMZrAeWrSEa2n6dwQHkJ0y5
         AmnQ==
X-Gm-Message-State: AOAM532SR4kL2usnmJxpgNfg7iAczLURdztm7r4jgfxV8xjtxLBamX3y
        0AZnvh74wMwr0neHFPqgKw==
X-Google-Smtp-Source: ABdhPJz4BrUvhhR2nCTy7A7vh4dXNXBh0LIgv2zqFnmr0FGkRD5e6QU3M9y+pZuD5awCtYMiHkG8sQ==
X-Received: by 2002:a6b:37c5:: with SMTP id e188mr503083ioa.110.1598648194010;
        Fri, 28 Aug 2020 13:56:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 7/9] perf: arm64: Add test for userspace counter access on heterogeneous systems
Date:   Fri, 28 Aug 2020 14:56:12 -0600
Message-Id: <20200828205614.3391252-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace counter access only works on heterogeneous systems with some
restrictions. The userspace process must be pinned to a homogeneous
subset of CPUs and must open the corresponding PMU for those CPUs. This
commit adds a test implementing these requirements.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Drop all but heterogeneous test as others covered by libperf tests
- Rework to use libperf
---
 tools/perf/arch/arm64/include/arch-tests.h |   7 +
 tools/perf/arch/arm64/tests/Build          |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
 tools/perf/arch/arm64/tests/user-events.c  | 170 +++++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..380ad34a3f09 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,11 +2,18 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+#include <linux/compiler.h>
+
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread);
 #endif
 
 extern struct test arch_tests[];
+int test__rd_pinned(struct test __maybe_unused *test,
+		       int __maybe_unused subtest);
+
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..3f9a20c17fc6 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,5 @@
 perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
+perf-y += user-events.o
 perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..80ce7bd3c16d 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Pinned CPU user counter access",
+		.func = test__rd_pinned,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
new file mode 100644
index 000000000000..9cf30adf39d9
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/user-events.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <sched.h>
+#include <cpumap.h>
+
+#include <perf/core.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+
+#include "pmu.h"
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+static int run_test(struct perf_evsel *evsel)
+{
+	int n;
+	volatile int tmp = 0;
+	u64 delta, i, loops = 1000;
+	struct perf_counts_values counts = { .val = 0 };
+
+	for (n = 0; n < 6; n++) {
+		u64 stamp, now;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		stamp = counts.val;
+
+		for (i = 0; i < loops; i++)
+			tmp++;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		now = counts.val;
+		loops *= 10;
+
+		delta = now - stamp;
+		pr_debug("%14d: %14llu\n", n, (long long)delta);
+
+		if (!delta)
+			break;
+	}
+	return delta ? 0 : -1;
+}
+
+static struct perf_pmu *pmu_for_cpu(int cpu)
+{
+	int acpu, idx;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_uncore)
+			continue;
+		perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
+			if (acpu == cpu)
+				return pmu;
+	}
+	return NULL;
+}
+
+static bool pmu_is_homogeneous(void)
+{
+	int core_cnt = 0;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
+			core_cnt++;
+	}
+	return core_cnt == 1;
+}
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	(void)level;
+	return vfprintf(stderr, fmt, ap);
+}
+
+static struct perf_evsel *perf_init(struct perf_event_attr *attr)
+{
+	int err;
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+
+	libperf_init(libperf_print);
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads) {
+		pr_err("failed to create threads\n");
+		return NULL;
+	}
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(attr);
+	if (!evsel) {
+		pr_err("failed to create evsel\n");
+		goto out_thread;
+	}
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	if (err) {
+		pr_err("failed to open evsel\n");
+		goto out_open;
+	}
+
+	if (!perf_evsel__mmap(evsel)) {
+		pr_err("failed to mmap evsel\n");
+		goto out_mmap;
+	}
+
+	return evsel;
+
+out_mmap:
+	perf_evsel__close(evsel);
+out_open:
+	perf_evsel__delete(evsel);
+out_thread:
+	perf_thread_map__put(threads);
+	return NULL;
+}
+
+int test__rd_pinned(struct test __maybe_unused *test,
+		    int __maybe_unused subtest)
+{
+	int cpu, cputmp, ret = -1;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.config = 0x8, /* Instruction count */
+		.config1 = 0, /* 32-bit counter */
+		.exclude_kernel = 1,
+	};
+	cpu_set_t cpu_set;
+	struct perf_pmu *pmu;
+
+	if (pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	cpu = sched_getcpu();
+	pmu = pmu_for_cpu(cpu);
+	if (!pmu)
+		return -1;
+	attr.type = pmu->type;
+
+	CPU_ZERO(&cpu_set);
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
+		CPU_SET(cpu, &cpu_set);
+	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+		pr_err("Could not set affinity\n");
+
+	evsel = perf_init(&attr);
+	if (!evsel)
+		return -1;
+
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
+		CPU_ZERO(&cpu_set);
+		CPU_SET(cpu, &cpu_set);
+		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+			pr_err("Could not set affinity\n");
+
+		pr_debug("Running on CPU %d\n", cpu);
+
+		ret = run_test(evsel);
+		if (ret)
+			break;
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+	return ret;
+}
-- 
2.25.1

