Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD32C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E3E20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ENKupNr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgBLSEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:04:23 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55562 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581530660; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=scA1WOIhiNQUeDOO5mLotG7uFqAUr6QFX19gy5bzx74=;
        b=ENKupNr1in2mbm7jeNljlhTxyY7EkvdcgjTtKNdip4oGqYR+tLVW4kOx0Me6EYf6ja92Qu
        SGFd+Z+NZppRk1tvrYqh3HalwgIQnHIrJAhFytxwCrxLi0rz/lQJCs4DcUSPiqWQYdJs+N
        dUL0jaLhLkuww/OIdXh7G5uZfa2so3M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v5] clocksource: Add driver for the Ingenic JZ47xx OST
Date:   Wed, 12 Feb 2020 15:04:08 -0300
Message-Id: <20200212180408.30872-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten ter Huurne <maarten@treewalker.org>

OST is the OS Timer, a 64-bit timer/counter with buffered reading.

SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
JZ4780 have a 64-bit OST.

This driver will register both a clocksource and a sched_clock to the
system.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: local_irq_save/restore were moved within sched_clock_register
    v3: Only register as 32-bit clocksource to simplify things
    v4: - Bypass regmap to read counters.
        - Use sched_clock_register_new() to avoid having a global pointer to
    	  the ingenic_ost.
    	- Don't print error codes in probe, since they will be printed anyway
    	  if the probe function fails.
    	- Rebased on 5.6-rc1.
    v5: Restored global pointer to the ingenic_ost

 drivers/clocksource/Kconfig       |   8 ++
 drivers/clocksource/Makefile      |   1 +
 drivers/clocksource/ingenic-ost.c | 189 ++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/clocksource/ingenic-ost.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cc909e465823..f2142e6bbea3 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -697,6 +697,14 @@ config INGENIC_TIMER
 	help
 	  Support for the timer/counter unit of the Ingenic JZ SoCs.
 
+config INGENIC_OST
+	bool "Clocksource for Ingenic OS Timer"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select MFD_SYSCON
+	help
+	  Support for the Operating System Timer of the Ingenic JZ SoCs.
+
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 713686faa549..641ba5383ab5 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
 obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
new file mode 100644
index 000000000000..029efc2731b4
--- /dev/null
+++ b/drivers/clocksource/ingenic-ost.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU Operating System Timer driver
+ *
+ * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
+ * Copyright (C) 2020 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#define TCU_OST_TCSR_MASK	0xffc0
+#define TCU_OST_TCSR_CNT_MD	BIT(15)
+
+#define TCU_OST_CHANNEL		15
+
+/*
+ * The TCU_REG_OST_CNT{L,R} from <linux/mfd/ingenic-tcu.h> are only for the
+ * regmap; these are for use with the __iomem pointer.
+ */
+#define OST_REG_CNTL		0x4
+#define OST_REG_CNTH		0x8
+
+struct ingenic_ost_soc_info {
+	bool is64bit;
+};
+
+struct ingenic_ost {
+	void __iomem *regs;
+	struct clk *clk;
+
+	struct clocksource cs;
+};
+
+static struct ingenic_ost *ingenic_ost;
+
+static u64 notrace ingenic_ost_read_cntl(void)
+{
+	/* Read using __iomem pointer instead of regmap to avoid locking */
+	return readl(ingenic_ost->regs + OST_REG_CNTL);
+}
+
+static u64 notrace ingenic_ost_read_cnth(void)
+{
+	/* Read using __iomem pointer instead of regmap to avoid locking */
+	return readl(ingenic_ost->regs + OST_REG_CNTH);
+}
+
+static u64 notrace ingenic_ost_clocksource_readl(struct clocksource *cs)
+{
+	return ingenic_ost_read_cntl();
+}
+
+static u64 notrace ingenic_ost_clocksource_readh(struct clocksource *cs)
+{
+	return ingenic_ost_read_cnth();
+}
+
+static int __init ingenic_ost_probe(struct platform_device *pdev)
+{
+	const struct ingenic_ost_soc_info *soc_info;
+	struct device *dev = &pdev->dev;
+	struct ingenic_ost *ost;
+	struct clocksource *cs;
+	struct regmap *map;
+	unsigned long rate;
+	int err;
+
+	soc_info = device_get_match_data(dev);
+	if (!soc_info)
+		return -EINVAL;
+
+	ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
+	if (!ost)
+		return -ENOMEM;
+
+	ingenic_ost = ost;
+
+	ost->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ost->regs))
+		return PTR_ERR(ost->regs);
+
+	map = device_node_to_regmap(dev->parent->of_node);
+	if (!map) {
+		dev_err(dev, "regmap not found");
+		return -EINVAL;
+	}
+
+	ost->clk = devm_clk_get(dev, "ost");
+	if (IS_ERR(ost->clk))
+		return PTR_ERR(ost->clk);
+
+	err = clk_prepare_enable(ost->clk);
+	if (err)
+		return err;
+
+	/* Clear counter high/low registers */
+	if (soc_info->is64bit)
+		regmap_write(map, TCU_REG_OST_CNTL, 0);
+	regmap_write(map, TCU_REG_OST_CNTH, 0);
+
+	/* Don't reset counter at compare value. */
+	regmap_update_bits(map, TCU_REG_OST_TCSR,
+			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
+
+	rate = clk_get_rate(ost->clk);
+
+	/* Enable OST TCU channel */
+	regmap_write(map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
+
+	cs = &ost->cs;
+	cs->name	= "ingenic-ost";
+	cs->rating	= 320;
+	cs->flags	= CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask	= CLOCKSOURCE_MASK(32);
+
+	if (soc_info->is64bit)
+		cs->read = ingenic_ost_clocksource_readl;
+	else
+		cs->read = ingenic_ost_clocksource_readh;
+
+	err = clocksource_register_hz(cs, rate);
+	if (err) {
+		dev_err(dev, "clocksource registration failed");
+		clk_disable_unprepare(ost->clk);
+		return err;
+	}
+
+	if (soc_info->is64bit)
+		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
+	else
+		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_ost_suspend(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	clk_disable(ost->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ingenic_ost_resume(struct device *dev)
+{
+	struct ingenic_ost *ost = dev_get_drvdata(dev);
+
+	return clk_enable(ost->clk);
+}
+
+static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops = {
+	/* _noirq: We want the OST clock to be gated last / ungated first */
+	.suspend_noirq = ingenic_ost_suspend,
+	.resume_noirq  = ingenic_ost_resume,
+};
+
+static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
+	.is64bit = false,
+};
+
+static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
+	.is64bit = true,
+};
+
+static const struct of_device_id ingenic_ost_of_match[] = {
+	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
+	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
+	{ }
+};
+
+static struct platform_driver ingenic_ost_driver = {
+	.driver = {
+		.name = "ingenic-ost",
+#ifdef CONFIG_PM_SUSPEND
+		.pm = &ingenic_ost_pm_ops,
+#endif
+		.of_match_table = ingenic_ost_of_match,
+	},
+};
+builtin_platform_driver_probe(ingenic_ost_driver, ingenic_ost_probe);
-- 
2.25.0

