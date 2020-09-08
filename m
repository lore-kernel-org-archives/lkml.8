Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764EA21D1B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599540180;
	bh=aX3NycxO6/+PuuUQsLmSS0cFMELAj7U9SjIurgoKCFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xf+AdcpFJ3y1Kr2a2EcS3/q/3IH1mF66zkdwcN6FUx+wPo4ksTHF2YVA0BI0Xac1F
	 qLaNk6HBRyaNTOMofIsUDwPKx1YGs/iNQ/FxQnU4wG6pusB+2B5Ig64TVAbav3eO8y
	 2sEbcDEj1SFhJop04XwWd8FI8cWGKniHOcU/zmmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgIHEm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIHEmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11530C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m8so3877357pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGdAu9fbKdMLQKxfef7oCAXkhq/ZtCfSpEwWwRhKfIU=;
        b=MUpMkoL/DPHITGJM2oDGScSBLowcpocUM8ui9kO6hUw1E7h5GS+4qd9tNyAN0Emno1
         6w1wY+NTtuJ1/Xzo4DhgL5IIXWlC+Z0ZihDiDzOfIWcwJgnTN6NO2mjtMBzMF9KtML2t
         vWlCw16pEttof+CS6NIW08Vyf0ehOtumquZFL0mR/XHV11JGzHo5+vxXplyHW/QmvQ7y
         B3Z1SSdUP86TkpeWFwyK3ec0GVyqTOC+NBECJqrfjOoy/mCUdfTHsARweeS+YlSBnmvF
         HcfxvdwzCl2MuS6UZ50QZejcsinBc37eTA3HLlByCFAB7m1tBZnLZJGV+p+2sgzB9T/J
         rIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JGdAu9fbKdMLQKxfef7oCAXkhq/ZtCfSpEwWwRhKfIU=;
        b=lBthZ81wM8muq7/yhfwSgpFNnr/ltqLcuJhA69+nhCNebTM3r01vzGHmIjTUhAGfHP
         xBjj1b8SACr3Du1VY8juHn93tDmj8ThDVSxR0aFtcX8iDCk+Ox56vml6CydmEDqZ8/1p
         NK20Wh0XpR49b0xlrvga0Eto+ry5LB4tmkUB/w8DZE2GNmMyfLDMSP8emdyKATJ/Taf+
         b/O94ofrnNqzO+Uds/tMymP4+f2x1riPaR46nYwgoBrzfcxQwoCTypjG7qsz+Q9Ud//J
         qyTmQD6B5ncUBUMQ2Sk8S2ptsl6YQbFzRiN94HhKprA5yJL4ULR34E23iaziRdgZjFVz
         rijA==
X-Gm-Message-State: AOAM532sYHVOrQmxPgmFtT1q0r/xe9QUfYCtURpHKYPBzxSZncnEVXRI
        SAuDkjPUjtM7zOubl24GxuQ=
X-Google-Smtp-Source: ABdhPJwQVszRyJtbl3wiRpjXSD2v+ixWS2pDZo0zKECY7GQ7UIXBpjSwxll2h2ml0F4p7Zo1JQ6iTA==
X-Received: by 2002:a63:c9:: with SMTP id 192mr8731361pga.37.1599540169516;
        Mon, 07 Sep 2020 21:42:49 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm16777625pfn.109.2020.09.07.21.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:48 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] perf test: Add multiply cgroup event test
Date:   Tue,  8 Sep 2020 13:42:28 +0900
Message-Id: <20200908044228.61197-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'll multiply given events for cgroups A, B and C.

  $ ./perf test -v 68
  68: Event multiplication for cgroups                      :
  --- start ---
  test child forked, pid 983140
  metric expr 1 / IPC for CPI
  metric expr instructions / cycles for IPC
  found event instructions
  found event cycles
  adding {instructions,cycles}:W
  copying metric event for cgroup 'A': instructions (idx=0)
  copying metric event for cgroup 'B': instructions (idx=0)
  copying metric event for cgroup 'C': instructions (idx=0)
  test child finished with 0
  ---- end ----
  Event multiplication for cgroups: Ok

Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c          |   2 +-
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   4 +
 tools/perf/tests/multiply-cgroup.c | 203 +++++++++++++++++++++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/cgroup.c           |  19 ++-
 tools/perf/util/cgroup.h           |   2 +-
 7 files changed, 223 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/tests/multiply-cgroup.c

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 55a7dc175cdf..c231972f3581 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2262,7 +2262,7 @@ int cmd_stat(int argc, const char **argv)
 
 	if (multiply_cgroup && stat_config.cgroups) {
 		if (evlist__multiply_cgroup(evsel_list, stat_config.cgroups,
-					    &stat_config.metric_events) < 0)
+					    &stat_config.metric_events, true) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 84352fc49a20..e685a3441853 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -60,6 +60,7 @@ perf-y += api-io.o
 perf-y += demangle-java-test.o
 perf-y += pfm.o
 perf-y += parse-metric.o
