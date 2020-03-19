Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB48C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3DF20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgCSOM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:12:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgCSOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvst-00027g-AU; Thu, 19 Mar 2020 15:10:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B87B21C22AB;
        Thu, 19 Mar 2020 15:10:47 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:47 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf metricgroup: Factor out
 metricgroup__add_metric_weak_group()
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1582581564-184429-3-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704741.28353.1068865705374247213.tip-bot2@tip-bot2>
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

Commit-ID:     f742634ab47f59160a85ddc502418556b21953c2
Gitweb:        https://git.kernel.org/tip/f742634ab47f59160a85ddc502418556b21953c2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 24 Feb 2020 13:59:21 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Mar 2020 14:44:36 -03:00

perf metricgroup: Factor out metricgroup__add_metric_weak_group()

Factor out metricgroup__add_metric_weak_group() which add metrics into a
weak group. The change can improve code readability. Because following
patch will introduce a function which add standalone metrics.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 57 +++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 02aee94..1cd042c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -399,13 +399,42 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	strlist__delete(metriclist);
 }
 
+static void metricgroup__add_metric_weak_group(struct strbuf *events,
+					       const char **ids,
+					       int idnum)
+{
+	bool no_group = false;
+	int i;
+
+	for (i = 0; i < idnum; i++) {
+		pr_debug("found event %s\n", ids[i]);
+		/*
+		 * Duration time maps to a software event and can make
+		 * groups not count. Always use it outside a
+		 * group.
+		 */
+		if (!strcmp(ids[i], "duration_time")) {
+			if (i > 0)
+				strbuf_addf(events, "}:W,");
+			strbuf_addf(events, "duration_time");
+			no_group = true;
+			continue;
+		}
+		strbuf_addf(events, "%s%s",
+			i == 0 || no_group ? "{" : ",",
+			ids[i]);
+		no_group = false;
+	}
+	if (!no_group)
+		strbuf_addf(events, "}:W");
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
-	int ret = -EINVAL;
-	int i, j;
+	int i, ret = -EINVAL;
 
 	if (!map)
 		return 0;
@@ -422,7 +451,6 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
-			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -431,27 +459,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				continue;
 			if (events->len > 0)
 				strbuf_addf(events, ",");
-			for (j = 0; j < idnum; j++) {
-				pr_debug("found event %s\n", ids[j]);
-				/*
-				 * Duration time maps to a software event and can make
-				 * groups not count. Always use it outside a
-				 * group.
-				 */
-				if (!strcmp(ids[j], "duration_time")) {
-					if (j > 0)
-						strbuf_addf(events, "}:W,");
-					strbuf_addf(events, "duration_time");
-					no_group = true;
-					continue;
-				}
-				strbuf_addf(events, "%s%s",
-					j == 0 || no_group ? "{" : ",",
-					ids[j]);
-				no_group = false;
-			}
-			if (!no_group)
-				strbuf_addf(events, "}:W");
+
+			metricgroup__add_metric_weak_group(events, ids, idnum);
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
