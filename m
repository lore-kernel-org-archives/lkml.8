Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF68C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52FE3221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgDQKpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729954AbgDQKpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA8E422B716E232EB4CD;
        Fri, 17 Apr 2020 18:45:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>
CC:     <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 11/13] perf metricgroup: Split up metricgroup__print()
Date:   Fri, 17 Apr 2020 18:41:22 +0800
Message-ID: <1587120084-18990-12-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To aid supporting system event metric groups, break up the function
metricgroup__print() into a part which iterates metrics and a part
which actually "prints" the metric.

No functional change intended.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 117 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d1033756a1bc..31e97e24c2b0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -315,6 +315,68 @@ static void metricgroup__print_strlist(struct strlist *metrics, bool raw)
 		putchar('\n');
 }
 
+
+static void metricgroup__print_pmu_event(struct pmu_event *pe,
+					 bool metricgroups, char *filter,
+					 bool raw, bool details,
+					 struct rblist *groups,
+					 struct strlist *metriclist)
+{
+	const char *g;
+
+	g = pe->metric_group;
+	if (!g && pe->metric_name) {
+		if (pe->name)
+			return;
+		g = "No_group";
+	}
+
+	if (g) {
+		char *omg;
+		char *mg = strdup(g);
+
+		if (!mg)
+			return;
+		omg = mg;
+		while ((g = strsep(&mg, ";")) != NULL) {
+			struct mep *me;
+			char *s;
+
+			g = skip_spaces(g);
+			if (*g == 0)
+				g = "No_group";
+			if (filter && !strstr(g, filter))
+				continue;
+			if (raw)
+				s = (char *)pe->metric_name;
+			else {
+				if (asprintf(&s, "%s\n%*s%s]", pe->metric_name,
+					     8, "[", pe->desc) < 0)
+					return;
+
+				if (details) {
+					if (asprintf(&s, "%s\n%*s%s]", s, 8,
+						     "[", pe->metric_expr) < 0)
+						return;
+				}
+			}
+
+			if (!s)
+				continue;
+
+			if (!metricgroups) {
+				strlist__add(metriclist, s);
+			} else {
+				me = mep_lookup(groups, g);
+				if (!me)
+					continue;
+				strlist__add(me->metrics, s);
+			}
+		}
+		free(omg);
+	}
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
@@ -339,63 +401,15 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
 	for (i = 0; ; i++) {
-		const char *g;
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
 		if (!pe->metric_expr)
 			continue;
-		g = pe->metric_group;
-		if (!g && pe->metric_name) {
-			if (pe->name)
-				continue;
-			g = "No_group";
-		}
-		if (g) {
-			char *omg;
-			char *mg = strdup(g);
-
-			if (!mg)
-				return;
-			omg = mg;
-			while ((g = strsep(&mg, ";")) != NULL) {
-				struct mep *me;
-				char *s;
-
-				g = skip_spaces(g);
-				if (*g == 0)
-					g = "No_group";
-				if (filter && !strstr(g, filter))
-					continue;
-				if (raw)
-					s = (char *)pe->metric_name;
-				else {
-					if (asprintf(&s, "%s\n%*s%s]",
-						     pe->metric_name, 8, "[", pe->desc) < 0)
-						return;
-
-					if (details) {
-						if (asprintf(&s, "%s\n%*s%s]",
-							     s, 8, "[", pe->metric_expr) < 0)
-							return;
-					}
-				}
-
-				if (!s)
-					continue;
 
-				if (!metricgroups) {
-					strlist__add(metriclist, s);
-				} else {
-					me = mep_lookup(&groups, g);
-					if (!me)
-						continue;
-					strlist__add(me->metrics, s);
-				}
-			}
-			free(omg);
-		}
+		metricgroup__print_pmu_event(pe, metricgroups, filter, raw,
+					     details, &groups, metriclist);
 	}
 
 	if (metricgroups && !raw)
@@ -407,7 +421,8 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
-			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
+			printf("%s%s%s", me->name, metrics && !raw ? ":" : "",
+			       raw ? " " : "\n");
 		if (metrics)
 			metricgroup__print_strlist(me->metrics, raw);
 		next = rb_next(node);
-- 
2.16.4