+perf-y += multiply-cgroup.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d328caaba45d..de48b9d28230 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -341,6 +341,10 @@ static struct test generic_tests[] = {
 		.desc = "Parse and process metrics",
 		.func = test__parse_metric,
 	},
+	{
+		.desc = "Event multiplication for cgroups",
+		.func = test__multiply_cgroup_events,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/multiply-cgroup.c b/tools/perf/tests/multiply-cgroup.c
new file mode 100644
index 000000000000..89af1644cd6a
--- /dev/null
+++ b/tools/perf/tests/multiply-cgroup.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include "debug.h"
+#include "evlist.h"
+#include "cgroup.h"
+#include "rblist.h"
+#include "metricgroup.h"
+#include "parse-events.h"
+#include "pmu-events/pmu-events.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static int test_multiply_events(struct evlist *evlist,
+				struct rblist *metric_events)
+{
+	int i, ret = TEST_FAIL;
+	int nr_events;
+	bool was_group_event;
+	int nr_members;  /* for the first evsel only */
+	const char cgrp_str[] = "A,B,C";
+	const char *cgrp_name[] = { "A", "B", "C" };
+	int nr_cgrps = ARRAY_SIZE(cgrp_name);
+	char **ev_name;
+	struct evsel *evsel;
+
+	TEST_ASSERT_VAL("evlist is empty", !perf_evlist__empty(evlist));
+
+	nr_events = evlist->core.nr_entries;
+	ev_name = calloc(nr_events, sizeof(*ev_name));
+	if (ev_name == NULL) {
+		pr_debug("memory allocation failure\n");
+		return TEST_FAIL;
+	}
+	i = 0;
+	evlist__for_each_entry(evlist, evsel) {
+		ev_name[i] = strdup(evsel->name);
+		if (ev_name[i] == NULL) {
+			pr_debug("memory allocation failure\n");
+			goto out;
+		}
+		i++;
+	}
+	/* remember grouping info */
+	was_group_event = evsel__is_group_event(evlist__first(evlist));
+	nr_members = evlist__first(evlist)->core.nr_members;
+
+	ret = evlist__multiply_cgroup(evlist, cgrp_str, metric_events, false);
+	if (ret < 0) {
+		pr_debug("failed to multiply cgroup\n");
+		goto out;
+	}
+
+	ret = TEST_FAIL;
+	if (evlist->core.nr_entries != nr_events * nr_cgrps) {
+		pr_debug("event count doesn't match\n");
+		goto out;
+	}
+
+	i = 0;
+	evlist__for_each_entry(evlist, evsel) {
+		if (strcmp(evsel->name, ev_name[i % nr_events])) {
+			pr_debug("event name doesn't match:\n");
+			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
+				 i, evsel->name, ev_name[i % nr_events]);
+			goto out;
+		}
+		if (strcmp(evsel->cgrp->name, cgrp_name[i / nr_events])) {
+			pr_debug("cgroup name doesn't match:\n");
+			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
+				 i, evsel->cgrp->name, cgrp_name[i / nr_events]);
+			goto out;
+		}
+
+		if ((i % nr_events) == 0) {
+			if (evsel__is_group_event(evsel) != was_group_event) {
+				pr_debug("event group doesn't match: got %s, expect %s\n",
+					 evsel__is_group_event(evsel) ? "true" : "false",
+					 was_group_event ? "true" : "false");
+				goto out;
+			}
+			if (evsel->core.nr_members != nr_members) {
+				pr_debug("event group member doesn't match: %d vs %d\n",
+					 evsel->core.nr_members, nr_members);
+				goto out;
+			}
+		}
+		i++;
+	}
+	ret = TEST_OK;
+
+out:	for (i = 0; i < nr_events; i++)
+		free(ev_name[i]);
+	free(ev_name);
+	return ret;
+}
+
+static int multiply_default_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+
+	evlist = perf_evlist__new_default();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	rblist__init(&metric_events);
+	ret = test_multiply_events(evlist, &metric_events);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int multiply_group_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+	struct parse_events_error err;
+	const char event_str[] = "{cycles,instructions}";
+
+	symbol_conf.event_group = true;
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	ret = parse_events(evlist, event_str, &err);
+	if (ret < 0) {
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 event_str, ret, err.str);
+		parse_events_print_error(&err, event_str);
+		evlist__delete(evlist);
+		return ret;
+	}
+
+	rblist__init(&metric_events);
+	ret = test_multiply_events(evlist, &metric_events);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int multiply_metric_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+	const char metric_str[] = "CPI";
+
+	struct pmu_event pme_test[] = {
+		{
+			.metric_expr	= "instructions / cycles",
+			.metric_name	= "IPC",
+		},
+		{
+			.metric_expr	= "1 / IPC",
+			.metric_name	= "CPI",
+		},
+		{
+			.metric_expr	= NULL,
+			.metric_name	= NULL,
+		},
+	};
+	struct pmu_events_map ev_map = {
+		.cpuid		= "test",
+		.version	= "1",
+		.type		= "core",
+		.table		= pme_test,
+	};
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	rblist__init(&metric_events);
+	ret = metricgroup__parse_groups_test(evlist, &ev_map, metric_str,
+					     false, false, &metric_events);
+	if (ret < 0) {
+		pr_debug("failed to parse '%s' metric\n", metric_str);
+		goto out;
+	}
+
+	ret = test_multiply_events(evlist, &metric_events);
+
+out:
+	metricgroup__rblist_exit(&metric_events);
+	evlist__delete(evlist);
+	return ret;
+}
+
+int test__multiply_cgroup_events(struct test *test __maybe_unused,
+				 int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = multiply_default_events();
+	TEST_ASSERT_EQUAL("failed to multiply default events", ret, 0);
+
+	ret = multiply_group_events();
+	TEST_ASSERT_EQUAL("failed to multiply event group", ret, 0);
+
+	ret = multiply_metric_events();
+	TEST_ASSERT_EQUAL("failed to multiply metric events", ret, 0);
+
+	return ret;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 4447a516c689..4b7c9e3a4fc5 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -122,6 +122,7 @@ int test__pfm(struct test *test, int subtest);
 const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
 int test__parse_metric(struct test *test, int subtest);
+int test__multiply_cgroup_events(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 1ba61b5d66b4..0723632002fc 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -52,7 +52,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
 	return NULL;
 }
 
-static struct cgroup *cgroup__new(const char *name)
+static struct cgroup *cgroup__new(const char *name, bool do_open)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
@@ -62,9 +62,14 @@ static struct cgroup *cgroup__new(const char *name)
 		cgroup->name = strdup(name);
 		if (!cgroup->name)
 			goto out_err;
-		cgroup->fd = open_cgroup(name);
-		if (cgroup->fd == -1)
-			goto out_free_name;
+
+		if (do_open) {
+			cgroup->fd = open_cgroup(name);
+			if (cgroup->fd == -1)
+				goto out_free_name;
+		} else {
+			cgroup->fd = -1;
+		}
 	}
 
 	return cgroup;
@@ -80,7 +85,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
-	return cgroup ?: cgroup__new(name);
+	return cgroup ?: cgroup__new(name, true);
 }
 
 static int add_cgroup(struct evlist *evlist, const char *str)
@@ -202,7 +207,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 }
 
 int evlist__multiply_cgroup(struct evlist *evlist, const char *str,
-			    struct rblist *metric_events)
+			    struct rblist *metric_events, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
@@ -240,7 +245,7 @@ int evlist__multiply_cgroup(struct evlist *evlist, const char *str,
 			if (!name)
 				break;
 
-			cgrp = cgroup__new(name);
+			cgrp = cgroup__new(name, open_cgroup);
 			free(name);
 			if (cgrp == NULL)
 				break;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 87dde992a172..b3d75f18b3ec 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -27,7 +27,7 @@ struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 int evlist__multiply_cgroup(struct evlist *evlist, const char *cgroups,
-			    struct rblist *metric_events);
+			    struct rblist *metric_events, bool open_cgroup);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
-- 
2.28.0.526.ge36021eeef-goog

