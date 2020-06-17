Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F64206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgFQJGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:06:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbgFQJGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:06:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DB84318A4F0EC286102;
        Wed, 17 Jun 2020 17:06:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 17:06:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linuxarm@huawei.com>, <irogers@google.com>, <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] perf pmu: List kernel supplied event aliases for arm64
Date:   Wed, 17 Jun 2020 17:01:53 +0800
Message-ID: <1592384514-119954-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit dc098b35b56f ("perf list: List kernel supplied event aliases"),
the aliases for events are supplied in addition to CPU event in perf list.

This relies on the name of the core PMU being "cpu", which is not the case
for arm64, so arm64 has always missed this. Use generic is_pmu_core()
helper which takes account of arm64 to make this feature work for arm64
(and possibly other archs).

Sample, before:
  armv8_pmuv3_0/br_mis_pred/          [Kernel PMU event]
after:
  br_mis_pred OR armv8_pmuv3_0/br_mis_pred/          [Kernel PMU event]

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 93fe72a9dc0b..a375364537cd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1475,7 +1475,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			char *name = alias->desc ? alias->name :
 				format_alias(buf, sizeof(buf), pmu, alias);
-			bool is_cpu = !strcmp(pmu->name, "cpu");
+			bool is_cpu = is_pmu_core(pmu->name);
 
 			if (alias->deprecated && !deprecated)
 				continue;
-- 
2.26.2

