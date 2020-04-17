Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40DC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4574F221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgDQKp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729143AbgDQKp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DCDC2D37064B8C8AEBB;
        Fri, 17 Apr 2020 18:45:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:20 +0800
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
Subject: [RFC PATCH v2 06/13] perf vendor events arm64: Add hip08 SMMUv3 PMCG events
Date:   Fri, 17 Apr 2020 18:41:17 +0800
Message-ID: <1587120084-18990-7-git-send-email-john.garry@huawei.com>
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

Add the SMMUv3 PMCG (Performance Monitor Event Group) events for hip08
platform.

This contains a mix of architected and IMP def events

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json    | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
new file mode 100644
index 000000000000..f2a1cb0332a6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
@@ -0,0 +1,42 @@
+[
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CYCLES"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANSACTION"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TLB_MISS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_CACHE_MISS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED"
+	    "Compat": "hip08"
+   },
+   {
+	    "EventCode": "0x8a",
+	    "EventName": "smmuv3_pmcg.L1_TLB",
+	    "BriefDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "PublicDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "Unit": "smmuv3_pmcg",
+	    "Compat": "hip08"
+   },
+]
-- 
2.16.4

