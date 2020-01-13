Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6FC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6952082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="kj72p8Gd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2UecMeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgAMEuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:50:12 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53629 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733148AbgAMEtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:49:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE5A561F8;
        Sun, 12 Jan 2020 23:49:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 23:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=iUvD6jP5FuOtc
        OXtQYD8XOO1+qZH/YNbgt8mkTL1xHo=; b=kj72p8Gd3oeiPreFhlgVInxUX/LH5
        K6jEpwATK4f4cVeyU+9IqCaLCw1+367++m8asyOqI6hF6wiuJn1aBqFclqm9bWuq
        1Qf81GYH6l6//UTvB9C6JSea0iw2Z86J3tHw9SkRL9qK71dBKrU2LRIpGYu9sikn
        SWro6V/eriY1chw674gwVqofNmO7zlFAPsZ4BpU/TvklCQY7TknaKddyIFfZDjWt
        eRqX/5AOYyaGsyToDwr4MVCTn6vujbbfYFS62X7zRxmWl9sZUU6g0WEE0buiVUny
        HquFj72dR7WPkq6KScqZSWQE/V9nLlyLm+sWsIIpj57ZafXitzxllSPAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=iUvD6jP5FuOtcOXtQYD8XOO1+qZH/YNbgt8mkTL1xHo=; b=w2UecMeg
        sgRUf2tjSTc/qyaudXK4tooGCFg3JybkZgkzw/p6FDJ131upModIMPwMGSiBmlwd
        9zRNbPP0RUrqb3qbGa/bdQG0b8YuMi5dP2Yu8amzGN218fJ3g+yeaLeOrncVGNHR
        KU+iR4mllYMmcwZFfxssKzQ6go152p5XubGoxsdMUDKUQsAhRTk3m0MEGc08CwXH
        c5+fsQf3bbYp+6cqXwiPdkq1GZVi1PjFtzLblYINDkFUIhr6zbR1ejLxF8GFgvxs
        AcIKOGJniDFks2GOrqk7qCJKLeGotzkp8o6Hhn0rry46Ka+a96+k5j3XOHMzUsXt
        AgjojFmNiEdzhw==
X-ME-Sender: <xms:4vYbXgrwkP9w3NsYrezFUmtOZpwvadrVsDf_tmpIeiyUsxtjUuUt7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4vYbXhcb-p9kJpFQAQeE0n75pQpoJ-T42TLLBiW_a_0KPcY-34vYVg>
    <xmx:4vYbXq34iU4J_pU87OifIewJ26Lc-IK91upGkWIwSLYeIBjZB_I8ew>
    <xmx:4vYbXsrmTUsYxDMdxcVOFof-w9uOeiZC2x9NUydiFug7kV-XywZwrw>
    <xmx:4vYbXkcbNf6CVik6T6qAhpwzHY85JIvn9C4X-avYvfcl4uMAYTtfrA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8E19B30607B4;
        Sun, 12 Jan 2020 23:49:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/9] irqchip/sun6i-r: Switch to a stacked irqchip driver
Date:   Sun, 12 Jan 2020 22:49:28 -0600
Message-Id: <20200113044936.26038-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113044936.26038-1-samuel@sholland.org>
References: <20200113044936.26038-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
original sun4i interrupt controller than the sun7i/sun9i NMI controller.
It is used for two distinct purposes:
 1) To control the trigger and mask for the NMI input pin
 2) To provide the interrupt input for the ARISC coprocessor

As this interrupt controller is not documented, information about it
comes from reverse-engineering the BSP-provided ARISC firmware.

Like the original sun4i interrupt controller, it has:
 - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
 - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
   sun4i and sunxi-nmi drivers
 - A MASK_REG at 0x50

Differences from the sun4i interrupt controller appear to be:
 - It is only known to have one register of each kind (max 32 inputs)
 - There is no FIQ-related logic
 - There is no interrupt priority logic

In order to fulfill its two purposes, this hardware block combines two
types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
chip, with a trigger type controlled by the NMI_CTRL_REG. The (masked)
"IRQ 0 pending" output from this chip is then routed to a non-maskable
SPI IRQ input on the GIC, as IRQ_TYPE_LEVEL_HIGH. In other words, bit 0
of ENABLE_REG and MASK_REG *do* affect the IRQs seen at the GIC.

