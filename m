Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B39FC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607FB2224E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgDQKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729932AbgDQKpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:33 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 99D9CE0BDA7C0A56020B;
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
Subject: [RFC PATCH v2 09/13] perf vendor events: Add JSON metrics for imx8mm DDR Perf
Date:   Fri, 17 Apr 2020 18:41:20 +0800
Message-ID: <1587120084-18990-10-git-send-email-john.garry@huawei.com>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Add JSON metrics for imx8mm DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/freescale/imx8mm/sys/ddrc.json      | 39 ++++++++++++++++++++++
 .../arch/arm64/freescale/imx8mm/sys/metrics.json   | 18 ++++++++++
 tools/perf/pmu-events/jevents.c                    |  1 +
 3 files changed, 58 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
new file mode 100644
index 000000000000..8a3dae61a48f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
@@ -0,0 +1,39 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.mx8mm"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.mx8mm"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.mx8mm"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.mx8mm"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.mx8mm"
+   }
+]
+
+
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
new file mode 100644
index 000000000000..b6a776ca7cc2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mm_ddr_read.all",
+	    "MetricExpr": "imx8_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4MB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.mx8mm"
+    },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mm_ddr_write.all",
+	    "MetricExpr": "imx8_ddr.write_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4MB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.mx8mm"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 76a84ec2ffc8..efdade0194af 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -257,6 +257,7 @@ static struct map {
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
 	/* it's not realistic to keep adding these, we need something more scalable ... */
+	{ "imx8_ddr", "imx8_ddr" },
 	{ "smmuv3_pmcg", "smmuv3_pmcg" },
 	{ "L3PMC", "amd_l3" },
 	{}
-- 
2.16.4

