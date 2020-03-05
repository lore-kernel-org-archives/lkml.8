Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490DBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1CB208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCELMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:12:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbgCELMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E2BFDBC46F786C5DBE5;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/6] perf jevents: Add some test events
Date:   Thu, 5 Mar 2020 19:08:03 +0800
Message-ID: <1583406486-154841-4-git-send-email-john.garry@huawei.com>
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

Add some test PMU events. The events are randomly chosen from x86 and
arm64 JSONs. The events include CPU and uncore events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../pmu-events/arch/test/test_cpu/branch.json | 12 +++++++++
 .../pmu-events/arch/test/test_cpu/other.json  | 26 +++++++++++++++++++
 .../pmu-events/arch/test/test_cpu/uncore.json | 21 +++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json

diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
new file mode 100644
index 000000000000..93ddfd8053ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_cpu/other.json
new file mode 100644
index 000000000000..7d53d7ecd723
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/other.json
@@ -0,0 +1,26 @@
+[
+    {
+        "EventCode": "0x6",
+        "Counter": "0,1",
+        "UMask": "0x80",
+        "EventName": "SEGMENT_REG_LOADS.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of segment register loads."
+    },
+    {
+        "EventCode": "0x9",
+        "Counter": "0,1",
+        "UMask": "0x20",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason"
+    },
+    {
+        "EventCode": "0x3A",
+        "Counter": "0,1",
+        "UMask": "0x0",
+        "EventName": "EIST_TRANS",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
new file mode 100644
index 000000000000..d0a890cc814d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
@@ -0,0 +1,21 @@
+[
+ {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc"
+   },
+   {
+	    "Unit": "CBO",
+	    "EventCode": "0x22",
+	    "UMask": "0x81",
+	    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
+	    "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "PublicDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "Counter": "0,1",
+	    "CounterMask": "0",
+	    "Invert": "0",
+	    "EdgeDetect": "0"
+  }
+]
-- 
2.17.1

