Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75141C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9692177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5euxkJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHGHQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04470C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:16:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 128so478556pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kiY70R+BKEfwoAW0V1FII+/M7MMCmP3lqqZu7SLgWOw=;
        b=f5euxkJZ+36FSXvujuQLTTOS0WtRn/r7VxFnyx1O4UyOK/eoc+cYFI9wcKAWygCx4t
         4unjX/FQNvbAZ1Dm+U2NgRL9yxYjHkkW5pf0vcaSCX5WkPFo7n5/64axTqXZJk/A9y18
         sMu44egNg1G6cIMMjypLFgOw7wmWG8+TDVUsk6VP934w17sSAbwkGI0v9SxxHRh8S6PJ
         SBNjt6+SDgUSf/xOZdD1w1PCF8mpoZVoSfhS88ESYVbcCda+Hzl5zvKWEgVLP9jD5GCK
         bIT1WCUXq+IsxrvyB2Bd24fAifU+7iilXkFtEE2hBc/AakWcbgpdYsPMHXInMR8IoiEn
         llFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kiY70R+BKEfwoAW0V1FII+/M7MMCmP3lqqZu7SLgWOw=;
        b=sR0ntY1CQgBJzH/MZOZDGbIdNGWa8FLDWJ9wI1mghd0A9+gVwsCzMpDfLKy4MrXOEX
         hkovYOILVOzM9/Oa7IA9AJnW2NqPHyQWUnqKfopCCw8bAD/HSzZudXoU7NvhxejPRBOE
         ieV0n9mNI2UiyCQutotbpTWb5/t7AprdU3iAIwyAHHnSuTQ4s27u8mmAbkReH4+5P1Bf
         FnkV+UmTNSk/oQqNe7pI6sobysHn3E6Ncj6ke50yozpe2/uuXTLyvJ/Zi78+aD/JYi8I
         7naHFk+JL674ZppKLxEJRx/LHuH64c0JJud6rzyeuicOC3kZMDz9bJeGegwapAATjfko
         EvIg==
X-Gm-Message-State: AOAM5305v0NmBe0VTO9XkKrYL8kEDaih1O+Wx88UZeehEdLbhh5iAha/
        nGLZCAt5NbmJH31GQxwbxZtbKQ==
X-Google-Smtp-Source: ABdhPJyWV4/piQBHY88FkEZy2/oguF30nBvVUPGhRb5ia4tw8ISTk3B3HNLwhlz+5v8ZBb9vMrVaiw==
X-Received: by 2002:aa7:9357:: with SMTP id 23mr11951157pfn.278.1596784611431;
        Fri, 07 Aug 2020 00:16:51 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a19sm11434640pfn.10.2020.08.07.00.16.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 00:16:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] perf arm_arch_timer: Test conversion between counter and timestamp
Date:   Fri,  7 Aug 2020 15:16:19 +0800
Message-Id: <20200807071620.11907-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807071620.11907-1-leo.yan@linaro.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 arch has provides the testing for conversion between tsc and perf
time, this patch studies it and writes a similar testing for conversion
between arch timer's counter and sample's time.

The testing approach firstly creates three time points:

  Time point 1: 1st process's sample with perf time 'comm1_time';
  Time point 2: read out arch timer counter 'test_arch_timer_cnt';
  Time point 3: 2nd process's sample with perf time 'comm2_time';

The testing converts perf time to and from arch timer counter for these
three values and the testing can pass only if the counter values and
time values are in the order.

The test steps are as below:

  # perf test list
    [...]
    67: Convert perf time to arch timer counter

  # perf test 67 -v
    67: Convert perf time to arch timer counter
    --- start ---
    test child forked, pid 5463
    mmap size 528384B
    1st event perf time 2231755083020 arch timer cnt 113097053477
    test time           2231755087460 arch timer cnt 113097053699
    2nd event perf time 2231755090680 arch timer cnt 113097053860
    test child finished with 0
    ---- end ----

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/include/arch-tests.h    |   6 +
 tools/perf/arch/arm64/tests/Build             |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c      |   4 +
 .../tests/perf-time-to-arch-timer-counter.c   | 189 ++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..12ad7592c9aa 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,6 +2,12 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+#include <linux/compiler.h>
