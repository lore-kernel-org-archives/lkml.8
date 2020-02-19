Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A30C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B752465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBSTKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:10:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:7642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgBSTKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:10:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 11:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="408536208"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2020 11:10:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf metricgroup: Support metric constraint
Date:   Wed, 19 Feb 2020 11:08:39 -0800
Message-Id: <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some metric groups have metric constraints. A metric group can be
scheduled as a group only when some constraints are applied.
For example, Page_Walks_Utilization has a metric constraint,
"NO_NMI_WATCHDOG".
When NMI watchdog is disabled, the metric group can be scheduled as a
group. Otherwise, splitting the metric group into standalone metrics.

Add a new function, metricgroup__has_constraint(), to check whether all
constraints are applied. If not, splitting the metric group into
standalone metrics.

Currently, only one constraint, "NO_NMI_WATCHDOG", is checked. Print a
warning for the metric group with the constraint, when NMI WATCHDOG is
enabled.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1cd042c..f9a9b50 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -22,6 +22,8 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/parse-options.h>
+#include <api/fs/fs.h>
+#include "util.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -429,6 +431,34 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
 		strbuf_addf(events, "}:W");
 }
 
+static void metricgroup__add_metric_non_group(struct strbuf *events,
+					      const char **ids,
+					      int idnum)
+{
+	int i;
+
+	for (i = 0; i < idnum; i++)
+		strbuf_addf(events, ",%s", ids[i]);
+}
+
+static bool violate_nmi_constraint;
+
+static bool metricgroup__has_constraint(struct pmu_event *pe)
+{
+	if (!pe->metric_constraint)
+		return false;
+
+	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
+	    sysctl__nmi_watchdog_enabled()) {
+		pr_warning("Splitting metric group %s into standalone metrics.\n",
+			   pe->metric_name);
+		violate_nmi_constraint = true;
+		return true;
+	}
+
+	return false;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -460,7 +490,10 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			if (events->len > 0)
 				strbuf_addf(events, ",");
 
-			metricgroup__add_metric_weak_group(events, ids, idnum);
+			if (metricgroup__has_constraint(pe))
+				metricgroup__add_metric_non_group(events, ids, idnum);
+			else
+				metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
@@ -544,6 +577,13 @@ int metricgroup__parse_groups(const struct option *opt,
 	strbuf_release(&extra_events);
 	ret = metricgroup__setup_events(&group_list, perf_evlist,
 					metric_events);
+
+	if (violate_nmi_constraint) {
+		pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
+			   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+			   "    perf stat ...\n"
+			   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+	}
 out:
 	metricgroup__free_egroups(&group_list);
 	return ret;
-- 
2.7.4

