Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A43C352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9F22468A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBHO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:58:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42044 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgBHO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYa-0003Ah-K0; Sat, 08 Feb 2020 15:58:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 128E21C1A0D;
        Sat,  8 Feb 2020 15:58:04 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:03 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206075711.1275-7-yuzenghui@huawei.com>
References: <20200206075711.1275-7-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158117388377.411.15122227166169440680.tip-bot2@tip-bot2>
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

Commit-ID:     5186a6cc3ef5a3fa327c258924ef098b0de77006
Gitweb:        https://git.kernel.org/tip/5186a6cc3ef5a3fa327c258924ef098b0de77006
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Thu, 06 Feb 2020 15:57:11 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Feb 2020 10:01:33 

irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors

V{PEND,PROP}BASER registers are actually located in VLPI_base frame
of the *redistributor*. Rename their accessors to reflect this fact.

No functional changes.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200206075711.1275-7-yuzenghui@huawei.com
---
 arch/arm/include/asm/arch_gicv3.h   | 12 ++++++------
 arch/arm64/include/asm/arch_gicv3.h |  8 ++++----
 drivers/irqchip/irq-gic-v3-its.c    | 28 ++++++++++++++--------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index b5752f0..c815477 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -326,16 +326,16 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
 #define gits_write_cwriter(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
- * GITS_VPROPBASER - hi and lo bits may be accessed independently.
+ * GICR_VPROPBASER - hi and lo bits may be accessed independently.
  */
-#define gits_read_vpropbaser(c)		__gic_readq_nonatomic(c)
-#define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
+#define gicr_read_vpropbaser(c)		__gic_readq_nonatomic(c)
+#define gicr_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
- * GITS_VPENDBASER - the Valid bit must be cleared before changing
+ * GICR_VPENDBASER - the Valid bit must be cleared before changing
  * anything else.
  */
-static inline void gits_write_vpendbaser(u64 val, void __iomem *addr)
+static inline void gicr_write_vpendbaser(u64 val, void __iomem *addr)
 {
 	u32 tmp;
 
@@ -352,7 +352,7 @@ static inline void gits_write_vpendbaser(u64 val, void __iomem *addr)
 	__gic_writeq_nonatomic(val, addr);
 }
 
-#define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
+#define gicr_read_vpendbaser(c)		__gic_readq_nonatomic(c)
 
 static inline bool gic_prio_masking_enabled(void)
 {
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 4750fc8..25fec4b 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -140,11 +140,11 @@ static inline u32 gic_read_rpr(void)
 #define gicr_write_pendbaser(v, c)	writeq_relaxed(v, c)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
-#define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
-#define gits_read_vpropbaser(c)		readq_relaxed(c)
+#define gicr_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+#define gicr_read_vpropbaser(c)		readq_relaxed(c)
 
-#define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
-#define gits_read_vpendbaser(c)		readq_relaxed(c)
+#define gicr_write_vpendbaser(v, c)	writeq_relaxed(v, c)
+#define gicr_read_vpendbaser(c)		readq_relaxed(c)
 
 static inline bool gic_prio_masking_enabled(void)
 {
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 811875b..1ee95f5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2429,7 +2429,7 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		 * ours wrt CommonLPIAff. Let's use its own VPROPBASER.
 		 * Make sure we don't write the Z bit in that case.
 		 */
-		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+		val = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 		val &= ~GICR_VPROPBASER_4_1_Z;
 
 		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
@@ -2452,7 +2452,7 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
 	if (!gic_rdists->has_rvpeid)
 		return true;
 
-	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+	val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 
 	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
 	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
@@ -2524,8 +2524,8 @@ static int allocate_vpe_l1_table(void)
 	 * effect of making sure no doorbell will be generated and we can
 	 * then safely clear VPROPBASER.Valid.
 	 */
-	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
-		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+	if (gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
+		gicr_write_vpendbaser(GICR_VPENDBASER_PendingLast,
 				      vlpi_base + GICR_VPENDBASER);
 
 	/*
@@ -2548,8 +2548,8 @@ static int allocate_vpe_l1_table(void)
 
 	/* First probe the page size */
 	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
-	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	val = gicr_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
 	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
 	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
 
@@ -2620,7 +2620,7 @@ static int allocate_vpe_l1_table(void)
 	val |= GICR_VPROPBASER_4_1_VALID;
 
 out:
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
 
 	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
@@ -2727,14 +2727,14 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 	bool clean;
 	u64 val;
 
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
 	val &= ~clr;
 	val |= set;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 		clean = !(val & GICR_VPENDBASER_Dirty);
 		if (!clean) {
 			count--;
@@ -2849,7 +2849,7 @@ static void its_cpu_init_lpis(void)
 		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
 		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
 			smp_processor_id(), val);
-		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+		gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 		/*
 		 * Also clear Valid bit of GICR_VPENDBASER, in case some
@@ -3523,7 +3523,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
 	val |= GICR_VPROPBASER_RaWb;
 	val |= GICR_VPROPBASER_InnerShareable;
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
@@ -3541,7 +3541,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= GICR_VPENDBASER_PendingLast;
 	val |= vpe->idai ? GICR_VPENDBASER_IDAI : 0;
 	val |= GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 }
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
@@ -3741,7 +3741,7 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	val |= info->g1en ? GICR_VPENDBASER_4_1_VGRP1EN : 0;
 	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
 
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 }
 
 static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
