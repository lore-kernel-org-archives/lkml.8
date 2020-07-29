Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B976C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA6420663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014429;
	bh=K6tYj+amRlGsenVq3ZPyFOpzNCEBFUPlh/yJ9jQfnG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKfU1bdMHPLro9e5AJYMxHPCZPvKZJMEnw4tG9PdwTKHQ64zOCEPShWJS9TbpjruY
	 9sriMnEG7P1ND3wOCKJKDuqsHt/MKxGNA9nEXOPww2kkQmYKSqdXpXxhAQpCGueGFg
	 E8ymdUCTfRj04COFFiasng/net6YtB4E0cLgmnf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgG2JU2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728328AbgG2JUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Eyu-HyyZM7qVoxYx4ZaFdQ-1; Wed, 29 Jul 2020 05:20:20 -0400
X-MC-Unique: Eyu-HyyZM7qVoxYx4ZaFdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E6FD80046C;
        Wed, 29 Jul 2020 09:20:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD526931E;
        Wed, 29 Jul 2020 09:20:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 16/19] perf metric: Make compute_single function more precise
Date:   Wed, 29 Jul 2020 11:19:05 +0200
Message-Id: <20200729091908.1378911-17-jolsa@kernel.org>
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

So far compute_single function relies on the fact, that there's only
single metric defined within evlist in all tests. In following patch we
will add test for metric group, so we need to be able to compute metric
by given name.

Adding the name argument to compute_single and iterating evlist and
evsel's expression to find the given metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200719181320.785305-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-metric.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 01370ccb9ed9..5ac32f80f8ea 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -108,17 +108,21 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
 }
 
 static double compute_single(struct rblist *metric_events, struct evlist *evlist,
-			     struct runtime_stat *st)
+			     struct runtime_stat *st, const char *name)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct metric_expr *mexp;
 	struct metric_event *me;
+	struct evsel *evsel;
 
-	me = metricgroup__lookup(metric_events, evsel, false);
-	if (me != NULL) {
-		struct metric_expr *mexp;
-
-		mexp = list_first_entry(&me->head, struct metric_expr, nd);
-		return test_generic_metric(mexp, 0, st);
+	evlist__for_each_entry(evlist, evsel) {
+		me = metricgroup__lookup(metric_events, evsel, false);
+		if (me != NULL) {
+			list_for_each_entry (mexp, &me->head, nd) {
+				if (strcmp(mexp->metric_name, name))
+					continue;
+				return test_generic_metric(mexp, 0, st);
+			}
+		}
 	}
 	return 0.;
 }
@@ -162,7 +166,7 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
 	load_runtime_stat(&st, evlist, vals);
 
 	/* And execute the metric */
-	*ratio = compute_single(&metric_events, evlist, &st);
+	*ratio = compute_single(&metric_events, evlist, &st, name);
 
 	/* ... clenup. */
 	metricgroup__rblist_exit(&metric_events);
-- 
2.25.4