The NMI is then followed by a contiguous block of (at least) 15 IRQ
inputs that are connected *in parallel* to both R_INTC and the GIC. Or
in other words, the other bits of ENABLE_REG and MASK_REG *do not*
affect the IRQs seen at the GIC.

Finally, the global "IRQ pending" output from R_INTC is connected to the
"external interrupt" input of the ARISC CPU (an OR1200).

Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
a perfect scenario for using a stacked irqchip driver. We want to hook
into enabling/disabling/masking IRQs to add more features to the GIC
(specifically to allow masking the NMI and setting its trigger type),
but we don't need to actually *handle* the IRQ.

And since R_INTC is in the always-on power domain, and its output is
connected directly in to the power management coprocessor, a stacked
irqchip driver provides a simple way to add wakeup support to this set
of IRQs. That is a future patch; for now, just the NMI is moved over.

This driver keeps the same DT binding as the existing driver. The
"interrupt" property of the R_INTC node is used to determine 1) the
offset between GIC and R_INTC hwirq numbers and 2) the type of trigger
between the R_INTC "IRQ 0 pending" output and the GIC NMI input.

This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
Support sun6i-a31-r-intc compatible").

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/mach-sunxi/Kconfig     |   1 +
 arch/arm64/Kconfig.platforms    |   1 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-sun6i-r.c   | 220 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c |  26 +---
 5 files changed, 226 insertions(+), 23 deletions(-)
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..ef1cc25902b5 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
+	select IRQ_DOMAIN_HIERARCHY
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 16d761475a86..d282d0a1d17d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -17,6 +17,7 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
 	select PINCTRL
 	select RESET_CONTROLLER
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index cc7c43932f16..41996d98c30a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
+obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun6i-r.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
new file mode 100644
index 000000000000..37b6e9c60bf8
--- /dev/null
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Allwinner A31 and newer SoCs R_INTC driver
+//
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define NMI_HWIRQ		0
+
+#define SUN6I_R_INTC_NR_IRQS	16
+
+#define SUN6I_R_INTC_CTRL	0x0c
+#define SUN6I_R_INTC_PENDING	0x10
+#define SUN6I_R_INTC_ENABLE	0x40
+#define SUN6I_R_INTC_MASK	0x50
+
+enum {
+	SUNXI_SRC_TYPE_LEVEL_LOW = 0,
+	SUNXI_SRC_TYPE_EDGE_FALLING,
+	SUNXI_SRC_TYPE_LEVEL_HIGH,
+	SUNXI_SRC_TYPE_EDGE_RISING,
+};
+
+static void __iomem *base;
+static irq_hw_number_t parent_offset;
+static u32 parent_type;
+
+static void sun6i_r_intc_irq_enable(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_ENABLE);
+
+	irq_chip_enable_parent(data);
+}
+
+static void sun6i_r_intc_irq_disable(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		writel(0, base + SUN6I_R_INTC_ENABLE);
+
+	irq_chip_disable_parent(data);
+}
+
+static void sun6i_r_intc_irq_mask(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_MASK);
+
+	irq_chip_mask_parent(data);
+}
+
+static void sun6i_r_intc_irq_unmask(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		writel(0, base + SUN6I_R_INTC_MASK);
+
+	irq_chip_unmask_parent(data);
+}
+
+static void sun6i_r_intc_irq_eoi(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_PENDING);
+
+	irq_chip_eoi_parent(data);
+}
+
+static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	if (data->hwirq == NMI_HWIRQ) {
+		u32 src_type;
+
+		switch (type) {
+		case IRQ_TYPE_EDGE_FALLING:
+			src_type = SUNXI_SRC_TYPE_EDGE_FALLING;
+			break;
+		case IRQ_TYPE_EDGE_RISING:
+			src_type = SUNXI_SRC_TYPE_EDGE_RISING;
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			src_type = SUNXI_SRC_TYPE_LEVEL_HIGH;
+			break;
+		case IRQ_TYPE_NONE:
+		case IRQ_TYPE_LEVEL_LOW:
+			src_type = SUNXI_SRC_TYPE_LEVEL_LOW;
+			break;
+		default:
+			pr_err("%pOF: invalid trigger type %d for IRQ %d\n",
+			       irq_domain_get_of_node(data->domain), type,
+			       data->irq);
+			return -EBADR;
+		}
+		writel(src_type, base + SUN6I_R_INTC_CTRL);
+
+		irqd_set_trigger_type(data, type);
+
+		/* Send the R_INTC -> GIC trigger type to the GIC driver. */
+		type = parent_type;
+	}
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip sun6i_r_intc_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_enable		= sun6i_r_intc_irq_enable,
+	.irq_disable		= sun6i_r_intc_irq_disable,
+	.irq_mask		= sun6i_r_intc_irq_mask,
+	.irq_unmask		= sun6i_r_intc_irq_unmask,
+	.irq_eoi		= sun6i_r_intc_irq_eoi,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+};
+
+static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
+					 struct irq_fwspec *fwspec,
+					 unsigned long *hwirq,
+					 unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode) || fwspec->param_count != 2)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type  = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+	if (hwirq + nr_irqs > SUN6I_R_INTC_NR_IRQS)
+		return -EINVAL;
+
+	/* Construct a GIC-compatible fwspec from this fwspec. */
+	gic_fwspec = (struct irq_fwspec) {
+		.fwnode      = domain->parent->fwnode,
+		.param_count = 3,
+		.param       = { GIC_SPI, parent_offset + hwirq, type },
+	};
+
+	for (i = 0; i < nr_irqs; ++i)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sun6i_r_intc_chip, NULL);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
+}
+
+static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
+	.translate	= sun6i_r_intc_domain_translate,
+	.alloc		= sun6i_r_intc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init sun6i_r_intc_init(struct device_node *node,
+				    struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct of_phandle_args parent_irq;
+	int ret;
+
+	/* Extract the R_INTC -> GIC mapping from the OF node. */
+	ret = of_irq_parse_one(node, 0, &parent_irq);
+	if (ret)
+		return ret;
+	if (parent_irq.args_count != 3 || parent_irq.args[0] != GIC_SPI)
+		return -EINVAL;
+	parent_offset = parent_irq.args[1];
+	parent_type   = parent_irq.args[2];
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: Failed to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	base = of_io_request_and_map(node, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("%pOF: Failed to map MMIO region\n", node);
+		return PTR_ERR(base);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  SUN6I_R_INTC_NR_IRQS, node,
+					  &sun6i_r_intc_domain_ops, NULL);
+	if (!domain) {
+		pr_err("%pOF: Failed to allocate domain\n", node);
+		iounmap(base);
+		return -ENOMEM;
+	}
+
+	/* Disable and unmask all interrupts. */
+	writel(0, base + SUN6I_R_INTC_ENABLE);
+	writel(0, base + SUN6I_R_INTC_MASK);
+
+	/* Clear any pending interrupts. */
+	writel(~0, base + SUN6I_R_INTC_PENDING);
+
+	return 0;
+}
+IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index a412b5d5d0fa..9f2bd0c5d289 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -27,18 +27,12 @@
 
 #define SUNXI_NMI_IRQ_BIT	BIT(0)
 
