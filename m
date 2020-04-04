Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485FC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FFA20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDDInq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgDDImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNK-00019E-Gc; Sat, 04 Apr 2020 10:41:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CF871C07F8;
        Sat,  4 Apr 2020 10:41:54 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:53 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf test: Test pmu-events aliases
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-8-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-8-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971391.28353.7791332872130759227.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     956a78356c24c1ac3becf854135dc065b6b74265
Gitweb:        https://git.kernel.org/tip/956a78356c24c1ac3becf854135dc065b6b74265
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:19 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:36:00 -03:00

perf test: Test pmu-events aliases

Add creating event aliases to the pmu-events test.

So currently we verify that the generated pmu-events.c is as expected for
some test events. Now test that we generate aliases as expected for those
events during normal operation.

For that, we cycle through each HW PMU in the system, and use the test
events to create aliases, and verify those against known, expected values.

For core PMUs, we should create an alias for every event in
test_cpu_events[].

However, for uncore PMUs, they need to be matched by the pmu_event.pmu
member, so use test_uncore_events[]; so check the match beforehand with
pmu_uncore_alias_match().

A sample run is as follows for my x86 machine:

  john@linux-3c19:~/linux> tools/perf/perf test -vv 10
  10: PMU events                                            :
  --- start ---

  ...

  testing PMU uncore_arb aliases: no events to match
  testing PMU cstate_pkg aliases: no events to match
  skipping testing PMU breakpoint
  testing aliases PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
  testing PMU uncore_cbox_1 aliases: pass
  testing PMU power aliases: no events to match
  testing aliases PMU cpu: matched event bp_l1_btb_correct
  testing aliases PMU cpu: matched event bp_l2_btb_correct
  testing aliases PMU cpu: matched event segment_reg_loads.any
  testing aliases PMU cpu: matched event dispatch_blocked.any
  testing aliases PMU cpu: matched event eist_trans
  testing PMU cpu aliases: pass
  testing PMU intel_pt aliases: no events to match
  skipping testing PMU software
  skipping testing PMU intel_bts
  testing PMU uncore_imc aliases: no events to match
  testing aliases PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
  testing PMU uncore_cbox_0 aliases: pass
  testing PMU cstate_core aliases: no events to match
  skipping testing PMU tracepoint
  testing PMU msr aliases: no events to match
  test child finished with 0

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-8-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/pmu-events.c | 148 ++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 12fc297..d64261d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -5,13 +5,24 @@
 #include <errno.h>
 #include <stdio.h>
 #include <linux/kernel.h>
-
+#include <linux/zalloc.h>
 #include "debug.h"
 #include "../pmu-events/pmu-events.h"
 
 struct perf_pmu_test_event {
 	struct pmu_event event;
+
+	/* extra events for aliases */
+	const char *alias_str;
+
+	/*
+	 * Note: For when PublicDescription does not exist in the JSON, we
+	 * will have no long_desc in pmu_event.long_desc, but long_desc may
+	 * be set in the alias.
+	 */
+	const char *alias_long_desc;
 };
