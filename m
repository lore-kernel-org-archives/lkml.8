Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C97E22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014383;
	bh=VmcUq4IZhxV0IMhc6wWiulDy22Lq5MZO1ZoDIPkzTDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOCBGKb8XvIt6Fg3mFBkAIdB5gai1mqljOPVpu18CFsk9yPwTs+qcdBI5hy5zLW6W
	 tPXOi5cVMKKFbM0nQoxmBF00qnwy/dVNFeMPGc4zffHAIJV4lSDlFKs3FvLdrVCNrJ
	 +bgfSopWyUQwO7OS1UwvvF39hfu5DgSbDSvNDSn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgG2JTl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:19:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727846AbgG2JTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-DcXjnSQUPHGsIWE8P5oB-g-1; Wed, 29 Jul 2020 05:19:33 -0400
X-MC-Unique: DcXjnSQUPHGsIWE8P5oB-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446D5800597;
        Wed, 29 Jul 2020 09:19:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4408F6931E;
        Wed, 29 Jul 2020 09:19:28 +0000 (UTC)
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
Subject: [PATCH 05/19] perf metric: Add macros for iterating map events
Date:   Wed, 29 Jul 2020 11:18:54 +0200
Message-Id: <20200729091908.1378911-6-jolsa@kernel.org>
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

Adding following macros to iterate events and metric:

  map_for_each_event(__pe, __idx, __map)
    - iterates over all pmu_events_map events

  map_for_each_metric(__pe, __idx, __map, __metric)
    - iterates over all metrics that match __metric argument

and use it in metricgroup__add_metric function. Macros will be be used
from other places in following changes.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 77 ++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index df0356ec120d..b37008fc253c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -614,6 +614,17 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 	return 0;
 }
 
+#define map_for_each_event(__pe, __idx, __map)				\
+	for (__idx = 0, __pe = &__map->table[__idx];			\
+	     __pe->name || __pe->metric_group || __pe->metric_name;	\
+	     __pe = &__map->table[++__idx])
+
+#define map_for_each_metric(__pe, __idx, __map, __metric)		\
+	map_for_each_event(__pe, __idx, __map)				\
+		if (__pe->metric_expr &&				\
+		    (match_metric(__pe->metric_group, __metric) ||	\
+		     match_metric(__pe->metric_name, __metric)))
+
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *group_list,
@@ -624,49 +635,41 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	int i, ret;
 	bool has_match = false;
 
-	for (i = 0; ; i++) {
-		pe = &map->table[i];
-
-		if (!pe->name && !pe->metric_group && !pe->metric_name) {
-			/* End of pmu events. */
-			if (!has_match)
-				return -EINVAL;
-			break;
-		}
-		if (!pe->metric_expr)
-			continue;
-		if (match_metric(pe->metric_group, metric) ||
-		    match_metric(pe->metric_name, metric)) {
-			has_match = true;
-			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
-
-			if (!strstr(pe->metric_expr, "?")) {
-				ret = __metricgroup__add_metric(group_list,
-								pe,
-								metric_no_group,
-								1);
-				if (ret)
-					return ret;
-			} else {
-				int j, count;
+	map_for_each_metric(pe, i, map, metric) {
+		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+		has_match = true;
+
+		if (!strstr(pe->metric_expr, "?")) {
+			ret = __metricgroup__add_metric(group_list,
+							pe,
+							metric_no_group,
+							1);
+			if (ret)
+				return ret;
+		} else {
+			int j, count;
 
-				count = arch_get_runtimeparam();
+			count = arch_get_runtimeparam();
 
-				/* This loop is added to create multiple
-				 * events depend on count value and add
-				 * those events to group_list.
-				 */
+			/* This loop is added to create multiple
+			 * events depend on count value and add
+			 * those events to group_list.
+			 */
 
-				for (j = 0; j < count; j++) {
-					ret = __metricgroup__add_metric(
-						group_list, pe,
-						metric_no_group, j);
-					if (ret)
-						return ret;
-				}
+			for (j = 0; j < count; j++) {
+				ret = __metricgroup__add_metric(
+					group_list, pe,
+					metric_no_group, j);
+				if (ret)
+					return ret;
 			}
 		}
 	}
+
+	/* End of pmu events. */
+	if (!has_match)
+		return -EINVAL;
+
 	list_for_each_entry(eg, group_list, nd) {
 		if (events->len > 0)
 			strbuf_addf(events, ",");
-- 
2.25.4

