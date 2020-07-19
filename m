Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7780C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3AC22C9E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182441;
	bh=eG3PCviiLXDgwz4vLigSYQrAr1mNr67BMyEOpCmRT10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kdYCfz9r2wiiKqa9JGNu3GVLsBeHk9lGeOfL2SdlabP2r3FYPBQmjaz+w/Rr5NNcA
	 CGG+kFRWSXGSD52zlPzHhT91vo1bRSTo02uO2lhvtvpbmPLPDS28rdcFavJMb1CqPL
	 sbSZHWZigSeqEf+AslUpKGuC0/g/OlRJP2cH/Soo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGSSOA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38511 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726696AbgGSSN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-WANIiW8JOAGGC8-gFj0XTw-1; Sun, 19 Jul 2020 14:13:52 -0400
X-MC-Unique: WANIiW8JOAGGC8-gFj0XTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E79478064DE;
        Sun, 19 Jul 2020 18:13:50 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 178A074F6C;
        Sun, 19 Jul 2020 18:13:47 +0000 (UTC)
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
Subject: [PATCH 08/19] perf metric: Collect referenced metrics in struct metric_ref_node
Date:   Sun, 19 Jul 2020 20:13:09 +0200
Message-Id: <20200719181320.785305-9-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Collecting referenced metrics in struct metric_ref_node object,
so we can process them later on.

The change will parse nested metric names out of expression and
'resolve' them.

All referenced metrics are dissolved into one context, meaning all
nested metrics events and added to the parent context.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 170 +++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ccd80538a6ae..d1b2c1aa436f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -102,12 +102,25 @@ void metricgroup__rblist_exit(struct rblist *metric_events)
 	rblist__exit(metric_events);
 }
 
+/*
+ * A node in the list of referenced metrics. metric_expr
+ * is held as a convenience to avoid a search through the
+ * metric list.
+ */
+struct metric_ref_node {
+	const char *metric_name;
+	const char *metric_expr;
+	struct list_head list;
+};
+
 struct egroup {
 	struct list_head nd;
 	struct expr_parse_ctx pctx;
 	const char *metric_name;
 	const char *metric_expr;
 	const char *metric_unit;
+	struct list_head metric_refs;
+	int metric_refs_cnt;
 	int runtime;
 	bool has_constraint;
 };
