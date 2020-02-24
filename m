Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15E4C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D136F20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgBXWAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:00:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:22327 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgBXWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:00:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284477379"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 14:00:39 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/5] perf metricgroup: Support metric constraint
Date:   Mon, 24 Feb 2020 13:59:23 -0800
Message-Id: <1582581564-184429-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
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
 tools/perf/util/metricgroup.c | 54 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1cd042c..c3a8c70 100644
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
@@ -429,6 +431,49 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
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
+static void metricgroup___watchdog_constraint_hint(const char *name, bool foot)
+{
+	static bool violate_nmi_constraint;
+
+	if (!foot) {
+		pr_warning("Splitting metric group %s into standalone metrics.\n", name);
+		violate_nmi_constraint = true;
+		return;
+	}
+
+	if (!violate_nmi_constraint)
+		return;
+
+	pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
+		   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
+		   "    perf stat ...\n"
+		   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+}
+
+static bool metricgroup__has_constraint(struct pmu_event *pe)
+{
+	if (!pe->metric_constraint)
+		return false;
+
+	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
+	    sysctl__nmi_watchdog_enabled()) {
+		metricgroup___watchdog_constraint_hint(pe->metric_name, false);
+		return true;
+	}
+
+	return false;
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -460,7 +505,10 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			if (events->len > 0)
 				strbuf_addf(events, ",");
 
-			metricgroup__add_metric_weak_group(events, ids, idnum);
+			if (metricgroup__has_constraint(pe))
+				metricgroup__add_metric_non_group(events, ids, idnum);
+			else
+				metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
@@ -502,6 +550,10 @@ static int metricgroup__add_metric_list(const char *list, struct strbuf *events,
 		}
 	}
 	free(nlist);
+
+	if (!ret)
+		metricgroup___watchdog_constraint_hint(NULL, true);
+
 	return ret;
 }
 
-- 
2.7.4

