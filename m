Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8691C433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C3720725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594560429;
	bh=0RjXj6BzcWBSzLOLGBJdmj21uWZ9EcLKtqmdfkZYbJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tKCiVRpiLrh0MIyz9BKMkvjdVDcU8WKa5DG/1sl/OyjuByvSefU0HB2Ah5Gr4kVQG
	 ol0kQCQYL02lIAHvbWPvKJrymxn+r6QL8Ncu3qILDVNVYZmU3rWdaFXrbwG68GuV5+
	 T5eewE2JQZJABeEiPHMe/XNRCtxdcl+LY8iOWhLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgGLN1I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:27:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60801 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728939AbgGLN1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:27:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-7WfGfLASNY-xjiA9LOaoIg-1; Sun, 12 Jul 2020 09:27:01 -0400
X-MC-Unique: 7WfGfLASNY-xjiA9LOaoIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1845C1085;
        Sun, 12 Jul 2020 13:26:59 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 447BE7EFB6;
        Sun, 12 Jul 2020 13:26:56 +0000 (UTC)
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
Subject: [PATCH 06/18] perf metric: Add find_metric function
Date:   Sun, 12 Jul 2020 15:26:22 +0200
Message-Id: <20200712132634.138901-7-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-1-jolsa@kernel.org>
References: <20200712132634.138901-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Decouple lookup metric logic into find_metric function,
so it can be used from other places in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/metricgroup.c | 89 +++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index df0356ec120d..72552608ff7d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -614,57 +614,64 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 	return 0;
 }
 
-static int metricgroup__add_metric(const char *metric, bool metric_no_group,
-				   struct strbuf *events,
-				   struct list_head *group_list,
-				   struct pmu_events_map *map)
+static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
 {
 	struct pmu_event *pe;
-	struct egroup *eg;
-	int i, ret;
-	bool has_match = false;
+	int i;
 
 	for (i = 0; ; i++) {
 		pe = &map->table[i];
-
-		if (!pe->name && !pe->metric_group && !pe->metric_name) {
-			/* End of pmu events. */
-			if (!has_match)
-				return -EINVAL;
+		/* End of pmu events. */
+		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
-		}
 		if (!pe->metric_expr)
 			continue;
 		if (match_metric(pe->metric_group, metric) ||
-		    match_metric(pe->metric_name, metric)) {
-			has_match = true;
-			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
-
-			if (!strstr(pe->metric_expr, "?")) {
-				ret = __metricgroup__add_metric(group_list,
-								pe,
-								metric_no_group,
-								1);
-				if (ret)
-					return ret;
-			} else {
-				int j, count;
-
-				count = arch_get_runtimeparam();
-
-				/* This loop is added to create multiple
-				 * events depend on count value and add
-				 * those events to group_list.
-				 */
+		    match_metric(pe->metric_name, metric))
+			return pe;
+	}
 
-				for (j = 0; j < count; j++) {
-					ret = __metricgroup__add_metric(
-						group_list, pe,
-						metric_no_group, j);
-					if (ret)
-						return ret;
-				}
-			}
+	return NULL;
+}
+
+static int metricgroup__add_metric(const char *metric, bool metric_no_group,
+				   struct strbuf *events,
+				   struct list_head *group_list,
+				   struct pmu_events_map *map)
+{
+	struct pmu_event *pe;
+	struct egroup *eg;
+	int ret;
+
+	pe = find_metric(metric, map);
+	if (!pe)
+		return -EINVAL;
+
+	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
+
+	if (!strstr(pe->metric_expr, "?")) {
+		ret = __metricgroup__add_metric(group_list,
+						pe,
+						metric_no_group,
+						1);
+		if (ret)
+			return ret;
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
+		for (j = 0; j < count; j++) {
+			ret = __metricgroup__add_metric(
+				group_list, pe,
+				metric_no_group, j);
+			if (ret)
+				return ret;
 		}
 	}
 	list_for_each_entry(eg, group_list, nd) {
-- 
2.25.4

