Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269E32074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098689;
	bh=yObPbJEU/cRg4r4lUMdpWtzrgBiIOLcaiombF/7r7qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9War5uNxWgyU64t+ndvCPeytbl3v3ISVExFtSMV9K7+IzAlRs8lXnnBdts8BDOR6
	 L6eSE4mvclUAQSqZo0HR8ebZpJDBzEneIauTlQEW3AtELCyW0e1j+kwYyTvRw2wxxd
	 qoBdFExpNMNMFimtE621ttGtQ0tV/B2WND3PMoRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgFBLv2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728070AbgFBLv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-hf1vTMizPbmP0VWUWxcakw-1; Tue, 02 Jun 2020 07:51:19 -0400
X-MC-Unique: hf1vTMizPbmP0VWUWxcakw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFFB080B713;
        Tue,  2 Jun 2020 11:51:17 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD2191001281;
        Tue,  2 Jun 2020 11:51:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/13] perf tools: Add map to parse_events function
Date:   Tue,  2 Jun 2020 13:50:49 +0200
Message-Id: <20200602115055.1168446-8-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing purposes we need to pass our own map of events
from parse_groups through metricgroup__add_metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f3e761e14e66..72999aacfa37 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -597,17 +597,14 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
-				   struct list_head *group_list)
+				   struct list_head *group_list,
+				   struct pmu_events_map *map)
 {
-	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
 	struct egroup *eg;
 	int i, ret;
 	bool has_match = false;
 
-	if (!map)
-		return 0;
-
 	for (i = 0; ; i++) {
 		pe = &map->table[i];
 
@@ -668,7 +665,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct strbuf *events,
-				        struct list_head *group_list)
+					struct list_head *group_list,
+					struct pmu_events_map *map)
 {
 	char *llist, *nlist, *p;
 	int ret = -EINVAL;
@@ -683,7 +681,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 	while ((p = strsep(&llist, ",")) != NULL) {
 		ret = metricgroup__add_metric(p, metric_no_group, events,
-					      group_list);
+					      group_list, map);
 		if (ret == -EINVAL) {
 			fprintf(stderr, "Cannot find metric or group `%s'\n",
 					p);
@@ -713,7 +711,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
 			bool fake_pmu,
-			struct rblist *metric_events)
+			struct rblist *metric_events,
+			struct pmu_events_map *map)
 {
 	struct parse_events_error parse_error;
 	struct strbuf extra_events;
@@ -723,7 +722,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	if (metric_events->nr_entries == 0)
 		metricgroup__rblist_init(metric_events);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &extra_events, &group_list);
+					   &extra_events, &group_list, map);
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
@@ -748,9 +747,13 @@ int metricgroup__parse_groups(const struct option *opt,
 			      struct rblist *metric_events)
 {
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
+	struct pmu_events_map *map = perf_pmu__find_map(NULL);
+
+	if (!map)
+		return 0;
 
 	return parse_groups(perf_evlist, str, metric_no_group,
-			    metric_no_merge, false, metric_events);
+			    metric_no_merge, false, metric_events, map);
 }
 
 bool metricgroup__has_metric(const char *metric)
-- 
2.25.4

