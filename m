Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E03C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C85208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCELMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:12:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbgCELMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:33 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 75239EA63A111208039D;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 6/6] perf test: Add pmu-events test
Date:   Thu, 5 Mar 2020 19:08:06 +0800
Message-ID: <1583406486-154841-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pmu-events test.

This test will scan all PMUs in the system, and run a PMU event aliasing
test for each CPU or uncore PMU.

For known aliases added in pmu-events/arch/test, we need to add an entry
in test_cpu_aliases[] or test_uncore_aliases[].

A sample run is as follows for x86:

Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
10: PMU event aliases                                     :
--- start ---
test child forked, pid 30869
Using CPUID GenuineIntel-6-9E-9
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
skipping testing PMU software
testing PMU power: skip
testing PMU cpu: matched event segment_reg_loads.any
testing PMU cpu: matched event dispatch_blocked.any
testing PMU cpu: matched event eist_trans
testing PMU cpu: matched event bp_l1_btb_correct
testing PMU cpu: matched event bp_l2_btb_correct
testing PMU cpu: pass
testing PMU cstate_core: skip
testing PMU uncore_cbox_2: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_2: pass
skipping testing PMU breakpoint
testing PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_0: pass
skipping testing PMU tracepoint
testing PMU cstate_pkg: skip
testing PMU uncore_arb: skip
testing PMU msr: skip
testing PMU uncore_cbox_3: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_3: pass
testing PMU intel_pt: skip
testing PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_1: pass
test child finished with 0
---- end ----
PMU event aliases: Ok


Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/pmu-events.c   | 192 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 198 insertions(+)
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
index 5f05db75cdd8..e8f56740d14a 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -72,6 +72,10 @@ static struct test generic_tests[] = {
 		.desc = "Parse perf pmu format",
 		.func = test__pmu,
 	},
