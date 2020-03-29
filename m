Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F903C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DB8207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgC2U20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:28:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgC2U0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVY-0001ML-FS; Sun, 29 Mar 2020 22:26:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 119711C0451;
        Sun, 29 Mar 2020 22:26:12 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:11 -0000
From:   "tip-bot2 for Mubin Sayyed" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/xilinx: Add support for multiple instances
Cc:     Mubin Sayyed <mubin.usman.sayyed@xilinx.com>,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317125600.15913-2-mubin.usman.sayyed@xilinx.com>
References: <20200317125600.15913-2-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Message-ID: <158551357166.28353.18244839318341076271.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     67862a3c47fcfc9330d153436c7a6604ae3daec9
Gitweb:        https://git.kernel.org/tip/67862a3c47fcfc9330d153436c7a6604ae3daec9
Author:        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
AuthorDate:    Tue, 17 Mar 2020 18:25:57 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:52 

irqchip/xilinx: Add support for multiple instances

Added support for cascaded interrupt controllers.

Following cascaded configurations have been tested,

- peripheral->xilinx-intc->xilinx-intc->gic->Cortexa53 processor
  on zcu102 board
- peripheral->xilinx-intc->xilinx-intc->microblaze processor
  on kcu105 board

Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200317125600.15913-2-mubin.usman.sayyed@xilinx.com
---
 drivers/irqchip/irq-xilinx-intc.c | 115 ++++++++++++++++-------------
 1 file changed, 67 insertions(+), 48 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index e3043de..34593fa 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -38,29 +38,31 @@ struct xintc_irq_chip {
 	void		__iomem *base;
 	struct		irq_domain *root_domain;
 	u32		intr_mask;
+	u32		nr_irq;
 };
 
-static struct xintc_irq_chip *xintc_irqc;
+static struct xintc_irq_chip *primary_intc;
 
-static void xintc_write(int reg, u32 data)
+static void xintc_write(struct xintc_irq_chip *irqc, int reg, u32 data)
 {
 	if (static_branch_unlikely(&xintc_is_be))
-		iowrite32be(data, xintc_irqc->base + reg);
+		iowrite32be(data, irqc->base + reg);
 	else
-		iowrite32(data, xintc_irqc->base + reg);
+		iowrite32(data, irqc->base + reg);
 }
 
-static unsigned int xintc_read(int reg)
+static u32 xintc_read(struct xintc_irq_chip *irqc, int reg)
 {
 	if (static_branch_unlikely(&xintc_is_be))
-		return ioread32be(xintc_irqc->base + reg);
+		return ioread32be(irqc->base + reg);
 	else
-		return ioread32(xintc_irqc->base + reg);
+		return ioread32(irqc->base + reg);
 }
 
 static void intc_enable_or_unmask(struct irq_data *d)
 {
-	unsigned long mask = 1 << d->hwirq;
+	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+	unsigned long mask = BIT(d->hwirq);
 
 	pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);
 
@@ -69,30 +71,35 @@ static void intc_enable_or_unmask(struct irq_data *d)
 	 * acks the irq before calling the interrupt handler
 	 */
 	if (irqd_is_level_type(d))
-		xintc_write(IAR, mask);
+		xintc_write(irqc, IAR, mask);
 
