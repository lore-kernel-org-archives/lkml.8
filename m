Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D678206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgF3Ni3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:38:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732994AbgF3NiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:38:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 62F8ABE43F81FB854361;
        Tue, 30 Jun 2020 21:38:19 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 30 Jun 2020 21:38:12 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, <kuhn.chenqun@huawei.com>,
        <wangjingyi11@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Use GFP_ATOMIC flag in allocate_vpe_l1_table()
Date:   Tue, 30 Jun 2020 21:37:46 +0800
Message-ID: <20200630133746.816-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting the latest kernel with DEBUG_ATOMIC_SLEEP=y on a GICv4.1 enabled
box, I get the following kernel splat:

[    0.053766] BUG: sleeping function called from invalid context at mm/slab.h:567
[    0.053767] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
[    0.053769] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3+ #23
[    0.053770] Call trace:
[    0.053774]  dump_backtrace+0x0/0x218
[    0.053775]  show_stack+0x2c/0x38
[    0.053777]  dump_stack+0xc4/0x10c
[    0.053779]  ___might_sleep+0xfc/0x140
[    0.053780]  __might_sleep+0x58/0x90
[    0.053782]  slab_pre_alloc_hook+0x7c/0x90
[    0.053783]  kmem_cache_alloc_trace+0x60/0x2f0
[    0.053785]  its_cpu_init+0x6f4/0xe40
[    0.053786]  gic_starting_cpu+0x24/0x38
[    0.053788]  cpuhp_invoke_callback+0xa0/0x710
[    0.053789]  notify_cpu_starting+0xcc/0xd8
[    0.053790]  secondary_start_kernel+0x148/0x200

 # ./scripts/faddr2line vmlinux its_cpu_init+0x6f4/0xe40
its_cpu_init+0x6f4/0xe40:
allocate_vpe_l1_table at drivers/irqchip/irq-gic-v3-its.c:2818
(inlined by) its_cpu_init_lpis at drivers/irqchip/irq-gic-v3-its.c:3138
(inlined by) its_cpu_init at drivers/irqchip/irq-gic-v3-its.c:5166

It turned out that we're allocating memory using GFP_KERNEL (may sleep)
within the CPU hotplug notifier, which is indeed an atomic context. Bad
thing may happen if we're playing on a system with more than a single
CommonLPIAff group. Avoid it by turning this into an atomic allocation.

Fixes: 5e5168461c22 ("irqchip/gic-v4.1: VPE table (aka GICR_VPROPBASER) allocation")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6a5a87fc4601..b66eeca442c4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2814,7 +2814,7 @@ static int allocate_vpe_l1_table(void)
 	if (val & GICR_VPROPBASER_4_1_VALID)
 		goto out;
 
-	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_KERNEL);
+	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_ATOMIC);
 	if (!gic_data_rdist()->vpe_table_mask)
 		return -ENOMEM;
 
@@ -2881,7 +2881,7 @@ static int allocate_vpe_l1_table(void)
 
 	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %d\n",
 		 np, npg, psz, epp, esz);
-	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * PAGE_SIZE));
+	page = alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * PAGE_SIZE));
 	if (!page)
 		return -ENOMEM;
 
-- 
2.19.1

