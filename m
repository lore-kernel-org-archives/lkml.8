Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFEF20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmb0VI1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgG1NeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:34:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729044AbgG1NeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595943259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUjyG2tIKTvg+aM2b2xVaR0pLtNxdwCm/9QT69IoEUI=;
        b=fmb0VI1MVJTGDgVjNBhCq+kRbY0C6wwIJjlU58q+IgReL6kioKBmXrqjaE32vM+66S+bRQ
        aUTVDuFP3NmDXyBKyJgovYlgYDN3+LxD+PTPugp5xwkOe5XtlwFhrLvYFr3YEZ73RF4BV5
        QwA14QrcNdOghdVVBwm+OBo2og4jSdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-PrGbXNodPG6oRY5s4lYPkw-1; Tue, 28 Jul 2020 09:34:15 -0400
X-MC-Unique: PrGbXNodPG6oRY5s4lYPkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D940B18C63D2;
        Tue, 28 Jul 2020 13:34:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.211])
        by smtp.corp.redhat.com (Postfix) with SMTP id A58DA5C1BD;
        Tue, 28 Jul 2020 13:34:09 +0000 (UTC)
Date:   Tue, 28 Jul 2020 15:34:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHv3 20/19] perf metric: Fix runtime metric for powerpc
Message-ID: <20200728133408.GF1243191@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
 <20200720081943.GE760733@krava>
 <dd465647-da63-c473-9944-bdfec2abe484@linux.ibm.com>
 <20200720191625.GL760733@krava>
 <20200728123955.GZ40195@kernel.org>
 <20200728125456.GD1243191@krava>
 <20200728130100.GE1243191@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728130100.GE1243191@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent code factoring screwed up runtime metrics for powerpc,
because we did not treat separate runtime metrics as single
metrics, but added them as referenced ones.

Fixing this by zero-ing parent metric object for __add_metric
call. Also there's no need to pass metric object to resolve_metric
function, we just need to iterate the metric_list.

Tested/Reviewed-By : Kajol Jain<kjain@linux.ibm.com>
Fixes: e975d61c466b ("perf metric: Collect referenced metrics in struct metric_ref_node")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e91a625fa1be..50bd485094ba 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -820,11 +820,11 @@ static int add_metric(struct list_head *metric_list,
 		      struct expr_id *parent,
 		      struct expr_ids *ids);
 
-static int resolve_metric(struct metric *m,
-			  bool metric_no_group,
-			  struct list_head *metric_list,
-			  struct pmu_events_map *map,
-			  struct expr_ids *ids)
+static int __resolve_metric(struct metric *m,
+			    bool metric_no_group,
+			    struct list_head *metric_list,
+			    struct pmu_events_map *map,
+			    struct expr_ids *ids)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -869,6 +869,23 @@ static int resolve_metric(struct metric *m,
 	return 0;
 }
 
+static int resolve_metric(bool metric_no_group,
+			  struct list_head *metric_list,
+			  struct pmu_events_map *map,
+			  struct expr_ids *ids)
+{
+	struct metric *m;
+	int err;
+
+	list_for_each_entry(m, metric_list, nd) {
+		err = __resolve_metric(m, metric_no_group, metric_list, map, ids);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int add_metric(struct list_head *metric_list,
 		      struct pmu_event *pe,
 		      bool metric_no_group,
@@ -876,6 +893,7 @@ static int add_metric(struct list_head *metric_list,
 		      struct expr_id *parent,
 		      struct expr_ids *ids)
 {
+	struct metric *orig = *m;
 	int ret = 0;
 
 	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
@@ -892,9 +910,8 @@ static int add_metric(struct list_head *metric_list,
 		 * those events to metric_list.
 		 */
 
-		for (j = 0; j < count && !ret; j++) {
+		for (j = 0; j < count && !ret; j++, *m = orig)
 			ret = __add_metric(metric_list, pe, metric_no_group, j, m, parent, ids);
-		}
 	}
 
 	return ret;
@@ -907,8 +924,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 {
 	struct expr_ids ids = { 0 };
+	struct metric *m = NULL;
 	struct pmu_event *pe;
-	struct metric *m;
 	LIST_HEAD(list);
 	int i, ret;
 	bool has_match = false;
@@ -925,7 +942,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		 * Process any possible referenced metrics
 		 * included in the expression.
 		 */
-		ret = resolve_metric(m, metric_no_group,
+		ret = resolve_metric(metric_no_group,
 				     &list, map, &ids);
 		if (ret)
 			return ret;
-- 
2.25.4