+	{
+		.desc = "PMU event aliases",
+		.func = test__pmu_event_aliases,
+	},
 	{
 		.desc = "DSO data read",
 		.func = test__dso_data,
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
new file mode 100644
index 000000000000..176b80666b5e
--- /dev/null
+++ b/tools/perf/tests/pmu-events.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "parse-events.h"
+#include "pmu.h"
+#include "tests.h"
+#include <errno.h>
+#include <stdio.h>
+#include <linux/kernel.h>
+
+#include <linux/zalloc.h>
+
+#include "debug.h"
+#include "../pmu-events/pmu-events.h"
+
+static struct perf_pmu_alias test_cpu_aliases[] = {
+	{
+		.name = (char *)"segment_reg_loads.any",
+		.str = (char *)"umask=0x80,(null)=0x30d40,event=0x6",
+		.desc = (char *)"Number of segment register loads",
+		.topic = (char *)"other",
+
+	},
+	{
+		.name = (char *)"dispatch_blocked.any",
+		.str = (char *)"umask=0x20,(null)=0x30d40,event=0x9",
+		.desc = (char *)"Memory cluster signals to block micro-op dispatch for any reason",
+		.topic = (char *)"other",
+
+	},
+	{
+		.name = (char *)"eist_trans",
+		.str = (char *)"umask=0,(null)=0x30d40,event=0x3a",
+		.desc = (char *)"Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+		.topic = (char *)"other",
+
+	},
+	{
+		.name = (char *)"bp_l1_btb_correct",
+		.str = (char *)"event=0x8a",
+		.desc = (char *)"L1 BTB Correction",
+		.topic = (char *)"branch",
+
+	},
+	{
+		.name = (char *)"bp_l2_btb_correct",
+		.str = (char *)"event=0x8b",
+		.desc = (char *)"L2 BTB Correction",
+		.topic = (char *)"branch",
+
+	},
+	{ /* sentinel */
+	}
+};
+
+static struct perf_pmu_alias test_uncore_aliases[] = {
+	{
+		.name = (char *)"uncore_hisi_ddrc.flux_wcmd",
+		.str = (char *)"event=0x2",
+		.desc = (char *)"DDRC write commands. Unit: hisi_sccl,ddrc ",
+		.topic = (char *)"uncore",
+
+	},
+	{
+		.name = (char *)"unc_cbo_xsnp_response.miss_eviction",
+		.str = (char *)"umask=0x81,event=0x22",
+		.desc = (char *)"Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.long_desc = (char *)"A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.topic = (char *)"uncore",
+
+	},
+	{ /* sentinel */
+	}
+
+};
+
+static bool is_same(char *reference, char *test)
+{
+	if (!test)
+		return false;
+
+	return !strcmp(reference, test);
+}
+
+static struct perf_pmu_alias *find_alias(char *pmu_name, char *alias_name)
+{
+	struct perf_pmu_alias *alias;
+
+	if (is_pmu_core(pmu_name))
+		alias = &test_cpu_aliases[0];
+	else
+		alias = &test_uncore_aliases[0];
+
+	for (; alias->name; alias++)
+		if (!strcmp(alias_name, alias->name))
+			return alias;
+
+	return NULL;
+}
+
+static int __test__pmu_event_aliases(char *pmu_name, int *count)
+{
+	struct perf_pmu_alias *alias;
+	struct perf_pmu *pmu;
+	LIST_HEAD(aliases);
+	int res = 0;
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return -1;
+
+	pmu->name = pmu_name;
+
+	pmu_add_cpu_aliases_map(&aliases, pmu, &pmu_events_map_test);
+
+	list_for_each_entry(alias, &aliases, list) {
+		struct perf_pmu_alias *test_alias;
+
+		test_alias = find_alias(pmu_name, alias->name);
+
+		if (!test_alias) {
+			pr_debug2("no alias for PMU %s\n", pmu_name);
+			res = -1;
+			break;
+		}
+
+		if (test_alias->desc &&
+		    !is_same(test_alias->desc, alias->desc)) {
+			pr_debug2("mismatched desc for PMU %s, %s vs %s\n",
+				  pmu_name, test_alias->desc, alias->desc);
+			res = -1;
+			break;
+		}
+
+		if (test_alias->long_desc &&
+		    !is_same(test_alias->long_desc, alias->long_desc)) {
+			pr_debug2("mismatched long_desc for PMU %s, %s vs %s\n",
+				  pmu_name, test_alias->long_desc,
+				  alias->long_desc);
+			res = -1;
+			break;
+		}
+
+		if (test_alias->str && !is_same(test_alias->str, alias->str)) {
+			pr_debug2("mismatched str for PMU %s, %s vs %s\n",
+				  pmu_name, test_alias->str, alias->str);
+			res = -1;
+			break;
+		}
+
+		if (test_alias->topic &&
+		    !is_same(test_alias->topic, alias->topic)) {
+			pr_debug2("mismatched topic for PMU %s, %s vs %s\n",
+				  pmu_name, test_alias->topic, alias->topic);
+			res = -1;
+			break;
+		}
+
+		(*count)++;
+
+		pr_debug2("testing PMU %s: matched event %s\n",
+			  pmu_name, test_alias->name);
+	}
+
+	free(pmu);
+	return res;
+}
+
+int test__pmu_event_aliases(struct test *test __maybe_unused,
+			    int subtest __maybe_unused)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		int count = 0;
+
+		if (list_empty(&pmu->format)) {
+			pr_debug2("skipping testing PMU %s\n", pmu->name);
+			continue;
+		}
+
+		if (__test__pmu_event_aliases(pmu->name, &count)) {
+			pr_debug("testing PMU %s: failed\n", pmu->name);
+			return -1;
+		}
+
+		if (count == 0)
+			pr_debug("testing PMU %s: skip\n", pmu->name);
+		else
+			pr_debug("testing PMU %s: pass\n", pmu->name);
+	}
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a160fef47c9..a7ca3bb1c9cd 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -49,6 +49,7 @@ int test__perf_evsel__roundtrip_name_test(struct test *test, int subtest);
 int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
+int test__pmu_event_aliases(struct test *test, int subtest);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
-- 
2.17.1

