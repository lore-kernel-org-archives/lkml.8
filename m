Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE0C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA25620757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480811;
	bh=y8SsABXQ2XPXeGeK1hFTHNSBSlRQIkq1HdFyWZj1gmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/3MbNl+DYJqqS7N611NNlQahd36v9dNtQObjqW0JW/3+KOCcDYqHhKnHJMCTVAcf
	 WgI1q3n4DhDGQKYuklQcpWEUlzIsTgfagXTqDkl8gGijyTJnsfi9PmGpRProjJId2N
	 hbkuqr+Ppcw4YDlO7I7AYcZwrrjHgzASUk5CEg0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgCQVda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgCQVd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB78120754;
        Tue, 17 Mar 2020 21:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480806;
        bh=y8SsABXQ2XPXeGeK1hFTHNSBSlRQIkq1HdFyWZj1gmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9IIR4EhUev6q/L9KKJyjnov1ugf/YfEzTFJZsqH+FTdaLo5Fb6daLE7X1jg8wP2x
         sRu3z5IDEiXZzNjlQR9oPcUUEjFjPlpeSdLZBJAO/yRK1JDluC9f5/bRUyToPieLus
         qp6Cl0APsBaExssPCAmOvEg9dL84gQ9n+Is+uZW0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/23] perf metricgroup: Support metric constraint
Date:   Tue, 17 Mar 2020 18:32:41 -0300
Message-Id: <20200317213259.15494-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some metric groups have metric constraints. A metric group can be
scheduled as a group only when some constraints are applied.  For
example, Page_Walks_Utilization has a metric constraint,
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1cd042cb262e..c3a8c701609a 100644
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
2.21.1

