Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0635BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAADA205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134498;
	bh=OKkiDwi7+VOsxFw9iLQeFq3c9QUx9Did1tiVQQqWN+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=btWXvFcF+dEqK3g9+Q0I6Ia69YJxRQvh3joFO2C9Ikv8XfsLDrb6sOt3GxDTYtPAi
	 K3dRbZQ7Ne2eZXJ9r3SkdAWdrF41d6m7sHRDjBEkVmDYNUp/nF+0bdg4XbsYozVcA1
	 V2UJ87yqcHhv7gDPHdkSZxygQW/hNpyWDxFFmZ2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgFBVsS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:48:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28150 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgFBVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:16 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-jXRi7SaUPNyD5VqoRqXi0g-1; Tue, 02 Jun 2020 17:48:12 -0400
X-MC-Unique: jXRi7SaUPNyD5VqoRqXi0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDCB1083E80;
        Tue,  2 Jun 2020 21:48:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB15278EF7;
        Tue,  2 Jun 2020 21:48:05 +0000 (UTC)
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
Subject: [PATCH 06/13] perf tools: Add fake_pmu to parse_events function
Date:   Tue,  2 Jun 2020 23:47:34 +0200
Message-Id: <20200602214741.1218986-7-jolsa@kernel.org>
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

Allow to pass fake_pmu in parse_groups function
so it can be used in parse_events call.

It's set true by metricgroup__parse_groups_test
function.

Acked-by: Ian Rogers <irogers@google.com>
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

