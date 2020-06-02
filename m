Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E24C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827D0205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134494;
	bh=+P2zQ2ScgjEt4egO/RoIFnDMN0RqJTBWI/Kw4bLBMBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NyD/pU3bcEjlG14m7jNDYUwGJx2IvcG1x5vDBcXOGw4XZL3h+YfHlSrEIK2k1a0gh
	 9PSr0m9QY32G0f4VT035vPXhL7VbRTXPV02PX14vYphDNxeo9TxngFpZ+dIBEuYJ6v
	 w6ps/QaVj4azwirN+WzbLwI+t3d5bcrh6g+WJRGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgFBVsO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:48:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28198 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgFBVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-5rEJLBUfPDi1AZxoAlMPlw-1; Tue, 02 Jun 2020 17:48:05 -0400
X-MC-Unique: 5rEJLBUfPDi1AZxoAlMPlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B7C1856941;
        Tue,  2 Jun 2020 21:48:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494201BCBE;
        Tue,  2 Jun 2020 21:47:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/13] perf tools: Factor out parse_groups function
Date:   Tue,  2 Jun 2020 23:47:33 +0200
Message-Id: <20200602214741.1218986-6-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
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

Factor out the parse_groups function, it will be used
for new test interface coming in following changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9a90afb4428c..47afe5867f9b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -709,14 +709,12 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 	}
 }
 
-int metricgroup__parse_groups(const struct option *opt,
-			      const char *str,
-			      bool metric_no_group,
-			      bool metric_no_merge,
-			      struct rblist *metric_events)
+static int parse_groups(struct evlist *perf_evlist, const char *str,
+			bool metric_no_group,
+			bool metric_no_merge,
+			struct rblist *metric_events)
 {
 	struct parse_events_error parse_error;
-	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	struct strbuf extra_events;
 	LIST_HEAD(group_list);
 	int ret;
@@ -742,6 +740,18 @@ int metricgroup__parse_groups(const struct option *opt,
 	return ret;
 }
 
+int metricgroup__parse_groups(const struct option *opt,
+			      const char *str,
+			      bool metric_no_group,
+			      bool metric_no_merge,
+			      struct rblist *metric_events)
+{
+	struct evlist *perf_evlist = *(struct evlist **)opt->value;
+
+	return parse_groups(perf_evlist, str, metric_no_group,
+			    metric_no_merge, metric_events);
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
-- 
2.25.4

