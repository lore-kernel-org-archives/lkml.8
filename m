Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A97C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37D3221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgDQKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:46:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbgDQKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC7BD718B77B28E81237;
        Fri, 17 Apr 2020 18:45:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:19 +0800
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
Subject: [RFC PATCH v2 04/13] perf vendor events arm64: Relocate hip08 events
Date:   Fri, 17 Apr 2020 18:41:15 +0800
Message-ID: <1587120084-18990-5-git-send-email-john.garry@huawei.com>
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

Relocate the core events JSONs to match to future structure, which will
have separate folders for CPU and system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json   | 0
 .../pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-ddrc.json    | 0
 .../pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-hha.json     | 0
 .../pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-l3c.json     | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                            | 2 +-
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-ddrc.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-hha.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-l3c.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/core-imp-def.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/core-imp-def.json
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-ddrc.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-ddrc.json
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-hha.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-hha.json
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-l3c.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/uncore-l3c.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 0d609149b82a..c92cb3b519fc 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -20,5 +20,5 @@
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
-0x00000000480fd010,v1,hisilicon/hip08,core
+0x00000000480fd010,v1,hisilicon/hip08/cpu,core
 0x00000000500f0000,v1,ampere/emag,core
-- 
2.16.4

