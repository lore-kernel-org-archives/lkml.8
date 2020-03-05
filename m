Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93790C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750562146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCELMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:12:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbgCELMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:32 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5685B9DD2F98D2B313FB;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] perf pmu: Refactor pmu_add_cpu_aliases()
Date:   Thu, 5 Mar 2020 19:08:04 +0800
Message-ID: <1583406486-154841-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create pmu_add_cpu_aliases_map() from pmu_add_cpu_aliases(), so the caller
can pass the map; the pmu-events test would use this since there would
be no CPUID matching to a mapfile there.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 21 +++++++++++++--------
 tools/perf/util/pmu.h |  3 +++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..c616a06a34a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -21,7 +21,6 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "header.h"
-#include "pmu-events/pmu-events.h"
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
@@ -744,16 +743,11 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map)
 {
 	int i;
-	struct pmu_events_map *map;
 	const char *name = pmu->name;
-
-	map = perf_pmu__find_map(pmu);
-	if (!map)
-		return;
-
 	/*
 	 * Found a matching PMU events table. Create aliases
 	 */
@@ -788,6 +782,17 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	}
 }
 
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+{
+	struct pmu_events_map *map;
+
+	map = perf_pmu__find_map(pmu);
+	if (!map)
+		return;
+
+	pmu_add_cpu_aliases_map(head, pmu, map);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..0b4a0efae38e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -7,6 +7,7 @@
 #include <linux/perf_event.h>
 #include <stdbool.h>
 #include "parse-events.h"
+#include "pmu-events/pmu-events.h"
 
 struct perf_evsel_config_term;
 
@@ -97,6 +98,8 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
-- 
2.17.1

