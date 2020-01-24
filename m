Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B044020704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbgAXOjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388969AbgAXOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 83B88F9C643DD5541539;
        Fri, 24 Jan 2020 22:39:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 22:38:55 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <ak@linux.intel.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 6/7] perf vendor events arm64: Relocate uncore events for hip08
Date:   Fri, 24 Jan 2020 22:35:04 +0800
Message-ID: <1579876505-113251-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to match uncore events via SYSID when we want to add any other
system event PMU aliasing in future, so relocate the uncore JSONs now.

We use HIP08 as the system id.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/{ => sys}/uncore-ddrc.json        | 0
 .../arch/arm64/hisilicon/hip08/{ => sys}/uncore-hha.json         | 0
 .../arch/arm64/hisilicon/hip08/{ => sys}/uncore-l3c.json         | 0
 tools/perf/pmu-events/arch/arm64/mapfile_sys.csv                 | 1 +
 4 files changed, 1 insertion(+)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-ddrc.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-hha.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-l3c.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-ddrc.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-ddrc.json
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-hha.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-hha.json
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-l3c.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/uncore-l3c.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile_sys.csv b/tools/perf/pmu-events/arch/arm64/mapfile_sys.csv
index 701d8ff67354..d2baadcbbbed 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile_sys.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile_sys.csv
@@ -11,3 +11,4 @@
 #	Type is sys
 #
 #Family-model,Version,Filename,EventType
+HIP08,v1,hisilicon/hip08/sys,sys
-- 
2.17.1

