Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28485C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swWsDvDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgEMV3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728718AbgEMV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:29:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FB8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:29:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n200so1230219ybg.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RvgPZsPKVaqB2h6hlO7zxVd8Nfau1UA1CDFS//hZd+s=;
        b=swWsDvDyuOPGoC7MzPNdCWVRKGNzDYifRxi7GCxURN22PQLBb1cSuvzi3l/iMsOHdn
         JTROG9GnHo6Uql5dMFeSCttPZHMBUpPwcorr/jep5rM65tNxtWbRPW0fEcEZwVXP2msg
         /jPt5Ck0+vEIOB3NPWtuWOOzmg3EmtTFgn6xy3HzzmjGd/jkD+h1zBCXtA+hac6N1b0P
         n+ZMesdgkhEsQ+9j5Q5/AxdkTnltxE2D0bn1isadfmriR60Sx138zALnrcAQNhA3xBMo
         hl30NcoFt49OjB/B6H8jZGSCzfwrknO6//sMhbIREUZM6JpwozoBa9oV6iefQAsVjynb
         AzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RvgPZsPKVaqB2h6hlO7zxVd8Nfau1UA1CDFS//hZd+s=;
        b=OLfvxukXIhl0OpZioyidfKA8VKH4o2zwX+xltjPnu3WzhDzCbc3FRXIfv1ZwzzPYjH
         aPF943ph5gubas9+Wb7xBWQUpwolJvRlf90HIlVsUjZLBZjZVeIaedA8zSFSpd9+9BEU
         WB9cvVqqfJHX70OQZtdHgsE1aYuqSwjUsD4cpMQdQrLBPF7mQZeEmMG9LXlNLThr6zds
         lrtSpSXh9CKOs1Hf1u3aHckduOF+9C12IXw1w7+TElc3U5sNou6CT61vlApnQk6k4BT7
         z1udao7fCQ8Fd4uRDnYFBBHf66GwXHQzH93YUZCnN9ccFQItPFxYHBDrrFq8XNAkWh6W
         Rong==
X-Gm-Message-State: AOAM5300pea+86QstWHhmvnQwDeWZV++hKFfpoAHOu+BEB1uDKyPLSGs
        oTO7BUww/56VcX43KUpHyTXWTLodyo4H
X-Google-Smtp-Source: ABdhPJyJN0vp4AH2ZpuVmTmXQvY4vXzZAdcfFb4vCg8t9aCdGpPKXI15Js+BOTowuYXPSx1xvmpqaUL/fojx
X-Received: by 2002:a25:b74a:: with SMTP id e10mr1683717ybm.126.1589405376805;
 Wed, 13 May 2020 14:29:36 -0700 (PDT)
Date:   Wed, 13 May 2020 14:29:33 -0700
Message-Id: <20200513212933.41273-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v3] perf test: Improve pmu event metric testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break pmu-events test into 2 and add a test to verify that all pmu metric
expressions simply parse. Try to parse all metric ids/events, skip/warn if
metrics for the current architecture fail to parse. To support warning
for a skip, and an ability for a subtest to describe why it skips.

Tested on power9, skylakex, haswell, broadwell, westmere, sandybridge and
ivybridge.
May skip/warn on other architectures if metrics are invalid. In particular
s390 is untested, but its expressions are trivial. The untested
architectures with expressions are power8, cascadelakex, tremontx, skylake,
jaketown, ivytown and variants of haswell and broadwell.