+
+/* Tests */
+int test__perf_time_to_arch_timer_cnt(struct test *test __maybe_unused,
+				      int subtest __maybe_unused);
+
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..1fd819e4f80f 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -2,3 +2,4 @@ perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
+perf-y += perf-time-to-arch-timer-counter.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..99d8ab865668 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -4,6 +4,10 @@
 #include "arch-tests.h"
 
 struct test arch_tests[] = {
+	{
+		.desc = "Convert perf time to arch timer counter",
+		.func = test__perf_time_to_arch_timer_cnt,
+	},
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	{
 		.desc = "DWARF unwind",
diff --git a/tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c b/tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
new file mode 100644
index 000000000000..09b9f43b48a4
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/perf-time-to-arch-timer-counter.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/types.h>
+#include <sys/prctl.h>
+#include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/mmap.h>
+
+#include "arm_arch_timer.h"
+#include "debug.h"
+#include "parse-events.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "thread_map.h"
+#include "record.h"
+#include "util/mmap.h"
+#include "tests/tests.h"
+
+#include "arch-tests.h"
+
+#define CHECK_NOT_LESS_ZERO(x) {		\
+	while ((x) < 0) {			\
+		pr_debug(#x " failed!\n");	\
+		goto out_err;			\
+	}					\
+}
+
+#define CHECK_NOT_NULL(x) {			\
+	while ((x) == NULL) {			\
+		pr_debug(#x " failed!\n");	\
+		goto out_err;			\
+	}					\
+}
+
+/*
+ * The arch timer's offset is set to zero, the virtual counter and physical
+ * counter should have the same value; so the user space program can read out
+ * counter with system register cntvct_el0 and it can be used to compare with
+ * kernel's counter.
+ */
+#define read_cntvct_el0(r) ({					\
+	u64 __val;						\
+	asm volatile("mrs %0, cntvct_el0" : "=r" (__val));	\
+	__val;							\
+})
+
+/**
+ * test__perf_time_to_arch_timer_cnt - test converting perf time to Arm arch
+ * timer counter.
+ *
+ * This function implements a test that checks that the conversion of perf time
+ * to and from Arm arch timer counter is consistent with the order of events.
+ * Returns 0 if the test passes, otherwise returns -1.  If TSC conversion is not
+ * supported then then the test passes but " (not supported)" is printed.
+ */
+int test__perf_time_to_arch_timer_cnt(struct test *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	struct record_opts opts = {
+		.mmap_pages	     = UINT_MAX,
+		.user_freq	     = UINT_MAX,
+		.user_interval	     = ULLONG_MAX,
+		.target		     = {
+			.uses_mmap   = true,
+		},
+		.sample_time	     = true,
+	};
+	struct perf_thread_map *threads = NULL;
+	struct perf_cpu_map *cpus = NULL;
+	struct evlist *evlist = NULL;
+	struct evsel *evsel = NULL;
+	int err = -1, ret, i;
+	const char *comm1, *comm2;
+	struct perf_arch_timer_conversion tc;
+	struct perf_event_mmap_page *pc;
+	union perf_event *event;
+	u64 test_arch_timer_cnt;
+	u64 comm1_arch_timer_cnt;
+	u64 comm2_arch_timer_cnt;
+	u64 test_time, comm1_time = 0, comm2_time = 0;
+	struct mmap *md;
+
+	threads = thread_map__new(-1, getpid(), UINT_MAX);
+	CHECK_NOT_NULL(threads);
+
+	cpus = perf_cpu_map__new(NULL);
+	CHECK_NOT_NULL(cpus);
+
+	evlist = evlist__new();
+	CHECK_NOT_NULL(evlist);
+
+	perf_evlist__set_maps(&evlist->core, cpus, threads);
+
+	CHECK_NOT_LESS_ZERO(parse_events(evlist, "cycles:u", NULL));
+
+	perf_evlist__config(evlist, &opts, NULL);
+
+	evsel = evlist__first(evlist);
+
+	evsel->core.attr.comm = 1;
+	evsel->core.attr.disabled = 1;
+	evsel->core.attr.enable_on_exec = 0;
+
+	CHECK_NOT_LESS_ZERO(evlist__open(evlist));
+
+	CHECK_NOT_LESS_ZERO(evlist__mmap(evlist, UINT_MAX));
+
+	pc = evlist->mmap[0].core.base;
+	ret = perf_read_arch_timer_conversion(pc, &tc);
+	if (ret) {
+		if (ret == -EOPNOTSUPP) {
+			fprintf(stderr, " (not supported)");
+			return 0;
+		}
+		goto out_err;
+	}
+
+	evlist__enable(evlist);
+
+	comm1 = "Test COMM 1";
+	CHECK_NOT_LESS_ZERO(prctl(PR_SET_NAME, (unsigned long)comm1, 0, 0, 0));
+
+	test_arch_timer_cnt = read_cntvct_el0();
+
+	comm2 = "Test COMM 2";
+	CHECK_NOT_LESS_ZERO(prctl(PR_SET_NAME, (unsigned long)comm2, 0, 0, 0));
+
+	evlist__disable(evlist);
+
+	for (i = 0; i < evlist->core.nr_mmaps; i++) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(&md->core) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
+			struct perf_sample sample;
+
+			if (event->header.type != PERF_RECORD_COMM ||
+			    (pid_t)event->comm.pid != getpid() ||
+			    (pid_t)event->comm.tid != getpid())
+				goto next_event;
+
+			if (strcmp(event->comm.comm, comm1) == 0) {
+				CHECK_NOT_LESS_ZERO(evsel__parse_sample(evsel, event, &sample));
+				comm1_time = sample.time;
+			}
+			if (strcmp(event->comm.comm, comm2) == 0) {
+				CHECK_NOT_LESS_ZERO(evsel__parse_sample(evsel, event, &sample));
+				comm2_time = sample.time;
+			}
+next_event:
+			perf_mmap__consume(&md->core);
+		}
+		perf_mmap__read_done(&md->core);
+	}
+
+	if (!comm1_time || !comm2_time)
+		goto out_err;
+
+	test_time = arch_timer_cyc_to_perf_time(test_arch_timer_cnt, &tc);
+	comm1_arch_timer_cnt = perf_time_to_arch_timer_cyc(comm1_time, &tc);
+	comm2_arch_timer_cnt = perf_time_to_arch_timer_cyc(comm2_time, &tc);
+
+	pr_debug("1st event perf time %"PRIu64" arch timer cnt %"PRIu64"\n",
+		 comm1_time, comm1_arch_timer_cnt);
+	pr_debug("test time           %"PRIu64" arch timer cnt %"PRIu64"\n",
+		 test_time, test_arch_timer_cnt);
+	pr_debug("2nd event perf time %"PRIu64" arch timer cnt %"PRIu64"\n",
+		 comm2_time, comm2_arch_timer_cnt);
+
+	if (test_time <= comm1_time ||
+	    test_time >= comm2_time)
+		goto out_err;
+
+	if (test_arch_timer_cnt <= comm1_arch_timer_cnt ||
+	    test_arch_timer_cnt >= comm2_arch_timer_cnt)
+		goto out_err;
+
+	err = 0;
+
+out_err:
+	evlist__delete(evlist);
+	return err;
+}
-- 
2.17.1

