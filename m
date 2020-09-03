Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9675C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0E020678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgICMPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:15:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728812AbgICMFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:05:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 680E1DE6978487D84FB4;
        Thu,  3 Sep 2020 20:05:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:05:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] irqchip: add Hisilicon SD5203 vector interrupt controller
Date:   Thu, 3 Sep 2020 20:05:04 +0800
Message-ID: <20200903120504.2308-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200903120504.2308-1-thunder.leizhen@huawei.com>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

This adds an irqchip driver and corresponding devicetree binding for the
primary interrupt controller based on Hisilicon SD5203 VIC(vector
interrupt controller).

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/irqchip/Kconfig          |   5 ++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-sd5203-vic.c | 128 +++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/irqchip/irq-sd5203-vic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..f64611a47cf2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -156,6 +156,11 @@ config FARADAY_FTINTC010
 	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
+config HISILICON_SD5203_VIC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+
 config HISILICON_IRQ_MBIGEN
 	bool
 	select ARM_GIC_V3
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..94b98f881940 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
+obj-$(CONFIG_HISILICON_SD5203_VIC)	+= irq-sd5203-vic.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
diff --git a/drivers/irqchip/irq-sd5203-vic.c b/drivers/irqchip/irq-sd5203-vic.c
new file mode 100644
index 000000000000..f6f8fd75f1ab
--- /dev/null
+++ b/drivers/irqchip/irq-sd5203-vic.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hisilicon SD5203 irqchip driver.
+ * Based on Synopsys DW APB ICTL irqchip driver.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <asm/exception.h>
+
+#define HISI_VIC_INT_ENABLE		0x00
+#define HISI_VIC_INT_MASK		0x08
+#define HISI_VIC_INT_FINALSTATUS	0x30
+#define HISI_VIC_MAX_IRQ		32
+
+static struct irq_domain *hisi_vic_irq_domain;
+static void __iomem *hisi_vic_iobase;
+
+static void __exception_irq_entry hisi_vic_handle_irq(struct pt_regs *regs)
+{
+	u32 stat = readl_relaxed(hisi_vic_iobase + HISI_VIC_INT_FINALSTATUS);
+	u32 hwirq;
+
+	while (stat) {
+		hwirq = fls(stat) - 1;
+		handle_domain_irq(hisi_vic_irq_domain, hwirq, regs);
+		stat &= ~BIT(hwirq);
+	}
+}
+
+static int hisi_vic_irq_domain_translate(struct irq_domain *d,
+					 struct irq_fwspec *fwspec,
+					 unsigned long *hwirq,
+					 unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 1))
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_NONE;
+
+	return 0;
+}
+
+static int hisi_vic_irq_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = hisi_vic_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops hisi_vic_irq_domain_ops = {
+	.translate = hisi_vic_irq_domain_translate,
+	.alloc = hisi_vic_irq_domain_alloc,
+	.free = irq_domain_free_irqs_top,
+};
+
+static int __init hisi_sd5203_vic_init(struct device_node *np,
+					struct device_node *parent)
+{
+	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct irq_chip_generic *gc;
+	int ret;
+
+	if (hisi_vic_iobase) {
+		pr_err("%pOF: the irqchip has been registered.\n", np);
+		return -EBUSY;
+	}
+
+	hisi_vic_iobase = of_iomap(np, 0);
+	if (!hisi_vic_iobase) {
+		pr_err("%pOF: unable to map resource\n", np);
+		return -ENOMEM;
+	}
+
+	hisi_vic_irq_domain = irq_domain_add_linear(np, HISI_VIC_MAX_IRQ,
+				       &hisi_vic_irq_domain_ops, NULL);
+	if (!hisi_vic_irq_domain) {
+		pr_err("%pOF: unable to add irq domain\n", np);
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	ret = irq_alloc_domain_generic_chips(hisi_vic_irq_domain,
+					     HISI_VIC_MAX_IRQ, 1,
+					     np->name, handle_fasteoi_irq,
+					     clr, 0, IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		pr_err("%pOF: unable to alloc irq domain gc\n", np);
+		goto err_unmap;
+	}
+
+	/* mask and enable all interrupts */
+	writel_relaxed(~0, hisi_vic_iobase + HISI_VIC_INT_MASK);
+	writel_relaxed(~0, hisi_vic_iobase + HISI_VIC_INT_ENABLE);
+
+	gc = irq_get_domain_generic_chip(hisi_vic_irq_domain, 0);
+	gc->reg_base = hisi_vic_iobase;
+	gc->chip_types[0].regs.mask = HISI_VIC_INT_MASK;
+	gc->chip_types[0].regs.enable = HISI_VIC_INT_ENABLE;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_clr_bit;
+	gc->chip_types[0].chip.irq_eoi = irq_gc_noop;
+
+	set_handle_irq(hisi_vic_handle_irq);
+	return 0;
+
+err_unmap:
+	iounmap(hisi_vic_iobase);
+	return ret;
+}
+IRQCHIP_DECLARE(hisi_sd5203_vic, "hisilicon,sd5203-vic", hisi_sd5203_vic_init);
-- 
2.26.0.106.g9fadedd


