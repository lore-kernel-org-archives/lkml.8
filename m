Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C595206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098696;
	bh=39WFNN1J9sJkMn0WHXfmVkX+rPiKaWeYEBDPZ0zI7GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NY1f65n/NgCEugSZ7t8avHMxcQxbYduLIF/VtXA5ybOUJABNrYtsgrFuHcVZEsSrd
	 qQL6vQgTkSBG3n3ft7zCjeHfyIjlg4Cjgukeq1eHEE+K+Ge6OfpYXv/7EnnpCKBysI
	 PESAhaubVlXO5hVhi96uChbUQpzaY2gVEbJXHiHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgFBLvf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728145AbgFBLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-XDo09HvkMKKZu6St_qx7XA-1; Tue, 02 Jun 2020 07:51:25 -0400
X-MC-Unique: XDo09HvkMKKZu6St_qx7XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A3791030981;
        Tue,  2 Jun 2020 11:51:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 161EF10013D7;
        Tue,  2 Jun 2020 11:51:12 +0000 (UTC)
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
Subject: [PATCH 06/13] perf tools: Add fake_pmu to parse_events function
Date:   Tue,  2 Jun 2020 13:50:48 +0200
Message-Id: <20200602115055.1168446-7-jolsa@kernel.org>
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

Allow to pass fake_pmu in parse_groups function
so it can be used in parse_events call.

It's set true by metricgroup__parse_groups_test
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 47afe5867f9b..f3e761e14e66 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -712,6 +712,7 @@ static void metricgroup__free_egroups(struct list_head *group_list)
 static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
+			bool fake_pmu,
 			struct rblist *metric_events)
 {
 	struct parse_events_error parse_error;
@@ -727,7 +728,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = parse_events(perf_evlist, extra_events.buf, &parse_error, false);
+	ret = parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
@@ -749,7 +750,7 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 
 	return parse_groups(perf_evlist, str, metric_no_group,
-			    metric_no_merge, metric_events);
+			    metric_no_merge, false, metric_events);
 }
 
 bool metricgroup__has_metric(const char *metric)
-- 
2.25.4

