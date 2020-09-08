Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5732F21D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4C6tqtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgIHIVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgIHIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:20:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA3C061755;
        Tue,  8 Sep 2020 01:20:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c10so15084730edk.6;
        Tue, 08 Sep 2020 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DTF07SAWl5KXUyeZsjfSS7NpFEYyyCWUCIZRtdcA04=;
        b=U4C6tqtwGMfJS8vh6pInoZryPiNFg5tcTT9rWW/tgjIT5J6iji+DjsEnxFWb5BXwtd
         STeyT6JqQ80SArqnqUS3FmXsMsOBHdtnWtmwX6EB4jWSQoxkoDBmf9diyKfafjy4UhEo
         iE/1uS3Z4AQSVqySBmxUqXHSuIgiti/AYKlPZ9eGpyjkI1B5w7aGuq0adVw6o2V0HjPx
         yeJQ62I5qPwOc0WyljzZR8aE3ux0apRwlKqm2ysSR+1kQ5ClQB6GP02UsmlWwKlAUTCF
         lkf58FnImXmjISa+eSAKKYDlbc5T3gpkFUc7toTAiqv58WCpgUxERKWnhU/1uN38obqJ
         F/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DTF07SAWl5KXUyeZsjfSS7NpFEYyyCWUCIZRtdcA04=;
        b=ErZThtDjp7kyuRDZR3eqZQajwSaUrJHIos4pqYI35013K5Exe5JvOSM8OTtGp8nEBD
         vnJT06s9Qq3skdXvToKXpMN1HfU5lXw/DBwUthv9cmhXS2sN6ZZ+DG0SMXeTDgzqD6DK
         cP4gBt52AuLyMSFvHosNFzY3aid3j/zfBl94D3sdgVfXqZ1FB5p8N7KY2kRN4yJ4qLgp
         W7NkirfslSixPaK1f7FZEcG1PKc5/yt70DhOzHSJ5UJj6cKklk+jvvIVR846vUWA+/b8
         LI/9XYBS/gr6BdhUpoaSBBj7uVRlMr5z+CyWUzb03BcApAUfMZS03N7aQupqBgM8kWhQ
         Njzw==
X-Gm-Message-State: AOAM5329H9H3lWa0zSr+QSb+2srqyw4eZkuDlcC7xUfby2bqdMCQOUyM
        uNVmI75UGhOvrv/QsWrDNjI=
X-Google-Smtp-Source: ABdhPJwSW/c4EHpZMZAIbj1v3qYCjwrZG/GxNxPUKm6ovYqpTPjfX+Uw7pkhewYNyMzy9l4bP5VWSQ==
X-Received: by 2002:aa7:cb10:: with SMTP id s16mr25947564edt.72.1599553255695;
        Tue, 08 Sep 2020 01:20:55 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g24sm13172326edy.51.2020.09.08.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:20:55 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Date:   Tue,  8 Sep 2020 11:20:49 +0300
Message-Id: <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This interrupt controller is found in the Actions Semi Owl SoCs (S500,
S700 and S900) and provides support for handling up to 3 external
interrupt lines.

Each line can be independently configured as interrupt and triggers on
either of the edges or either of the levels. Additionally, each line
can also be masked individually.

The patch is based on the work started by Parthiban Nallathambi:
https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
[cristi: optimized DT, various fixes/cleanups/improvements]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v6:
 - Got rid of the of_match table and used IRQCHIP_DECLARE for each
   of the 3 driver compatibles
 - Transformed owl_sirq_of_init() into a helper function: renamed
   to owl_sirq_of_init(), dropped handling of the custom property
   'actions,ext-interrupts' and used standard API for parsing the
   replacement 'interrupts'
 - Used GIC_SPI constant instead of the related number
 - Minor changes in the commit message

Changes in v5 - according to Marc's review:
 - Updated commit message
 - Aligned members in struct owl_sirq_chip_data
 - Added naming for SIRQ0 control register offset
 - Improved code readability by using FIELD_PREP and FIELD_GET
 - Dropped redundant handling of the IRQ trigger information
 - Added missing irq_set_affinity to owl_sirq_chip descriptor

 drivers/irqchip/Makefile       |   1 +
 drivers/irqchip/irq-owl-sirq.c | 359 +++++++++++++++++++++++++++++++++
 2 files changed, 360 insertions(+)
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
index 000000000000..6e4127465094
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,359 @@
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
+#include <dt-bindings/interrupt-controller/arm-gic.h>
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
+	parent_fwspec.param[0] = GIC_SPI;
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
+static int __init owl_sirq_init(const struct owl_sirq_params *params,
+				struct device_node *node,
+				struct device_node *parent)
+{
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
+	raw_spin_lock_init(&chip_data->lock);
+
+	chip_data->params = params;
+
+	chip_data->base = of_iomap(node, 0);
+	if (!chip_data->base) {
+		pr_err("%pOF: failed to map sirq registers\n", node);
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	for (i = 0; i < NUM_SIRQ; i++) {
+		struct of_phandle_args irq;
+
+		ret = of_irq_parse_one(node, i, &irq);
+		if (ret) {
+			pr_err("%pOF: failed to parse interrupt %d\n", node, i);
+			goto out_unmap;
+		}
+
+		if (WARN_ON(irq.args_count != 3)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+
+		chip_data->ext_irqs[i] = irq.args[1];
+
+		/* Set 24MHz external interrupt clock freq */
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_CLK_SEL, i);
+	}
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
+static int __init owl_sirq_s500_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s500_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s500, "actions,s500-sirq", owl_sirq_s500_of_init);
+IRQCHIP_DECLARE(owl_sirq_s700, "actions,s700-sirq", owl_sirq_s500_of_init);
+
+static int __init owl_sirq_s900_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s900_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s900, "actions,s900-sirq", owl_sirq_s900_of_init);
-- 
2.28.0

