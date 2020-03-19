Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD42137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgCSOLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgCSOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvso-00026d-ST; Thu, 19 Mar 2020 15:10:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CEE8D1C22A4;
        Thu, 19 Mar 2020 15:10:46 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf metricgroup: Support metric constraint
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1582581564-184429-5-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704654.28353.11563888471626644942.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ab483d8bc8acb83f0103bc38ef8f2c27d98ffd1b
Gitweb:        https://git.kernel.org/tip/ab483d8bc8acb83f0103bc38ef8f2c27d98ffd1b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 24 Feb 2020 13:59:23 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Mar 2020 14:47:50 -03:00

perf metricgroup: Support metric constraint

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
 tools/perf/util/metricgroup.c | 54 +++++++++++++++++++++++++++++++++-
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
 
