Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D016C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B17B20776
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360199;
	bh=GPN6pnllQQrI6M77dtz5hmN/Ho4dnsbGOTnH6iSBcVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgLVNFFH8itm46lSBAsC/cwOp6nijwuyC6IhOHW2tnqZUbk9aeNuWASyBs3wnuIo0
	 Cp+TqamWayTd7FVRLAlLCVL77JomcQci1aRYShFJ8ldyIcB+g5a9RTCRxEkVNcB6Qo
	 JAImOXbVbJTq2fNhBCCm68I7Erocr3h4M+Yiv7ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgEXWnG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:43:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27023 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388607AbgEXWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:43:01 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-vryBCJ15OIqULXy29LpnRA-1; Sun, 24 May 2020 18:42:54 -0400
X-MC-Unique: vryBCJ15OIqULXy29LpnRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD20460;
        Sun, 24 May 2020 22:42:52 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AECF5D788;
        Sun, 24 May 2020 22:42:49 +0000 (UTC)
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
Subject: [PATCH 09/14] perf tools: Add fake_pmu to parse_events function
Date:   Mon, 25 May 2020 00:42:14 +0200
Message-Id: <20200524224219.234847-10-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
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

Allow to set fake_pmu new parse_groups function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e2b4c621700c..547f83ee5c68 100644
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
@@ -727,7 +728,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
+
+	if (fake_pmu)
+		ret = parse_events_fake(perf_evlist, extra_events.buf, &parse_error);
+	else
+		ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
@@ -749,7 +754,7 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 
 	return parse_groups(perf_evlist, str, metric_no_group,
-			    metric_no_merge, metric_events);
+			    metric_no_merge, false, metric_events);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
-- 
2.25.4

