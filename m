Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02556C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C1422CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="AgEIBPo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgHET6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgHEQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:43:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE4C06138E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:01:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so12678801pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4fpWOqpBFl4YW+gjIGDtcJmKMkUJgphCM8cmn4jPi0=;
        b=AgEIBPo7jkQpOlkHlqljgV9zaXxH9CVK+sp71nP3S85oCgjoPbBIX9hEGrvRfF8S2S
         wlH9yDchUSJ6psQ2YzxDgSpauTHLTHImjH5yH8kKL6CeUv99FqEdaqknCPh1sARYsZBK
         YhPW3G2PXL8mkDbHfkm5wZ4IsdFbbDarKqxPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4fpWOqpBFl4YW+gjIGDtcJmKMkUJgphCM8cmn4jPi0=;
        b=Ni5ZhuDHCAoMO32dX1EOG1fr/Nz7jhbcZytLs+Fx8HTWkQsYSe2kgcfC4otkdBmmse
         jzi3XruGMVfjeQAuf74HCgwBz2PiFVOJrOnEvJd7+oqKteE3pgEkEde1OLowcdejJ4L4
         RtrkGhDjw4gLGjKWBbJIPgiPvkQmIQlx5FC9y0dFMMNSwx4626yl3GLZHRtlpr+z7SKX
         lqehFSuFlYOjmpVhbaOSmx2VD+dQeU1rF46BisY3Adkf72tj2uWIqODVakGYAR1m/4z2
         pEVMjjRbXvXkTr2lDBXPrXRO0a/TUVh0gCIfhOypoqiMEpAF+knJF61+tHPUuz+Gw8k0
         1mlw==
X-Gm-Message-State: AOAM530deda+u5OLfq1F79q8ksy714Gcw8y3fkflX04DSh5PraWTNf+M
        I7SPiDw3O6Pth6pMkrC/1xO99Q==
X-Google-Smtp-Source: ABdhPJySE9UZPCujh2vALZVNOpXJZnYkWwGKM0HQFCvSc2ybGU3FBflfuw+pnV1AAWlHtgeBiS3E6Q==
X-Received: by 2002:aa7:8eca:: with SMTP id b10mr1046302pfr.50.1596625288482;
        Wed, 05 Aug 2020 04:01:28 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id fv21sm2583142pjb.16.2020.08.05.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:01:27 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, arnd@arndb.de, Daniel Palmer <daniel@0x0f.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/3] irqchip: mstar: msc313-intc interrupt controller driver
Date:   Wed,  5 Aug 2020 20:00:51 +0900
Message-Id: <20200805110052.2655487-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805110052.2655487-1-daniel@0x0f.com>
References: <20200805110052.2655487-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the two peripheral interrupt controllers
in MStar MSC313 and other MStar/Sigmastar Armv7 SoCs.

Supports both the "IRQ" and "FIQ" controllers that
forward interrupts from the various IP blocks inside the
SoC to the ARM GIC.

They are basically the same thing except for one difference:
The FIQ controller needs to clear the interrupt and the IRQ
controller doesn't.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Tested-by: Willy Tarreau <w@1wt.eu>
---
 MAINTAINERS                       |   1 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-msc313-intc.c | 210 ++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/irqchip/irq-msc313-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e64d17aad7b..4d07403a7726 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2157,6 +2157,7 @@ F:	arch/arm/boot/dts/infinity*.dtsi
 F:	arch/arm/boot/dts/mercury*.dtsi
 F:	arch/arm/boot/dts/mstar-v7.dtsi
 F:	arch/arm/mach-mstar/
