Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F692C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6993B221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgDQKpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729945AbgDQKpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B57A69A7C71A36E71477;
        Fri, 17 Apr 2020 18:45:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:22 +0800
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
Subject: [RFC PATCH v2 12/13] perf metricgroup: Support printing metric groups for system PMUs
Date:   Fri, 17 Apr 2020 18:41:23 +0800
Message-ID: <1587120084-18990-13-git-send-email-john.garry@huawei.com>
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

Currently only metricgroups for core- or uncore-based events is supported.
Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 31e97e24c2b0..81a6aa04a601 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -377,19 +377,55 @@ static void metricgroup__print_pmu_event(struct pmu_event *pe,
 	}
 }
 
+struct metricgroup_print_sys_idata {
+	struct strlist *metriclist;
+	bool metricgroups;
+	char *filter;
+	bool raw;
+	bool details;
+	struct rblist *groups;
+};
+
+typedef int (*metricgroup_sys_event_iter_fn)(struct pmu_event *pe, void *);
+
+struct metricgroup_iter_data {
+	metricgroup_sys_event_iter_fn fn;
+	void *data;
+};
+
+static int metricgroup__sys_event_iter(struct perf_pmu *pmu,
+				       struct pmu_event *pe,
+				       void *data)
+{
+	struct metricgroup_iter_data *d = data;
+
+	if (!pe->metric_expr || !pe->compat || strcmp(pe->compat, pmu->id))
+		return 0;
+
+	return d->fn(pe, d->data);
+}
+
+static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
+{
+	struct metricgroup_print_sys_idata *d = data;
+
+	metricgroup__print_pmu_event(pe, d->metricgroups, d->filter, d->raw,
+				     d->details, d->groups, d->metriclist);
+
+	return 0;
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details)
 {
 	struct pmu_events_map *map = perf_pmu__find_map(NULL);
 	struct pmu_event *pe;
+	struct perf_pmu *pmu = NULL;
 	int i;
 	struct rblist groups;
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
 
-	if (!map)
-		return;
-
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
 		if (!metriclist)
@@ -400,7 +436,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (i = 0; ; i++) {
+	for (i = 0; map; i++) {
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
@@ -412,6 +448,23 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 					     details, &groups, metriclist);
 	}
 
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		struct metricgroup_iter_data data = {
+			.fn = metricgroup__print_sys_event_iter,
+			.data = (void *) &(struct metricgroup_print_sys_idata){
+				.metriclist = metriclist,
+				.metricgroups = metricgroups,
+				.filter = filter,
+				.raw = raw,
+				.details = details,
+				.groups = &groups,
+			},
+		};
+
+		pmu_for_each_sys_event(pmu, metricgroup__sys_event_iter,
+				       &data);
+	}
+
 	if (metricgroups && !raw)
 		printf("\nMetric Groups:\n\n");
 	else if (metrics && !raw)
-- 
2.16.4

