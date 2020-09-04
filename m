Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC31206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgIDJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:58:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgIDJ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:58:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59DC36ED6012F55B743F;
        Fri,  4 Sep 2020 17:58:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Sep 2020 17:58:41 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <zhangshaokun@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] arm64: perf: Remove unnecessary event_idx check
Date:   Fri, 4 Sep 2020 17:57:38 +0800
Message-ID: <1599213458-28394-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

event_idx is obtained from armv8pmu_get_event_idx(), and this idx must be
between ARMV8_IDX_CYCLE_COUNTER and cpu_pmu->num_events. So it's unnecessary
to do this check. Let's remove it.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 arch/arm64/kernel/perf_event.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9..885a357 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -307,8 +307,6 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
  */
 #define	ARMV8_IDX_CYCLE_COUNTER	0
 #define	ARMV8_IDX_COUNTER0	1
-#define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
-	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)


 /*
@@ -365,12 +363,6 @@ static inline int armv8pmu_has_overflowed(u32 pmovsr)
 	return pmovsr & ARMV8_PMU_OVERFLOWED_MASK;
 }

-static inline int armv8pmu_counter_valid(struct arm_pmu *cpu_pmu, int idx)
-{
-	return idx >= ARMV8_IDX_CYCLE_COUNTER &&
-		idx <= ARMV8_IDX_COUNTER_LAST(cpu_pmu);
-}
-
 static inline int armv8pmu_counter_has_overflowed(u32 pmnc, int idx)
 {
 	return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
@@ -440,15 +432,11 @@ static u64 armv8pmu_unbias_long_counter(struct perf_event *event, u64 value)

 static u64 armv8pmu_read_counter(struct perf_event *event)
 {
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 	u64 value = 0;

-	if (!armv8pmu_counter_valid(cpu_pmu, idx))
-		pr_err("CPU%u reading wrong counter %d\n",
-			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
+	if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
 	else
 		value = armv8pmu_read_hw_counter(event);
@@ -477,16 +465,12 @@ static inline void armv8pmu_write_hw_counter(struct perf_event *event,

 static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
-	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;

 	value = armv8pmu_bias_long_counter(event, value);

-	if (!armv8pmu_counter_valid(cpu_pmu, idx))
-		pr_err("CPU%u writing wrong counter %d\n",
-			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
+	if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		write_sysreg(value, pmccntr_el0);
 	else
 		armv8pmu_write_hw_counter(event, value);
--
2.8.1

