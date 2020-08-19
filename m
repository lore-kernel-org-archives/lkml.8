Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F008C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F194208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoyZy5hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHSQjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHSQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:38:06 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFBAC061342;
        Wed, 19 Aug 2020 09:38:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so18615462edb.12;
        Wed, 19 Aug 2020 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1z3eY2e3bxGidDllkegZE04IryrnKtWIutHWpc8k8I=;
        b=JoyZy5hvBY8uOXiDITuyz77/vUCETtH4WpvrJGu4LgrPgbSEpZ0KGdxsmkSY3EqUSS
         OFHqpjy1YxHisk3YL2ekzrEhkb1KA3k1DTuWtD9gT5MWOUETXKthQhfmX9XJKKJ7AxAB
         PS9r839zciNaJeezYI2ChFsKS2f0qZivdyn7kRPmPslCJMalWEqW+5N88WQhH4yZzutz
         TyRvgJ2cdhZLtmcXuzyXQLFWr+wnYRn1xmRlNkTZ+5Z9SrL1hVc2PgHcO4x2MVsXVJx0
         pi2PCirG5YZAxseHtVgYpWokdoJ5KNf6MYCkvnXYavVIxYBzB/EfBZolT72Z2d5TRxtn
         DnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1z3eY2e3bxGidDllkegZE04IryrnKtWIutHWpc8k8I=;
        b=YgtnB6wdgOhnF5Il9AnjO3daZ7ir68bo1HWNtgFRD1kz4WQFjCwQqQuin4yeTIACdr
         fS0E6kdeqIw1gBd6UGrSONg40GNLDD7qa/F5ETfUWxqNjbbmjaWwB2JhyvKDio/7dHJb
         P71SIN9Onx02a1EMa1Wr3CzYLwEQmcH8nDEcsTG39R7jhcRuQD+hhWCrjvfWz8ahwAN5
         PtF+SZ8LgHYPkcOcNcm2jb6iOXxnBXojvl5IjZZWAxHHviuQ4BSOqHS+NvYdt8AWaXYz
         Gre/N7lLsdcQ//oOLffVTpv+KuhhJ28LflSOHnwi9x8VgN/v/WP7lEzpg3gUFQoguMQO
         jNTw==
X-Gm-Message-State: AOAM531r16YfTAHRK03TuW23pKP07NEX80iabFZZB6WCLxWR0HdmVLU0
        eZR6YurAju4Tv29emsqWVfU=
X-Google-Smtp-Source: ABdhPJyKokcctliFKN3v6LooRUPHC151f2V03fD+hlZ7qaAJousGWVpNOv02eS6SCwAdTJPR6PA6QA==
X-Received: by 2002:a50:fb10:: with SMTP id d16mr25736345edq.134.1597855083405;
        Wed, 19 Aug 2020 09:38:03 -0700 (PDT)
Received: from localhost.localdomain ([188.24.144.238])
        by smtp.gmail.com with ESMTPSA id m13sm18310774edi.89.2020.08.19.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:38:03 -0700 (PDT)
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
Subject: [PATCH v5 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Date:   Wed, 19 Aug 2020 19:37:57 +0300
Message-Id: <c90b08b1723e20f276de84c7686760e0d3ae072d.1597852360.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
References: <cover.1597852360.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This interrupt controller is found in the Actions Semi Owl SoCs (S500,
S700 and S900) and provides support for handling up to 3 external
interrupt lines.

Each line can be independently configured as interrupt and triggers
on either of the edges (raising or falling) or either of the levels
(high or low). Additionally, each line can also be masked individually.

This is based on the patch series submitted by Parthiban Nallathambi:
https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
[cristi: optimized DT, various fixes/cleanups/improvements]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v5 - according to Marc's review:
* Updated commit message
* Aligned members in struct owl_sirq_chip_data
* Added naming for SIRQ0 control register offset
* Improved code readability by using FIELD_PREP and FIELD_GET
* Dropped redundant handling of the IRQ trigger information
* Added missing irq_set_affinity to owl_sirq_chip descriptor

 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-owl-sirq.c | 347 +++++++++++++++++++++++++++++++++
 2 files changed, 348 insertions(+)
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
index 000000000000..2e55984d1a2c
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,347 @@
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
+#include <linux/bitfield.h>
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
+/* S500 & S700 SIRQ control register masks */
+#define INTC_EXTCTL_SIRQ0_MASK		GENMASK(23, 16)
+#define INTC_EXTCTL_SIRQ1_MASK		GENMASK(15, 8)
+#define INTC_EXTCTL_SIRQ2_MASK		GENMASK(7, 0)
+
+/* S900 SIRQ control register offsets, relative to controller base address */
+#define INTC_EXTCTL0			0x0000
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
+	const struct owl_sirq_params	*params;
+	void __iomem			*base;
+	raw_spinlock_t			lock;
+	u32				ext_irqs[NUM_SIRQ];
+};
+
+/* S500 & S700 SoCs */
+static const struct owl_sirq_params owl_sirq_s500_params = {
+	.reg_shared = true,
+	.reg_offset = { 0, 0, 0 },
+};
+
+/* S900 SoC */
+static const struct owl_sirq_params owl_sirq_s900_params = {
+	.reg_shared = false,
+	.reg_offset = { INTC_EXTCTL0, INTC_EXTCTL1, INTC_EXTCTL2 },
+};
+
+static u32 owl_field_get(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_GET(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_GET(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_GET(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_field_prep(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32 index)
+{
+	u32 val;
+
+	val = readl_relaxed(data->base + data->params->reg_offset[index]);
+	if (data->params->reg_shared)
+		val = owl_field_get(val, index);
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
+		val &= ~owl_field_prep(0xff, index);
+		extctl = owl_field_prep(extctl, index) | val;
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
+	if (!irqd_is_level_type(data))
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
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sirq_type = INTC_EXTCTL_TYPE_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		sirq_type = INTC_EXTCTL_TYPE_FALLING;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		sirq_type = INTC_EXTCTL_TYPE_RISING;
+		break;
+	default:
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
+#ifdef CONFIG_SMP
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+#endif
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

