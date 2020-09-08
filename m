Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE1EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FB221D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599540187;
	bh=zpb21ZCxYuHZx4t2X5o91I3HqDtRQbDLmdaFPBAFyEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zckgwulqXnwRnSuHTud8xomE9ds9MYrnImGx36BI6l/7Sq3mCL0/COlNj4EJx7Hl2
	 OOt2Vviwk+sw88nUxGuzCVuT2V8QQ+4aCqx5aEvXaHSDvxEWSbKcx2X+wNN/edUnyv
	 n3uRRJcqzOAOyul6SA8aPjY3/ZDiDZnRsVpWx4R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgIHEnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgIHEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EF6C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np15so8171781pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A/XAWbIK9os72LtbRqYGmKkcxvmOHy9/rCa4psvarhU=;
        b=QjyxjFBiOWqfZt1hgSeRzOYn5F/F6GVjGX4qi+I2yJH1sHw+v8xnE+bnutSnTv8d0a
         OK3Yb7olbMQm6QesiQdRXlaujhG7KEtMZaePs1t2lyLzR8w9eCc3Q5dQh5puf5xOI7Hu
         D28z47Zj8A7x++BGkeyhWkXhDbmJAWvyY/qJHzHkoEFpD4iyh/CflzJjv8iX9S0N77ey
         jlEEERZM2aEqQJfsToygKC2TNzBObLH1Jday13v0QegGpTWkL8ANptZVzIegDw9g7A2a
         6FQAsE141+CnCv9sdYKIswDAyrbSN+GnpOHvbD8EgrG9Mw+kDb1gjSCwqjHsm6yBRmSd
         cUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=A/XAWbIK9os72LtbRqYGmKkcxvmOHy9/rCa4psvarhU=;
        b=K+FrUs36l3lt8fUwZTdKRGAsLeZmwiw4+xN0pRotQ3zsiT2o8ySJA7vtvGTXGf1tpJ
         /6DeGVrd/Olsaui1kfh/vjaWSkh5ZZYNvlJNNjgCdPPQLpvb5eQfYEZpgLzGq4AWNy6H
         RZt9sz58gHXQ+nosUiriOjjo4SkPhXmwow7Xwmp+663urLzrlGVvI7FbpdBEmVAOu0PO
         II63I6Bh6yiztjbzl1zuATCX/LXuc7ZpoZiq21IPOI1Sepi8pSQvDTRmHLBnAjQBRvuI
         fQ4EKWiDzVIFy97j8nYkO/CaWtV904uK93c/534qYhQoqiuCZJPEOTxRWgAORAooh02M
         uzNA==
X-Gm-Message-State: AOAM531QIktOvMGYLxzE7GQMrD0FvWc/3hjzoN75URHue9+5PnzgC4Bq
        LpwC6sT33SI7Odnp4nvusMc=
X-Google-Smtp-Source: ABdhPJwynT1cqh+E67Tca2DOAEKZrvhzZaDlZ0NOlh8AoGpO/9TgAzhMQMBt8GH9cotk0KrTsF4QsQ==
X-Received: by 2002:a17:90a:e981:: with SMTP id v1mr2263174pjy.177.1599540165851;
        Mon, 07 Sep 2020 21:42:45 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm16777625pfn.109.2020.09.07.21.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:45 -0700 (PDT)
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
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 3/4] perf tools: Copy metric events properly when multiply cgroups
Date:   Tue,  8 Sep 2020 13:42:27 +0900
Message-Id: <20200908044228.61197-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metricgroup__copy_metric_events() is to handle metrics events when
multiplying event for cgroups.  As the metric events keep pointers to
evsel, it should be refreshed when events are cloned during the
operation.

The perf_stat__collect_metric_expr() is also called in case an event
has a metric directly.

During the copy, it references evsel by index as the evlist now has
cloned evsels for the given cgroup.

Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c     |  3 +-
 tools/perf/util/cgroup.c      | 15 ++++++-
 tools/perf/util/cgroup.h      |  4 +-
 tools/perf/util/evlist.c      | 11 +++++
 tools/perf/util/evlist.h      |  1 +
 tools/perf/util/metricgroup.c | 77 +++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 +++
 7 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6724d23ce2e7..55a7dc175cdf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2261,7 +2261,8 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 
 	if (multiply_cgroup && stat_config.cgroups) {
-		if (evlist__multiply_cgroup(evsel_list, stat_config.cgroups) < 0)
+		if (evlist__multiply_cgroup(evsel_list, stat_config.cgroups,
+					    &stat_config.metric_events) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4892f9496bc2..1ba61b5d66b4 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -3,6 +3,9 @@
 #include "evsel.h"
 #include "cgroup.h"
 #include "evlist.h"
+#include "rblist.h"
+#include "metricgroup.h"
+#include "stat.h"
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -198,10 +201,12 @@ int parse_cgroups(const struct option *opt, const char *str,
 	return 0;
 }
 
-int evlist__multiply_cgroup(struct evlist *evlist, const char *str)
+int evlist__multiply_cgroup(struct evlist *evlist, const char *str,
+			    struct rblist *metric_events)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
+	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	int ret = -1;
@@ -221,6 +226,8 @@ int evlist__multiply_cgroup(struct evlist *evlist, const char *str)
 	/* save original events and init evlist */
 	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
 	evlist->core.nr_entries = 0;
+	orig_metric_events = *metric_events;
+	rblist__init(metric_events);
 
 	for (;;) {
 		p = strchr(str, ',');
@@ -256,6 +263,11 @@ int evlist__multiply_cgroup(struct evlist *evlist, const char *str)
 		cgroup__put(cgrp);
 		nr_cgroups++;
 
+		perf_stat__collect_metric_expr(tmp_list);
+		if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
+						    &orig_metric_events) < 0)
+			break;
+
 		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
 
@@ -267,6 +279,7 @@ int evlist__multiply_cgroup(struct evlist *evlist, const char *str)
 	}
 	evlist__delete(orig_list);
 	evlist__delete(tmp_list);
