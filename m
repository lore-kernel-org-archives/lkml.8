Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC8C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA323208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgEGPBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:01:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728219AbgEGPBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:01:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6F3F9C4D0216598D07B;
        Thu,  7 May 2020 23:01:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 23:00:53 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH -next] riscv: perf_event: Make some funciton static
Date:   Thu, 7 May 2020 23:04:44 +0800
Message-ID: <20200507150445.174390-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning detected when running make with W=1,
../arch/riscv/kernel/perf_event.c:150:5: warning: no previous prototype for ‘riscv_map_cache_decode’ [-Wmissing-prototypes]
 int riscv_map_cache_decode(u64 config, unsigned int *type,
     ^~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/kernel/perf_event.c:345:13: warning: no previous prototype for ‘riscv_base_pmu_handle_irq’ [-Wmissing-prototypes]
 irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
             ^~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/kernel/perf_event.c:364:6: warning: no previous prototype for ‘release_pmc_hardware’ [-Wmissing-prototypes]
 void release_pmc_hardware(void)
      ^~~~~~~~~~~~~~~~~~~~
../arch/riscv/kernel/perf_event.c:467:12: warning: no previous prototype for ‘init_hw_perf_events’ [-Wmissing-prototypes]
 int __init init_hw_perf_events(void)
            ^~~~~~~~~~~~~~~~~~~

Cc: Alan Kao <alankao@andestech.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/kernel/perf_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index 91626d9ae5f2..c835f0362d94 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -147,7 +147,7 @@ static int riscv_map_hw_event(u64 config)
 	return riscv_pmu->hw_events[config];
 }
 
-int riscv_map_cache_decode(u64 config, unsigned int *type,
+static int riscv_map_cache_decode(u64 config, unsigned int *type,
 			   unsigned int *op, unsigned int *result)
 {
 	return -ENOENT;
@@ -342,7 +342,7 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
 
 static DEFINE_MUTEX(pmc_reserve_mutex);
 
-irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
+static irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
 {
 	return IRQ_NONE;
 }
@@ -361,7 +361,7 @@ static int reserve_pmc_hardware(void)
 	return err;
 }
 
-void release_pmc_hardware(void)
+static void release_pmc_hardware(void)
 {
 	mutex_lock(&pmc_reserve_mutex);
 	if (riscv_pmu->irq >= 0)
@@ -464,7 +464,7 @@ static const struct of_device_id riscv_pmu_of_ids[] = {
 	{ /* sentinel value */ }
 };
 
-int __init init_hw_perf_events(void)
+static int __init init_hw_perf_events(void)
 {
 	struct device_node *node = of_find_node_by_type(NULL, "pmu");
 	const struct of_device_id *of_id;
-- 
2.26.2

