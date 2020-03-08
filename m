Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA7C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304120828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCHQdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgCHQcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AC29B23A;
        Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC 09/11] irqchip: Add Sunplus SP7021 interrupt (mux) controller
Date:   Sun,  8 Mar 2020 17:32:27 +0100
Message-Id: <20200308163230.4002-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/irqchip/Makefile     |   1 +
 drivers/irqchip/irq-sp7021.c | 285 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 drivers/irqchip/irq-sp7021.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index eae0d78cbf22..a6b70d666739 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,3 +105,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
+obj-$(CONFIG_ARCH_SUNPLUS)		+= irq-sp7021.o
diff --git a/drivers/irqchip/irq-sp7021.c b/drivers/irqchip/irq-sp7021.c
new file mode 100644
index 000000000000..a0b7972f2abb
--- /dev/null
+++ b/drivers/irqchip/irq-sp7021.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Sunplus Plus1 SP7021 SoC interrupt controller
+ *
+ * Copyright (c) 2020 Andreas Färber
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define REG_INTC_INTR_TYPE(i)		(0x0 + (i) * 4)
+#define REG_INTC_INTR_POLARITY(i)	(0x1c + (i) * 4)
+#define REG_INTC_INTR_PRIO(i)		(0x38 + (i) * 4)
+#define REG_INTC_INTR_MASK(i)		(0x54 + (i) * 4)
+
+#define REG_INTC_INTR_CLR(i)		(0x0 + (i) * 4)
+#define REG_INTC_MASKED_FIQS(i)		(0x1c + (i) * 4)
+#define REG_INTC_MASKED_IRQS(i)		(0x38 + (i) * 4)
+#define REG_INTC_INTR_GROUP		0x7c
+
+#define INTC_INTR_GROUP_FIQ	GENMASK(6, 0)
+#define INTC_INTR_GROUP_IRQ	GENMASK(14, 8)
+
+struct sp7021_intc_data {
+	void __iomem		*base0;
+	void __iomem		*base1;
+	int			ext0_irq;
+	int			ext1_irq;
+	struct irq_chip		chip;
+	struct irq_domain	*domain;
+	raw_spinlock_t		lock;
+};
+
+static void sp7021_intc_ext0_irq_handle(struct irq_desc *desc)
+{
+	struct sp7021_intc_data *s = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 mask, masked;
+	int i, j;
+
+	chained_irq_enter(chip, desc);
+
+	mask = readl_relaxed(s->base1 + REG_INTC_INTR_GROUP);
+	mask = FIELD_GET(INTC_INTR_GROUP_IRQ, mask);
+	while (mask) {
+		i = fls(mask) - 1;
+		mask &= ~BIT(i);
+
+		masked = readl_relaxed(s->base1 + REG_INTC_MASKED_IRQS(i));
+		while (masked) {
+			j = fls(masked) - 1;
+			masked &= ~BIT(j);
+
+			generic_handle_irq(irq_find_mapping(s->domain,
+							    i * 32 + j));
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void sp7021_intc_ext1_irq_handle(struct irq_desc *desc)
+{
+	struct sp7021_intc_data *s = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 mask, masked;
+	int i, j;
+
+	chained_irq_enter(chip, desc);
+
+	mask = readl_relaxed(s->base1 + REG_INTC_INTR_GROUP);
+	mask = FIELD_GET(INTC_INTR_GROUP_FIQ, mask);
+	while (mask) {
+		i = fls(mask) - 1;
+		mask &= ~BIT(i);
+
+		masked = readl_relaxed(s->base1 + REG_INTC_MASKED_FIQS(i));
+		while (masked) {
+			j = fls(masked) - 1;
+			masked &= ~BIT(j);
+
+			generic_handle_irq(irq_find_mapping(s->domain,
+							    i * 32 + j));
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void sp7021_intc_ack_irq(struct irq_data *data)
+{
+	struct sp7021_intc_data *s = irq_data_get_irq_chip_data(data);
+	unsigned int idx;
+	u32 mask;
+
+	idx = data->hwirq / 32;
+
+	mask = BIT(data->hwirq % 32);
+	writel_relaxed(mask, s->base1 + REG_INTC_INTR_CLR(idx));
+}
+
+static void sp7021_intc_mask_irq(struct irq_data *data)
+{
+	struct sp7021_intc_data *s = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	unsigned int idx;
+	u32 mask;
+
+	idx = data->hwirq / 32;
+
+	raw_spin_lock_irqsave(&s->lock, flags);
+
+	mask = readl_relaxed(s->base0 + REG_INTC_INTR_MASK(idx));
+	mask &= ~BIT(data->hwirq % 32);
+	writel_relaxed(mask, s->base0 + REG_INTC_INTR_MASK(idx));
+
+	raw_spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static void sp7021_intc_unmask_irq(struct irq_data *data)
+{
+	struct sp7021_intc_data *s = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	unsigned int idx;
+	u32 mask;
+
+	idx = data->hwirq / 32;
+
+	raw_spin_lock_irqsave(&s->lock, flags);
+
+	mask = readl_relaxed(s->base0 + REG_INTC_INTR_MASK(idx));
+	mask |= BIT(data->hwirq % 32);
+	writel_relaxed(mask, s->base0 + REG_INTC_INTR_MASK(idx));
+
+	raw_spin_unlock_irqrestore(&s->lock, flags);
+}
+
+static int sp7021_intc_set_irq_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct sp7021_intc_data *s = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	unsigned int idx;
+	u32 mask, type, polarity;
+
+	idx = data->hwirq / 32;
+	mask = BIT(data->hwirq % 32);
+
+	if (flow_type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_chip_handler_name_locked(data, &s->chip, handle_level_irq, NULL);
+	else
+		irq_set_chip_handler_name_locked(data, &s->chip, handle_edge_irq, NULL);
+
+	raw_spin_lock_irqsave(&s->lock, flags);
+
+	type = readl_relaxed(s->base0 + REG_INTC_INTR_TYPE(idx));
+	polarity = readl_relaxed(s->base0 + REG_INTC_INTR_POLARITY(idx));
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_RISING:
+		type |= mask;
+		polarity &= ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type |= mask;
+		polarity |= mask;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		type &= ~mask;
+		polarity &= ~mask;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type &= ~mask;
+		polarity |= mask;
+		break;
+	default:
+		raw_spin_unlock_irqrestore(&s->lock, flags);
+		return -EBADR;
+	}
+
+	writel_relaxed(type, s->base0 + REG_INTC_INTR_TYPE(idx));
+	writel_relaxed(polarity, s->base0 + REG_INTC_INTR_POLARITY(idx));
+
+	raw_spin_unlock_irqrestore(&s->lock, flags);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static const struct irq_chip sp7021_intc_irq_chip = {
+	.name			= "SP7021-A",
+	.irq_ack		= sp7021_intc_ack_irq,
+	.irq_mask		= sp7021_intc_mask_irq,
+	.irq_unmask		= sp7021_intc_unmask_irq,
+	.irq_set_type		= sp7021_intc_set_irq_type,
+};
+
+static int sp7021_intc_irq_domain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hw)
+{
+	struct sp7021_intc_data *s = d->host_data;
+	unsigned int idx;
+	u32 mask, type;
+
+	idx = hw / 32;
+	mask = BIT(hw % 32);
+
+	type = readl_relaxed(s->base0 + REG_INTC_INTR_TYPE(idx));
+
+	irq_set_chip_and_handler(irq, &s->chip, (type & mask) ? handle_edge_irq : handle_level_irq);
+	irq_set_chip_data(irq, s);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sp7021_intc_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= sp7021_intc_irq_domain_map,
+};
+
+int __init sp7021_intc_init(struct device_node *node, struct device_node *parent)
+{
+	struct sp7021_intc_data *s;
+	void __iomem *base0, *base1;
+	int i;
+
+	base0 = of_iomap(node, 0);
+	if (!base0)
+		return -EIO;
+
+	base1 = of_iomap(node, 1);
+	if (!base1)
+		return -EIO;
+
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->base0 = base0;
+	s->base1 = base1;
+	s->chip = sp7021_intc_irq_chip;
+
+	s->ext0_irq = irq_of_parse_and_map(node, 0);
+	if (s->ext0_irq <= 0) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	s->ext1_irq = irq_of_parse_and_map(node, 1);
+	if (s->ext1_irq <= 0) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_init(&s->lock);
+
+	for (i = 0; i < 7; i++) {
+		writel_relaxed(0, s->base0 + REG_INTC_INTR_MASK(i));
+		writel_relaxed(~0, s->base0 + REG_INTC_INTR_TYPE(i));
+		writel_relaxed(0, s->base0 + REG_INTC_INTR_POLARITY(i));
+
+		/* irq, not fiq */
+		writel_relaxed(~0, s->base0 + REG_INTC_INTR_PRIO(i));
+
+		writel_relaxed(~0, s->base1 + REG_INTC_INTR_CLR(i));
+	}
+
+	s->domain = irq_domain_add_linear(node, 200, &sp7021_intc_domain_ops,
+					  s);
+	if (!s->domain) {
+		kfree(s);
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(s->ext0_irq, sp7021_intc_ext0_irq_handle, s);
+	irq_set_chained_handler_and_data(s->ext1_irq, sp7021_intc_ext1_irq_handle, s);
+
+	return 0;
+}
+IRQCHIP_DECLARE(sp7021_intc, "sunplus,sp7021-intc", sp7021_intc_init);
-- 
2.16.4