+	rblist__exit(&orig_metric_events);
 
 	return ret;
 }
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 9a842f243dfb..87dde992a172 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -23,9 +23,11 @@ struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
 struct evlist;
+struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
-int evlist__multiply_cgroup(struct evlist *evlist, const char *cgroups);
+int evlist__multiply_cgroup(struct evlist *evlist, const char *cgroups,
+			    struct rblist *metric_events);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e3fa3bf7498a..457df8ce1fd9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1866,3 +1866,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 
 	return err;
 }
+
+struct evsel *evlist__get_evsel(struct evlist *evlist, int idx)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->idx == idx)
+			return evsel;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c73f7f7f120b..57f5fd5e6290 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -381,4 +381,5 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 #define EVLIST_ENABLED_MSG "Events enabled\n"
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
+struct evsel *evlist__get_evsel(struct evlist *evlist, int idx);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..f4a67bf85a7c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -25,6 +25,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include <asm/bug.h>
+#include "cgroup.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -1104,3 +1105,79 @@ bool metricgroup__has_metric(const char *metric)
 	}
 	return false;
 }
+
+int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
+				    struct rblist *new_metric_events,
+				    struct rblist *old_metric_events)
+{
+	unsigned i;
+
+	for (i = 0; i < rblist__nr_entries(old_metric_events); i++) {
+		struct rb_node *nd;
+		struct metric_event *old_me, *new_me;
+		struct metric_expr *old_expr, *new_expr;
+		struct evsel *evsel;
+		size_t alloc_size;
+		int idx, nr;
+
+		nd = rblist__entry(old_metric_events, i);
+		old_me = container_of(nd, struct metric_event, nd);
+
+		evsel = evlist__get_evsel(evlist, old_me->evsel->idx);
+		new_me = metricgroup__lookup(new_metric_events, evsel, true);
+		if (!new_me)
+			return -ENOMEM;
+
+		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
+			 cgrp ? cgrp->name : "root", evsel->name, evsel->idx);
+
+		list_for_each_entry(old_expr, &old_me->head, nd) {
+			new_expr = malloc(sizeof(*new_expr));
+			if (!new_expr)
+				return -ENOMEM;
+
+			new_expr->metric_expr = old_expr->metric_expr;
+			new_expr->metric_name = old_expr->metric_name;
+			new_expr->metric_unit = old_expr->metric_unit;
+			new_expr->runtime = old_expr->runtime;
+
+			if (old_expr->metric_refs) {
+				/* calculate number of metric_events */
+				for (nr = 0; old_expr->metric_refs[nr].metric_name; nr++)
+					continue;
+				alloc_size = sizeof(*new_expr->metric_refs);
+				new_expr->metric_refs = calloc(nr + 1, alloc_size);
+				if (!new_expr->metric_refs) {
+					free(new_expr);
+					return -ENOMEM;
+				}
+
+				memcpy(new_expr->metric_refs, old_expr->metric_refs,
+				       nr * alloc_size);
+			} else {
+				new_expr->metric_refs = NULL;
+			}
+
+			/* calculate number of metric_events */
+			for (nr = 0; old_expr->metric_events[nr]; nr++)
+				continue;
+			alloc_size = sizeof(*new_expr->metric_events);
+			new_expr->metric_events = calloc(nr + 1, alloc_size);
+			if (!new_expr->metric_events) {
+				free(new_expr->metric_refs);
+				free(new_expr);
+				return -ENOMEM;
+			}
+
+			/* copy evsel in the same position */
+			for (idx = 0; idx < nr; idx++) {
+				evsel = old_expr->metric_events[idx];
+				evsel = evlist__get_evsel(evlist, evsel->idx);
+				new_expr->metric_events[idx] = evsel;
+			}
+
+			list_add(&new_expr->nd, &new_me->head);
+		}
+	}
+	return 0;
+}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 62623a39cbec..bb9ea9e1ea9a 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -6,11 +6,13 @@
 #include <linux/rbtree.h>
 #include <stdbool.h>
 
+struct evlist;
 struct evsel;
 struct evlist;
 struct option;
 struct rblist;
 struct pmu_events_map;
+struct cgroup;
 
 struct metric_event {
 	struct rb_node nd;
@@ -54,4 +56,8 @@ void metricgroup__print(bool metrics, bool groups, char *filter,
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(void);
 void metricgroup__rblist_exit(struct rblist *metric_events);
+
+int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
+				    struct rblist *new_metric_events,
+				    struct rblist *old_metric_events);
 #endif
-- 
2.28.0.526.ge36021eeef-goog