-	xintc_write(SIE, mask);
+	xintc_write(irqc, SIE, mask);
 }
 
 static void intc_disable_or_mask(struct irq_data *d)
 {
+	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
 	pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
-	xintc_write(CIE, 1 << d->hwirq);
+	xintc_write(irqc, CIE, BIT(d->hwirq));
 }
 
 static void intc_ack(struct irq_data *d)
 {
+	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
 	pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
-	xintc_write(IAR, 1 << d->hwirq);
+	xintc_write(irqc, IAR, BIT(d->hwirq));
 }
 
 static void intc_mask_ack(struct irq_data *d)
 {
-	unsigned long mask = 1 << d->hwirq;
+	struct xintc_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+	unsigned long mask = BIT(d->hwirq);
 
 	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
-	xintc_write(CIE, mask);
-	xintc_write(IAR, mask);
+	xintc_write(irqc, CIE, mask);
+	xintc_write(irqc, IAR, mask);
 }
 
 static struct irq_chip intc_dev = {
@@ -103,13 +110,28 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
+static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
+{
+	unsigned int irq = 0;
+	u32 hwirq;
+
+	hwirq = xintc_read(irqc, IVR);
+	if (hwirq != -1U)
+		irq = irq_find_mapping(irqc->root_domain, hwirq);
+
+	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
+
+	return irq;
+}
+
 unsigned int xintc_get_irq(void)
 {
-	unsigned int hwirq, irq = -1;
+	unsigned int irq = -1;
+	u32 hwirq;
 
-	hwirq = xintc_read(IVR);
+	hwirq = xintc_read(primary_intc, IVR);
 	if (hwirq != -1U)
-		irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
+		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
 
 	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
 
@@ -118,15 +140,18 @@ unsigned int xintc_get_irq(void)
 
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
-	if (xintc_irqc->intr_mask & (1 << hw)) {
+	struct xintc_irq_chip *irqc = d->host_data;
+
+	if (irqc->intr_mask & BIT(hw)) {
 		irq_set_chip_and_handler_name(irq, &intc_dev,
-						handle_edge_irq, "edge");
+					      handle_edge_irq, "edge");
 		irq_clear_status_flags(irq, IRQ_LEVEL);
 	} else {
 		irq_set_chip_and_handler_name(irq, &intc_dev,
-						handle_level_irq, "level");
+					      handle_level_irq, "level");
 		irq_set_status_flags(irq, IRQ_LEVEL);
 	}
+	irq_set_chip_data(irq, irqc);
 	return 0;
 }
 
@@ -138,12 +163,14 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
 static void xil_intc_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xintc_irq_chip *irqc;
 	u32 pending;
 
+	irqc = irq_data_get_irq_handler_data(&desc->irq_data);
 	chained_irq_enter(chip, desc);
 	do {
-		pending = xintc_get_irq();
-		if (pending == -1U)
+		pending = xintc_get_irq_local(irqc);
+		if (pending == 0)
 			break;
 		generic_handle_irq(pending);
 	} while (true);
@@ -153,28 +180,19 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
-	u32 nr_irq;
-	int ret, irq;
 	struct xintc_irq_chip *irqc;
-
-	if (xintc_irqc) {
-		pr_err("irq-xilinx: Multiple instances aren't supported\n");
-		return -EINVAL;
-	}
+	int ret, irq;
 
 	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
 	if (!irqc)
 		return -ENOMEM;
-
-	xintc_irqc = irqc;
-
 	irqc->base = of_iomap(intc, 0);
 	BUG_ON(!irqc->base);
 
-	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
+	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &irqc->nr_irq);
 	if (ret < 0) {
 		pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n");
-		goto err_alloc;
+		goto error;
 	}
 
 	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr_mask);
@@ -183,34 +201,34 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> nr_irq)
+	if (irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
-		intc, nr_irq, irqc->intr_mask);
+		intc, irqc->nr_irq, irqc->intr_mask);
 
 
 	/*
 	 * Disable all external interrupts until they are
 	 * explicity requested.
 	 */
-	xintc_write(IER, 0);
+	xintc_write(irqc, IER, 0);
 
 	/* Acknowledge any pending interrupts just in case. */
-	xintc_write(IAR, 0xffffffff);
+	xintc_write(irqc, IAR, 0xffffffff);
 
 	/* Turn on the Master Enable. */
-	xintc_write(MER, MER_HIE | MER_ME);
-	if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
+	xintc_write(irqc, MER, MER_HIE | MER_ME);
+	if (xintc_read(irqc, MER) != (MER_HIE | MER_ME)) {
 		static_branch_enable(&xintc_is_be);
-		xintc_write(MER, MER_HIE | MER_ME);
+		xintc_write(irqc, MER, MER_HIE | MER_ME);
 	}
 
-	irqc->root_domain = irq_domain_add_linear(intc, nr_irq,
+	irqc->root_domain = irq_domain_add_linear(intc, irqc->nr_irq,
 						  &xintc_irq_domain_ops, irqc);
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
-		goto err_alloc;
+		goto error;
 	}
 
 	if (parent) {
@@ -222,16 +240,17 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		} else {
 			pr_err("irq-xilinx: interrupts property not in DT\n");
 			ret = -EINVAL;
-			goto err_alloc;
+			goto error;
 		}
 	} else {
-		irq_set_default_host(irqc->root_domain);
+		primary_intc = irqc;
+		irq_set_default_host(primary_intc->root_domain);
 	}
 
 	return 0;
 
-err_alloc:
-	xintc_irqc = NULL;
+error:
+	iounmap(irqc->base);
 	kfree(irqc);
 	return ret;
 
