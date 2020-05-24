Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D7CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312B120899
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360194;
	bh=j9x9cfZ7hVB+ySSj4nrfkzoIsVXNYQkkvRl6NYpxAfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QE2ZYOHZUt11HFeZKsiC5McmRRn/MQWO8kr9dnlimIDzrHmD01EbEhrhUvs4pW8DJ
	 6XERMWnU4jYNOZnG9VKl0eBfNWNamJJuEn+1iZHGTJnRwPhhCApXI0hn36vdzZfvpu
	 K6ri/aHVa3zElVg6jlr1msZaEYrKUDkwrqyHicUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbgEXWnN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:43:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35393 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388644AbgEXWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:43:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-AfjghVnLPNiDXjHXsjq86w-1; Sun, 24 May 2020 18:43:04 -0400
X-MC-Unique: AfjghVnLPNiDXjHXsjq86w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD9C107ACCA;
        Sun, 24 May 2020 22:43:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA7BE6ED86;
        Sun, 24 May 2020 22:43:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 13/14] perf tests: Add parse metric test for ipc metric
Date:   Mon, 25 May 2020 00:42:18 +0200
Message-Id: <20200524224219.234847-14-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 4
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new test that process metrics code and checks
the expected results. Starting with easy ipc metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 ++
 tools/perf/tests/parse-metric.c | 117 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 123 insertions(+)
 create mode 100644 tools/perf/tests/parse-metric.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index c75557aeef0e..bb7c2d8364d1 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -57,6 +57,7 @@ perf-y += maps.o
 perf-y += time-utils-test.o
 perf-y += genelf.o
 perf-y += api-io.o
+perf-y += parse-metric.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a9daaeb9fd27..bf20abdca0b0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -324,6 +324,10 @@ static struct test generic_tests[] = {
 		.desc = "maps__merge_in",
 		.func = test__maps__merge_in,
 	},
+	{
+		.desc = "Parse and process metrics",
+		.func = test__parse_metric,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
new file mode 100644
index 000000000000..3005d27c5c48
--- /dev/null
+++ b/tools/perf/tests/parse-metric.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <string.h>
+#include "metricgroup.h"
+#include "tests.h"
+#include "pmu-events/pmu-events.h"
+#include "evlist.h"
+#include "rblist.h"
+#include "debug.h"
+#include "expr.h"
+#include "stat.h"
+
+static struct pmu_event pme_test[] = {
+{
+	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
+	.metric_name	= "IPC",
+},
+};
+
+static struct pmu_events_map map = {
+	.cpuid		= "test",
+	.version	= "1",
+	.type		= "core",
+	.table		= pme_test,
+};
+
+static double compute_single(struct rblist *metric_events, struct evsel *evsel,
+			     struct runtime_stat *st)
+{
+	struct metric_event *me;
+
+	me = metricgroup__lookup(metric_events, evsel, false);
+	if (me != NULL) {
+		struct metric_expr *mexp;
+
+		mexp = list_first_entry(&me->head, struct metric_expr, nd);
+		return test_generic_metric(mexp, 0, st);
+	}
+
+	return 0.;
+}
+
+struct value {
+	const char	*event;
+	u64		 val;
+};
+
+static u64 find_value(const char *name, struct value *values)
+{
+	struct value *v = values;
+
+	while (v->event) {
+		if (!strcmp(name, v->event))
+			return v->val;
+		v++;
+	};
+
+	return 0;
+}
+
+static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
+			      struct value *values)
+{
+	struct evsel *evsel;
+	u64 count;
+
+	evlist__for_each_entry(evlist, evsel) {
+		count = find_value(evsel->name, values);
+		perf_stat__update_shadow_stats(evsel, count, 0, st);
+	}
+}
+
+static int test_ipc(void)
+{
+	double ratio;
+	struct rblist metric_events = {
+		.nr_entries = 0,
+	};
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct value vals[] = {
+		{ .event = "inst_retired.any",        .val = 300 },
+		{ .event = "cpu_clk_unhalted.thread", .val = 200 },
+		{ 0 },
+	};
+	struct runtime_stat st;
+	int err;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -1;
+
+	err = metricgroup__parse_groups_test(evlist, &map,
+					     "IPC",
+					     false, false,
+					     &metric_events);
+
+	TEST_ASSERT_VAL("failed to parse metrics", err == 0);
+
+	runtime_stat__init(&st);
+	load_runtime_stat(&st, evlist, vals);
+
+	evsel = evlist__first(evlist);
+	ratio = compute_single(&metric_events, evsel, &st);
+
+	TEST_ASSERT_VAL("IPC failed, wrong ratio", ratio == 1.5);
+
+	runtime_stat__exit(&st);
+	evlist__delete(evlist);
+	return 0;
+}
+
+int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6c6c4b6a4796..0a7853b72240 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -117,6 +117,7 @@ int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 int test__jit_write_elf(struct test *test, int subtest);
 int test__api_io(struct test *test, int subtest);
+int test__parse_metric(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.25.4

