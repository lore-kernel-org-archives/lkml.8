Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F06C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA721883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596014411;
	bh=jB1hNwztxmtlfl9Zy49f7zbKJUQ8yfzjgpz1WnP4lfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KupBdEjxLpAmjYdlRHF0/bwf8INjIMpLbpAtrV6KEAT40GHjPw75fV3vDoQMQjf0l
	 RYx8o5MIgRzGsf5wLjRGyBOlXUXAkk5Eo1lt++XklRJchAJJofs/f1khFI4sZ/PEGJ
	 1U7mMWoROdIbTNwChO32mZnJi4Q86BTiATvWYGW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgG2JUK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:20:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38165 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728195AbgG2JUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:09 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-8BytmW01OcWCfHyTO70nbQ-1; Wed, 29 Jul 2020 05:20:02 -0400
X-MC-Unique: 8BytmW01OcWCfHyTO70nbQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02DBF10059A8;
        Wed, 29 Jul 2020 09:20:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804E66931E;
        Wed, 29 Jul 2020 09:19:56 +0000 (UTC)
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
Subject: [PATCH 12/19] perf metric: Add events for the current list
Date:   Wed, 29 Jul 2020 11:19:01 +0200
Message-Id: <20200729091908.1378911-13-jolsa@kernel.org>
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

There's no need to iterate the whole list of groups, when adding new
events. The currently created groups are the ones we want to add.

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
Link: http://lore.kernel.org/lkml/20200719181320.785305-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a9f101948e1f..caec3696e52b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -813,6 +813,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 {
 	struct pmu_event *pe;
 	struct egroup *eg;
+	LIST_HEAD(list);
 	int i, ret;
 	bool has_match = false;
 
@@ -820,7 +821,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		has_match = true;
 		eg = NULL;
 
-		ret = add_metric(group_list, pe, metric_no_group, &eg);
+		ret = add_metric(&list, pe, metric_no_group, &eg);
 		if (ret)
 			return ret;
 
@@ -829,7 +830,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		 * included in the expression.
 		 */
 		ret = resolve_metric(eg, metric_no_group,
-				     group_list, map);
+				     &list, map);
 		if (ret)
 			return ret;
 	}
@@ -838,7 +839,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	if (!has_match)
 		return -EINVAL;
 
-	list_for_each_entry(eg, group_list, nd) {
+	list_for_each_entry(eg, &list, nd) {
 		if (events->len > 0)
 			strbuf_addf(events, ",");
 
@@ -850,6 +851,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 							   &eg->pctx);
 		}
 	}
+
+	list_splice(&list, group_list);
 	return 0;
 }
 
-- 
2.25.4

