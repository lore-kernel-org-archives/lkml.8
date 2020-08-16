Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0776320760
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzJaLGhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgHPLhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgHPLe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:34:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5FEC061389;
        Sun, 16 Aug 2020 04:34:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w17so10097306edt.8;
        Sun, 16 Aug 2020 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/Xk9vqsFa2pytcZR9ZEjV+eE9g6nLCPU/rDSAimPno=;
        b=UzJaLGhHPGRYCf1XSubqG9MTpbrvITheAIv7kV4wyCZcDFRenDGdJWCldDeAiE+TZK
         JdBLWGN7Yb/KfF6AN6R6rW5D9HL8whMEWVj8f+1p2UhVgmgEY/pWTFjdsiS0nJ0b0gOm
         CPLU/9IjZ2DpN22S1LQ1VPmx53CjOg7zwjmncaz19Y0xneDuzaKE8BY8mFW8eRuV3GaD
         FuC7EAl8ru+/srrroweUgR4Jqccjnrf9ucINI8cm4+8zEQ6p/16hArc5bNIyIysuDTAQ
         2ppJqL8vJcz4zmePXz5WX3jwthKMx3wcUrlvD+JLIYfoWMi/wRteEzZaCnoKf6Li6D+w
         8XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/Xk9vqsFa2pytcZR9ZEjV+eE9g6nLCPU/rDSAimPno=;
        b=bsbjFEsWwm4uRI2lJXk2sko1LgqttW6odazgKxCdmU56MawGc5Vv+gAC3UeJT9/qEa
         Ki+/nFd1s92Z4pAYS4qzOAWZlh6TWmEdbTiwkMm9dNt33XH/bJpT7GxxUgwmhXlZ1dOc
         53XZmf17ZBKAMPPphocpHCy24rRJVyRBw3ssFdVnkI/kbhjfHDqZIK7ms7YxG0jmUwrg
         VhHqFdyB9wvw0ZCVdlqrlthUNKx8eRAWJnmKhokPXRwkjvScOgQsDDBCzXnSFBPnx6Qo
         g/GBv67zmKdvkF4BVIHP8N1m3y0Q1qbWCrhxYBR+QSdl1RHa4z3TvqKmJOSVVE6y8MPd
         yeAA==
X-Gm-Message-State: AOAM530wGD0nlkFOTrjO8p6bRRtgDkAXXna3DreHXeV46btxF3i9hWf1
        pPsQS33pKQTWFpd7m0AEUUg=
X-Google-Smtp-Source: ABdhPJxx5cQuV+5JU7Cb5jz1ijuFSesE5B9q177XEHYSWQxSytOpwWwHXlgS13NllYxAy13nf/lBBQ==
X-Received: by 2002:a05:6402:1a46:: with SMTP id bf6mr10296238edb.284.1597577642444;
        Sun, 16 Aug 2020 04:34:02 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id p1sm11272945edu.11.2020.08.16.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 04:34:01 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Date:   Sun, 16 Aug 2020 14:33:55 +0300
Message-Id: <addb413d192d88c076c6ed7f453aa693095bdd15.1597571397.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
References: <cover.1597571397.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controller appears on Actions Semi Owl family SoC's S500, S700 and
S900 and provides support for 3 external interrupt controllers through
dedicated SIRQ pins.

Each line can be independently configured as interrupt and triggers
on either of the edges (raising or falling) or either of the levels
(high or low). Each line can also be masked independently.

