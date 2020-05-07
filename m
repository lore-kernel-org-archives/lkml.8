Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BA920CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEGMCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:02:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbgEGMCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D05AFE545BD120C91F3D;
        Thu,  7 May 2020 20:02:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:02:00 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 12/12] perf metricgroup: Support adding metrics for system PMUs
Date:   Thu, 7 May 2020 19:57:51 +0800
Message-ID: <1588852671-61996-13-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only adding metrics for core- or uncore-based events is
supported. Extend this for system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/metricgroup.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ecf14aa01a59..4062bb33912a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -598,6 +598,25 @@ static int metricgroup__add_metric_pmu_event(struct pmu_event *pe,
 	return 0;
 }
 
+struct metricgroup_add_iter_data {
+	const char *metric;
+	struct strbuf *events;
+	struct list_head *group_list;
+	int *ret;
+};
+
+static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
+						  void *data)
+{
+	struct metricgroup_add_iter_data *d = data;
+
+	if (!match_pe_metric(pe, d->metric))
+		return 0;
+
+	return (*d->ret = metricgroup__add_metric_pmu_event(pe, d->events,
+							    d->group_list));
+}
+
 static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				   struct list_head *group_list)
 {
@@ -605,10 +624,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 	struct pmu_event *pe;
 	int i, ret = -EINVAL;
 
-	if (!map)
-		return 0;
-
-	for (i = 0; ; i++) {
+	for (i = 0; map; i++) {
 		pe = &map->table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
@@ -623,6 +639,21 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				return ret;
 		}
 	}
+
+	{
+		struct metricgroup_iter_data data = {
+			.fn = metricgroup__add_metric_sys_event_iter,
+			.data = (void *) &(struct metricgroup_add_iter_data){
+				.metric = metric,
+				.events = events,
+				.group_list = group_list,
+				.ret = &ret,
+			},
+		};
+
+		pmu_for_each_sys_event(metricgroup__sys_event_iter, &data);
+	}
+
 	return ret;
 }
 
-- 
2.16.4

