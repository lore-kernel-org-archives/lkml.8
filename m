Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CF120853
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="kDTh9+TV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XL7qVypQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgEYEMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46247 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbgEYEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82B71580087;
        Mon, 25 May 2020 00:12:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=XGZVmq6uCEkE3
        +0rylBILWVToJCZO4RcfvdTY3QxMgg=; b=kDTh9+TV3j5NBldXhCvrbTV7gN5gB
        t83Wi6+tXDsNXtjRSyty0ldOBieGuashlwkdbbyXe90kvVNe9DEZ3p97Ph8nW9gQ
        jKpT6cU6FIMeCDoaOtEONGB8aVqmzJWDoJuKvvadIZrhA+p0hMTXa7PvD0068s1M
        6ahPHuTYyDvFjeHTnxbyRjPUVubZd/Gas2GS9mckS2ORdbEA5Prt7EvjfLLQmIH4
        aFXkQQw90qW4Fl9euclmRqH4grGzZpyGo383+ZTeW5k4j4ZIosX9KzDLfMlaFZ6B
        Rf/EqRw6JmIIwKhKisXwQ7ST7Tnlucalu6wSfiy30OeQC7NF+EC0YPvbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=XGZVmq6uCEkE3+0rylBILWVToJCZO4RcfvdTY3QxMgg=; b=XL7qVypQ
        caFwjCDUn9iek4LVfa0KMVCAHrHgwAXsz3VJ0ns24+f0OWYc3pdo0zm2u/A3fqOv
        BQOEmR7vU0jbYXlR/4qhOiiUIeSoJnRTPKcsU7quxFfO5ywl+KWc+2Lq+F4FbDA0
        knq+TT+SAhwySihHgatS8X9xqWonMeD3uMZMze4DtfzvVgMMFsrI37i4hTJy4dEA
        aUkJr9NTBYKAAly64nYEtOUiChatq0HiLGTT+JSImt324+O2CjBm8XAD1Z9UoWYx
        1eKMPfbDyoQIq/iK1JCWQMoJQMKlNCYfOGk94NnzJh3WIt8wRj9wzfm621yjmzOE
        YrcpO0gCxLWUng==
X-ME-Sender: <xms:tkXLXk-mBcouULBw6xHs1ST8y63u8dk7qPyA7IoGkvouI0tj0EFt1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:tkXLXsvlnDLcq3I0kSNoDqPwQipZVoNkAmXDXb4xxwXLDkPSAOEAZQ>
    <xmx:tkXLXqCRxlsnVtHRz2kFfdsxH7wG0AQYJOEhLb4NvYDjdJ1sEtv75A>
    <xmx:tkXLXkctxb68GdNS4nYprDKviWZI56bHHdWN1BP36SORvRYjtsNr6Q>
    <xmx:tkXLXqHyfC2BxHekVMBsVUqGRM4WdROpCMnNK8-7VPb4rwggU6vgzw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC142306654F;
        Mon, 25 May 2020 00:12:37 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 1/9] irqchip/sun6i-r: Use a stacked irqchip driver
Date:   Sun, 24 May 2020 23:12:54 -0500
Message-Id: <20200525041302.51213-2-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
original sun4i interrupt controller than the sun7i/sun9i NMI controller.
It is used for two distinct purposes:
 1) To control the trigger, latch, and mask for the NMI input pin
 2) To provide the interrupt input for the ARISC coprocessor

As this interrupt controller is not documented, information about it
comes from vendor-provided ARISC firmware and from experimentation.

Like the original sun4i interrupt controller, it has:
 - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
 - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
   sun4i and sunxi-nmi drivers
 - A MASK_REG at 0x50
 - A RESP_REG at 0x60

Differences from the sun4i interrupt controller appear to be:
 - It is only known to have one register of each kind (max 32 inputs)
 - There is no FIQ-related logic
 - There is no interrupt priority logic

In order to fulfill its two purposes, this hardware block combines two
types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
chip, with a trigger type controlled by the NMI_CTRL_REG. The "IRQ 0
pending" output from this chip, if enabled, is then routed to a SPI IRQ
input on the GIC, as IRQ_TYPE_LEVEL_HIGH. In other words, bit 0 of
ENABLE_REG *does* affect the NMI IRQ seen at the GIC.

The NMI is then followed by a contiguous block of (at least) 15 IRQ
inputs that are connected in parallel to both R_INTC and the GIC. Or
in other words, the other bits of ENABLE_REG *do not* affect the IRQs
seen at the GIC.

