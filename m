Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F4C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3022075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEGMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:02:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgEGMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9590B2471D12B6EA3F03;
        Thu,  7 May 2020 20:02:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:01:58 +0800
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
Subject: [PATCH RFC v3 07/12] perf pmu: Add pmu_add_sys_aliases()
Date:   Thu, 7 May 2020 19:57:46 +0800
Message-ID: <1588852671-61996-8-git-send-email-john.garry@huawei.com>
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

Add pmu_add_sys_aliases() to add system PMU events aliases.

For adding system PMU events, we iterate through all the events per
SoC event table in pmu_sys_event_tables[].

Matches must satisfy both:
- PMU identifer matches event "compat" value
- like uncore event matching, the event "Unit" member must match; this
  match under return value of pmu_uncore_alias_match() (maybe rename that
  function?)

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 80 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6f77c6af9e04..3986d2360fc1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -809,6 +809,83 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	pmu_add_cpu_aliases_map(head, pmu, map);
 }
 
+void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
+{
+	int i = 0;
+
+	while (1) {
+		struct pmu_sys_events *event_table;
+		int j = 0;
+
+		event_table = &pmu_sys_event_tables[i++];
+
+		if (!event_table->table)
+			break;
+
+		while (1) {
+			struct pmu_event *pe = &event_table->table[j++];
+			int ret;
+
+			if (!pe->name && !pe->metric_group && !pe->metric_name)
+				break;
+
+			ret = fn(pe, data);
+			if (ret)
+				break;
+		}
+	}
+}
+
+struct pmu_sys_event_iter_data {
+	struct list_head *head;
+	struct perf_pmu *pmu;
+};
+
+static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
+{
+	struct pmu_sys_event_iter_data *idata = data;
+	struct perf_pmu *pmu = idata->pmu;
+
+	if (!pe->name) {
+		if (pe->metric_group || pe->metric_name)
+			return 0;
+		return -EINVAL;
+	}
+
+	if (!pe->compat || !pe->pmu)
+		return 0;
+
+	if (!strcmp(pmu->id, pe->compat) &&
+	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
+		__perf_pmu__new_alias(idata->head, NULL,
+				      (char *)pe->name,
+				      (char *)pe->desc,
+				      (char *)pe->event,
+				      (char *)pe->long_desc,
+				      (char *)pe->topic,
+				      (char *)pe->unit,
+				      (char *)pe->perpkg,
+				      (char *)pe->metric_expr,
+				      (char *)pe->metric_name,
+				      (char *)pe->deprecated);
+	}
+
+	return 0;
+}
+
+static void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu)
+{
+	struct pmu_sys_event_iter_data idata = {
+		.head = head,
+		.pmu = pmu,
+	};
+
+	if (!pmu->id)
+		return;
+
+	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, &idata);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
@@ -864,6 +941,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
+	pmu_add_sys_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 62ebca9481fe..f75f54afb354 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -106,6 +106,8 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 
+typedef int (*pmu_sys_event_iter_fn)(struct pmu_event *pe, void *data);
+void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data);
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 #endif /* __PMU_H */
-- 
2.16.4