@@ -574,27 +587,72 @@ int __weak arch_get_runtimeparam(void)
 static int __add_metric(struct list_head *group_list,
 			struct pmu_event *pe,
 			bool metric_no_group,
-			int runtime)
+			int runtime,
+		        struct egroup **egp)
 {
+	struct metric_ref_node *ref;
 	struct egroup *eg;
 
-	eg = malloc(sizeof(*eg));
-	if (!eg)
-		return -ENOMEM;
+	if (*egp == NULL) {
+		/*
+		 * We got in here for the parent group,
+		 * allocate it and put it on the list.
+		 */
+		eg = malloc(sizeof(*eg));
+		if (!eg)
+			return -ENOMEM;
+
+		expr__ctx_init(&eg->pctx);
+		eg->metric_name = pe->metric_name;
+		eg->metric_expr = pe->metric_expr;
+		eg->metric_unit = pe->unit;
+		eg->runtime = runtime;
+		eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
+		INIT_LIST_HEAD(&eg->metric_refs);
+		eg->metric_refs_cnt = 0;
+		*egp = eg;
+	} else {
+		/*
+		 * We got here for the referenced metric, via the
+		 * recursive metricgroup__add_metric call, add
+		 * it to the parent group.
+		 */
+		eg = *egp;
+
+		ref = malloc(sizeof(*ref));
+		if (!ref)
+			return -ENOMEM;
+
+		/*
+		 * Intentionally passing just const char pointers,
+		 * from 'pe' object, so they never go away. We don't
+		 * need to change them, so there's no need to create
+		 * our own copy.
+		 */
+		ref->metric_name = pe->metric_name;
+		ref->metric_expr = pe->metric_expr;
 
-	expr__ctx_init(&eg->pctx);
-	eg->metric_name = pe->metric_name;
-	eg->metric_expr = pe->metric_expr;
-	eg->metric_unit = pe->unit;
-	eg->runtime = runtime;
-	eg->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
+		list_add(&ref->list, &eg->metric_refs);
+		eg->metric_refs_cnt++;
+	}
 
+	/*
+	 * For both the parent and referenced metrics, we parse
+	 * all the metric's IDs and add it to the parent context.
+	 */
 	if (expr__find_other(pe->metric_expr, NULL, &eg->pctx, runtime) < 0) {
 		expr__ctx_clear(&eg->pctx);
 		free(eg);
 		return -EINVAL;
 	}
 
+	/*
+	 * We add new group only in the 'parent' call,
+	 * so bail out for referenced metric case.
+	 */
+	if (eg->metric_refs_cnt)
+		return 0;
+
 	if (list_empty(group_list))
 		list_add(&eg->nd, group_list);
 	else {
@@ -625,16 +683,78 @@ static int __add_metric(struct list_head *group_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
+static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
+{
+	struct pmu_event *pe;
+	int i;
+
+	map_for_each_event(pe, i, map) {
+		if (match_metric(pe->metric_name, metric))
+			return pe;
+	}
+
+	return NULL;
+}
+
+static int add_metric(struct list_head *group_list,
+		      struct pmu_event *pe,
+		      bool metric_no_group,
+		      struct egroup **egp);
+
+static int resolve_metric(struct egroup *eg,
+			  bool metric_no_group,
+			  struct list_head *group_list,
+			  struct pmu_events_map *map)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+	bool all;
+	int ret;
+
+	/*
+	 * Iterate all the parsed IDs and if there's metric,
+	 * add it to the context.
+	 */
+	do {
+		all = true;
+		hashmap__for_each_entry((&eg->pctx.ids), cur, bkt) {
+			struct pmu_event *pe;
+
+			pe = find_metric(cur->key, map);
+			if (!pe)
+				continue;
+
+			all = false;
+			/* The metric key itself needs to go out.. */
+			expr__del_id(&eg->pctx, cur->key);
+
+			/* ... and it gets resolved to the parent context. */
+			ret = add_metric(group_list, pe, metric_no_group, &eg);
+			if (ret)
+				return ret;
+
+			/*
+			 * We added new metric to hashmap, so we need
+			 * to break the iteration and start over.
+			 */
+			break;
+		}
+	} while (!all);
+
+	return 0;
+}
+
 static int add_metric(struct list_head *group_list,
 		      struct pmu_event *pe,
-		      bool metric_no_group)
+		      bool metric_no_group,
+		      struct egroup **egp)
 {
 	int ret = 0;
 
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
 	if (!strstr(pe->metric_expr, "?")) {
-		ret = __add_metric(group_list, pe, metric_no_group, 1);
+		ret = __add_metric(group_list, pe, metric_no_group, 1, egp);
 	} else {
 		int j, count;
 
@@ -646,7 +766,7 @@ static int add_metric(struct list_head *group_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++) {
-			ret = __add_metric(group_list, pe, metric_no_group, j);
+			ret = __add_metric(group_list, pe, metric_no_group, j, egp);
 		}
 	}
 
@@ -657,6 +777,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *group_list,
 				   struct pmu_events_map *map)
+
 {
 	struct pmu_event *pe;
 	struct egroup *eg;
@@ -665,8 +786,18 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 	map_for_each_metric(pe, i, map, metric) {
 		has_match = true;
+		eg = NULL;
 
-		ret = add_metric(group_list, pe, metric_no_group);
+		ret = add_metric(group_list, pe, metric_no_group, &eg);
+		if (ret)
+			return ret;
+
+		/*
+		 * Process any possible referenced metrics
+		 * included in the expression.
+		 */
+		ret = resolve_metric(eg, metric_no_group,
+				     group_list, map);
 		if (ret)
 			return ret;
 	}
@@ -723,11 +854,22 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 	return ret;
 }
 
+static void egroup__free_refs(struct egroup *egroup)
+{
+	struct metric_ref_node *ref, *tmp;
+
+	list_for_each_entry_safe(ref, tmp, &egroup->metric_refs, list) {
+		list_del(&ref->list);
+		free(ref);
+	}
+}
+
 static void metricgroup__free_egroups(struct list_head *group_list)
 {
 	struct egroup *eg, *egtmp;
 
 	list_for_each_entry_safe (eg, egtmp, group_list, nd) {
+		egroup__free_refs(eg);
 		expr__ctx_clear(&eg->pctx);
 		list_del_init(&eg->nd);
 		free(eg);
-- 
2.25.4

