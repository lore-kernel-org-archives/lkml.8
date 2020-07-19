Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9567C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F14B20684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182435;
	bh=VEB4vLo0c1vpN+EtAI+XRNBpBfomQUbUy1qjTT3rggY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFJw8v9nLRmrWLipGMP9dpjt5hayGcIT2DH9Wa+JU77l8H/7GazY/8cHQv3NnaDaX
	 U0hPuPNn6kirPaWgMEY9Nl5XEMVlwSpU4wWsqziWE+ftK4jbIq7U6E+2ztmkS38iC6
	 vCctZMcQB72mkVO66l2VTOyKmeFlON/VhlFpSOLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGSSNy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:13:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGSSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-eATXo_s8MCWkcix7-Tzzxw-1; Sun, 19 Jul 2020 14:13:46 -0400
X-MC-Unique: eATXo_s8MCWkcix7-Tzzxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78789106B248;
        Sun, 19 Jul 2020 18:13:44 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99D5674F6C;
        Sun, 19 Jul 2020 18:13:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 06/19] perf metric: Add add_metric function
Date:   Sun, 19 Jul 2020 20:13:07 +0200
Message-Id: <20200719181320.785305-7-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple metric adding logging into add_metric function,
so it can be used from other places in following changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 62 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b37008fc253c..4096be7a7a9e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -625,6 +625,39 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
+static int add_metric(struct list_head *group_list,
+		      struct pmu_event *pe,
+		      bool metric_no_group)
+{
+	int ret = 0;
+
+	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+
+	if (!strstr(pe->metric_expr, "?")) {
+		ret = __metricgroup__add_metric(group_list,
+						pe,
+						metric_no_group,
+						1);
+	} else {
+		int j, count;
+
+		count = arch_get_runtimeparam();
+
+		/* This loop is added to create multiple
+		 * events depend on count value and add
+		 * those events to group_list.
+		 */
+
+		for (j = 0; j < count && !ret; j++) {
+			ret = __metricgroup__add_metric(
+				group_list, pe,
+				metric_no_group, j);
+		}
+	}
+
+	return ret;
+}
+
 static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 				   struct strbuf *events,
 				   struct list_head *group_list,
@@ -636,34 +669,11 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 	bool has_match = false;
 
 	map_for_each_metric(pe, i, map, metric) {
-		pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 		has_match = true;
 
-		if (!strstr(pe->metric_expr, "?")) {
-			ret = __metricgroup__add_metric(group_list,
-							pe,
-							metric_no_group,
-							1);
-			if (ret)
-				return ret;
-		} else {
-			int j, count;
-
-			count = arch_get_runtimeparam();
-
-			/* This loop is added to create multiple
-			 * events depend on count value and add
-			 * those events to group_list.
-			 */
-
-			for (j = 0; j < count; j++) {
-				ret = __metricgroup__add_metric(
-					group_list, pe,
-					metric_no_group, j);
-				if (ret)
-					return ret;
-			}
-		}
+		ret = add_metric(group_list, pe, metric_no_group);
+		if (ret)
+			return ret;
 	}
 
 	/* End of pmu events. */
-- 
2.25.4

