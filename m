Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B080C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED420772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098698;
	bh=qURvSTAsIbcxbKUDuCiZxmXrLOubzE5S4+pFedDWcDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vf5Imj6cK3B/2o31inak/GsD3T9LrnHJPxNGKXMWag26Ck+DvA0e/yuPXZnvAw13h
	 xZ9jmQPqCc5vifgwarHbz/i7vFaNmBuXqWnlUitD8hPJ24/wbZj17uuuLznUqMP+5C
	 olTnbjnmLaAEkSldaVuadMR5J4tuMzvGfcoi1D44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgFBLve convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727863AbgFBLv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-LhOn6Yk3P8ujbXGnvQj51w-1; Tue, 02 Jun 2020 07:51:22 -0400
X-MC-Unique: LhOn6Yk3P8ujbXGnvQj51w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98C031030983;
        Tue,  2 Jun 2020 11:51:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC061001281;
        Tue,  2 Jun 2020 11:51:18 +0000 (UTC)
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
Subject: [PATCH 08/13] perf tools: Add metricgroup__parse_groups_test function
Date:   Tue,  2 Jun 2020 13:50:50 +0200
Message-Id: <20200602115055.1168446-9-jolsa@kernel.org>
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

Adding metricgroup__parse_groups_test function. It will
be used as test's interface to metric parsing in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 11 +++++++++++
 tools/perf/util/metricgroup.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 72999aacfa37..fe33fee7f6ad 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -756,6 +756,17 @@ int metricgroup__parse_groups(const struct option *opt,
 			    metric_no_merge, false, metric_events, map);
 }
 
+int metricgroup__parse_groups_test(struct evlist *evlist,
+				   struct pmu_events_map *map,
+				   const char *str,
+				   bool metric_no_group,
+				   bool metric_no_merge,
+				   struct rblist *metric_events)
+{
+	return parse_groups(evlist, str, metric_no_group,
+			    metric_no_merge, true, metric_events, map);
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 287850bcdeca..426c824e20bf 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -7,8 +7,10 @@
 #include <stdbool.h>
 
 struct evsel;
+struct evlist;
 struct option;
 struct rblist;
+struct pmu_events_map;
 
 struct metric_event {
 	struct rb_node nd;
@@ -34,6 +36,13 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
 
+int metricgroup__parse_groups_test(struct evlist *evlist,
+				   struct pmu_events_map *map,
+				   const char *str,
+				   bool metric_no_group,
+				   bool metric_no_merge,
+				   struct rblist *metric_events);
+
 void metricgroup__print(bool metrics, bool groups, char *filter,
 			bool raw, bool details);
 bool metricgroup__has_metric(const char *metric);
-- 
2.25.4

