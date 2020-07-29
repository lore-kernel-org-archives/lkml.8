Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7193FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A61620663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014442;
	bh=UAGQxONBoXM321ikXXJ5thEhmujW/JVJ658Xam52tEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCx7Wrtd8ahZ5cmNl/YH60cFZxK+QCJbbJMeRLK0Sh4iHH5rC+iNRvC7t3KMlzHA8
	 +mZ7GvONFDCmpQsu9rn7L3UYPt0vFOUIPYOPlo0sMFTIE6UPOKK2xYCoeD9mqml/Cm
	 tPlRGc4SnMNtZhefooUDps2XdQkAdjKzfbmRdD3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgG2JUl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728362AbgG2JUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-u5k39R8sNDqRtvbOzjUigQ-1; Wed, 29 Jul 2020 05:20:35 -0400
X-MC-Unique: u5k39R8sNDqRtvbOzjUigQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 834DE107ACCA;
        Wed, 29 Jul 2020 09:20:33 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1243A6931E;
        Wed, 29 Jul 2020 09:20:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 19/19] perf metric: Rename group_list to metric_list
Date:   Wed, 29 Jul 2020 11:19:08 +0200
Message-Id: <20200729091908.1378911-20-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the previous change that rename egroup to metric, there's no
reason to call the list 'group_list' anymore, renaming it to
metric_list.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2bbe1b800696..283b5e432559 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -639,7 +639,7 @@ int __weak arch_get_runtimeparam(void)
 	return 1;
 }
 
-static int __add_metric(struct list_head *group_list,
+static int __add_metric(struct list_head *metric_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
@@ -726,13 +726,13 @@ static int __add_metric(struct list_head *group_list,
 	if (m->metric_refs_cnt)
 		return 0;
 
-	if (list_empty(group_list))
-		list_add(&m->nd, group_list);
+	if (list_empty(metric_list))
+		list_add(&m->nd, metric_list);
 	else {
 		struct list_head *pos;
 
 		/* Place the largest groups at the front. */
-		list_for_each_prev(pos, group_list) {
+		list_for_each_prev(pos, metric_list) {
 			struct metric *old = list_entry(pos, struct metric, nd);
 
 			if (hashmap__size(&m->pctx.ids) <=
@@ -813,7 +813,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
 	return p->id ? 0 : -ENOMEM;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **mp,
@@ -822,7 +822,7 @@ static int add_metric(struct list_head *group_list,
 
 static int resolve_metric(struct metric *m,
 			  bool metric_no_group,
-			  struct list_head *group_list,
+			  struct list_head *metric_list,
 			  struct pmu_events_map *map,
 			  struct expr_ids *ids)
 {
@@ -854,7 +854,7 @@ static int resolve_metric(struct metric *m,
 			expr__del_id(&m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
-			ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
+			ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
 			if (ret)
 				return ret;
 
@@ -869,7 +869,7 @@ static int resolve_metric(struct metric *m,
 	return 0;
 }
 
-static int add_metric(struct list_head *group_list,
+static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
 		      struct metric **m,
@@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
+		ret = __add_metric(metric_list, pe, metric_no_group, 1, m, parent, ids);
 	} else {
 		int j, count;
 
@@ -889,11 +889,11 @@ static int add_metric(struct list_head *group_list,
 
 		/* This loop is added to create multiple
 		 * events depend on count value and add
-		 * those events to group_list.
+		 * those events to metric_list.
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
+			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
 		}
 	}
 
@@ -902,7 +902,7 @@ static int add_metric(struct list_head *group_list,
 
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
-				   struct list_head *group_list,
+				   struct list_head *metric_list,
 				   struct pmu_events_map *map)
 
 {
@@ -948,14 +948,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 
-	list_splice(&list, group_list);
+	list_splice(&list, metric_list);
 	expr_ids__exit(&ids);
 	return 0;
 }
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
-					struct list_head *group_list,
+					struct list_head *metric_list,
 					struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
@@ -971,7 +971,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      group_list, map);
+					      metric_list, map);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -996,11 +996,11 @@ static void metric__free_refs(struct metric *metric)
 	}
 }
 
-static void metricgroup__free_metrics(struct list_head *group_list)
+static void metricgroup__free_metrics(struct list_head *metric_list)
 {
 	struct metric *m, *tmp;
 
-	list_for_each_entry_safe (m, tmp, group_list, nd) {
+	list_for_each_entry_safe (m, tmp, metric_list, nd) {
 		metric__free_refs(m);
 		expr__ctx_clear(&m->pctx);
 		list_del_init(&m->nd);
@@ -1017,13 +1017,13 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 {
 	struct parse_events_error parse_error;
 	struct strbuf extra_events;
-	LIST_HEAD(group_list);
+	LIST_HEAD(metric_list);
 	int ret;
 
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &group_list, map);
+					   &extra_events, &metric_list, map);
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
@@ -1034,10 +1034,10 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		goto out;
 	}
 	strbuf_release(&extra_events);
-	ret = metricgroup__setup_events(&group_list, metric_no_merge,
+	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
-	metricgroup__free_metrics(&group_list);
+	metricgroup__free_metrics(&metric_list);
 	return ret;
 }
 
-- 
2.25.4

