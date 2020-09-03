Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D576EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8678C20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgICJIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:08:21 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39503 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgICJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:08:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U7nxXAG_1599124089;
Received: from localhost(mailfrom:zoucao@linux.alibaba.com fp:SMTPD_---0U7nxXAG_1599124089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 17:08:10 +0800
From:   Zou Cao <zoucao@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Subject: [PATCH] irqchip/gic-v3: change gic_data into gic_v3_data
Date:   Thu,  3 Sep 2020 17:08:08 +0800
Message-Id: <1599124088-80231-1-git-send-email-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple gic_data symbol between irq_gic.c and irq_gic_v3.c,
we can see the same symbol name:

	cat /proc/kallsyms | grep gic_data
------>
	ffff80001138f1d0 d gic_data
	ffff80001138f940 d gic_data

Normally CONFIG_ARM_GIC and CONFIG_ARM_GIC_V3 are all enabled, move
the gic_data symbol into different name, it will be friend for
kallsyms_lookup_name to get addr easily.

Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3.c | 188 +++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index cc46bc2d..ba040d8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -56,12 +56,12 @@ struct gic_chip_data {
 	struct partition_desc	**ppi_descs;
 };
 
-static struct gic_chip_data gic_data __read_mostly;
+static struct gic_chip_data gic_v3_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
-#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
-#define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
-#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
+#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_v3_data.rdists.gicd_typer))
+#define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_v3_data.rdists.gicd_typer), 1020U)
+#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_v3_data.rdists.gicd_typer)
 
 /*
  * The behaviours of RPR and PMR registers differ depending on the value of
@@ -104,7 +104,7 @@ struct gic_chip_data {
 static DEFINE_PER_CPU(bool, has_rss);
 
 #define MPIDR_RS(mpidr)			(((mpidr) & 0xF0UL) >> 4)
-#define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
+#define gic_data_rdist()		(this_cpu_ptr(gic_v3_data.rdists.rdist))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)
 
@@ -165,7 +165,7 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 	case SPI_RANGE:
 	case ESPI_RANGE:
 		/* SPI -> dist_base */
-		return gic_data.dist_base;
+		return gic_v3_data.dist_base;
 
 	default:
 		return NULL;
@@ -190,7 +190,7 @@ static void gic_do_wait_for_rwp(void __iomem *base)
 /* Wait for completion of a distributor change */
 static void gic_dist_wait_for_rwp(void)
 {
-	gic_do_wait_for_rwp(gic_data.dist_base);
+	gic_do_wait_for_rwp(gic_v3_data.dist_base);
 }
 
 /* Wait for completion of a redistributor change */
@@ -216,7 +216,7 @@ static void gic_enable_redist(bool enable)
 	u32 count = 1000000;	/* 1s! */
 	u32 val;
 
-	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
+	if (gic_v3_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
 		return;
 
 	rbase = gic_data_rdist_rd_base();
@@ -310,7 +310,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_v3_data.dist_base;
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -328,7 +328,7 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
 		base = gic_data_rdist_sgi_base();
 		rwp_wait = gic_redist_wait_for_rwp;
 	} else {
-		base = gic_data.dist_base;
+		base = gic_v3_data.dist_base;
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
@@ -554,7 +554,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		base = gic_data_rdist_sgi_base();
 		rwp_wait = gic_redist_wait_for_rwp;
 	} else {
-		base = gic_data.dist_base;
+		base = gic_v3_data.dist_base;
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
@@ -617,7 +617,7 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	 * PSR.I will be restored when we ERET to the
 	 * interrupted context.
 	 */
-	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+	err = handle_domain_nmi(gic_v3_data.domain, irqnr, regs);
 	if (err)
 		gic_deactivate_unhandled(irqnr);
 
@@ -655,7 +655,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		else
 			isb();
 
-		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		err = handle_domain_irq(gic_v3_data.domain, irqnr, regs);
 		if (err) {
 			WARN_ONCE(true, "Unexpected interrupt received!\n");
 			gic_deactivate_unhandled(irqnr);
@@ -723,7 +723,7 @@ static void __init gic_dist_init(void)
 {
 	unsigned int i;
 	u64 affinity;
-	void __iomem *base = gic_data.dist_base;
+	void __iomem *base = gic_v3_data.dist_base;
 	u32 val;
 
 	/* Disable the distributor */
@@ -758,7 +758,7 @@ static void __init gic_dist_init(void)
 	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
 
 	val = GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1;
-	if (gic_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
+	if (gic_v3_data.rdists.gicd_typer2 & GICD_TYPER2_nASSGIcap) {
 		pr_info("Enabling SGIs without active state\n");
 		val |= GICD_CTLR_nASSGIreq;
 	}
@@ -783,8 +783,8 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 	int ret = -ENODEV;
 	int i;
 
-	for (i = 0; i < gic_data.nr_redist_regions; i++) {
-		void __iomem *ptr = gic_data.redist_regions[i].redist_base;
+	for (i = 0; i < gic_v3_data.nr_redist_regions; i++) {
+		void __iomem *ptr = gic_v3_data.redist_regions[i].redist_base;
 		u64 typer;
 		u32 reg;
 
@@ -797,15 +797,15 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 
 		do {
 			typer = gic_read_typer(ptr + GICR_TYPER);
-			ret = fn(gic_data.redist_regions + i, ptr);
+			ret = fn(gic_v3_data.redist_regions + i, ptr);
 			if (!ret)
 				return 0;
 
-			if (gic_data.redist_regions[i].single_redist)
+			if (gic_v3_data.redist_regions[i].single_redist)
 				break;
 
-			if (gic_data.redist_stride) {
-				ptr += gic_data.redist_stride;
+			if (gic_v3_data.redist_stride) {
+				ptr += gic_v3_data.redist_stride;
 			} else {
 				ptr += SZ_64K * 2; /* Skip RD_base + SGI_base */
 				if (typer & GICR_TYPER_VLPIS)
@@ -841,7 +841,7 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 
 		pr_info("CPU%d: found redistributor %lx region %d:%pa\n",
 			smp_processor_id(), mpidr,
-			(int)(region - gic_data.redist_regions),
+			(int)(region - gic_v3_data.redist_regions),
 			&gic_data_rdist()->phys_base);
 		return 0;
 	}
@@ -867,44 +867,44 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 
-	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
+	gic_v3_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 
 	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
-	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
-	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
-					   gic_data.rdists.has_rvpeid);
-	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
+	gic_v3_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
+	gic_v3_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
+					   gic_v3_data.rdists.has_rvpeid);
+	gic_v3_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
 
 	/* Detect non-sensical configurations */
-	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
-		gic_data.rdists.has_direct_lpi = false;
-		gic_data.rdists.has_vlpis = false;
-		gic_data.rdists.has_rvpeid = false;
+	if (WARN_ON_ONCE(gic_v3_data.rdists.has_rvpeid && !gic_v3_data.rdists.has_vlpis)) {
+		gic_v3_data.rdists.has_direct_lpi = false;
+		gic_v3_data.rdists.has_vlpis = false;
+		gic_v3_data.rdists.has_rvpeid = false;
 	}
 
-	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
+	gic_v3_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_v3_data.ppi_nr);
 
 	return 1;
 }
 
 static void gic_update_rdist_properties(void)
 {
-	gic_data.ppi_nr = UINT_MAX;
+	gic_v3_data.ppi_nr = UINT_MAX;
 	gic_iterate_rdists(__gic_update_rdist_properties);
-	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
-		gic_data.ppi_nr = 0;
-	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	if (gic_data.rdists.has_vlpis)
+	if (WARN_ON(gic_v3_data.ppi_nr == UINT_MAX))
+		gic_v3_data.ppi_nr = 0;
+	pr_info("%d PPIs implemented\n", gic_v3_data.ppi_nr);
+	if (gic_v3_data.rdists.has_vlpis)
 		pr_info("GICv4 features: %s%s%s\n",
-			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
-			gic_data.rdists.has_rvpeid ? "RVPEID " : "",
-			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
+			gic_v3_data.rdists.has_direct_lpi ? "DirectLPI " : "",
+			gic_v3_data.rdists.has_rvpeid ? "RVPEID " : "",
+			gic_v3_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
 
 /* Check whether it's single security state view */
 static inline bool gic_dist_security_disabled(void)
 {
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+	return readl_relaxed(gic_v3_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
 }
 
 static void gic_cpu_sys_reg_init(void)
@@ -1017,7 +1017,7 @@ static void gic_cpu_sys_reg_init(void)
 	 *   - The write is ignored.
 	 *   - The RS field is treated as 0.
 	 */
-	if (need_rss && (!gic_data.has_rss))
+	if (need_rss && (!gic_v3_data.has_rss))
 		pr_crit_once("RSS is required but GICD doesn't support it\n");
 }
 
@@ -1032,7 +1032,7 @@ static int __init gicv3_nolpi_cfg(char *buf)
 static int gic_dist_supports_lpis(void)
 {
 	return (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) &&
-		!!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
+		!!(readl_relaxed(gic_v3_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) &&
 		!gicv3_nolpi);
 }
 
@@ -1047,7 +1047,7 @@ static void gic_cpu_init(void)
 
 	gic_enable_redist(true);
 
-	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
+	WARN((gic_v3_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
 	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
 	     "Distributor has extended ranges, but CPU%d doesn't\n",
 	     smp_processor_id());
@@ -1055,10 +1055,10 @@ static void gic_cpu_init(void)
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
-	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
+	for (i = 0; i < gic_v3_data.ppi_nr + 16; i += 32)
 		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_v3_data.ppi_nr + 16, gic_redist_wait_for_rwp);
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
@@ -1420,10 +1420,10 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	 */
 	if (fwspec->param_count >= 4 &&
 	    fwspec->param[0] == 1 && fwspec->param[3] != 0 &&
-	    gic_data.ppi_descs)
-		return d == partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
+	    gic_v3_data.ppi_descs)
+		return d == partition_get_domain(gic_v3_data.ppi_descs[fwspec->param[1]]);
 
-	return d == gic_data.domain;
+	return d == gic_v3_data.domain;
 }
 
 static const struct irq_domain_ops gic_irq_domain_ops = {
@@ -1441,14 +1441,14 @@ static int partition_domain_translate(struct irq_domain *d,
 	struct device_node *np;
 	int ret;
 
-	if (!gic_data.ppi_descs)
+	if (!gic_v3_data.ppi_descs)
 		return -ENOMEM;
 
 	np = of_find_node_by_phandle(fwspec->param[3]);
 	if (WARN_ON(!np))
 		return -EINVAL;
 
-	ret = partition_translate_id(gic_data.ppi_descs[fwspec->param[1]],
+	ret = partition_translate_id(gic_v3_data.ppi_descs[fwspec->param[1]],
 				     of_node_to_fwnode(np));
 	if (ret < 0)
 		return ret;
@@ -1549,11 +1549,11 @@ static void gic_enable_nmi_support(void)
 		return;
 	}
 
-	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
+	ppi_nmi_refs = kcalloc(gic_v3_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
 
-	for (i = 0; i < gic_data.ppi_nr; i++)
+	for (i = 0; i < gic_v3_data.ppi_nr; i++)
 		refcount_set(&ppi_nmi_refs[i], 0);
 
 	/*
@@ -1590,20 +1590,20 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (static_branch_likely(&supports_deactivate_key))
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
-	gic_data.fwnode = handle;
-	gic_data.dist_base = dist_base;
-	gic_data.redist_regions = rdist_regs;
-	gic_data.nr_redist_regions = nr_redist_regions;
-	gic_data.redist_stride = redist_stride;
+	gic_v3_data.fwnode = handle;
+	gic_v3_data.dist_base = dist_base;
+	gic_v3_data.redist_regions = rdist_regs;
+	gic_v3_data.nr_redist_regions = nr_redist_regions;
+	gic_v3_data.redist_stride = redist_stride;
 
 	/*
 	 * Find out how many interrupts are supported.
 	 */
-	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
-	gic_data.rdists.gicd_typer = typer;
+	typer = readl_relaxed(gic_v3_data.dist_base + GICD_TYPER);
+	gic_v3_data.rdists.gicd_typer = typer;
 
-	gic_enable_quirks(readl_relaxed(gic_data.dist_base + GICD_IIDR),
-			  gic_quirks, &gic_data);
+	gic_enable_quirks(readl_relaxed(gic_v3_data.dist_base + GICD_IIDR),
+			  gic_quirks, &gic_v3_data);
 
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
@@ -1612,30 +1612,30 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	 * ThunderX1 explodes on reading GICD_TYPER2, in violation of the
 	 * architecture spec (which says that reserved registers are RES0).
 	 */
-	if (!(gic_data.flags & FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539))
-		gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
-
-	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
-						 &gic_data);
-	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-	gic_data.rdists.has_rvpeid = true;
-	gic_data.rdists.has_vlpis = true;
-	gic_data.rdists.has_direct_lpi = true;
-	gic_data.rdists.has_vpend_valid_dirty = true;
-
-	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
+	if (!(gic_v3_data.flags & FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539))
+		gic_v3_data.rdists.gicd_typer2 = readl_relaxed(gic_v3_data.dist_base + GICD_TYPER2);
+
+	gic_v3_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
+						 &gic_v3_data);
+	gic_v3_data.rdists.rdist = alloc_percpu(typeof(*gic_v3_data.rdists.rdist));
+	gic_v3_data.rdists.has_rvpeid = true;
+	gic_v3_data.rdists.has_vlpis = true;
+	gic_v3_data.rdists.has_direct_lpi = true;
+	gic_v3_data.rdists.has_vpend_valid_dirty = true;
+
+	if (WARN_ON(!gic_v3_data.domain) || WARN_ON(!gic_v3_data.rdists.rdist)) {
 		err = -ENOMEM;
 		goto out_free;
 	}
 
-	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
+	irq_domain_update_bus_token(gic_v3_data.domain, DOMAIN_BUS_WIRED);
 
-	gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
+	gic_v3_data.has_rss = !!(typer & GICD_TYPER_RSS);
 	pr_info("Distributor has %sRange Selector support\n",
-		gic_data.has_rss ? "" : "no ");
+		gic_v3_data.has_rss ? "" : "no ");
 
 	if (typer & GICD_TYPER_MBIS) {
-		err = mbi_init(handle, gic_data.domain);
+		err = mbi_init(handle, gic_v3_data.domain);
 		if (err)
 			pr_err("Failed to initialize MBIs\n");
 	}
@@ -1650,11 +1650,11 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_cpu_pm_init();
 
 	if (gic_dist_supports_lpis()) {
-		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_init(handle, &gic_v3_data.rdists, gic_v3_data.domain);
 		its_cpu_init();
 	} else {
 		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
-			gicv2m_init(handle, gic_data.domain);
+			gicv2m_init(handle, gic_v3_data.domain);
 	}
 
 	gic_enable_nmi_support();
@@ -1662,9 +1662,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	return 0;
 
 out_free:
-	if (gic_data.domain)
-		irq_domain_remove(gic_data.domain);
-	free_percpu(gic_data.rdists.rdist);
+	if (gic_v3_data.domain)
+		irq_domain_remove(gic_v3_data.domain);
+	free_percpu(gic_v3_data.rdists.rdist);
 	return err;
 }
 
@@ -1690,8 +1690,8 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	if (!parts_node)
 		return;
 
-	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
-	if (!gic_data.ppi_descs)
+	gic_v3_data.ppi_descs = kcalloc(gic_v3_data.ppi_nr, sizeof(*gic_v3_data.ppi_descs), GFP_KERNEL);
+	if (!gic_v3_data.ppi_descs)
 		return;
 
 	nr_parts = of_get_child_count(parts_node);
@@ -1745,11 +1745,11 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		part_idx++;
 	}
 
-	for (i = 0; i < gic_data.ppi_nr; i++) {
+	for (i = 0; i < gic_v3_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;
 		struct irq_fwspec ppi_fwspec = {
-			.fwnode		= gic_data.fwnode,
+			.fwnode		= gic_v3_data.fwnode,
 			.param_count	= 3,
 			.param		= {
 				[0]	= GIC_IRQ_TYPE_PARTITION,
@@ -1761,12 +1761,12 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		irq = irq_create_fwspec_mapping(&ppi_fwspec);
 		if (WARN_ON(!irq))
 			continue;
-		desc = partition_create_desc(gic_data.fwnode, parts, nr_parts,
+		desc = partition_create_desc(gic_v3_data.fwnode, parts, nr_parts,
 					     irq, &partition_domain_ops);
 		if (WARN_ON(!desc))
 			continue;
 
-		gic_data.ppi_descs[i] = desc;
+		gic_v3_data.ppi_descs[i] = desc;
 	}
 
 out_put_node:
@@ -1794,8 +1794,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (!ret)
 		gic_v3_kvm_info.vcpu = r;
 
-	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
-	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	gic_v3_kvm_info.has_v4 = gic_v3_data.rdists.has_vlpis;
+	gic_v3_kvm_info.has_v4_1 = gic_v3_data.rdists.has_rvpeid;
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
@@ -1846,7 +1846,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	if (of_property_read_u64(node, "redistributor-stride", &redist_stride))
 		redist_stride = 0;
 
-	gic_enable_of_quirks(node, gic_quirks, &gic_data);
+	gic_enable_of_quirks(node, gic_quirks, &gic_v3_data);
 
 	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
 			     redist_stride, &node->fwnode);
@@ -2110,8 +2110,8 @@ static void __init gic_acpi_setup_kvm_info(void)
 		vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
 	}
 
-	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
-	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	gic_v3_kvm_info.has_v4 = gic_v3_data.rdists.has_vlpis;
+	gic_v3_kvm_info.has_v4_1 = gic_v3_data.rdists.has_rvpeid;
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
-- 
1.8.3.1

