Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36BC20C09
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 07:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgE3Hqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgE3Hqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 03:46:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25140C08C5C9;
        Sat, 30 May 2020 00:46:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jewCN-0001p3-R1; Sat, 30 May 2020 09:46:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CE001C032F;
        Sat, 30 May 2020 09:46:31 +0200 (CEST)
Date:   Sat, 30 May 2020 07:46:31 -0000
From:   "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add Loongson PCH MSI controller
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528152757.1028711-6-jiaxun.yang@flygoat.com>
References: <20200528152757.1028711-6-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <159082479130.17951.860616699515754060.tip-bot2@tip-bot2>
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

Commit-ID:     632dcc2c75ef6de3272aa4ddd8f19da1f1ace323
Gitweb:        https://git.kernel.org/tip/632dcc2c75ef6de3272aa4ddd8f19da1f1ace323
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Thu, 28 May 2020 23:27:53 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 29 May 2020 09:42:18 +01:00

irqchip: Add Loongson PCH MSI controller

This controller appears on Loongson LS7A family of PCH to transform
interrupts from PCI MSI into HyperTransport vectorized interrrupts
and send them to procrssor's HT vector controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200528152757.1028711-6-jiaxun.yang@flygoat.com
---
 drivers/irqchip/Kconfig                |  10 +-
 drivers/irqchip/Makefile               |   1 +-
 drivers/irqchip/irq-loongson-pch-msi.c | 255 ++++++++++++++++++++++++-
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-pch-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5524a62..0b6b826 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -549,4 +549,14 @@ config LOONGSON_PCH_PIC
 	help
 	  Support for the Loongson PCH PIC Controller.
 
+config LOONGSON_PCH_MSI
+	bool "Loongson PCH PIC Controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on PCI
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select PCI_MSI
+	help
+	  Support for the Loongson PCH MSI Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index acc7233..3a4ce28 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -109,3 +109,4 @@ obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
+obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
new file mode 100644
index 0000000..50becd2
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson PCH MSI support
+ */
+
+#define pr_fmt(fmt) "pch-msi: " fmt
+
+#include <linux/irqchip.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+struct pch_msi_data {
+	struct mutex	msi_map_lock;
+	phys_addr_t	doorbell;
+	u32		irq_first;	/* The vector number that MSIs starts */
+	u32		num_irqs;	/* The number of vectors for MSIs */
+	unsigned long	*msi_map;
+};
+
+static void pch_msi_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void pch_msi_unmask_msi_irq(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	pci_msi_unmask_irq(d);
+}
+
+static struct irq_chip pch_msi_irq_chip = {
+	.name			= "PCH PCI MSI",
+	.irq_mask		= pch_msi_mask_msi_irq,
+	.irq_unmask		= pch_msi_unmask_msi_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int pch_msi_allocate_hwirq(struct pch_msi_data *priv, int num_req)
+{
+	int first;
+
+	mutex_lock(&priv->msi_map_lock);
+
+	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
+					get_count_order(num_req));
+	if (first < 0) {
+		mutex_unlock(&priv->msi_map_lock);
+		return -ENOSPC;
+	}
+
+	mutex_unlock(&priv->msi_map_lock);
+
+	return priv->irq_first + first;
+}
+
+static void pch_msi_free_hwirq(struct pch_msi_data *priv,
+				int hwirq, int num_req)
+{
+	int first = hwirq - priv->irq_first;
+
+	mutex_lock(&priv->msi_map_lock);
+	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
+	mutex_unlock(&priv->msi_map_lock);
+}
+
+static void pch_msi_compose_msi_msg(struct irq_data *data,
+					struct msi_msg *msg)
+{
+	struct pch_msi_data *priv = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = upper_32_bits(priv->doorbell);
+	msg->address_lo = lower_32_bits(priv->doorbell);
+	msg->data = data->hwirq;
+}
+
+static struct msi_domain_info pch_msi_domain_info = {
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+	.chip	= &pch_msi_irq_chip,
+};
+
+static struct irq_chip middle_irq_chip = {
+	.name			= "PCH MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
+};
+
+static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, int hwirq)
+{
+	struct irq_fwspec fwspec;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hwirq;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
+					   unsigned int virq,
+					   unsigned int nr_irqs, void *args)
+{
+	struct pch_msi_data *priv = domain->host_data;
+	int hwirq, err, i;
+
+	hwirq = pch_msi_allocate_hwirq(priv, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = pch_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &middle_irq_chip, priv);
+	}
+
+	return 0;
+
+err_hwirq:
+	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, i - 1);
+
+	return err;
+}
+
+static void pch_msi_middle_domain_free(struct irq_domain *domain,
+					   unsigned int virq,
+					   unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct pch_msi_data *priv = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	pch_msi_free_hwirq(priv, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops pch_msi_middle_domain_ops = {
+	.alloc	= pch_msi_middle_domain_alloc,
+	.free	= pch_msi_middle_domain_free,
+};
+
+static int pch_msi_init_domains(struct pch_msi_data *priv,
+				struct device_node *node,
+				struct irq_domain *parent)
+{
+	struct irq_domain *middle_domain, *msi_domain;
+
+	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+						priv->num_irqs,
+						&pch_msi_middle_domain_ops,
+						priv);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	middle_domain->parent = parent;
+	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
+
+	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+					       &pch_msi_domain_info,
+					       middle_domain);
+	if (!msi_domain) {
+		pr_err("Failed to create PCI MSI domain\n");
+		irq_domain_remove(middle_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int pch_msi_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	struct pch_msi_data *priv;
+	struct irq_domain *parent_domain;
+	struct resource res;
+	int ret;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->msi_map_lock);
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret) {
+		pr_err("Failed to allocate resource\n");
+		goto err_priv;
+	}
+
+	priv->doorbell = res.start;
+
+	if (of_property_read_u32(node, "loongson,msi-base-vec",
+				&priv->irq_first)) {
+		pr_err("Unable to parse MSI vec base\n");
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-num-vecs",
+				&priv->num_irqs)) {
+		pr_err("Unable to parse MSI vec number\n");
+		ret = -EINVAL;
+		goto err_priv;
+	}
+
+	priv->msi_map = bitmap_alloc(priv->num_irqs, GFP_KERNEL);
+	if (!priv->msi_map) {
+		ret = -ENOMEM;
+		goto err_priv;
+	}
+
+	pr_debug("Registering %d MSIs, starting at %d\n",
+		 priv->num_irqs, priv->irq_first);
+
+	ret = pch_msi_init_domains(priv, node, parent_domain);
+	if (ret)
+		goto err_map;
+
+	return 0;
+
+err_map:
+	kfree(priv->msi_map);
+err_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
