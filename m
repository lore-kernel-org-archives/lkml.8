Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CEC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75C12465A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBHO6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:58:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42045 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBHO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYb-0003BP-LL; Sat, 08 Feb 2020 15:58:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D8D31C1F87;
        Sat,  8 Feb 2020 15:58:05 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:05 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206075711.1275-3-yuzenghui@huawei.com>
References: <20200206075711.1275-3-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158117388508.411.11315542355277366568.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8b718d403c5cdc7f0ea492c33ec88169f3e76462
Gitweb:        https://git.kernel.org/tip/8b718d403c5cdc7f0ea492c33ec88169f3e76462
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Thu, 06 Feb 2020 15:57:07 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Feb 2020 10:01:33 

irqchip/gic-v4.1: Set vpe_l1_base for all redistributors

Currently, we will not set vpe_l1_page for the current RD if we can
inherit the vPE configuration table from another RD (or ITS), which
results in an inconsistency between RDs within the same CommonLPIAff
group.

Let's rename it to vpe_l1_base to indicate the base address of the
vPE configuration table of this RD, and set it properly for *all*
v4.1 redistributors.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200206075711.1275-3-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 5 ++++-
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 992bc72..0f1fe56 100644
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
index f0b8ca7..83439bf 100644
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
