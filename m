Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3662C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC8207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140191;
	bh=0N5NwWug7ytyvaRU9+WeyUDqKc7pPB9S0AHwn8vM78s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=of3EvyrUvz55KKD8m2ZO0SMilnUIZGyWWe+mpjJuCFd34jY/9JvgOq8krSeUegCbJ
	 8X2D7vn8dDnZhzZePsfrsM4wUpoEYTY/IKgjcFvGadTeXB0J5ZTG8ExItp47TzFg2t
	 exE2OItgAEixAz4iDVOqfBANS+3vMbbjsmVltd7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCYMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgCYMnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:43:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEF82078E;
        Wed, 25 Mar 2020 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140185;
        bh=0N5NwWug7ytyvaRU9+WeyUDqKc7pPB9S0AHwn8vM78s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbTzZIHJSrzcmY4echpHJ6lOm2hBQ4pHuU0WPsO3W17n7nsUssGEsODVIU1eY0eYE
         tFllda+tZJHqN7jvjo3MMX65KuZjD05BP5p1lx2gC7xxwcPl3yrmhuOo7Uc7gXeAal
         Mmrrxh1Gjq6c8/81T0ErVkhTyNsVJ08sMWLqsuuI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com
Subject: [PATCH 22/24] perf test: Test pmu-events aliases
Date:   Wed, 25 Mar 2020 09:41:22 -0300
Message-Id: <20200325124124.32648-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

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
 tools/perf/tests/pmu-events.c | 148 +++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 12fc29746a09..d64261da8bf7 100644
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
-- 
2.21.1