-#define SUN6I_R_INTC_CTRL	0x0c
-#define SUN6I_R_INTC_PENDING	0x10
-#define SUN6I_R_INTC_ENABLE	0x40
-
 /*
  * For deprecated sun6i-a31-sc-nmi compatible.
- * Registers are offset by 0x0c.
  */
-#define SUN6I_R_INTC_NMI_OFFSET	0x0c
-#define SUN6I_NMI_CTRL		(SUN6I_R_INTC_CTRL - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_PENDING	(SUN6I_R_INTC_PENDING - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_ENABLE	(SUN6I_R_INTC_ENABLE - SUN6I_R_INTC_NMI_OFFSET)
+#define SUN6I_NMI_CTRL		0x00
+#define SUN6I_NMI_PENDING	0x04
+#define SUN6I_NMI_ENABLE	0x34
 
 #define SUN7I_NMI_CTRL		0x00
 #define SUN7I_NMI_PENDING	0x04
@@ -61,12 +55,6 @@ struct sunxi_sc_nmi_reg_offs {
 	u32 enable;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_r_intc_reg_offs __initconst = {
-	.ctrl	= SUN6I_R_INTC_CTRL,
-	.pend	= SUN6I_R_INTC_PENDING,
-	.enable	= SUN6I_R_INTC_ENABLE,
-};
-
 static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
@@ -232,14 +220,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	return ret;
 }
 
-static int __init sun6i_r_intc_irq_init(struct device_node *node,
-					struct device_node *parent)
-{
-	return sunxi_sc_nmi_irq_init(node, &sun6i_r_intc_reg_offs);
-}
-IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc",
-		sun6i_r_intc_irq_init);
-
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-- 
2.23.0