v3. addresses review comments from John Garry <john.garry@huawei.com>,
Jiri Olsa <jolsa@redhat.com> and Arnaldo Carvalho de Melo
<acme@kernel.org>.
v2. changes the commit message as event parsing errors no longer cause
the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  16 ++-
 tools/perf/tests/pmu-events.c   | 168 ++++++++++++++++++++++++++++++--
 tools/perf/tests/tests.h        |   4 +
 3 files changed, 181 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3471ec52ea11..21552e965545 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -75,6 +75,13 @@ static struct test generic_tests[] = {
 	{
 		.desc = "PMU events",
 		.func = test__pmu_events,
+		.subtest = {
+			.skip_if_fail	= false,
+			.get_nr		= test__pmu_events_subtest_get_nr,
+			.get_desc	= test__pmu_events_subtest_get_desc,
+			.skip_reason	= test__pmu_events_subtest_skip_reason,
+		},
+
 	},
 	{
 		.desc = "DSO data read",
@@ -409,6 +416,7 @@ static int run_test(struct test *test, int subtest)
 
 static int test_and_print(struct test *t, bool force_skip, int subtest)
 {
+	const char *skip_reason = NULL;
 	int err;
 
 	if (!force_skip) {
@@ -430,7 +438,13 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 		pr_info(" Ok\n");
 		break;
 	case TEST_SKIP:
-		color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
+		if (t->subtest.skip_reason)
+			skip_reason = t->subtest.skip_reason(subtest);
+		if (skip_reason) {
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (%s)\n",
+				      skip_reason);
+		} else
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip\n");
 		break;
 	case TEST_FAIL:
 	default:
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index d64261da8bf7..e21f0addcfbb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -8,6 +8,9 @@
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "../pmu-events/pmu-events.h"
+#include "util/evlist.h"
+#include "util/expr.h"
+#include "util/parse-events.h"
 
 struct perf_pmu_test_event {
 	struct pmu_event event;
@@ -144,7 +147,7 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
 }
 
 /* Verify generated events from pmu-events.c is as expected */
-static int __test_pmu_event_table(void)
+static int test_pmu_event_table(void)
 {
 	struct pmu_events_map *map = __test_pmu_get_events_map();
 	struct pmu_event *table;
@@ -347,14 +350,11 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
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
 
@@ -377,3 +377,159 @@ int test__pmu_events(struct test *test __maybe_unused,
 
 	return 0;
 }
+
+static bool is_number(const char *str)
+{
+	char *end_ptr;
+
+	strtod(str, &end_ptr);
+	return end_ptr != str;
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
+		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
+			pe->metric_name, id, pe->metric_expr);
+		pr_warning("Error string '%s' help '%s'\n", error.str,
+			error.help);
+	} else if (ret) {
+		pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
+			  id, pe->metric_name, pe->metric_expr);
+		ret = 0;
+	}
+	evlist__delete(evlist);
+	free(error.str);
+	free(error.help);
+	free(error.first_str);
+	free(error.first_help);
+	return ret;
+}
+
+static void expr_failure(const char *msg,
+			 const struct pmu_events_map *map,
+			 const struct pmu_event *pe)
+{
+	pr_debug("%s for map %s %s %s\n",
+		msg, map->cpuid, map->version, map->type);
+	pr_debug("On metric %s\n", pe->metric_name);
+	pr_debug("On expression %s\n", pe->metric_expr);
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
+		if (!map->table)
+			break;
+		j = 0;
+		for (;;) {
+			pe = &map->table[j++];
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+			if (!pe->metric_expr)
+				continue;
+			if (expr__find_other(pe->metric_expr, NULL,
+						&ids, &idnum, 0) < 0) {
+				expr_failure("Parse other failed", map, pe);
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
+			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
+				expr_failure("Parse failed", map, pe);
+				ret++;
+			}
+			for (k = 0; k < idnum; k++)
+				zfree(&ids[k]);
+			free(ids);
+		}
+	}
+	/* TODO: fail when not ok */
+	return ret == 0 ? TEST_OK : TEST_SKIP;
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
+const char *test__pmu_events_subtest_get_desc(int subtest)
+{
+	if (subtest < 0 ||
+	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
+		return NULL;
+	return pmu_events_testcase_table[subtest].desc;
+}
+
+const char *test__pmu_events_subtest_skip_reason(int subtest)
+{
+	if (subtest < 0 ||
+	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
+		return NULL;
+	if (pmu_events_testcase_table[subtest].func != test_parsing)
+		return NULL;
+	return "some metrics failed";
+}
+
+int test__pmu_events_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(pmu_events_testcase_table);
+}
+
+int test__pmu_events(struct test *test __maybe_unused, int subtest)
+{
+	if (subtest < 0 ||
+	    subtest >= (int)ARRAY_SIZE(pmu_events_testcase_table))
+		return TEST_FAIL;
+	return pmu_events_testcase_table[subtest].func();
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index d6d4ac34eeb7..6c6c4b6a4796 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -34,6 +34,7 @@ struct test {
 		bool skip_if_fail;
 		int (*get_nr)(void);
 		const char *(*get_desc)(int subtest);
+		const char *(*skip_reason)(int subtest);
 	} subtest;
 	bool (*is_supported)(void);
 	void *priv;
@@ -50,6 +51,9 @@ int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
 int test__pmu_events(struct test *test, int subtest);
+const char *test__pmu_events_subtest_get_desc(int subtest);
+const char *test__pmu_events_subtest_skip_reason(int subtest);
+int test__pmu_events_subtest_get_nr(void);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
-- 
2.26.2.645.ge9eca65c58-goog

