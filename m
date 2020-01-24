Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983162075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbgAXTMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:12:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404044AbgAXTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MN-0007da-9Q; Fri, 24 Jan 2020 20:11:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A6CAA1C1A62;
        Fri, 24 Jan 2020 20:11:10 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:10 -0000
From:   "tip-bot2 for Joakim Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add NXP INTMUX interrupt multiplexer support
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117060653.27485-3-qiangqing.zhang@nxp.com>
References: <20200117060653.27485-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Message-ID: <157989307050.396.18224709770351816954.tip-bot2@tip-bot2>
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

Commit-ID:     2fbb13961e741494992bae7bfaf7259b65769f9f
Gitweb:        https://git.kernel.org/tip/2fbb13961e741494992bae7bfaf7259b65769f9f
Author:        Joakim Zhang <qiangqing.zhang@nxp.com>
AuthorDate:    Fri, 17 Jan 2020 06:10:10 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

irqchip: Add NXP INTMUX interrupt multiplexer support

The Interrupt Multiplexer (INTMUX) expands the number of peripherals
that can interrupt the core:
* The INTMUX has 8 channels that are assigned to 8 NVIC interrupt slots.
* Each INTMUX channel can receive up to 32 interrupt sources and has 1
  interrupt output.
* The INTMUX routes the interrupt sources to the interrupt outputs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200117060653.27485-3-qiangqing.zhang@nxp.com
---
 drivers/irqchip/Kconfig          |   6 +-
 drivers/irqchip/Makefile         |   1 +-
 drivers/irqchip/irq-imx-intmux.c | 309 ++++++++++++++++++++++++++++++-
 3 files changed, 316 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 20c62d7..1006c69 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,6 +457,12 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config IMX_INTMUX
+	def_bool y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX INTMUX interrupt multiplexer.
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 4b1c511..eae0d78 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
+obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
new file mode 100644
index 0000000..c27577c
--- /dev/null
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 NXP
+
+/*                     INTMUX Block Diagram
+ *
+ *                               ________________
+ * interrupt source #  0  +---->|                |
+ *                        |     |                |
+ * interrupt source #  1  +++-->|                |
+ *            ...         | |   |   channel # 0  |--------->interrupt out # 0
+ *            ...         | |   |                |
+ *            ...         | |   |                |
+ * interrupt source # X-1 +++-->|________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                        | | | |                |
+ *                        | +-->|                |
+ *                        | | | |   channel # 1  |--------->interrupt out # 1
+ *                        | | +>|                |
+ *                        | | | |                |
+ *                        | | | |________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |       ...
+ *                        | | |       ...
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                          | | |                |
+ *                          +-->|                |
+ *                            | |   channel # N  |--------->interrupt out # N
+ *                            +>|                |
+ *                              |                |
+ *                              |________________|
+ *
+ *
+ * N: Interrupt Channel Instance Number (N=7)
+ * X: Interrupt Source Number for each channel (X=32)
+ *
+ * The INTMUX interrupt multiplexer has 8 channels, each channel receives 32
+ * interrupt sources and generates 1 interrupt output.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANIER(n)	(0x10 + (0x40 * n))
+#define CHANIPR(n)	(0x20 + (0x40 * n))
+
+#define CHAN_MAX_NUM		0x8
+
+struct intmux_irqchip_data {
+	int			chanidx;
+	int			irq;
+	struct irq_domain	*domain;
+};
+
+struct intmux_data {
+	raw_spinlock_t			lock;
+	void __iomem			*regs;
+	struct clk			*ipg_clk;
+	int				channum;
+	struct intmux_irqchip_data	irqchip_data[];
+};
+
+static void imx_intmux_irq_mask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* disable the interrupt source of this channel */
+	val &= ~BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void imx_intmux_irq_unmask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* enable the interrupt source of this channel */
+	val |= BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static struct irq_chip imx_intmux_irq_chip = {
+	.name		= "intmux",
+	.irq_mask	= imx_intmux_irq_mask,
+	.irq_unmask	= imx_intmux_irq_unmask,
+};
+
+static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, h->host_data);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int imx_intmux_irq_xlate(struct irq_domain *d, struct device_node *node,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+
+	/*
+	 * two cells needed in interrupt specifier:
+	 * the 1st cell: hw interrupt number
+	 * the 2nd cell: channel index
+	 */
+	if (WARN_ON(intsize != 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[1] >= data->channum))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static int imx_intmux_irq_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+
+	/* Not for us */
+	if (fwspec->fwnode != d->fwnode)
+		return false;
+
+	return irqchip_data->chanidx == fwspec->param[1];
+}
+
+static const struct irq_domain_ops imx_intmux_domain_ops = {
+	.map		= imx_intmux_irq_map,
+	.xlate		= imx_intmux_irq_xlate,
+	.select		= imx_intmux_irq_select,
+};
+
+static void imx_intmux_irq_handler(struct irq_desc *desc)
+{
+	struct intmux_irqchip_data *irqchip_data = irq_desc_get_handler_data(desc);
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long irqstat;
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	/* read the interrupt source pending status of this channel */
+	irqstat = readl_relaxed(data->regs + CHANIPR(idx));
+
+	for_each_set_bit(pos, &irqstat, 32) {
+		virq = irq_find_mapping(irqchip_data->domain, pos);
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_intmux_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct irq_domain *domain;
+	struct intmux_data *data;
+	int channum;
+	int i, ret;
+
+	channum = platform_irq_count(pdev);
+	if (channum == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (channum > CHAN_MAX_NUM) {
+		dev_err(&pdev->dev, "supports up to %d multiplex channels\n",
+			CHAN_MAX_NUM);
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data) +
+			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->ipg_clk)) {
+		ret = PTR_ERR(data->ipg_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	data->channum = channum;
+	raw_spin_lock_init(&data->lock);
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chanidx = i;
+
+		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
+		if (data->irqchip_data[i].irq <= 0) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "failed to get irq\n");
+			goto out;
+		}
+
+		domain = irq_domain_add_linear(np, 32, &imx_intmux_domain_ops,
+					       &data->irqchip_data[i]);
+		if (!domain) {
+			ret = -ENOMEM;
+			dev_err(&pdev->dev, "failed to create IRQ domain\n");
+			goto out;
+		}
+		data->irqchip_data[i].domain = domain;
+
+		/* disable all interrupt sources of this channel firstly */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 imx_intmux_irq_handler,
+						 &data->irqchip_data[i]);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
+}
+
+static int imx_intmux_remove(struct platform_device *pdev)
+{
+	struct intmux_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->channum; i++) {
+		/* disable all interrupt sources of this channel */
+		writel_relaxed(0, data->regs + CHANIER(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 NULL, NULL);
+
+		irq_domain_remove(data->irqchip_data[i].domain);
+	}
+
+	clk_disable_unprepare(data->ipg_clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_intmux_id[] = {
+	{ .compatible = "fsl,imx-intmux", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver imx_intmux_driver = {
+	.driver = {
+		.name = "imx-intmux",
+		.of_match_table = imx_intmux_id,
+	},
+	.probe = imx_intmux_probe,
+	.remove = imx_intmux_remove,
+};
+builtin_platform_driver(imx_intmux_driver);
