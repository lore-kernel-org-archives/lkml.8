Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9AC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E422206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560478;
	bh=jYfkGeEzbYTauoxraG9AsL7vQfSN82Q5w0dtW1r/MKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NQlzZ+YGqu9hI7U+a99O3e1Lzk5Nhi2bDb+H4WHrMxUvZO0na8OZUm/xJsknY1Lsw
	 vP7FfJzHWNg7+GIgzTUzM38xRJv+WHYxMuomSYrHLoah1Cq9ziiHUOB7zYbukKtHQj
	 +mge1KPcrefJQN/EheHvwY5nNX/USzVFc+LFr4X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGLN15 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729009AbgGLN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-4GMeZD8pNSyLZ1pe1nh5sw-1; Sun, 12 Jul 2020 09:27:36 -0400
X-MC-Unique: 4GMeZD8pNSyLZ1pe1nh5sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE30A80183C;
        Sun, 12 Jul 2020 13:27:34 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB4671944D;
        Sun, 12 Jul 2020 13:27:31 +0000 (UTC)
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
Subject: [PATCH 17/18] perf metric: Rename struct egroup to metric
Date:   Sun, 12 Jul 2020 15:26:33 +0200
Message-Id: <20200712132634.138901-18-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Renaming struct egroup to metric, because it seems
to make more sense. Plus renaming all the variables
that hold egroup to appropriate names.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 158 +++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 69ec20dd737b..9b880a5fb52b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -112,7 +112,7 @@ struct metric_ref_node {
 
 #define RECURSION_ID_MAX 100
 
-struct egroup {
+struct metric {
 	struct list_head nd;
 	struct expr_parse_ctx pctx;
 	const char *metric_name;
@@ -242,7 +242,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 	struct metric_expr *expr;
 	int i = 0;
 	int ret = 0;
-	struct egroup *eg;
+	struct metric *m;
 	struct evsel *evsel, *tmp;
 	unsigned long *evlist_used;
 
@@ -250,23 +250,23 @@ static int metricgroup__setup_events(struct list_head *groups,
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
@@ -289,10 +289,10 @@ static int metricgroup__setup_events(struct list_head *groups,
 		 * Collect and store collected nested expressions
 		 * for metric processing.
 		 */
-		if (eg->refs_cnt) {
+		if (m->refs_cnt) {
 			struct metric_ref_node *ref;
 
-			metric_refs = zalloc(sizeof(struct metric_ref) * (eg->refs_cnt + 1));
+			metric_refs = zalloc(sizeof(struct metric_ref) * (m->refs_cnt + 1));
 			if (!metric_refs) {
 				ret = -ENOMEM;
 				free(metric_events);
@@ -300,7 +300,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 			}
 
 			i = 0;
-			list_for_each_entry(ref, &eg->refs, list) {
+			list_for_each_entry(ref, &m->refs, list) {
 				metric_refs[i].metric_name = ref->metric_name;
 				metric_refs[i].metric_expr = ref->metric_expr;
 				i++;
@@ -308,11 +308,11 @@ static int metricgroup__setup_events(struct list_head *groups,
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
 
@@ -617,38 +617,38 @@ static int __add_metric(struct list_head *group_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
 			int runtime,
-			struct egroup **egp,
+		        struct metric **mp,
 			struct expr_id *parent)
 {
 	struct metric_ref_node *ref;
-	struct egroup *eg;
+	struct metric *m;
 
-	if (*egp == NULL) {
+	if (*mp == NULL) {
 		/*
 		 * We got in here for the master group,
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
-		INIT_LIST_HEAD(&eg->refs);
-		eg->refs_cnt = 0;
-		*egp = eg;
+		expr__ctx_init(&m->pctx);
+		m->metric_name = pe->metric_name;
+		m->metric_expr = pe->metric_expr;
+		m->metric_unit = pe->unit;
+		m->runtime = runtime;
+		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
+		INIT_LIST_HEAD(&m->refs);
+		m->refs_cnt = 0;
+		*mp = m;
 
 		/* Initialize first recursion exr id with base name. */
-		parent = &eg->recursion.id[0];
-		eg->recursion.cnt = 1;
+		parent = &m->recursion.id[0];
+		m->recursion.cnt = 1;
 
 		parent->id = strdup(pe->metric_name);
 		if (!parent->id) {
-			free(eg);
+			free(m);
 			return -ENOMEM;
 		}
 	} else {
@@ -657,7 +657,7 @@ static int __add_metric(struct list_head *group_list,
 		 * recursive metricgroup__add_metric call, add
 		 * it to the master group.
 		 */
-		eg = *egp;
+		m = *mp;
 
 		ref = malloc(sizeof(*ref));
 		if (!ref)
@@ -665,22 +665,22 @@ static int __add_metric(struct list_head *group_list,
 
 		ref->metric_name = pe->metric_name;
 		ref->metric_expr = pe->metric_expr;
-		list_add(&ref->list, &eg->refs);
-		eg->refs_cnt++;
-		eg->has_constraint |= metricgroup__has_constraint(pe);
+		list_add(&ref->list, &m->refs);
+		m->refs_cnt++;
+		m->has_constraint |= metricgroup__has_constraint(pe);
 	}
 
 	/* Force all found IDs in metric to have us as parent ID. */
 	WARN_ON_ONCE(!parent);
-	eg->pctx.parent = parent;
+	m->pctx.parent = parent;
 
 	/*
 	 * For both the master and referenced metrics, we parse
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
 
@@ -688,23 +688,23 @@ static int __add_metric(struct list_head *group_list,
 	 * We add new group only in the 'master' call,
 	 * so bail out for referenced metric case.
 	 */
-	if (eg->refs_cnt)
+	if (m->refs_cnt)
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
@@ -730,7 +730,7 @@ static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *
 	return NULL;
 }
 
-static int recursion_check(struct egroup *eg, const char *id, struct expr_id **parent)
+static int recursion_check(struct metric *m, const char *id, struct expr_id **parent)
 {
 	struct expr_id_data *data;
 	struct expr_id *p;
@@ -742,7 +742,7 @@ static int recursion_check(struct egroup *eg, const char *id, struct expr_id **p
 	 * if we already processed 'id', if we did, it's recursion
 	 * and we fail.
 	 */
-	ret = expr__get_id(&eg->pctx, id, &data);
+	ret = expr__get_id(&m->pctx, id, &data);
 	if (ret)
 		return ret;
 
@@ -760,13 +760,13 @@ static int recursion_check(struct egroup *eg, const char *id, struct expr_id **p
 	 * If we are over the limit of static entris, the metric
 	 * is too difficult/nested to process, fail as well.
 	 */
-	if (eg->recursion.cnt + 1 >= RECURSION_ID_MAX) {
+	if (m->recursion.cnt + 1 >= RECURSION_ID_MAX) {
 		pr_err("failed: too many nested metrics\n");
 		return -EINVAL;
 	}
 
-	p = &eg->recursion.id[eg->recursion.cnt];
-	eg->recursion.cnt++;
+	p = &m->recursion.id[m->recursion.cnt];
+	m->recursion.cnt++;
 
 	p->id     = strdup(id);
 	p->parent = data->parent;
@@ -778,10 +778,10 @@ static int recursion_check(struct egroup *eg, const char *id, struct expr_id **p
 static int add_metric(struct list_head *group_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
-		      struct egroup **egp,
+		      struct metric **mp,
 		      struct expr_id *parent);
 
-static int resolve_metric(struct egroup *eg,
+static int resolve_metric(struct metric *m,
 			  bool metric_no_group,
 			  struct list_head *group_list,
 			  struct pmu_events_map *map)
@@ -797,7 +797,7 @@ static int resolve_metric(struct egroup *eg,
 	 */
 	do {
 		all = true;
-		hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
+		hashmap__for_each_entry((&m->pctx.ids), cur, bkt) {
 			struct expr_id *parent;
 			struct pmu_event *pe;
 
@@ -805,16 +805,16 @@ static int resolve_metric(struct egroup *eg,
 			if (!pe)
 				continue;
 
-			ret = recursion_check(eg, cur->key, &parent);
+			ret = recursion_check(m, cur->key, &parent);
 			if (ret)
 				return ret;
 
 			all = false;
 			/* The metric key itself needs to go out.. */
-			expr__del_id(&eg->pctx, cur->key);
+			expr__del_id(&m->pctx, cur->key);
 
 			/* ... and it gets resolved to the parent context. */
-			ret = add_metric(group_list, pe, metric_no_group, &eg, parent);
+			ret = add_metric(group_list, pe, metric_no_group, &m, parent);
 			if (ret)
 				return ret;
 
@@ -832,7 +832,7 @@ static int resolve_metric(struct egroup *eg,
 static int add_metric(struct list_head *group_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
-		      struct egroup **egp,
+		      struct metric **m,
 		      struct expr_id *parent)
 {
 	int ret = 0;
@@ -840,7 +840,7 @@ static int add_metric(struct list_head *group_list,
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1, egp, parent);
+		ret = __add_metric(group_list, pe, metric_no_group, 1, m, parent);
 	} else {
 		int j, count;
 
@@ -852,7 +852,7 @@ static int add_metric(struct list_head *group_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j, egp, parent);
+			ret = __add_metric(group_list, pe, metric_no_group, j, m, parent);
 		}
 	}
 
@@ -865,7 +865,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct pmu_events_map *map)
 
 {
-	struct egroup *eg = NULL;
+	struct metric *m = NULL;
 	struct pmu_event *pe;
 	int ret;
 
@@ -873,7 +873,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	if (!pe)
 		return -EINVAL;
 
-	ret = add_metric(group_list, pe, metric_no_group, &eg, NULL);
+	ret = add_metric(group_list, pe, metric_no_group, &m, NULL);
 	if (ret)
 		return ret;
 
@@ -881,7 +881,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	 * Process any possible referenced metrics
 	 * included in the expression.
 	 */
-	ret = resolve_metric(eg, metric_no_group,
+	ret = resolve_metric(m, metric_no_group,
 			     group_list, map);
 	if (ret)
 		return ret;
@@ -893,12 +893,12 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	 * Even if we add multiple groups through the runtime
 	 * param, they share same events.
 	 */
-	if (eg->has_constraint) {
+	if (m->has_constraint) {
 		metricgroup__add_metric_non_group(events,
-						  &eg->pctx);
+						  &m->pctx);
 	} else {
 		metricgroup__add_metric_weak_group(events,
-						   &eg->pctx);
+						   &m->pctx);
 	}
 	return 0;
 }
@@ -936,35 +936,35 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 	return ret;
 }
 
-static void egroup__free_refs(struct egroup *egroup)
+static void metric__free_refs(struct metric *metric)
 {
 	struct metric_ref_node *ref, *tmp;
 
-	list_for_each_entry_safe(ref, tmp, &egroup->refs, list) {
+	list_for_each_entry_safe(ref, tmp, &metric->refs, list) {
 		list_del(&ref->list);
 		free(ref);
 	}
 }
 
-static void egroup__free_recursion(struct egroup *egroup)
+static void metric__free_recursion(struct metric *metric)
 {
 	int i;
 
-	for (i = 0; i < egroup->recursion.cnt; i++) {
-		free(egroup->recursion.id[i].id);
+	for (i = 0; i < metric->recursion.cnt; i++) {
+		free(metric->recursion.id[i].id);
 	}
 }
 
-static void metricgroup__free_egroups(struct list_head *group_list)
+static void metricgroup__free_metrics(struct list_head *group_list)
 {
-	struct egroup *eg, *egtmp;
-
-	list_for_each_entry_safe (eg, egtmp, group_list, nd) {
-		egroup__free_recursion(eg);
-		egroup__free_refs(eg);
-		expr__ctx_clear(&eg->pctx);
-		list_del_init(&eg->nd);
-		free(eg);
+	struct metric *m, *tmp;
+
+	list_for_each_entry_safe (m, tmp, group_list, nd) {
+		metric__free_recursion(m);
+		metric__free_refs(m);
+		expr__ctx_clear(&m->pctx);
+		list_del_init(&m->nd);
+		free(m);
 	}
 }
 
@@ -997,7 +997,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	ret = metricgroup__setup_events(&group_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
-	metricgroup__free_egroups(&group_list);
+	metricgroup__free_metrics(&group_list);
 	return ret;
 }
 
-- 
2.25.4

