Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8C521883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014399;
	bh=m4c/WIFOmh0tDCgon9pmR3tE5DjicLTJW2HSfel+Pls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIJWS60ScuyJpy/ncg35eva47w9oJLT2ftAd2zrtNkHRmAF9ofZynw2Kp0QC2hqda
	 BpEm3Kx6Y+6rs04Grgx1oJymPLF6CnS1xbQBDXiBbRCDl1oOGk1kk2HW9oYiqzDuNZ
	 x+ez9tacHmWsZGzkdYzRoMOTcnrJCsBKAznt/3og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgG2JT6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:19:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27132 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728249AbgG2JTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-ywQpxUUCMp2lGhMX3z11dw-1; Wed, 29 Jul 2020 05:19:50 -0400
X-MC-Unique: ywQpxUUCMp2lGhMX3z11dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A798106B242;
        Wed, 29 Jul 2020 09:19:48 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC2756932D;
        Wed, 29 Jul 2020 09:19:44 +0000 (UTC)
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
Subject: [PATCH 09/19] perf metric: Collect referenced metrics in struct metric_expr
Date:   Wed, 29 Jul 2020 11:18:58 +0200
Message-Id: <20200729091908.1378911-10-jolsa@kernel.org>
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

Add referenced metrics into struct metric_expr object, so they are
accessible when computing the metric.

Storing just name and expression itself, so the metric can be resolved
and computed.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0997df4e4f52..a9f101948e1f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 	struct metric_expr *expr, *tmp;
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
+		free(expr->metric_refs);
 		free(expr);
 	}
 
@@ -248,6 +249,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
+		struct metric_ref *metric_refs = NULL;
 
 		metric_events = calloc(sizeof(void *),
 				hashmap__size(&eg->pctx.ids) + 1);
@@ -279,6 +281,36 @@ static int metricgroup__setup_events(struct list_head *groups,
 			free(metric_events);
 			break;
 		}
+
+		/*
+		 * Collect and store collected nested expressions
+		 * for metric processing.
+		 */
+		if (eg->metric_refs_cnt) {
+			struct metric_ref_node *ref;
+
+			metric_refs = zalloc(sizeof(struct metric_ref) * (eg->metric_refs_cnt + 1));
+			if (!metric_refs) {
+				ret = -ENOMEM;
+				free(metric_events);
+				break;
+			}
+
+			i = 0;
+			list_for_each_entry(ref, &eg->metric_refs, list) {
+				/*
+				 * Intentionally passing just const char pointers,
+				 * originally from 'struct pmu_event' object.
+				 * We don't need to change them, so there's no
+				 * need to create our own copy.
+				 */
+				metric_refs[i].metric_name = ref->metric_name;
+				metric_refs[i].metric_expr = ref->metric_expr;
+				i++;
+			}
+		};
+
+		expr->metric_refs = metric_refs;
 		expr->metric_expr = eg->metric_expr;
 		expr->metric_name = eg->metric_name;
 		expr->metric_unit = eg->metric_unit;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8315bd1a7da4..62623a39cbec 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -18,12 +18,18 @@ struct metric_event {
 	struct list_head head; /* list of metric_expr */
 };
 
+struct metric_ref {
+	const char *metric_name;
+	const char *metric_expr;
+};
+
 struct metric_expr {
 	struct list_head nd;
 	const char *metric_expr;
 	const char *metric_name;
 	const char *metric_unit;
 	struct evsel **metric_events;
+	struct metric_ref *metric_refs;
 	int runtime;
 };
 
-- 
2.25.4

