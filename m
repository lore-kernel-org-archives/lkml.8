Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B8220723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgE3Hrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgE3Hqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5999C03E969;
        Sat, 30 May 2020 00:46:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCO-0001pb-Kx; Sat, 30 May 2020 09:46:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4DF621C032F;
        Sat, 30 May 2020 09:46:32 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:32 -0000
From:   "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add Loongson PCH PIC controller
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528152757.1028711-4-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <159082479219.17951.11998633686009610260.tip-bot2@tip-bot2>
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

Commit-ID:     ef8c01eb64ca6719da449dab0aa9424e13c58bd0
Gitweb:        https://git.kernel.org/tip/ef8c01eb64ca6719da449dab0aa9424e13c58bd0
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Thu, 28 May 2020 23:27:51 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 29 May 2020 09:42:18 +01:00

irqchip: Add Loongson PCH PIC controller

This controller appears on Loongson LS7A family of PCH to transform
interrupts from devices into HyperTransport vectorized interrrupts
and send them to procrssor's HT vector controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200528152757.1028711-4-jiaxun.yang@flygoat.com
---
 drivers/irqchip/Kconfig                |   9 +-
 drivers/irqchip/Makefile               |   1 +-
 drivers/irqchip/irq-loongson-pch-pic.c | 243 ++++++++++++++++++++++++-
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-pch-pic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index de4564e..5524a62 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -540,4 +540,13 @@ config LOONGSON_HTVEC
 	help
 	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
 
+config LOONGSON_PCH_PIC
+	bool "Loongson PCH PIC Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
+	help
+	  Support for the Loongson PCH PIC Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7456187..acc7233 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
+obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
new file mode 100644
index 0000000..2a05b93
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson PCH PIC support
+ */
+
+#define pr_fmt(fmt) "pch-pic: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+/* Registers */
+#define PCH_PIC_MASK		0x20
+#define PCH_PIC_HTMSI_EN	0x40
+#define PCH_PIC_EDGE		0x60
+#define PCH_PIC_CLR		0x80
+#define PCH_PIC_AUTO0		0xc0
+#define PCH_PIC_AUTO1		0xe0
+#define PCH_INT_ROUTE(irq)	(0x100 + irq)
+#define PCH_INT_HTVEC(irq)	(0x200 + irq)
+#define PCH_PIC_POL		0x3e0
+
+#define PIC_COUNT_PER_REG	32
+#define PIC_REG_COUNT		2
+#define PIC_COUNT		(PIC_COUNT_PER_REG * PIC_REG_COUNT)
+#define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
+#define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
+
+struct pch_pic {
+	void __iomem		*base;
+	struct irq_domain	*pic_domain;
+	u32			ht_vec_base;
+	raw_spinlock_t		pic_lock;
+};
+
+static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
+{
+	u32 reg;
+	void __iomem *addr = priv->base + offset + PIC_REG_IDX(bit) * 4;
+
+	raw_spin_lock(&priv->pic_lock);
+	reg = readl(addr);
+	reg |= BIT(PIC_REG_BIT(bit));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->pic_lock);
+}
+
+static void pch_pic_bitclr(struct pch_pic *priv, int offset, int bit)
+{
+	u32 reg;
+	void __iomem *addr = priv->base + offset + PIC_REG_IDX(bit) * 4;
+
+	raw_spin_lock(&priv->pic_lock);
+	reg = readl(addr);
+	reg &= ~BIT(PIC_REG_BIT(bit));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->pic_lock);
+}
+
+static void pch_pic_eoi_irq(struct irq_data *d)
+{
+	u32 idx = PIC_REG_IDX(d->hwirq);
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	writel(BIT(PIC_REG_BIT(d->hwirq)),
+			priv->base + PCH_PIC_CLR + idx * 4);
+}
+
+static void pch_pic_mask_irq(struct irq_data *d)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	pch_pic_bitset(priv, PCH_PIC_MASK, d->hwirq);
+	irq_chip_mask_parent(d);
+}
+
+static void pch_pic_unmask_irq(struct irq_data *d)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	irq_chip_unmask_parent(d);
+	pch_pic_bitclr(priv, PCH_PIC_MASK, d->hwirq);
+}
+
+static int pch_pic_set_type(struct irq_data *d, unsigned int type)
+{
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+	int ret = 0;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
+		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct irq_chip pch_pic_irq_chip = {
+	.name			= "PCH PIC",
+	.irq_mask		= pch_pic_mask_irq,
+	.irq_unmask		= pch_pic_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_eoi		= pch_pic_eoi_irq,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= pch_pic_set_type,
+};
+
+static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	int err;
+	unsigned int type;
+	unsigned long hwirq;
+	struct irq_fwspec fwspec;
+	struct pch_pic *priv = domain->host_data;
+
+	irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq + priv->ht_vec_base;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &pch_pic_irq_chip, priv,
+			    handle_fasteoi_ack_irq, NULL, NULL);
+	irq_set_probe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops pch_pic_domain_ops = {
+	.translate	= irq_domain_translate_twocell,
+	.alloc		= pch_pic_alloc,
+	.free		= irq_domain_free_irqs_parent,
+};
+
+static void pch_pic_reset(struct pch_pic *priv)
+{
+	int i;
+
+	for (i = 0; i < PIC_COUNT; i++) {
+		/* Write vectore ID */
+		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
+		/* Hardcode route to HT0 Lo */
+		writeb(1, priv->base + PCH_INT_ROUTE(i));
+	}
+
+	for (i = 0; i < PIC_REG_COUNT; i++) {
+		/* Clear IRQ cause registers, mask all interrupts */
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_MASK + 4 * i);
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_CLR + 4 * i);
+		/* Clear auto bounce, we don't need that */
+		writel_relaxed(0, priv->base + PCH_PIC_AUTO0 + 4 * i);
+		writel_relaxed(0, priv->base + PCH_PIC_AUTO1 + 4 * i);
+		/* Enable HTMSI transformer */
+		writel_relaxed(0xFFFFFFFF, priv->base + PCH_PIC_HTMSI_EN + 4 * i);
+	}
+}
+
+static int pch_pic_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct pch_pic *priv;
+	struct irq_domain *parent_domain;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->pic_lock);
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto free_priv;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		err = -ENXIO;
+		goto iounmap_base;
+	}
+
+	if (of_property_read_u32(node, "loongson,pic-base-vec",
+				&priv->ht_vec_base)) {
+		pr_err("Failed to determine pic-base-vec\n");
+		err = -EINVAL;
+		goto iounmap_base;
+	}
+
+	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						       PIC_COUNT,
+						       of_node_to_fwnode(node),
+						       &pch_pic_domain_ops,
+						       priv);
+	if (!priv->pic_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		err = -ENOMEM;
+		goto iounmap_base;
+	}
+
+	pch_pic_reset(priv);
+
+	return 0;
+
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return err;
+}
+
+IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
