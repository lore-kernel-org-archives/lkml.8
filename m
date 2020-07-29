Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CE5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180B620663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014439;
	bh=EojW1B9NexzUb0Ygs93AT7oT2TAQAZzQva7naUM7NfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfAYeNwJ9of26YyZKFhDZjxkUu0BQ8SewlSNAnCRrKDvMxvxtBHovxtXM1PJEjM9m
	 /zdvSfMI2vAeUPhshvvt79mqkS+OoRq1Zr1JklojAtvCdrxKLxk757bCeByifJQG4Y
	 eamIu+AM4l/IKKeVi5rlvSY18AjDRrNJCeDvM/Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgG2JUi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728051AbgG2JUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Nlizf3MsP1mJzGDFbGiZxQ-1; Wed, 29 Jul 2020 05:20:29 -0400
X-MC-Unique: Nlizf3MsP1mJzGDFbGiZxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA9D31800D4A;
        Wed, 29 Jul 2020 09:20:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 536F36932D;
        Wed, 29 Jul 2020 09:20:22 +0000 (UTC)
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
Subject: [PATCH 18/19] perf metric: Rename struct egroup to metric
Date:   Wed, 29 Jul 2020 11:19:07 +0200
Message-Id: <20200729091908.1378911-19-jolsa@kernel.org>
In-Reply-To: <20200729091908.1378911-1-jolsa@kernel.org>
References: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming struct egroup to metric, because it seems to make more sense.
Plus renaming all the variables that hold egroup to appropriate names.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 142 +++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 572bcf72e1b6..2bbe1b800696 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -115,7 +115,7 @@ struct metric_ref_node {
 	struct list_head list;
 };
 
