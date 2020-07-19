Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A301DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D38B22482
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182456;
	bh=+BbGrElEHww2npXh1WbknJh7wmnZGEMz0IEqwdL+D6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jnuTEvfzZD/UFg0MGwnHVfPep3tQKOK/oPR+/E8sCF5TSA7YiZms+tswyccRVpaRe
	 thmli0wZkFKU3QpRcFSjpl7dp5EtWLHZ1yBqU5MPCxtmetnBRxFo1hB3EqlHt7IZYd
	 9wbCvJs3eDDWBtITf6NLqHUm55FovHoF39V6B5vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGSSOP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:14:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbgGSSOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:14:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-fxuqUa3SNByjxCB29yBxNA-1; Sun, 19 Jul 2020 14:14:07 -0400
X-MC-Unique: fxuqUa3SNByjxCB29yBxNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67DB618A1DF1;
        Sun, 19 Jul 2020 18:14:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D49C74F6C;
        Sun, 19 Jul 2020 18:14:02 +0000 (UTC)
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
Subject: [PATCH 12/19] perf metric: Add events for the current list
Date:   Sun, 19 Jul 2020 20:13:13 +0200
Message-Id: <20200719181320.785305-13-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to iterate the whole list of groups,
when adding new events. The currently created groups
are the ones we want to add.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index bb5757b9419d..332414d93f7a 100644
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

