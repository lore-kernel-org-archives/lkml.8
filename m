Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB277C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFE620776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgE3Hqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgE3Hqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC7C03E969;
        Sat, 30 May 2020 00:46:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCP-0001q9-Ie; Sat, 30 May 2020 09:46:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 300211C032F;
        Sat, 30 May 2020 09:46:33 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:33 -0000
From:   "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add Loongson HyperTransport Vector support
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528152757.1028711-2-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <159082479307.17951.4027089078248854057.tip-bot2@tip-bot2>
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

Commit-ID:     818e915fbac518e8c78e1877a0048d92d4965e5a
Gitweb:        https://git.kernel.org/tip/818e915fbac518e8c78e1877a0048d92d4965e5a
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Thu, 28 May 2020 23:27:49 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 29 May 2020 09:42:18 +01:00

irqchip: Add Loongson HyperTransport Vector support

This controller appears on Loongson-3 chips for receiving interrupt
vectors from PCH's PIC and PCH's PCIe MSI interrupts.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200528152757.1028711-2-jiaxun.yang@flygoat.com
---
 drivers/irqchip/Kconfig              |   8 +-
 drivers/irqchip/Makefile             |   1 +-
 drivers/irqchip/irq-loongson-htvec.c | 214 ++++++++++++++++++++++++++-
 3 files changed, 223 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-htvec.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a85aada..de4564e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -532,4 +532,12 @@ config LOONGSON_HTPIC
 	help
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
+config LOONGSON_HTVEC
+	bool "Loongson3 HyperTransport Interrupt Vector Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 37bbe39..7456187 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
+obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
new file mode 100644
index 0000000..1ece933
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson HyperTransport Interrupt Vector support
+ */
+
+#define pr_fmt(fmt) "htvec: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+/* Registers */
+#define HTVEC_EN_OFF		0x20
+#define HTVEC_MAX_PARENT_IRQ	4
+
+#define VEC_COUNT_PER_REG	32
+#define VEC_REG_COUNT		4
+#define VEC_COUNT		(VEC_COUNT_PER_REG * VEC_REG_COUNT)
+#define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
+#define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
+
+struct htvec {
+	void __iomem		*base;
+	struct irq_domain	*htvec_domain;
+	raw_spinlock_t		htvec_lock;
+};
+
+static void htvec_irq_dispatch(struct irq_desc *desc)
+{
+	int i;
+	u32 pending;
+	bool handled = false;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct htvec *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < VEC_REG_COUNT; i++) {
+		pending = readl(priv->base + 4 * i);
+		while (pending) {
+			int bit = __ffs(pending);
+
+			generic_handle_irq(irq_linear_revmap(priv->htvec_domain, bit +
+							     VEC_COUNT_PER_REG * i));
+			pending &= ~BIT(bit);
+			handled = true;
+		}
+	}
+
+	if (!handled)
+		spurious_interrupt();
+
+	chained_irq_exit(chip, desc);
+}
+
+static void htvec_ack_irq(struct irq_data *d)
+{
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	writel(BIT(VEC_REG_BIT(d->hwirq)),
+	       priv->base + VEC_REG_IDX(d->hwirq) * 4);
+}
+
+static void htvec_mask_irq(struct irq_data *d)
+{
+	u32 reg;
+	void __iomem *addr;
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&priv->htvec_lock);
+	addr = priv->base + HTVEC_EN_OFF;
+	addr += VEC_REG_IDX(d->hwirq) * 4;
+	reg = readl(addr);
+	reg &= ~BIT(VEC_REG_BIT(d->hwirq));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->htvec_lock);
+}
+
+static void htvec_unmask_irq(struct irq_data *d)
+{
+	u32 reg;
+	void __iomem *addr;
+	struct htvec *priv = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&priv->htvec_lock);
+	addr = priv->base + HTVEC_EN_OFF;
+	addr += VEC_REG_IDX(d->hwirq) * 4;
+	reg = readl(addr);
+	reg |= BIT(VEC_REG_BIT(d->hwirq));
+	writel(reg, addr);
+	raw_spin_unlock(&priv->htvec_lock);
+}
+
+static struct irq_chip htvec_irq_chip = {
+	.name			= "LOONGSON_HTVEC",
+	.irq_mask		= htvec_mask_irq,
+	.irq_unmask		= htvec_unmask_irq,
+	.irq_ack		= htvec_ack_irq,
+};
+
+static int htvec_domain_alloc(struct irq_domain *domain, unsigned int virq,
+			      unsigned int nr_irqs, void *arg)
+{
+	unsigned long hwirq;
+	unsigned int type, i;
+	struct htvec *priv = domain->host_data;
+
+	irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &htvec_irq_chip,
+				    priv, handle_edge_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void htvec_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops htvec_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= htvec_domain_alloc,
+	.free		= htvec_domain_free,
+};
+
+static void htvec_reset(struct htvec *priv)
+{
+	u32 idx;
+
+	/* Clear IRQ cause registers, mask all interrupts */
+	for (idx = 0; idx < VEC_REG_COUNT; idx++) {
+		writel_relaxed(0x0, priv->base + HTVEC_EN_OFF + 4 * idx);
+		writel_relaxed(0xFFFFFFFF, priv->base);
+	}
+}
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct htvec *priv;
+	int err, parent_irq[4], num_parents = 0, i;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->htvec_lock);
+	priv->base = of_iomap(node, 0);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto free_priv;
+	}
+
+	/* Interrupt may come from any of the 4 interrupt line */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	if (!num_parents) {
+		pr_err("Failed to get parent irqs\n");
+		err = -ENODEV;
+		goto iounmap_base;
+	}
+
+	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						      VEC_COUNT,
+						      &htvec_domain_ops,
+						      priv);
+	if (!priv->htvec_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		err = -ENOMEM;
+		goto iounmap_base;
+	}
+
+	htvec_reset(priv);
+
+	for (i = 0; i < num_parents; i++)
+		irq_set_chained_handler_and_data(parent_irq[i],
+						 htvec_irq_dispatch, priv);
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
+IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