-struct egroup {
+struct metric {
 	struct list_head nd;
 	struct expr_parse_ctx pctx;
 	const char *metric_name;
@@ -262,7 +262,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 	struct metric_expr *expr;
 	int i = 0;
 	int ret = 0;
-	struct egroup *eg;
+	struct metric *m;
 	struct evsel *evsel, *tmp;
 	unsigned long *evlist_used;
 
@@ -270,23 +270,23 @@ static int metricgroup__setup_events(struct list_head *groups,
 	if (!evlist_used)
 		return -ENOMEM;
 
-	list_for_each_entry (eg, groups, nd) {
+	list_for_each_entry (m, groups, nd) {
 		struct evsel **metric_events;
 		struct metric_ref *metric_refs = NULL;
 
 		metric_events = calloc(sizeof(void *),
-				hashmap__size(&eg->pctx.ids) + 1);
+				hashmap__size(&m->pctx.ids) + 1);
 		if (!metric_events) {
 			ret = -ENOMEM;
 			break;
 		}
-		evsel = find_evsel_group(perf_evlist, &eg->pctx,
+		evsel = find_evsel_group(perf_evlist, &m->pctx,
 					 metric_no_merge,
-					 eg->has_constraint, metric_events,
+					 m->has_constraint, metric_events,
 					 evlist_used);
 		if (!evsel) {
 			pr_debug("Cannot resolve %s: %s\n",
-					eg->metric_name, eg->metric_expr);
+					m->metric_name, m->metric_expr);
 			free(metric_events);
 			continue;
 		}
@@ -309,10 +309,10 @@ static int metricgroup__setup_events(struct list_head *groups,
 		 * Collect and store collected nested expressions
 		 * for metric processing.
 		 */
-		if (eg->metric_refs_cnt) {
+		if (m->metric_refs_cnt) {
 			struct metric_ref_node *ref;
 
-			metric_refs = zalloc(sizeof(struct metric_ref) * (eg->metric_refs_cnt + 1));
+			metric_refs = zalloc(sizeof(struct metric_ref) * (m->metric_refs_cnt + 1));
 			if (!metric_refs) {
 				ret = -ENOMEM;
 				free(metric_events);
@@ -320,7 +320,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			}
 
 			i = 0;
-			list_for_each_entry(ref, &eg->metric_refs, list) {
+			list_for_each_entry(ref, &m->metric_refs, list) {
 				/*
 				 * Intentionally passing just const char pointers,
 				 * originally from 'struct pmu_event' object.
@@ -334,11 +334,11 @@ static int metricgroup__setup_events(struct list_head *groups,
 		};
 
 		expr->metric_refs = metric_refs;
-		expr->metric_expr = eg->metric_expr;
-		expr->metric_name = eg->metric_name;
-		expr->metric_unit = eg->metric_unit;
+		expr->metric_expr = m->metric_expr;
+		expr->metric_name = m->metric_name;
+		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
-		expr->runtime = eg->runtime;
+		expr->runtime = m->runtime;
 		list_add(&expr->nd, &me->head);
 	}
 
@@ -643,41 +643,41 @@ static int __add_metric(struct list_head *group_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
-			struct egroup **egp,
+			struct metric **mp,
 			struct expr_id *parent,
 			struct expr_ids *ids)
 {
 	struct metric_ref_node *ref;
-	struct egroup *eg;
+	struct metric *m;
 
-	if (*egp == NULL) {
+	if (*mp == NULL) {
 		/*
 		 * We got in here for the parent group,
 		 * allocate it and put it on the list.
 		 */
-		eg = zalloc(sizeof(*eg));
-		if (!eg)
+		m = zalloc(sizeof(*m));
+		if (!m)
 			return -ENOMEM;
 
-		expr__ctx_init(&eg->pctx);
-		eg->metric_name = pe->metric_name;
-		eg->metric_expr = pe->metric_expr;
-		eg->metric_unit = pe->unit;
-		eg->runtime = runtime;
-		eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
-		INIT_LIST_HEAD(&eg->metric_refs);
-		eg->metric_refs_cnt = 0;
-		*egp = eg;
+		expr__ctx_init(&m->pctx);
+		m->metric_name = pe->metric_name;
+		m->metric_expr = pe->metric_expr;
+		m->metric_unit = pe->unit;
+		m->runtime = runtime;
+		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
+		INIT_LIST_HEAD(&m->metric_refs);
+		m->metric_refs_cnt = 0;
+		*mp = m;
 
 		parent = expr_ids__alloc(ids);
 		if (!parent) {
-			free(eg);
+			free(m);
 			return -EINVAL;
 		}
 
 		parent->id = strdup(pe->metric_name);
 		if (!parent->id) {
-			free(eg);
+			free(m);
 			return -ENOMEM;
 		}
 	} else {
@@ -686,7 +686,7 @@ static int __add_metric(struct list_head *group_list,
 		 * recursive metricgroup__add_metric call, add
 		 * it to the parent group.
 		 */
-		eg = *egp;
+		m = *mp;
 
 		ref = malloc(sizeof(*ref));
 		if (!ref)
@@ -701,21 +701,21 @@ static int __add_metric(struct list_head *group_list,
 		ref->metric_name = pe->metric_name;
 		ref->metric_expr = pe->metric_expr;
 
-		list_add(&ref->list, &eg->metric_refs);
-		eg->metric_refs_cnt++;
+		list_add(&ref->list, &m->metric_refs);
+		m->metric_refs_cnt++;
 	}
 
 	/* Force all found IDs in metric to have us as parent ID. */
 	WARN_ON_ONCE(!parent);
-	eg->pctx.parent = parent;
+	m->pctx.parent = parent;
 
 	/*
 	 * For both the parent and referenced metrics, we parse
 	 * all the metric's IDs and add it to the parent context.
 	 */
-	if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
-		expr__ctx_clear(&eg->pctx);
-		free(eg);
+	if (expr__find_other(pe->metric_expr, NULL, &m->pctx, runtime) < 0) {
+		expr__ctx_clear(&m->pctx);
+		free(m);
 		return -EINVAL;
 	}
 
@@ -723,23 +723,23 @@ static int __add_metric(struct list_head *group_list,
 	 * We add new group only in the 'parent' call,
 	 * so bail out for referenced metric case.
 	 */
-	if (eg->metric_refs_cnt)
+	if (m->metric_refs_cnt)
 		return 0;
 
 	if (list_empty(group_list))
-		list_add(&eg->nd, group_list);
+		list_add(&m->nd, group_list);
 	else {
 		struct list_head *pos;
 
 		/* Place the largest groups at the front. */
 		list_for_each_prev(pos, group_list) {
-			struct egroup *old = list_entry(pos, struct egroup, nd);
+			struct metric *old = list_entry(pos, struct metric, nd);
 
-			if (hashmap__size(&eg->pctx.ids) <=
+			if (hashmap__size(&m->pctx.ids) <=
 			    hashmap__size(&old->pctx.ids))
 				break;
 		}
-		list_add(&eg->nd, pos);
+		list_add(&m->nd, pos);
 	}
 
 	return 0;
@@ -769,7 +769,7 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
 	return NULL;
 }
 
-static int recursion_check(struct egroup *eg, const char *id, struct expr_id **parent,
+static int recursion_check(struct metric *m, const char *id, struct expr_id **parent,
 			   struct expr_ids *ids)
 {
 	struct expr_id_data *data;
@@ -782,7 +782,7 @@ static int recursion_check(struct egroup *eg, const char *id, struct expr_id **p
 	 * if we already processed 'id', if we did, it's recursion
 	 * and we fail.
 	 */
-	ret = expr__get_id(&eg->pctx, id, &data);
+	ret = expr__get_id(&m->pctx, id, &data);
 	if (ret)
 		return ret;
 
@@ -816,11 +816,11 @@ static int recursion_check(struct egroup *eg, const char *id, struct expr_id **p
 static int add_metric(struct list_head *group_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
-		      struct egroup **egp,
+		      struct metric **mp,
 		      struct expr_id *parent,
 		      struct expr_ids *ids);
 
-static int resolve_metric(struct egroup *eg,
+static int resolve_metric(struct metric *m,
 			  bool metric_no_group,
 			  struct list_head *group_list,
 			  struct pmu_events_map *map,
@@ -837,7 +837,7 @@ static int resolve_metric(struct egroup *eg,
 	 */
 	do {
 		all = true;
-		hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
+		hashmap__for_each_entry((&m->pctx.ids), cur, bkt) {
 			struct expr_id *parent;
 			struct pmu_event *pe;
 
@@ -845,16 +845,16 @@ static int resolve_metric(struct egroup *eg,
 			if (!pe)
 				continue;
 
-			ret = recursion_check(eg, cur->key, &parent, ids);
+			ret = recursion_check(m, cur->key, &parent, ids);
 			if (ret)
 				return ret;
 
 			all = false;
 			/* The metric key itself needs to go out.. */
-			expr__del_id(&eg->pctx, cur->key);
+			expr__del_id(&m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
-			ret = add_metric(group_list, pe, metric_no_group, &eg, parent, ids);
+			ret = add_metric(group_list, pe, metric_no_group, &m, parent, ids);
 			if (ret)
 				return ret;
 
@@ -872,7 +872,7 @@ static int resolve_metric(struct egroup *eg,
 static int add_metric(struct list_head *group_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
-		      struct egroup **egp,
+		      struct metric **m,
 		      struct expr_id *parent,
 		      struct expr_ids *ids)
 {
@@ -881,7 +881,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1, egp, parent, ids);
+		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent, ids);
 	} else {
 		int j, count;
 
@@ -893,7 +893,7 @@ static int add_metric(struct list_head *group_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j, egp, parent, ids);
+			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent, ids);
 		}
 	}
 
@@ -908,16 +908,16 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 {
 	struct expr_ids ids = { 0 };
 	struct pmu_event *pe;
-	struct egroup *eg;
+	struct metric *m;
 	LIST_HEAD(list);
 	int i, ret;
 	bool has_match = false;
 
 	map_for_each_metric(pe, i, map, metric) {
 		has_match = true;
-		eg = NULL;
+		m = NULL;
 
-		ret = add_metric(&list, pe, metric_no_group, &eg, NULL, &ids);
+		ret = add_metric(&list, pe, metric_no_group, &m, NULL, &ids);
 		if (ret)
 			return ret;
 
@@ -925,7 +925,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		 * Process any possible referenced metrics
 		 * included in the expression.
 		 */
-		ret = resolve_metric(eg, metric_no_group,
+		ret = resolve_metric(m, metric_no_group,
 				     &list, map, &ids);
 		if (ret)
 			return ret;
@@ -935,16 +935,16 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	if (!has_match)
 		return -EINVAL;
 
-	list_for_each_entry(eg, &list, nd) {
+	list_for_each_entry(m, &list, nd) {
 		if (events->len > 0)
 			strbuf_addf(events, ",");
 
-		if (eg->has_constraint) {
+		if (m->has_constraint) {
 			metricgroup__add_metric_non_group(events,
-							  &eg->pctx);
+							  &m->pctx);
 		} else {
 			metricgroup__add_metric_weak_group(events,
-							   &eg->pctx);
+							   &m->pctx);
 		}
 	}
 
@@ -986,25 +986,25 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 	return ret;
 }
 
-static void egroup__free_refs(struct egroup *egroup)
+static void metric__free_refs(struct metric *metric)
 {
 	struct metric_ref_node *ref, *tmp;
 
-	list_for_each_entry_safe(ref, tmp, &egroup->metric_refs, list) {
+	list_for_each_entry_safe(ref, tmp, &metric->metric_refs, list) {
 		list_del(&ref->list);
 		free(ref);
 	}
 }
 
-static void metricgroup__free_egroups(struct list_head *group_list)
+static void metricgroup__free_metrics(struct list_head *group_list)
 {
-	struct egroup *eg, *egtmp;
+	struct metric *m, *tmp;
 
-	list_for_each_entry_safe (eg, egtmp, group_list, nd) {
-		egroup__free_refs(eg);
-		expr__ctx_clear(&eg->pctx);
-		list_del_init(&eg->nd);
-		free(eg);
+	list_for_each_entry_safe (m, tmp, group_list, nd) {
+		metric__free_refs(m);
+		expr__ctx_clear(&m->pctx);
+		list_del_init(&m->nd);
+		free(m);
 	}
 }
 
@@ -1037,7 +1037,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	ret = metricgroup__setup_events(&group_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
-	metricgroup__free_egroups(&group_list);
+	metricgroup__free_metrics(&group_list);
 	return ret;
 }
 
-- 
2.25.4

