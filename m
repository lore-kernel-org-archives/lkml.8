Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9BC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B07214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXS2wZpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD3HwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgD3HwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e2so6671586ybm.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lytLiK1l2mCXDqSPmsYP0EW7fq3nVZKmt1GeJk6Y/kY=;
        b=kXS2wZpVywn0paGLUGpsReEua+fdaStRzrx/mnbiyZwog4vpkeRNA2LniayrHclGQl
         1nHm2PUNAfh4KMAR51N6ig/Y10wCq3wsTpK9Bl/07At5bK/rMNXNT+YEtsGzR61Rb6g0
         8IorBntDpOfD0D31eT++Ux2OBlfxGdNGA5fJIJRgyZFIOWVG9UHdCTuoKfnyNLPCCe+/
         zTqHbmH8SYNmoFN5zELWLJd9tra3Vt48N0wv9JK1jm7LsZozkRayUC5FRTv99srJrtOv
         11YWPk2ZJFRKmXkCB4Ujeo+/iMznmj75z6j6/LLAMT23tmhp1BQPq01d0PCtPdScXn6h
         q6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lytLiK1l2mCXDqSPmsYP0EW7fq3nVZKmt1GeJk6Y/kY=;
        b=Vr09l+fgDFVzJJQKSqoCR1TNsTrOecH1/wwhA7KlMybGR3FvhG+DR3I4fF8eDD8fUL
         VgnMJ2ZbXUMzWMDw6urwxvfBmAsbpjFFQR1x/va6pJ6n+xG7WiM+D0JBpPcv/9AUxUYN
         7kzUeIDyvS2dx5Q8Cu0cJw/RlYLaWVKhrLYcOuz8SNavTjBSKIKPd0oVPmV970iu+z7a
         fF7w2duhEdVVHfDR65Zs3r/e+L7YsLkMhdzbu/dpa8roN0WAHuq9F/5RowBntuYrJebQ
         NvmTfevV2xnuSECPFRnXxusAhlfyKGJ4lJYMSJw7iGKSyc6GCLAwG3/oQpXZQS+Wm/P0
         4F1w==
X-Gm-Message-State: AGi0PuZc6TqksvXNZ6IVkEJav906G+qF2DmoXFCJ1/n3PE2j3WZJpzsh
        yb70q60viw7wG/X+bOwyfK/DltLTl+K3
X-Google-Smtp-Source: APiQypL5B5ZPIVSBKv9aN00LRW3yg5nqRIuLl+UE5rdf6OZt4RFOkGMRD29XFss0QsIjo1dCAkR+PSUjqkZO
X-Received: by 2002:a5b:584:: with SMTP id l4mr3843638ybp.232.1588233129976;
 Thu, 30 Apr 2020 00:52:09 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:44 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-13-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 12/12] perf test: improve pmu event metric testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic floating point number test to expr.
Break pmu-events test into 2 and add a test to verify that all pmu metric
expressions simply parse. Try to parse all metric ids/events, failing if
metrics for the current architecture fail to parse.

