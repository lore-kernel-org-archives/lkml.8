Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D986C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434A02068F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560472;
	bh=zpZV3MLVwkR/P1a/1AwX/BlrIv/ijlQqU81pbu1VOy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R28Y/4SeXe2GdXyQahuMV2WA5iraqnS4e8J+qRStUzOJxKLdovPu0OzVMtaCevp63
	 R2Pl1cEVwhhdcyyNDD0a70n9XXmuicB2C34c/3ZpftQm2gpyEb4pOzGB/VYaZptcse
	 X2vBk4m//wLjsToKHact+yL+tGTbsWpWuSebcZZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgGLN1v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729069AbgGLN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-xHU8eCUKO4eMoUtV0NBxrQ-1; Sun, 12 Jul 2020 09:27:40 -0400
X-MC-Unique: xHU8eCUKO4eMoUtV0NBxrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D91211087;
        Sun, 12 Jul 2020 13:27:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E32C1944D;
        Sun, 12 Jul 2020 13:27:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 18/18] perf metric: Rename group_list to list
Date:   Sun, 12 Jul 2020 15:26:34 +0200
Message-Id: <20200712132634.138901-19-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the previous change that rename egroup
to metric, there's no reason to call the list
'group_list' anymore, renaming it to list.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 45 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9b880a5fb52b..0645ac1031fe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -613,7 +613,7 @@ int __weak arch_get_runtimeparam(void)
 	return 1;
 }
 
-static int __add_metric(struct list_head *group_list,
+static int __add_metric(struct list_head *list,
 			struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
@@ -691,13 +691,13 @@ static int __add_metric(struct list_head *group_list,
 	if (m->refs_cnt)
 		return 0;
 
-	if (list_empty(group_list))
-		list_add(&m->nd, group_list);
+	if (list_empty(list))
+		list_add(&m->nd, list);
 	else {
 		struct list_head *pos;
 
 		/* Place the largest groups at the front. */
-		list_for_each_prev(pos, group_list) {
+		list_for_each_prev(pos, list) {
 			struct metric *old = list_entry(pos, struct metric, nd);
 
 			if (hashmap__size(&m->pctx.ids) <=
@@ -775,7 +775,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	return p->id ? 0 : -ENOMEM;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **mp,
@@ -783,7 +783,7 @@ static int add_metric(struct list_head *group_list,
 
 static int resolve_metric(struct metric *m,
 			  bool metric_no_group,
-			  struct list_head *group_list,
+			  struct list_head *list,
 			  struct pmu_events_map *map)
 {
 	struct hashmap_entry *cur;
@@ -814,7 +814,7 @@ static int resolve_metric(struct metric *m,
 			expr__del_id(&m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
-			ret = add_metric(group_list, pe, metric_no_group, &m, parent);
+			ret = add_metric(list, pe, metric_no_group, &m, parent);
 			if (ret)
 				return ret;
 
@@ -829,7 +829,7 @@ static int resolve_metric(struct metric *m,
 	return 0;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **m,
@@ -840,7 +840,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent);
+		ret = __add_metric(list, pe, metric_no_group, 1, m, parent);
 	} else {
 		int j, count;
 
@@ -848,11 +848,11 @@ static int add_metric(struct list_head *group_list,
 
 		/* This loop is added to create multiple
 		 * events depend on count value and add
-		 * those events to group_list.
+		 * those events to list.
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent);
+			ret = __add_metric(list, pe, metric_no_group, j, m, parent);
 		}
 	}
 
@@ -861,7 +861,7 @@ static int add_metric(struct list_head *group_list,
 
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
-				   struct list_head *group_list,
+				   struct list_head *list,
 				   struct pmu_events_map *map)
 
 {
@@ -873,7 +873,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	if (!pe)
 		return -EINVAL;
 
-	ret = add_metric(group_list, pe, metric_no_group, &m, NULL);
+	ret = add_metric(list, pe, metric_no_group, &m, NULL);
 	if (ret)
 		return ret;
 
@@ -881,8 +881,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	 * Process any possible referenced metrics
 	 * included in the expression.
 	 */
-	ret = resolve_metric(m, metric_no_group,
-			     group_list, map);
+	ret = resolve_metric(m, metric_no_group, list, map);
 	if (ret)
 		return ret;
 
@@ -905,7 +904,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
-					struct list_head *group_list,
+					struct list_head *mlist,
 					struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
@@ -921,7 +920,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      group_list, map);
+					      mlist, map);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -955,11 +954,11 @@ static void metric__free_recursion(struct metric *metric)
 	}
 }
 
-static void metricgroup__free_metrics(struct list_head *group_list)
+static void metricgroup__free_metrics(struct list_head *list)
 {
 	struct metric *m, *tmp;
 
-	list_for_each_entry_safe (m, tmp, group_list, nd) {
+	list_for_each_entry_safe (m, tmp, list, nd) {
 		metric__free_recursion(m);
 		metric__free_refs(m);
 		expr__ctx_clear(&m->pctx);
@@ -977,13 +976,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 {
 	struct parse_events_error parse_error;
 	struct strbuf extra_events;
-	LIST_HEAD(group_list);
+	LIST_HEAD(list);
 	int ret;
 
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &group_list, map);
+					   &extra_events, &list, map);
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
@@ -994,10 +993,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		goto out;
 	}
 	strbuf_release(&extra_events);
-	ret = metricgroup__setup_events(&group_list, metric_no_merge,
+	ret = metricgroup__setup_events(&list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
-	metricgroup__free_metrics(&group_list);
+	metricgroup__free_metrics(&list);
 	return ret;
 }
 
-- 
2.25.4