This is based on the patch series submitted by Parthiban Nallathambi:
https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
[cristi: optimized DT, various fixes/cleanups/improvements]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-owl-sirq.c | 318 +++++++++++++++++++++++++++++++++
 2 files changed, 319 insertions(+)
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..b8eb5b8b766d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
new file mode 100644
index 000000000000..29b7ffc40ac7
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi Owl SoCs SIRQ interrupt controller driver
+ *
+ * Copyright (C) 2014 Actions Semi Inc.
+ * David Liu <liuwei@actions-semi.com>
+ *
+ * Author: Parthiban Nallathambi <pn@denx.de>
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ * Author: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define NUM_SIRQ			3
+
+#define INTC_EXTCTL_PENDING		BIT(0)
+#define INTC_EXTCTL_CLK_SEL		BIT(4)
+#define INTC_EXTCTL_EN			BIT(5)
+#define INTC_EXTCTL_TYPE_MASK		GENMASK(7, 6)
+#define INTC_EXTCTL_TYPE_HIGH		0
+#define INTC_EXTCTL_TYPE_LOW		BIT(6)
+#define INTC_EXTCTL_TYPE_RISING		BIT(7)
+#define INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
+
+/* S900 SIRQ1 & SIRQ2 control register offsets, relative to SIRQ0 */
+#define INTC_EXTCTL1			0x0328
+#define INTC_EXTCTL2			0x032c
+
+struct owl_sirq_params {
+	/* INTC_EXTCTL reg shared for all three SIRQ lines */
+	bool reg_shared;
+	/* INTC_EXTCTL reg offsets relative to controller base address */
+	u16 reg_offset[NUM_SIRQ];
+};
+
+struct owl_sirq_chip_data {
+	const struct owl_sirq_params *params;
+	void __iomem *base;
+	raw_spinlock_t lock;
+	u32 ext_irqs[NUM_SIRQ];
+	u8 trigger;
+};
+
+/* S500 and S700 SoCs */
+static const struct owl_sirq_params owl_sirq_s500_params = {
+	.reg_shared = true,
+	.reg_offset = { 0, 0, 0 },
+};
+
+/* S900 SoC */
+static const struct owl_sirq_params owl_sirq_s900_params = {
+	.reg_shared = false,
+	.reg_offset = { 0, INTC_EXTCTL1, INTC_EXTCTL2 },
+};
+
+static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32 index)
+{
+	u32 val;
+
+	val = readl_relaxed(data->base + data->params->reg_offset[index]);
+	if (data->params->reg_shared)
+		val = (val >> (2 - index) * 8) & 0xff;
+
+	return val;
+}
+
+static void owl_sirq_write_extctl(struct owl_sirq_chip_data *data,
+				  u32 extctl, u32 index)
+{
+	u32 val;
+
+	if (data->params->reg_shared) {
+		val = readl_relaxed(data->base + data->params->reg_offset[index]);
+		val &= ~(0xff << (2 - index) * 8);
+		extctl &= 0xff;
+		extctl = (extctl << (2 - index) * 8) | val;
+	}
+
+	writel_relaxed(extctl, data->base + data->params->reg_offset[index]);
+}
+
+static void owl_sirq_clear_set_extctl(struct owl_sirq_chip_data *d,
+				      u32 clear, u32 set, u32 index)
+{
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&d->lock, flags);
+	val = owl_sirq_read_extctl(d, index);
+	val &= ~clear;
+	val |= set;
+	owl_sirq_write_extctl(d, val, index);
+	raw_spin_unlock_irqrestore(&d->lock, flags);
+}
+
+static void owl_sirq_eoi(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	/*
+	 * Software must clear external interrupt pending, when interrupt type
+	 * is edge triggered, so we need per SIRQ based clearing.
+	 */
+	if (chip_data->trigger & (1 << data->hwirq))
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_PENDING,
+					  data->hwirq);
+
+	irq_chip_eoi_parent(data);
+}
+
+static void owl_sirq_mask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_EN, 0, data->hwirq);
+	irq_chip_mask_parent(data);
+}
+
+static void owl_sirq_unmask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_EN, data->hwirq);
+	irq_chip_unmask_parent(data);
+}
+
+/*
+ * GIC does not handle falling edge or active low, hence SIRQ shall be
+ * programmed to convert falling edge to rising edge signal and active
+ * low to active high signal.
+ */
+static int owl_sirq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+	u32 sirq_type;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sirq_type = INTC_EXTCTL_TYPE_LOW;
+		chip_data->trigger &= ~(1 << data->hwirq);
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sirq_type = INTC_EXTCTL_TYPE_HIGH;
+		chip_data->trigger &= ~(1 << data->hwirq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		sirq_type = INTC_EXTCTL_TYPE_FALLING;
+		chip_data->trigger |= 1 << data->hwirq;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		sirq_type = INTC_EXTCTL_TYPE_RISING;
+		chip_data->trigger |= 1 << data->hwirq;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_TYPE_MASK, sirq_type,
+				  data->hwirq);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip owl_sirq_chip = {
+	.name		= "owl-sirq",
+	.irq_mask	= owl_sirq_mask,
+	.irq_unmask	= owl_sirq_unmask,
+	.irq_eoi	= owl_sirq_eoi,
+	.irq_set_type	= owl_sirq_set_type,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+};
+
+static int owl_sirq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= NUM_SIRQ)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int owl_sirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct owl_sirq_chip_data *chip_data = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = owl_sirq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &owl_sirq_chip,
+				      chip_data);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = 0;	/* SPI */
+	parent_fwspec.param[1] = chip_data->ext_irqs[hwirq];
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static const struct irq_domain_ops owl_sirq_domain_ops = {
+	.translate	= owl_sirq_domain_translate,
+	.alloc		= owl_sirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static const struct of_device_id owl_sirq_of_match[] = {
+	{ .compatible = "actions,s500-sirq", .data = &owl_sirq_s500_params },
+	{ .compatible = "actions,s700-sirq", .data = &owl_sirq_s500_params },
+	{ .compatible = "actions,s900-sirq", .data = &owl_sirq_s900_params },
+	{ /* sentinel */ }
+};
+
+static int __init owl_sirq_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	const struct of_device_id *match;
+	struct irq_domain *domain, *parent_domain;
+	struct owl_sirq_chip_data *chip_data;
+	int ret, i;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: failed to find sirq parent domain\n", node);
+		return -ENXIO;
+	}
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	match = of_match_node(owl_sirq_of_match, node);
+	if (!match) {
+		pr_warn("owl-sirq: assuming S500/S700 compatible controller\n");
+		chip_data->params = &owl_sirq_s500_params;
+	} else {
+		chip_data->params = match->data;
+	}
+
+	raw_spin_lock_init(&chip_data->lock);
+
+	chip_data->base = of_iomap(node, 0);
+	if (!chip_data->base) {
+		pr_err("%pOF: failed to map sirq registers\n", node);
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	ret = of_property_read_variable_u32_array(node, "actions,ext-interrupts",
+						  chip_data->ext_irqs,
+						  NUM_SIRQ, NUM_SIRQ);
+	if (ret < NUM_SIRQ) {
+		pr_err("%pOF: failed to read sirq interrupts\n", node);
+		goto out_unmap;
+	}
+
+	/* Set 24MHz external interrupt clock freq */
+	for (i = 0; i < NUM_SIRQ; i++)
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_CLK_SEL, i);
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_SIRQ, node,
+					  &owl_sirq_domain_ops, chip_data);
+	if (!domain) {
+		pr_err("%pOF: failed to add domain\n", node);
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(chip_data->base);
+out_free:
+	kfree(chip_data);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(owl_sirq, "actions,owl-sirq", owl_sirq_of_init);
-- 
2.28.0

