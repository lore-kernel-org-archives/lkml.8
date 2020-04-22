Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3B4C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B29A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tK59ZXOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDVHsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726601AbgDVHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B9C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o103so1041180pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=794UeF8W+at79LCC9i7BwnlKAALsYEgJqYQvE4+BBD4=;
        b=tK59ZXOFVCNvqBueajde6oI1B0sVXcmEKjZ0J6mvGxMQFQa0q4thkcUDal7X9ssBlS
         3sWuR0aME9xK1drbc/Ztbl6jHg5pGBFrxTei/rB9C/kt9OQNIlrhKZDJRZuDmGxiEwhZ
         bJkJw6dDr3CHuy8NKkFA1idScBmTVwg8f9Ri1tl9yb3zH6BrOZa6eSYsyPVOqK2GRcUW
         ZjCZ5NqSJtayLgzJjCGfd2qX3V+bXBRLXUNWJ0AOzIVE2LSaD6wS6Qb/quTG5FX8Jh+D
         py7LyFgTubjPE/LFzn0Lb5Y98VK1SHf0SJSAZ1jwGS7+pthMbtklQ4JvkMCGzqvDHP7n
         nVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=794UeF8W+at79LCC9i7BwnlKAALsYEgJqYQvE4+BBD4=;
        b=AnfGW6xWo8lk56JoVdP/GcP0Lp8WtpgDXFAW9eZafXB5tYGqB7lyFVMBhq5Mix5USh
         RsRQD6ksUJezlN9TzK4g6KMLOyN4hgqmWgmJEa2BGfF9RnWVXWxC6dSsKtD7qhkGgCKh
         UoH+BYt1jJw92a+tJKdkb/1sAQZTbZ6Qsft1s87RYZMCCendATAUIK42TGLxLMWOWrUd
         zx8DWAIHDfcCniDwjZ0DNgYMo5JibpnGFcEn+HQsg3gkCk9aEPICi7YIl9eJxFC512Np
         faTVbd5ILm3idw5p/tRkmdHFtXXbMaEQEUhHq9c6eKIUx9uI2brj1hrxGJ/UFnyeUp1H
         /SOg==
X-Gm-Message-State: AGi0PuZYwvY4bsbSzUTnqLVBWBwazrzdlXJPsC8xALoiE2XrXiu+qrv8
        n1c8UBG9NSdfFl6ah3MmQq5PcZqKdIq8
X-Google-Smtp-Source: APiQypKK2/FUCgMLVD+//6q/2vuAXLiR2pEpy9lCDmybC/An8vw1vvLkm/EA9FMmmtbdpoObm91oGte+pTu3
X-Received: by 2002:a17:90a:252f:: with SMTP id j44mr10214236pje.9.1587541713855;
 Wed, 22 Apr 2020 00:48:33 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:09 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-9-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 8/8] perf test: add expr test for pmu metrics
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic floating point number test.
Verify that all pmu metrics parse.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c |  5 ++
 tools/perf/tests/expr.c         | 91 ++++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |  2 +
 3 files changed, 97 insertions(+), 1 deletion(-)

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
index ea10fc4412c4..125f9b040e20 100644
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
@@ -65,3 +68,89 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
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
+			for (k = 0; k < idnum; k++)
+				expr__add_id(&ctx, ids[k], 1);
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

