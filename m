Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21669C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EE92084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1iHYrJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDVWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgDVWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:05:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDDC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:05:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id bc2so3040536plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ccAncsvLs1Shxdnx0s2rhoVdoaZEUZXVPRbZhF6Qp9w=;
        b=K1iHYrJ3sczYEZpWiRx0KO03qtljW5ykTqGPUOkrKzgP81ORPGvJJXIY6EJsNUll6j
         i0QlrxudZhOUMH3CBDlnmlIJ8ePleSN27H+v0JbwEzH+sCCrdrmfN+WMAonr16sAzzcd
         kZ0/sVQSf93tHeQ5lO9/xN8w4e0udZtL3033DnBPqnwfQ7CRzCHiSG0X4Xn9NPvd58jh
         0zbp4QPMe1FFGHtwYukX23rZK4/EI5LM48h6AFy+pVtolB+5o/MOj4ghBz+AOU/YOqfy
         jUumpKdxx1WS/I0/8d12XLcRsb1jUdDRR//liGNnd0ehtD1DR4tL8xykvVAfwlO5Exge
         nOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ccAncsvLs1Shxdnx0s2rhoVdoaZEUZXVPRbZhF6Qp9w=;
        b=GirR4DdUpaQXx9mhlnDfY7HJmVDn4XR1F1EYlKrdnXSjYQqUFPRdmkS/Eu3Aa9hlM2
         Y+p4uIlbwVd23LWnN+Uyid7xq92A5ifhlGAiiv+cLr6BR6ZUbx6WpQxvjl1CAn1kNBL7
         B/zfDPlpjA2JNqPFD4cdLvERw50uabbNtB1VC26wBB8E8k1iRuyM39tw7z3S9vSUdkvE
         +3UwXZFjnF6SiNWYhcVwsme68JWP7aJ2jXA1dDj/9NOTZ5aBSfQjTVAOHjhQ5WU+rRwN
         oC0GTNBzsd6RuR+SVOUUI8vC67sMD7xwFVzTeBhhgHMe5VnIoNaI3V3EDLaEA00a+XWy
         YOwA==
X-Gm-Message-State: AGi0PuYAw+ACgcy6fgjBpFn9r2LRlE46SUEnviBo0dEOzEMWUbb7n5/J
        OEVizledyJsAe8HTi9B6udY/yL24KfpU
X-Google-Smtp-Source: APiQypK5pedQFtw9mxUk8NaEPKRidbrbFzJc8Ri8D7P0nUM14OJHTmE4EiHWmn0wNB5v/9X29yC6LZa8pHPx
X-Received: by 2002:a17:90a:9504:: with SMTP id t4mr902919pjo.21.1587593100740;
 Wed, 22 Apr 2020 15:05:00 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:30 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-12-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 11/11] perf test: add expr test for pmu metrics
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
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic floating point number test.
Verify that all pmu metrics, for the current architecture, parse.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  5 ++
 tools/perf/tests/expr.c         | 96 ++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |  2 +
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b6322eb0f423..28d547951f6b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -63,6 +63,11 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Simple expression parser",
 		.func = test__expr,
+		.subtest = {
+			.get_nr		= test__expr_subtest_get_nr,
+			.get_desc	= test__expr_subtest_get_desc,
+		},
+
 	},
 	{
 		.desc = "PERF_RECORD_* events & perf_sample fields",
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index ea10fc4412c4..35af232eb01d 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "pmu-events/pmu-events.h"
 #include "util/debug.h"
 #include "util/expr.h"
 #include "tests.h"
 #include <stdlib.h>
 #include <string.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
 static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
@@ -16,7 +18,7 @@ static int test(struct expr_parse_ctx *ctx, const char *e, double val2)
 	return 0;
 }
 
-int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
+static int parse_tests(void)
 {
 	const char *p;
 	const char **other;
@@ -39,6 +41,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	ret |= test(&ctx, "min(1,2) + 1", 2);
 	ret |= test(&ctx, "max(1,2) + 1", 3);
 	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
+	ret |= test(&ctx, "1.1 + 2.1", 3.2);
 
 	if (ret)
 		return ret;
@@ -65,3 +68,94 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	return 0;
 }
+
+static int pmu_tests(void)
+{
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
+			/*
+			 * Add all ids with a made up value. The value may
+			 * trigger divide by zero when subtracted and so try to
+			 * make them unique.
+			 */
+			for (k = 0; k < idnum; k++)
+				expr__add_id(&ctx, ids[k], k + 1);
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
+} expr_testcase_table[] = {
+	{
+		.func = parse_tests,
+		.desc = "Basic expressions",
+	},
+	{
+		.func = pmu_tests,
+		.desc = "Parsing of pmu metrics",
+	},
+};
+
+const char *test__expr_subtest_get_desc(int i)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(expr_testcase_table))
+		return NULL;
+	return expr_testcase_table[i].desc;
+}
+
+int test__expr_subtest_get_nr(void)
+{
+	return (int)ARRAY_SIZE(expr_testcase_table);
+}
+
+int test__expr(struct test *test __maybe_unused, int i __maybe_unused)
+{
+	if (i < 0 || i >= (int)ARRAY_SIZE(expr_testcase_table))
+		return TEST_FAIL;
+	return expr_testcase_table[i].func();
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 61a1ab032080..315d64ffd14c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -72,6 +72,8 @@ int test__keep_tracking(struct test *test, int subtest);
 int test__parse_no_sample_id_all(struct test *test, int subtest);
 int test__dwarf_unwind(struct test *test, int subtest);
 int test__expr(struct test *test, int subtest);
+const char *test__expr_subtest_get_desc(int subtest);
+int test__expr_subtest_get_nr(void);
 int test__hists_filter(struct test *test, int subtest);
 int test__mmap_thread_lookup(struct test *test, int subtest);
 int test__thread_maps_share(struct test *test, int subtest);
-- 
2.26.2.303.gf8c07b1a785-goog

