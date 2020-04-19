Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B91C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D5122202
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDSN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDSN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:57:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9730C061A10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 06:57:48 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQAS7-0002lw-R6; Sun, 19 Apr 2020 15:57:44 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5FA89100EA1;
        Sun, 19 Apr 2020 15:57:43 +0200 (CEST)
Date:   Sun, 19 Apr 2020 13:56:39 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.7-rc2
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
Message-ID: <158730459980.31269.13583785801133825132.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-04-19

up to:  b5963029d9e3: Merge tag 'irqchip-fixes-5.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of fixes/updates for the interrupt subsystem:

 - Remove setup_irq() and remove_irq(). All users have been converted so
   remove them before new users surface.

 - A set of bugfixes for various interrupt chip drivers

 - Add a few missing static attributes to address sparse warnings.

Thanks,

	tglx

------------------>
Atish Patra (1):
      irqchip/sifive-plic: Fix maximum priority threshold value

Grygorii Strashko (1):
      irqchip/ti-sci-inta: Fix processing of masked irqs

Jason Yan (2):
      irqchip/irq-mvebu-icu: Make legacy_bindings static
      irqchip/irq-bcm7038-l1: Make bcm7038_l1_of_init() static

Marc Zyngier (3):
      irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling
      irqchip/gic-v4.1: Update effective affinity of virtual SGIs
      irqchip/meson-gpio: Fix HARDIRQ-safe -> HARDIRQ-unsafe lock order

Zenghui Yu (1):
      irqchip/mbigen: Free msi_desc on device teardown

afzal mohammed (1):
      genirq: Remove setup_irq() and remove_irq()


 drivers/irqchip/irq-bcm7038-l1.c   |  2 +-
 drivers/irqchip/irq-gic-v3-its.c   | 20 +++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       | 11 ++++++----
 drivers/irqchip/irq-mbigen.c       |  8 ++++++-
 drivers/irqchip/irq-meson-gpio.c   | 18 +++++++++-------
 drivers/irqchip/irq-mvebu-icu.c    |  2 +-
 drivers/irqchip/irq-sifive-plic.c  |  2 +-
 drivers/irqchip/irq-ti-sci-inta.c  |  3 ++-
 include/linux/irq.h                |  2 --
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 kernel/irq/manage.c                | 44 --------------------------------------
 11 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index eb9bce93cd05..fd7c537fb42a 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -416,7 +416,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-int __init bcm7038_l1_of_init(struct device_node *dn,
+static int __init bcm7038_l1_of_init(struct device_node *dn,
 			      struct device_node *parent)
 {
 	struct bcm7038_l1_chip *intc;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 54d142ccc63a..124251b0ccba 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -14,6 +14,7 @@
 #include <linux/dma-iommu.h>
 #include <linux/efi.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/log2.h>
@@ -3672,6 +3673,20 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
+static void its_wait_vpt_parse_complete(void)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val;
+
+	if (!gic_rdists->has_vpend_valid_dirty)
+		return;
+
+	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
+						val,
+						!(val & GICR_VPENDBASER_Dirty),
+						10, 500));
+}
+
 static void its_vpe_schedule(struct its_vpe *vpe)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
@@ -3702,6 +3717,8 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= vpe->idai ? GICR_VPENDBASER_IDAI : 0;
 	val |= GICR_VPENDBASER_Valid;
 	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	its_wait_vpt_parse_complete();
 }
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
@@ -3910,6 +3927,8 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
 
 	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	its_wait_vpt_parse_complete();
 }
 
 static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
@@ -4035,6 +4054,7 @@ static int its_sgi_set_affinity(struct irq_data *d,
 	 * not on the host (since they can only be targetting a vPE).
 	 * Tell the kernel we've done whatever it asked for.
 	 */
+	irq_data_update_effective_affinity(d, mask_val);
 	return IRQ_SET_MASK_OK;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9dbc81b6f62e..d7006ef18a0d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -873,6 +873,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
 	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
 					   gic_data.rdists.has_rvpeid);
+	gic_data.rdists.has_vpend_valid_dirty &= !!(typer & GICR_TYPER_DIRTY);
 
 	/* Detect non-sensical configurations */
 	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
@@ -893,10 +894,11 @@ static void gic_update_rdist_properties(void)
 	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
 		gic_data.ppi_nr = 0;
 	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
-	pr_info("%sVLPI support, %sdirect LPI support, %sRVPEID support\n",
-		!gic_data.rdists.has_vlpis ? "no " : "",
-		!gic_data.rdists.has_direct_lpi ? "no " : "",
-		!gic_data.rdists.has_rvpeid ? "no " : "");
+	if (gic_data.rdists.has_vlpis)
+		pr_info("GICv4 features: %s%s%s\n",
+			gic_data.rdists.has_direct_lpi ? "DirectLPI " : "",
+			gic_data.rdists.has_rvpeid ? "RVPEID " : "",
+			gic_data.rdists.has_vpend_valid_dirty ? "Valid+Dirty " : "");
 }
 
 /* Check whether it's single security state view */
