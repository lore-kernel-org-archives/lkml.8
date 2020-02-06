Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED8521775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBFH6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:58:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbgBFH6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:58:35 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 123D151719EAA284CA6A;
        Thu,  6 Feb 2020 15:58:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 15:58:25 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 2/6] irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
Date:   Thu, 6 Feb 2020 15:57:07 +0800
Message-ID: <20200206075711.1275-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200206075711.1275-1-yuzenghui@huawei.com>
References: <20200206075711.1275-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we will not set vpe_l1_page for the current RD if we can
inherit the vPE configuration table from another RD (or ITS), which
results in an inconsistency between RDs within the same CommonLPIAff
group.

Let's rename it to vpe_l1_base to indicate the base address of the
vPE configuration table of this RD, and set it properly for *all*
v4.1 redistributors.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 5 ++++-
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 992bc72cab6f..0f1fe56ce0af 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2376,6 +2376,8 @@ static u64 inherit_vpe_l1_table_from_its(void)
 			continue;
 
 		/* We have a winner! */
+		gic_data_rdist()->vpe_l1_base = its->tables[2].base;
+
 		val  = GICR_VPROPBASER_4_1_VALID;
 		if (baser & GITS_BASER_INDIRECT)
 			val |= GICR_VPROPBASER_4_1_INDIRECT;
@@ -2432,6 +2434,7 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 		val &= ~GICR_VPROPBASER_4_1_Z;
 
+		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
 		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
 
 		return val;
@@ -2542,7 +2545,7 @@ static int allocate_vpe_l1_table(void)
 	if (!page)
 		return -ENOMEM;
 
-	gic_data_rdist()->vpe_l1_page = page;
+	gic_data_rdist()->vpe_l1_base = page_address(page);
 	pa = virt_to_phys(page_address(page));
 	WARN_ON(!IS_ALIGNED(pa, psz));
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f0b8ca766e7d..83439bfb6c5b 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -652,10 +652,10 @@ struct rdists {
 	struct {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
-		struct page	*vpe_l1_page;
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
 		cpumask_t	*vpe_table_mask;
+		void		*vpe_l1_base;
 	} __percpu		*rdist;
 	phys_addr_t		prop_table_pa;
 	void			*prop_table_va;
-- 
2.19.1