Tested on skylakex with the patch set in place. May fail on other
architectures if metrics are invalid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |   5 +
 tools/perf/tests/expr.c         |   1 +
 tools/perf/tests/pmu-events.c   | 156 ++++++++++++++++++++++++++++++--
 tools/perf/tests/tests.h        |   2 +
 4 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b6322eb0f423..41acad17bd70 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -75,6 +75,11 @@ static struct test generic_tests[] = {
 	{
 		.desc = "PMU events",
 		.func = test__pmu_events,
+		.subtest = {
+			.get_nr		= test__pmu_events_subtest_get_nr,
+			.get_desc	= test__pmu_events_subtest_get_desc,
+		},
+
 	},
 	{
 		.desc = "DSO data read",
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index ea10fc4412c4..3f227115bf52 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -39,6 +39,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "min(1,2) + 1", 2);
 	ret |= test(&ctx, "max(1,2) + 1", 3);
 	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(&ctx, "1.1 + 2.1", 3.2);
 
 	if (ret)
 		return ret;
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index d64261da8bf7..8520060ef199 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -8,6 +8,10 @@
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "../pmu-events/pmu-events.h"
+#include "util/evlist.h"
+#include "util/expr.h"
+#include "util/parse-events.h"
+#include <ctype.h>
 
 struct perf_pmu_test_event {
 	struct pmu_event event;
@@ -144,7 +148,7 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
 }
 
 /* Verify generated events from pmu-events.c is as expected */
-static int __test_pmu_event_table(void)
+static int test_pmu_event_table(void)
 {
 	struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct pmu_event *table;
@@ -347,14 +351,11 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
 	return res;
 }
 
-int test__pmu_events(struct test *test __maybe_unused,
-		     int subtest __maybe_unused)
+
+static int test_aliases(void)
 {
 	struct perf_pmu *pmu = NULL;
 
-	if (__test_pmu_event_table())
-		return -1;
-
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		int count = 0;
 
@@ -377,3 +378,146 @@ int test__pmu_events(struct test *test __maybe_unused,
 
 	return 0;
 }
+
+static bool is_number(const char *str)
+{
+	size_t i;
+
+	for (i = 0; i < strlen(str); i++) {
+		if (!isdigit(str[i]) && str[i] != '.')
+			return false;
+	}
+	return true;
+}
+
+static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
+{
+	struct parse_events_error error;
+	struct evlist *evlist;
+	int ret;
+
+	/* Numbers are always valid. */
+	if (is_number(id))
+		return 0;
+
+	evlist = evlist__new();
+	memset(&error, 0, sizeof(error));
+	ret = parse_events(evlist, id, &error);
+	if (ret && same_cpu) {
+		pr_debug("Parse event failed: id '%s' metric '%s' expr '%s'\n",
+			id, pe->metric_name, pe->metric_expr);
+		pr_debug("Error string '%s' help '%s'\n",
+			error.str, error.help);
+	} else if (ret) {
+		pr_debug("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
+			id, pe->metric_name, pe->metric_expr);
+	}
+	evlist__delete(evlist);
+	free(error.str);
+	free(error.help);
+	free(error.first_str);
+	free(error.first_help);
+	return same_cpu ? ret : 0;
+}
+
+static int test_parsing(void)
+{
+	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
+	struct pmu_events_map *map;
+	struct pmu_event *pe;
+	int i, j, k;
+	const char **ids;
+	int idnum;
+	int ret = 0;
+	struct expr_parse_ctx ctx;
+	double result;
+
+	i = 0;
+	for (;;) {
+		map = &pmu_events_map[i++];
+		if (!map->table) {
+			map = NULL;
+			break;
+		}
+		j = 0;
+		for (;;) {
+			pe = &map->table[j++];
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+			if (!pe->metric_expr)
+				continue;
+			if (expr__find_other(pe->metric_expr, NULL,
+						&ids, &idnum) < 0) {
+				pr_debug("Parse other failed for map %s %s %s\n",
+					map->cpuid, map->version, map->type);
+				pr_debug("On metric %s\n", pe->metric_name);
+				pr_debug("On expression %s\n", pe->metric_expr);
+				ret++;
+				continue;
+			}
+			expr__ctx_init(&ctx);
+
+			/*
+			 * Add all ids with a made up value. The value may
+			 * trigger divide by zero when subtracted and so try to
+			 * make them unique.
+			 */
+			for (k = 0; k < idnum; k++)
+				expr__add_id(&ctx, ids[k], k + 1);
+
+			for (k = 0; k < idnum; k++) {
+				if (check_parse_id(ids[k], map == cpus_map, pe))
+					ret++;
+			}
+
+			if (expr__parse(&result, &ctx, pe->metric_expr)) {
+				pr_debug("Parse failed for map %s %s %s\n",
+					map->cpuid, map->version, map->type);
+				pr_debug("On metric %s\n", pe->metric_name);
+				pr_debug("On expression %s\n", pe->metric_expr);
+				ret++;
+			}
+			for (k = 0; k < idnum; k++)
+				zfree(&ids[k]);
+			free(ids);
+		}
+	}
+	return ret;
+}
+
+static const struct {
+	int (*func)(void);
+	const char *desc;
+} pmu_events_testcase_table[] = {
+	{
+		.func = test_pmu_event_table,
+		.desc = "PMU event table sanity",
+	},
+	{
+		.func = test_aliases,
+		.desc = "PMU event map aliases",
+	},
+	{
+		.func = test_parsing,
+		.desc = "Parsing of PMU event table metrics",
+	},
+};
+
+const char *test__pmu_events_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
+		return NULL;
+	return pmu_events_testcase_table[i].desc;
+}
+
+int test__pmu_events_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(pmu_events_testcase_table);
+}
+
+int test__pmu_events(struct test *test __maybe_unused, int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
+		return TEST_FAIL;
+	return pmu_events_testcase_table[i].func();
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab032080..f8c4eaf56d72 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -50,6 +50,8 @@ int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
 int test__pmu_events(struct test *test, int subtest);
+const char *test__pmu_events_subtest_get_desc(int subtest);
+int test__pmu_events_subtest_get_nr(void);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
-- 
2.26.2.303.gf8c07b1a785-goog