+F:	drivers/irqchip/irq-msc313-intc.c
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..67f3ae3507b8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_ARCH_MSTARV7)		+= irq-msc313-intc.o
diff --git a/drivers/irqchip/irq-msc313-intc.c b/drivers/irqchip/irq-msc313-intc.c
new file mode 100644
index 000000000000..b50f5c858d38
--- /dev/null
+++ b/drivers/irqchip/irq-msc313-intc.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Daniel Palmer
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define REGOFF_MASK		0x0
+#define REGOFF_POLARITY		0x10
+#define REGOFF_STATUSCLEAR	0x20
+#define IRQSPERREG		16
+#define IRQBIT(hwirq)		BIT((hwirq % IRQSPERREG))
+#define REGOFF(hwirq)		((hwirq >> 4) * 4)
+
+struct msc313_intc {
+	struct irq_domain *domain;
+	void __iomem *base;
+	struct irq_chip irqchip;
+	u8 gicoff;
+};
+
+static void msc313_intc_maskunmask(struct msc313_intc *intc, int hwirq, bool mask)
+{
+	int regoff = REGOFF(hwirq);
+	void __iomem *addr = intc->base + REGOFF_MASK + regoff;
+	u16 bit = IRQBIT(hwirq);
+	u16 reg = readw_relaxed(addr);
+
+	if (mask)
+		reg |= bit;
+	else
+		reg &= ~bit;
+
+	writew_relaxed(reg, addr);
+}
+
+static void msc313_intc_mask_irq(struct irq_data *data)
+{
+	struct msc313_intc *intc = data->chip_data;
+
+	msc313_intc_maskunmask(intc, data->hwirq, true);
+	irq_chip_mask_parent(data);
+}
+
+static void msc313_intc_unmask_irq(struct irq_data *data)
+{
+	struct msc313_intc *intc = data->chip_data;
+
+	msc313_intc_maskunmask(intc, data->hwirq, false);
+	irq_chip_unmask_parent(data);
+}
+
+static int msc313_intc_set_type_irq(struct irq_data *data, unsigned int flow_type)
+{
+	struct msc313_intc *intc = data->chip_data;
+	int irq = data->hwirq;
+	int regoff = REGOFF(irq);
+	void __iomem *addr = intc->base + REGOFF_POLARITY + regoff;
+	u16 bit = IRQBIT(irq);
+	u16 reg = readw_relaxed(addr);
+
+	if (flow_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_HIGH))
+		reg &= ~bit;
+	else
+		reg |= bit;
+
+	writew_relaxed(reg, addr);
+	return 0;
+}
+
+static void msc313_intc_irq_eoi(struct irq_data *data)
+{
+	struct msc313_intc *intc = data->chip_data;
+	int irq = data->hwirq;
+	int regoff = REGOFF(irq);
+	void __iomem *addr = intc->base + REGOFF_STATUSCLEAR + regoff;
+	u16 bit = IRQBIT(irq);
+	u16 reg = readw_relaxed(addr);
+
+	reg |= bit;
+	writew_relaxed(reg, addr);
+	irq_chip_eoi_parent(data);
+}
+
+static int msc313_intc_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode) || fwspec->param_count != 2)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int msc313_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	struct msc313_intc *intc = domain->host_data;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0], &intc->irqchip, intc);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param[0] = GIC_SPI;
+	parent_fwspec.param[1] = fwspec->param[0] + intc->gicoff;
+	parent_fwspec.param[2] = fwspec->param[1];
+	parent_fwspec.param_count = 3;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops msc313_intc_domain_ops = {
+		.translate = msc313_intc_domain_translate,
+		.alloc = msc313_intc_domain_alloc,
+		.free = irq_domain_free_irqs_common,
+};
+
+static int  msc313_intc_of_init(struct device_node *node,
+				   struct device_node *parent,
+				   void (*eoi)(struct irq_data *data))
+{
+	struct irq_domain *domain_parent;
+	struct msc313_intc *intc;
+	int ret = 0;
+	u32 gicoffset, numirqs;
+
+	if (of_property_read_u32(node, "mstar,gic-offset", &gicoffset)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (of_property_read_u32(node, "mstar,nr-interrupts", &numirqs)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	intc->base = of_iomap(node, 0);
+	if (IS_ERR(intc->base)) {
+		ret = PTR_ERR(intc->base);
+		goto free_intc;
+	}
+
+	intc->irqchip.name = node->name;
+	intc->irqchip.irq_mask = msc313_intc_mask_irq;
+	intc->irqchip.irq_unmask = msc313_intc_unmask_irq;
+	intc->irqchip.irq_eoi = eoi;
+	intc->irqchip.irq_set_type = msc313_intc_set_type_irq;
+	intc->irqchip.flags = IRQCHIP_MASK_ON_SUSPEND;
+
+	intc->gicoff = gicoffset;
+
+	intc->domain = irq_domain_add_hierarchy(domain_parent, 0, numirqs, node,
+			&msc313_intc_domain_ops, intc);
+	if (!intc->domain) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	return 0;
+
+unmap:
+	iounmap(intc->base);
+free_intc:
+	kfree(intc);
+out:
+	return ret;
+}
+
+static int __init msc313_intc_irq_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return msc313_intc_of_init(node, parent, irq_chip_eoi_parent);
+};
+
+static int __init msc313_intc_fiq_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return msc313_intc_of_init(node, parent, msc313_intc_irq_eoi);
+};
+
+IRQCHIP_DECLARE(msc313_intc_irq, "mstar,msc313-intc-irq",
+		msc313_intc_irq_of_init);
+IRQCHIP_DECLARE(mstar_intc_fiq, "mstar,msc313-intc-fiq",
+		msc313_intc_fiq_of_init);
-- 
2.27.0