+
 static struct perf_pmu_test_event test_cpu_events[] = {
 	{
 		.event = {
@@ -20,6 +31,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 			.desc = "L1 BTB Correction",
 			.topic = "branch",
 		},
+		.alias_str = "event=0x8a",
+		.alias_long_desc = "L1 BTB Correction",
 	},
 	{
 		.event = {
@@ -28,6 +41,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 			.desc = "L2 BTB Correction",
 			.topic = "branch",
 		},
+		.alias_str = "event=0x8b",
+		.alias_long_desc = "L2 BTB Correction",
 	},
 	{
 		.event = {
@@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 			.desc = "Number of segment register loads",
 			.topic = "other",
 		},
+		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
+		.alias_long_desc = "Number of segment register loads",
 	},
 	{
 		.event = {
@@ -44,6 +61,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 			.desc = "Memory cluster signals to block micro-op dispatch for any reason",
 			.topic = "other",
 		},
+		.alias_str = "umask=0x20,(null)=0x30d40,event=0x9",
+		.alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
 	},
 	{
 		.event = {
@@ -52,6 +71,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
 			.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 			.topic = "other",
 		},
+		.alias_str = "umask=0,(null)=0x30d40,event=0x3a",
+		.alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
 	},
 	{ /* sentinel */
 		.event = {
@@ -70,6 +91,8 @@ static struct perf_pmu_test_event test_uncore_events[] = {
 			.long_desc = "DDRC write commands",
 			.pmu = "hisi_sccl,ddrc",
 		},
+		.alias_str = "event=0x2",
+		.alias_long_desc = "DDRC write commands",
 	},
 	{
 		.event = {
@@ -80,6 +103,8 @@ static struct perf_pmu_test_event test_uncore_events[] = {
 			.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 			.pmu = "uncore_cbox",
 		},
+		.alias_str = "umask=0x81,event=0x22",
+		.alias_long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 	},
 	{ /* sentinel */
 		.event = {
@@ -223,11 +248,132 @@ static int __test_pmu_event_table(void)
 
 	return 0;
 }
+
+static struct perf_pmu_alias *find_alias(const char *test_event, struct list_head *aliases)
+{
+	struct perf_pmu_alias *alias;
+
+	list_for_each_entry(alias, aliases, list)
+		if (!strcmp(test_event, alias->name))
+			return alias;
+
+	return NULL;
+}
+
+/* Verify aliases are as expected */
+static int __test__pmu_event_aliases(char *pmu_name, int *count)
+{
+	struct perf_pmu_test_event *test;
+	struct pmu_event *te;
+	struct perf_pmu *pmu;
+	LIST_HEAD(aliases);
+	int res = 0;
+	bool use_uncore_table;
+	struct pmu_events_map *map = __test_pmu_get_events_map();
+
+	if (!map)
+		return -1;
+
+	if (is_pmu_core(pmu_name)) {
+		test = &test_cpu_events[0];
+		use_uncore_table = false;
+	} else {
+		test = &test_uncore_events[0];
+		use_uncore_table = true;
+	}
+
+	pmu = zalloc(sizeof(*pmu));
+	if (!pmu)
+		return -1;
+
+	pmu->name = pmu_name;
+
+	pmu_add_cpu_aliases_map(&aliases, pmu, map);
+
+	for (te = &test->event; te->name; test++, te = &test->event) {
+		struct perf_pmu_alias *alias = find_alias(te->name, &aliases);
+
+		if (!alias) {
+			bool uncore_match = pmu_uncore_alias_match(pmu_name,
+								   te->pmu);
+
+			if (use_uncore_table && !uncore_match) {
+				pr_debug3("testing aliases PMU %s: skip matching alias %s\n",
+					  pmu_name, te->name);
+				continue;
+			}
+
+			pr_debug2("testing aliases PMU %s: no alias, alias_table->name=%s\n",
+				  pmu_name, te->name);
+			res = -1;
+			break;
+		}
+
+		if (!is_same(alias->desc, te->desc)) {
+			pr_debug2("testing aliases PMU %s: mismatched desc, %s vs %s\n",
+				  pmu_name, alias->desc, te->desc);
+			res = -1;
+			break;
+		}
+
+		if (!is_same(alias->long_desc, test->alias_long_desc)) {
+			pr_debug2("testing aliases PMU %s: mismatched long_desc, %s vs %s\n",
+				  pmu_name, alias->long_desc,
+				  test->alias_long_desc);
+			res = -1;
+			break;
+		}
+
+		if (!is_same(alias->str, test->alias_str)) {
+			pr_debug2("testing aliases PMU %s: mismatched str, %s vs %s\n",
+				  pmu_name, alias->str, test->alias_str);
+			res = -1;
+			break;
+		}
+
+		if (!is_same(alias->topic, te->topic)) {
+			pr_debug2("testing aliases PMU %s: mismatched topic, %s vs %s\n",
+				  pmu_name, alias->topic, te->topic);
+			res = -1;
+			break;
+		}
+
+		(*count)++;
+		pr_debug2("testing aliases PMU %s: matched event %s\n",
+			  pmu_name, alias->name);
+	}
+
+	free(pmu);
+	return res;
+}
+
 int test__pmu_events(struct test *test __maybe_unused,
 		     int subtest __maybe_unused)
 {
+	struct perf_pmu *pmu = NULL;
+
 	if (__test_pmu_event_table())
 		return -1;
 
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		int count = 0;
+
+		if (list_empty(&pmu->format)) {
+			pr_debug2("skipping testing PMU %s\n", pmu->name);
+			continue;
+		}
+
+		if (__test__pmu_event_aliases(pmu->name, &count)) {
+			pr_debug("testing PMU %s aliases: failed\n", pmu->name);
+			return -1;
+		}
+
+		if (count == 0)
+			pr_debug3("testing PMU %s aliases: no events to match\n",
+				  pmu->name);
+		else
+			pr_debug("testing PMU %s aliases: pass\n", pmu->name);
+	}
+
 	return 0;
 }