Finally, the global "IRQ pending" output from R_INTC, after being masked
by MASK_REG and RESP_REG, is connected to the "external interrupt" input
of the ARISC CPU (an OR1200). This path is not relevant to Linux.

Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
a perfect scenario for using a stacked irqchip driver. We want to hook
into enabling/disabling IRQs to add more features to the GIC
(specifically to allow masking the NMI and setting its trigger type),
but we don't need to actually handle the IRQ in this driver.

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
 arch/arm/mach-sunxi/Kconfig     |   4 +
 arch/arm64/Kconfig.platforms    |   2 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-sun6i-r.c   | 216 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c |  26 +---
 5 files changed, 226 insertions(+), 23 deletions(-)
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..216b5954d6a9 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -30,6 +30,8 @@ config MACH_SUN6I
 	bool "Allwinner A31 (sun6i) SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select MFD_SUN6I_PRCM
 	select SUN5I_HSTIMER
 
@@ -46,6 +48,8 @@ config MACH_SUN8I
 	bool "Allwinner sun8i Family SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select MFD_SUN6I_PRCM
 
 config MACH_SUN9I
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cfe0f9e..b9c3a7118a2c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -17,6 +17,8 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 37bbe39bf909..c9692bdaabfa 100644
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
index 000000000000..f8bfa5515f20
--- /dev/null
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -0,0 +1,216 @@
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
+#define NMI_HWIRQ_BIT		BIT(NMI_HWIRQ)
+
+#define SUN6I_R_INTC_NR_IRQS	16
+
+#define SUN6I_R_INTC_NMI_CTRL	0x0c
+#define SUN6I_R_INTC_PENDING	0x10
+#define SUN6I_R_INTC_ENABLE	0x40
+
+static void __iomem *base;
+static irq_hw_number_t parent_offset;
+static u32 parent_type;
+
+static struct irq_chip sun6i_r_intc_edge;
+static struct irq_chip sun6i_r_intc_level;
+
+static void sun6i_r_intc_nmi_ack(void)
+{
+	/*
+	 * The NMI IRQ channel has a latch, separate from its trigger.
+	 * This latch must be cleared to clear the output to the GIC.
+	 */
+	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_PENDING);
+}
+
+static void sun6i_r_intc_irq_ack(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		sun6i_r_intc_nmi_ack();
+}
+
+static void sun6i_r_intc_irq_eoi(struct irq_data *data)
+{
+	if (data->hwirq == NMI_HWIRQ)
+		sun6i_r_intc_nmi_ack();
+
+	irq_chip_eoi_parent(data);
+}
+
+static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	/*
+	 * Only the NMI IRQ is routed through this interrupt controller on its
+	 * way to the GIC. Other IRQs are routed to the GIC in parallel and
+	 * must have a trigger type appropriate for the GIC.
+	 *
+	 * The "External NMI" input to the GIC actually comes from bit 0 of
+	 * this device's PENDING register. So the IRQ type of the NMI, as seen
+	 * by the GIC, does not depend on the IRQ type of the NMI pin itself.
+	 */
+	if (data->hwirq == NMI_HWIRQ) {
+		u32 nmi_src_type;
+
+		switch (type) {
+		case IRQ_TYPE_LEVEL_LOW:
+			nmi_src_type = 0;
+			break;
+		case IRQ_TYPE_EDGE_FALLING:
+			nmi_src_type = 1;
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			nmi_src_type = 2;
+			break;
+		case IRQ_TYPE_EDGE_RISING:
+			nmi_src_type = 3;
+			break;
+		default:
+			pr_err("%pOF: invalid trigger type %d for IRQ %d\n",
+			       irq_domain_get_of_node(data->domain), type,
+			       data->irq);
+			return -EBADR;
+		}
+
+		if (type & IRQ_TYPE_EDGE_BOTH) {
+			irq_set_chip_handler_name_locked(data,
+							 &sun6i_r_intc_edge,
+							 handle_fasteoi_ack_irq,
+							 NULL);
+		} else {
+			irq_set_chip_handler_name_locked(data,
+							 &sun6i_r_intc_level,
+							 handle_fasteoi_irq,
+							 NULL);
+		}
+
+		writel_relaxed(nmi_src_type, base + SUN6I_R_INTC_NMI_CTRL);
+
+		/* Send the R_INTC -> GIC trigger type to the GIC driver. */
+		type = parent_type;
+	}
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip sun6i_r_intc_edge = {
+	.name			= "sun6i-r-intc",
+	.irq_ack		= sun6i_r_intc_irq_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip sun6i_r_intc_level = {
+	.name			= "sun6i-r-intc",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= sun6i_r_intc_irq_eoi,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_EOI_THREADED,
+};
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
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
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
+					      &sun6i_r_intc_level, NULL);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
+}
+
+static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
+	.translate	= irq_domain_translate_twocell,
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
+	/* Clear and enable the NMI. */
+	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_PENDING);
+	writel_relaxed(NMI_HWIRQ_BIT, base + SUN6I_R_INTC_ENABLE);
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
2.24.1

