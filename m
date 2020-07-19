Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B0C433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822772176B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182469;
	bh=tw3/HWFgfAn3o7tb8ZP+TnCXVohzU3VLdKv+fkQR0yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VUVhxvpjZT2u8Fn029eGjFS1NUNnPSsncpqf802cLjmQgXtrB2MDpcAiCRtKFconN
	 qYBIZTvldQAoLSVGgSoIQVbc4C6FyZO5oxt4BvEO5xtT5JQd6noeRUxy7noJAZVDXo
	 mYGx76xLklQr2urAZQCwNMhtrDa34/l6yDkXyZnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgGSSO0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726959AbgGSSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:25 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-BaCFTuT6Nd-hMS-MMbGsbw-1; Sun, 19 Jul 2020 14:14:20 -0400
X-MC-Unique: BaCFTuT6Nd-hMS-MMbGsbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33AB51083;
        Sun, 19 Jul 2020 18:14:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D18374F6C;
        Sun, 19 Jul 2020 18:14:15 +0000 (UTC)
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
Subject: [PATCH 16/19] perf metric: Make compute_single function more precise
Date:   Sun, 19 Jul 2020 20:13:17 +0200
Message-Id: <20200719181320.785305-17-jolsa@kernel.org>
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

So far compute_single function relies on the fact, that
there's only single metric defined within evlist in all
tests. In following patch we will add test for metric
group, so we need to be able to compute metric by given
name.

Adding the name argument to compute_single and iterating
evlist and evsel's expression to find the given metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

