Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B820D20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200882;
	bh=jwOnv3GsK3v3Tr89KKmM8aAFTFpMoRKwiie7CC0I7B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0zQqPi1DnpSkvPMArOXrJASTUnMAsqM7thAGbMwD4HMgFcKOqv/1UvwXC6wk7QIa
	 tCGzZSF42CyXcKOjRA8/WtbCwkefEs0RAtZkggeievyYtVfZjMGH//VjyW2NPjRlND
	 BCWlkM5iYDtnTWDH9OBPMKrauqEVkSK6kMpwHZko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgFZTsB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:48:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgFZTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:59 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-g4Z37pvyPPi7rR5uXcrzwQ-1; Fri, 26 Jun 2020 15:47:54 -0400
X-MC-Unique: g4Z37pvyPPi7rR5uXcrzwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A6F800D5C;
        Fri, 26 Jun 2020 19:47:52 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4431944D;
        Fri, 26 Jun 2020 19:47:49 +0000 (UTC)
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
Subject: [PATCH 07/10] perf tools: Collect other metrics in struct metric_expr
Date:   Fri, 26 Jun 2020 21:47:17 +0200
Message-Id: <20200626194720.2915044-8-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-1-jolsa@kernel.org>
References: <20200626194720.2915044-1-jolsa@kernel.org>
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

Add 'other' metrics into struct metric_expr object,
so they are accessible when computing the metric.

Storing just name and expression itself, so the metric
can be resolved and computed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 27 +++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f88fd667cc78..a5d5dcc1b805 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
 	struct metric_expr *expr, *tmp;
 
 	list_for_each_entry_safe(expr, tmp, &me->head, nd) {
+		free(expr->metric_other);
 		free(expr);
 	}
 
@@ -243,6 +244,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 
 	list_for_each_entry (eg, groups, nd) {
 		struct evsel **metric_events;
+		struct metric_other *other = NULL;
 
 		metric_events = calloc(sizeof(void *),
 				hashmap__size(&eg->pctx.ids) + 1);
@@ -274,6 +276,31 @@ static int metricgroup__setup_events(struct list_head *groups,
 			free(metric_events);
 			break;
 		}
+
+		/*
+		 * Collect and store collected 'other' expressions
+		 * for metric processing.
+		 */
+		if (eg->other_cnt) {
+			struct eother *eo;
+
+			other = zalloc(sizeof(struct metric_other) * (eg->other_cnt + 1));
+			if (!other) {
+				ret = -ENOMEM;
+				free(metric_events);
+				free(other);
+				break;
+			}
+
+			i = 0;
+			list_for_each_entry(eo, &eg->other, list) {
+				other[i].metric_name = eo->metric_name;
+				other[i].metric_expr = eo->metric_expr;
+				i++;
+			}
+		};
+
+		expr->metric_other = other;
 		expr->metric_expr = eg->metric_expr;
 		expr->metric_name = eg->metric_name;
 		expr->metric_unit = eg->metric_unit;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 8315bd1a7da4..3a1e320cb2d3 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -18,12 +18,18 @@ struct metric_event {
 	struct list_head head; /* list of metric_expr */
 };
 
+struct metric_other {
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
+	struct metric_other *metric_other;
 	int runtime;
 };
 
-- 
2.25.4

