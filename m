Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C15C35254
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90B52467A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBHO6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:58:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgBHO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYb-0003Ap-B3; Sat, 08 Feb 2020 15:58:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 01DCF1C1A0D;
        Sat,  8 Feb 2020 15:58:05 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:04 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Ensure L2 vPE table is allocated
 at RD level
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206075711.1275-4-yuzenghui@huawei.com>
References: <20200206075711.1275-4-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158117388476.411.8823556213611156122.tip-bot2@tip-bot2>
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

Commit-ID:     4e6437f12d6e929e802f5599a2d50dfcf92d0f50
Gitweb:        https://git.kernel.org/tip/4e6437f12d6e929e802f5599a2d50dfcf92d0f50
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Thu, 06 Feb 2020 15:57:08 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Feb 2020 10:01:33 

irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level

In GICv4, we will ensure that level2 vPE table memory is allocated
for the specified vpe_id on all v4 ITS, in its_alloc_vpe_table().
This still works well for the typical GICv4.1 implementation, where
the new vPE table is shared between the ITSs and the RDs.

To make it explicit, let us introduce allocate_vpe_l2_table() to
make sure that the L2 tables are allocated on all v4.1 RDs. We're
likely not need to allocate memory in it because the vPE table is
shared and (L2 table is) already allocated at ITS level, except
for the case where the ITS doesn't share anything (say SVPET == 0,
practically unlikely but architecturally allowed).

The implementation of allocate_vpe_l2_table() is mostly copied from
its_alloc_table_entry().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200206075711.1275-4-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 80 +++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0f1fe56..ae4e7b3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2443,6 +2443,72 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 	return 0;
 }
 
+static bool allocate_vpe_l2_table(int cpu, u32 id)
+{
+	void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
+	u64 val, gpsz, npg;
+	unsigned int psz, esz, idx;
+	struct page *page;
+	__le64 *table;
+
+	if (!gic_rdists->has_rvpeid)
+		return true;
+
+	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+
+	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
+	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
+	npg  = FIELD_GET(GICR_VPROPBASER_4_1_SIZE, val) + 1;
+
+	switch (gpsz) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case GIC_PAGE_SIZE_4K:
+		psz = SZ_4K;
+		break;
+	case GIC_PAGE_SIZE_16K:
+		psz = SZ_16K;
+		break;
+	case GIC_PAGE_SIZE_64K:
+		psz = SZ_64K;
+		break;
+	}
+
+	/* Don't allow vpe_id that exceeds single, flat table limit */
+	if (!(val & GICR_VPROPBASER_4_1_INDIRECT))
+		return (id < (npg * psz / (esz * SZ_8)));
+
+	/* Compute 1st level table index & check if that exceeds table limit */
+	idx = id >> ilog2(psz / (esz * SZ_8));
+	if (idx >= (npg * psz / GITS_LVL1_ENTRY_SIZE))
+		return false;
+
+	table = gic_data_rdist_cpu(cpu)->vpe_l1_base;
+
+	/* Allocate memory for 2nd level table */
+	if (!table[idx]) {
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(psz));
+		if (!page)
+			return false;
+
+		/* Flush Lvl2 table to PoC if hw doesn't support coherency */
+		if (!(val & GICR_VPROPBASER_SHAREABILITY_MASK))
+			gic_flush_dcache_to_poc(page_address(page), psz);
+
+		table[idx] = cpu_to_le64(page_to_phys(page) | GITS_BASER_VALID);
+
+		/* Flush Lvl1 entry to PoC if hw doesn't support coherency */
+		if (!(val & GICR_VPROPBASER_SHAREABILITY_MASK))
+			gic_flush_dcache_to_poc(table + idx, GITS_LVL1_ENTRY_SIZE);
+
+		/* Ensure updated table contents are visible to RD hardware */
+		dsb(sy);
+	}
+
+	return true;
+}
+
 static int allocate_vpe_l1_table(void)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
@@ -2957,6 +3023,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 static bool its_alloc_vpe_table(u32 vpe_id)
 {
 	struct its_node *its;
+	int cpu;
 
 	/*
 	 * Make sure the L2 tables are allocated on *all* v4 ITSs. We
@@ -2979,6 +3046,19 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 			return false;
 	}
 
+	/* Non v4.1? No need to iterate RDs and go back early. */
+	if (!gic_rdists->has_rvpeid)
+		return true;
+
+	/*
+	 * Make sure the L2 tables are allocated for all copies of
+	 * the L1 table on *all* v4.1 RDs.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (!allocate_vpe_l2_table(cpu, vpe_id))
+			return false;
+	}
+
 	return true;
 }
 