@@ -1620,6 +1622,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.rdists.has_rvpeid = true;
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
+	gic_data.rdists.has_vpend_valid_dirty = true;
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 6b566bba263b..ff7627b57772 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -220,10 +220,16 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
+static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	platform_msi_domain_free(domain, virq, nr_irqs);
+}
+
 static const struct irq_domain_ops mbigen_domain_ops = {
 	.translate	= mbigen_domain_translate,
 	.alloc		= mbigen_irq_domain_alloc,
-	.free		= irq_domain_free_irqs_common,
+	.free		= mbigen_irq_domain_free,
 };
 
 static int mbigen_of_create_domain(struct platform_device *pdev,
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index ccc7f823911b..bc7aebcc96e9 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -144,12 +144,17 @@ struct meson_gpio_irq_controller {
 static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 				       unsigned int reg, u32 mask, u32 val)
 {
+	unsigned long flags;
 	u32 tmp;
 
+	spin_lock_irqsave(&ctl->lock, flags);
+
 	tmp = readl_relaxed(ctl->base + reg);
 	tmp &= ~mask;
 	tmp |= val;
 	writel_relaxed(tmp, ctl->base + reg);
+
+	spin_unlock_irqrestore(&ctl->lock, flags);
 }
 
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
@@ -196,14 +201,15 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
 			       u32 **channel_hwirq)
 {
+	unsigned long flags;
 	unsigned int idx;
 
-	spin_lock(&ctl->lock);
+	spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
 	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
 	if (idx >= NUM_CHANNEL) {
-		spin_unlock(&ctl->lock);
+		spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
 	}
@@ -211,6 +217,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	/* Mark the channel as used */
 	set_bit(idx, ctl->channel_map);
 
+	spin_unlock_irqrestore(&ctl->lock, flags);
+
 	/*
 	 * Setup the mux of the channel to route the signal of the pad
 	 * to the appropriate input of the GIC
@@ -225,8 +233,6 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	 */
 	*channel_hwirq = &(ctl->channel_irqs[idx]);
 
-	spin_unlock(&ctl->lock);
-
 	pr_debug("hwirq %lu assigned to channel %d - irq %u\n",
 		 hwirq, idx, **channel_hwirq);
 
@@ -287,13 +293,9 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 			val |= REG_EDGE_POL_LOW(params, idx);
 	}
 
-	spin_lock(&ctl->lock);
-
 	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
 				   REG_EDGE_POL_MASK(params, idx), val);
 
-	spin_unlock(&ctl->lock);
-
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 547045d89c4b..91adf771f185 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -66,7 +66,7 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
-DEFINE_STATIC_KEY_FALSE(legacy_bindings);
+static DEFINE_STATIC_KEY_FALSE(legacy_bindings);
 
 static void mvebu_icu_init(struct mvebu_icu *icu,
 			   struct mvebu_icu_msi_data *msi_data,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c34fb3ae0ff8..d0a71febdadc 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -56,7 +56,7 @@
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
 
-#define	PLIC_DISABLE_THRESHOLD		0xf
+#define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
 struct plic_priv {
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 8f6e6b08eadf..7e3ebf6ed2cd 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -37,6 +37,7 @@
 #define VINT_ENABLE_SET_OFFSET	0x0
 #define VINT_ENABLE_CLR_OFFSET	0x8
 #define VINT_STATUS_OFFSET	0x18
+#define VINT_STATUS_MASKED_OFFSET	0x20
 
 /**
  * struct ti_sci_inta_event_desc - Description of an event coming to
@@ -116,7 +117,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
 	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
-			    VINT_STATUS_OFFSET);
+			    VINT_STATUS_MASKED_OFFSET);
 
 	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
 		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 9315fbb87db3..c63c2aa915ff 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -573,8 +573,6 @@ enum {
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
 struct irqaction;
-extern int setup_irq(unsigned int irq, struct irqaction *new);
-extern void remove_irq(unsigned int irq, struct irqaction *act);
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 765d9b769b69..6c36b6cc3edf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -243,6 +243,7 @@
 
 #define GICR_TYPER_PLPIS		(1U << 0)
 #define GICR_TYPER_VLPIS		(1U << 1)
+#define GICR_TYPER_DIRTY		(1U << 2)
 #define GICR_TYPER_DirectLPIS		(1U << 3)
 #define GICR_TYPER_LAST			(1U << 4)
 #define GICR_TYPER_RVPEID		(1U << 7)
@@ -686,6 +687,7 @@ struct rdists {
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
+	bool			has_vpend_valid_dirty;
 };
 
 struct irq_domain;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fe40c658f86f..453a8a0f4804 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1690,34 +1690,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	return ret;
 }
 
-/**
- *	setup_irq - setup an interrupt
- *	@irq: Interrupt line to setup
- *	@act: irqaction for the interrupt
- *
- * Used to statically setup interrupts in the early boot process.
- */
-int setup_irq(unsigned int irq, struct irqaction *act)
-{
-	int retval;
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (!desc || WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		return -EINVAL;
-
-	retval = irq_chip_pm_get(&desc->irq_data);
-	if (retval < 0)
-		return retval;
-
-	retval = __setup_irq(irq, desc, act);
-
-	if (retval)
-		irq_chip_pm_put(&desc->irq_data);
-
-	return retval;
-}
-EXPORT_SYMBOL_GPL(setup_irq);
-
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1858,22 +1830,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	return action;
 }
 
-/**
- *	remove_irq - free an interrupt
- *	@irq: Interrupt line to free
- *	@act: irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		__free_irq(desc, act->dev_id);
-}
-EXPORT_SYMBOL_GPL(remove_irq);
-
 /**
  *	free_irq - free an interrupt allocated with request_irq
  *	@irq: Interrupt line to free

