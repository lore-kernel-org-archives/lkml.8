Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98707C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720AB206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgCQLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:06:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbgCQLGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 886B848C4EC93EA50C0B;
        Tue, 17 Mar 2020 19:06:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 19:06:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/7] perf test: Add pmu-events test
Date:   Tue, 17 Mar 2020 19:02:16 +0800
Message-ID: <1584442939-8911-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pmu-events test.

The initial test will verify that the test tables in generated pmu-events.c
match against known, expected values.

For known events added in pmu-events/arch/test, we need to add an entry
in test_cpu_aliases_events[] or test_uncore_events[].

A sample run is as follows for x86:

john@linux-3c19:~/linux> tools/perf/perf test -vv 10
10: PMU event aliases                                     :
--- start ---
test child forked, pid 5316
testing event table bp_l1_btb_correct: pass
testing event table bp_l2_btb_correct: pass
testing event table segment_reg_loads.any: pass
testing event table dispatch_blocked.any: pass
testing event table eist_trans: pass
testing event table uncore_hisi_ddrc.flux_wcmd: pass
testing event table unc_cbo_xsnp_response.miss_eviction: pass
test child finished with 0
---- end ----
PMU event aliases: Ok

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/pmu-events.c   | 227 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 233 insertions(+)
 create mode 100644 tools/perf/tests/pmu-events.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1692529639b0..b3d1bf13ca07 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -14,6 +14,7 @@ perf-y += evsel-roundtrip-name.o
 perf-y += evsel-tp-sched.o
 perf-y += fdarray.o
 perf-y += pmu.o
