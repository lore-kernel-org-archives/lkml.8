Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA9C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660C021473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgEGMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:02:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgEGMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A63FE10C1DAEE116B8E2;
        Thu,  7 May 2020 20:02:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:01:57 +0800
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
Subject: [PATCH RFC v3 04/12] perf vendor events arm64: Add Architected events smmuv3-pmcg.json
Date:   Thu, 7 May 2020 19:57:43 +0800
Message-ID: <1588852671-61996-5-git-send-email-john.garry@huawei.com>
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

Add JSON for Architected events from [0], Section 10.3 .

[0] https://static.docs.arm.com/ihi0070/a/IHI_0070A_SMMUv3.pdf

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json | 58 +++++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                   |  2 +
 2 files changed, 60 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
new file mode 100644
index 000000000000..8a59ce48bf06
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
@@ -0,0 +1,58 @@
+[
+    {
+        "PublicDescription": "Clock cycles",
+        "EventCode": "0x00",
+        "EventName": "smmuv3_pmcg.CYCLES",
+        "BriefDescription": "Clock cycles"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Transaction",
+        "EventCode": "0x01",
+        "EventName": "smmuv3_pmcg.TRANSACTION",
+        "BriefDescription": "Transaction"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "TLB miss caused by incoming transaction or (ATS or non-ATS) translation request",
+        "EventCode": "0x02",
+        "EventName": "smmuv3_pmcg.TLB_MISS",
+        "BriefDescription": "TLB miss caused by incoming transaction or (ATS or non-ATS) translation request"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request",
+        "EventCode": "0x03",
+        "EventName": "smmuv3_pmcg.CONFIG_CACHE_MISS",
+        "BriefDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Translation table walk access",
+        "EventCode": "0x04",
+        "EventName": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS",
+        "BriefDescription": "Translation table walk access"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Configuration structure access",
+        "EventCode": "0x05",
+        "EventName": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS",
+        "BriefDescription": "Configuration structure access"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "PCIe ATS Translation Request received",
+        "EventCode": "0x06",
+        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ",
+        "BriefDescription": "PCIe ATS Translation Request received"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "PCIe ATS Translated Transaction passed through SMMU",
+        "EventCode": "0x07",
+        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED",
+        "BriefDescription": "PCIe ATS Translated Transaction passed through SMMU"
+        "Unit": "smmuv3_pmcg",
+    }
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index acb6b77bddc0..76a84ec2ffc8 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -256,6 +256,8 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	/* it's not realistic to keep adding these, we need something more scalable ... */
+	{ "smmuv3_pmcg", "smmuv3_pmcg" },
 	{ "L3PMC", "amd_l3" },
 	{}
 };
-- 
2.16.4