+perf-y += pmu-events.o
 perf-y += hists_common.o
 perf-y += hists_link.o
 perf-y += hists_filter.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5f05db75cdd8..5921af647c4a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,10 @@ static struct test generic_tests[] = {
 		.func = test__pmu,
 	},
 	{
+		.desc = "PMU events",
+		.func = test__pmu_events,
+	},
+	{
 		.desc = "DSO data read",
 		.func = test__dso_data,
 	},
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
new file mode 100644
index 000000000000..19a30807c880
--- /dev/null
+++ b/tools/perf/tests/pmu-events.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "parse-events.h"
+#include "pmu.h"
+#include "tests.h"
+#include <errno.h>
+#include <stdio.h>
+#include <linux/kernel.h>
+
+#include "debug.h"
+#include "../pmu-events/pmu-events.h"
+
+struct perf_pmu_test_event {
+	struct pmu_event event;
+};
+static struct perf_pmu_test_event test_cpu_events[] = {
+	{
+		.event = {
+			.name = "bp_l1_btb_correct",
+			.event = "event=0x8a",
+			.desc = "L1 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "bp_l2_btb_correct",
+			.event = "event=0x8b",
+			.desc = "L2 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "segment_reg_loads.any",
+			.event = "umask=0x80,period=200000,event=0x6",
+			.desc = "Number of segment register loads",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "dispatch_blocked.any",
+			.event = "umask=0x20,period=200000,event=0x9",
+			.desc = "Memory cluster signals to block micro-op dispatch for any reason",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "eist_trans",
+			.event = "umask=0x0,period=200000,event=0x3a",
+			.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+			.topic = "other",
+		},
+	},
+	{ /* sentinel */
+	}
+};
+
+static struct perf_pmu_test_event test_uncore_events[] = {
+	{
+		.event = {
+			.name = "uncore_hisi_ddrc.flux_wcmd",
+			.event = "event=0x2",
+			.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
+			.topic = "uncore",
+			.long_desc = "DDRC write commands",
+			.pmu = "hisi_sccl,ddrc",
+		},
+	},
+	{
+		.event = {
+			.name = "unc_cbo_xsnp_response.miss_eviction",
+			.event = "umask=0x81,event=0x22",
+			.desc = "Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.topic = "uncore",
+			.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.pmu = "uncore_cbox",
+		},
+	},
+	{ /* sentinel */
+	}
+};
+
+const int total_test_events_size = ARRAY_SIZE(test_uncore_events);
+
+static bool is_same(const char *reference, const char *test)
+{
+	if (!reference && !test)
+		return true;
+
+	if (reference && !test)
+		return false;
+
+	if (!reference && test)
+		return false;
+
+	return !strcmp(reference, test);
+}
+
+static struct pmu_events_map *__test_pmu_get_events_map(void)
+{
+	struct pmu_events_map *map;
+
+	for (map = &pmu_events_map[0]; map->cpuid; map++) {
+		if (!strcmp(map->cpuid, "testcpu"))
+			return map;
+	}
+
+	pr_err("could not find test events map\n");
+
+	return NULL;
+}
+
+/* Verify generated events from pmu-events.c is as expected */
+static int __test_pmu_event_table(void)
+{
+	struct pmu_events_map *map = __test_pmu_get_events_map();
+	struct pmu_event *table;
+	int map_events = 0, expected_events;
+
+	/* ignore 2x sentinels */
+	expected_events = ARRAY_SIZE(test_cpu_events) +
+			  ARRAY_SIZE(test_uncore_events) - 2;
+
+	if (!map)
+		return -1;
+
+	for (table = map->table; table->name; table++) {
+		struct perf_pmu_test_event *test;
+		struct pmu_event *te;
+		bool found = false;
+
+		if (table->pmu)
+			test = &test_uncore_events[0];
+		else
+			test = &test_cpu_events[0];
+
+		te = &test->event;
+
+		for (; te->name; test++, te = &test->event) {
+			if (strcmp(table->name, te->name))
+				continue;
+			found = true;
+			map_events++;
+
+			if (!is_same(table->desc, te->desc)) {
+				pr_debug2("testing event table %s: mismatched desc, %s vs %s\n",
+					  table->name, table->desc, te->desc);
+				return -1;
+			}
+
+			if (!is_same(table->topic, te->topic)) {
+				pr_debug2("testing event table %s: mismatched topic, %s vs %s\n",
+					  table->name, table->topic,
+					  te->topic);
+				return -1;
+			}
+
+			if (!is_same(table->long_desc, te->long_desc)) {
+				pr_debug2("testing event table %s: mismatched long_desc, %s vs %s\n",
+					  table->name, table->long_desc,
+					  te->long_desc);
+				return -1;
+			}
+
+			if (!is_same(table->unit, te->unit)) {
+				pr_debug2("testing event table %s: mismatched unit, %s vs %s\n",
+					  table->name, table->unit,
+					  te->unit);
+				return -1;
+			}
+
+			if (!is_same(table->perpkg, te->perpkg)) {
+				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
+					  table->name, table->perpkg,
+					  te->perpkg);
+				return -1;
+			}
+
+			if (!is_same(table->metric_expr, te->metric_expr)) {
+				pr_debug2("testing event table %s: mismatched metric_expr, %s vs %s\n",
+					  table->name, table->metric_expr,
+					  te->metric_expr);
+				return -1;
+			}
+
+			if (!is_same(table->metric_name, te->metric_name)) {
+				pr_debug2("testing event table %s: mismatched metric_name, %s vs %s\n",
+					  table->name,  table->metric_name,
+					  te->metric_name);
+				return -1;
+			}
+
+			if (!is_same(table->deprecated, te->deprecated)) {
+				pr_debug2("testing event table %s: mismatched deprecated, %s vs %s\n",
+					  table->name, table->deprecated,
+					  te->deprecated);
+				return -1;
+			}
+
+			pr_debug("testing event table %s: pass\n", table->name);
+		}
+
+		if (!found) {
+			pr_err("testing event table: could not find event %s\n",
+			       table->name);
+			return -1;
+		}
+	}
+
+	if (map_events != expected_events) {
+		pr_err("testing event table: found %d, but expected %d\n",
+		       map_events, expected_events);
+		return -1;
+	}
+
+	return 0;
+}
+int test__pmu_events(struct test *test __maybe_unused,
+		     int subtest __maybe_unused)
+{
+	if (__test_pmu_event_table())
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a160fef47c9..61a1ab032080 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -49,6 +49,7 @@ int test__perf_evsel__roundtrip_name_test(struct test *test, int subtest);
 int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
+int test__pmu_events(struct test *test, int subtest);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
-- 
2.12.3

