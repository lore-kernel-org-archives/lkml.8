Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C7C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9690207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC/CVlGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGTNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGTNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:12:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E69BC0619D2;
        Mon, 20 Jul 2020 06:12:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so17817551wrw.1;
        Mon, 20 Jul 2020 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5qKLJ+tkyNoiIYvNCceCAKgETivXbgE351HNu9vJLM=;
        b=qC/CVlGlsT+vw727bcIQ5i5W7npkkN0SbzGzQouZiEK47YELMUL2McW+5aIuA8poOy
         7o4JumtmuTP1aHAwmTKEHdoLpQZLhuQbd38xeHImAib8dUM3hlC3hu7QSb86rPVE+pFb
         8jth+n0GAcbVNkBbxQXyEx5s6V81VOSlop4Vmhmo68hQg1Di+L4Aqbk6iBC6nISuiN/c
         RVU6h/gwP86t/6oivpgCJ2GumEHg9E0wKjrUd8WIpufvpZR+IgLWtkd6y00gcrzUh40s
         rITIq/I16ZWcSEmJQNVDP2W4CEad8uVXUmUhll8e/PD4fTSWp8Q1EmohxBCml+Fa1aMU
         F5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5qKLJ+tkyNoiIYvNCceCAKgETivXbgE351HNu9vJLM=;
        b=b0zHukkxkZW9NnE1dtVrIwPEh9kOgk6v/TAylCQrVR5y0yIHo/Ycw6tkVenzdpGcHP
         Be2OnkBZLHp3/UM3hh4hM7mNPAokSgXMz9XdPY4ETXXf6fUGmlPkckzHaV5lRENlS+LD
         qzkAaGhHQPtwUCZ45XkCoQFIHgN1YkELy1p00LO/Z4UrbRjEfDPS8rFxWG9T7WQtDERx
         r9QHt6vPmuIDyqkAEkaWkArVJtsuKhE/TmMX1fd0xMNemFtc9gYS1leCvP3phTjErCN9
         KCFcN3JFS2VV6U/i9fJKIHnB8MwEKaQ6Pn/KJ7/ylTUJZOjZTZnnVDMpsbOZr7T/x1zY
         Su+Q==
X-Gm-Message-State: AOAM5306Qw0EaO1/TAHuxcMxkytZRj7cv9lMJ2GpkEqeYcUfufDu2WDg
        9u6XBxNuSSVb/dd8Xj2w77Y=
X-Google-Smtp-Source: ABdhPJz/zCijYOXe8ooLTu6RUQyDyJ8FILk5l4+o5J+ygDU+iM/a/KEbIzE8bUYhuBz97QwBp5srbg==
X-Received: by 2002:adf:f682:: with SMTP id v2mr10670665wrp.90.1595250738858;
        Mon, 20 Jul 2020 06:12:18 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j24sm2725293wrb.49.2020.07.20.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:12:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Simon Arlott <simon@octiron.net>
Subject: [PATCH v8 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Mon, 20 Jul 2020 15:12:09 +0200
Message-Id: <20200720131209.1236590-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720131209.1236590-1-noltari@gmail.com>
References: <20200720131209.1236590-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Simon Arlott <simon@octiron.net>
---
 v8: readd Simon as author and remove his email address from the source code.
 v7: remove Simon from authors.
 v6: introduce changes suggested by Vinod:
  - Remove BMIPS_GENERIC default from kconfig.
  - Print registered message as debug.
 v5: use devm_reset_control_get_exclusive.
 v4: several improvements:
  - Use devm_platform_ioremap_resource.
  - Code cleanups.
  - Improve device mode config:
    - Move USBH_SWAP_CONTROL device mode value to variant variable.
    - Set USBH_UTMI_CONTROL1 register value (variant variable).
 v3: introduce changes suggested by Florian:
  - Add support for device mode.
 v2: introduce changes suggested by Florian:
  - Drop OF dependency (use device_get_match_data).
  - Drop __initconst from variant tables.
  - Use devm_clk_get_optional.

 drivers/phy/broadcom/Kconfig            |   8 +
 drivers/phy/broadcom/Makefile           |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c | 457 ++++++++++++++++++++++++
 3 files changed, 466 insertions(+)
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index b29f11c19155..a1f1a9c90d0d 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -2,6 +2,14 @@
 #
 # Phy drivers for Broadcom platforms
 #
+config PHY_BCM63XX_USBH
+	tristate "BCM63xx USBH PHY driver"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this to support the BCM63xx USBH PHY driver.
+	  If unsure, say N.
+
 config PHY_CYGNUS_PCIE
 	tristate "Broadcom Cygnus PCIe PHY driver"
 	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index c78de546135c..7024127f86ad 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_BCM63XX_USBH)		+= phy-bcm63xx-usbh.o
 obj-$(CONFIG_PHY_CYGNUS_PCIE)		+= phy-bcm-cygnus-pcie.o
 obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
 obj-$(CONFIG_PHY_BCM_NS_USB2)		+= phy-bcm-ns-usb2.o
diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
new file mode 100644
index 000000000000..6c05ba8b08be
--- /dev/null
+++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BCM6328 USBH PHY Controller Driver
+ *
+ * Copyright (C) 2020 Álvaro Fernández Rojas <noltari@gmail.com>
+ * Copyright (C) 2015 Simon Arlott
+ *
+ * Derived from bcm963xx_4.12L.06B_consumer/kernel/linux/arch/mips/bcm963xx/setup.c:
+ * Copyright (C) 2002 Broadcom Corporation
+ *
+ * Derived from OpenWrt patches:
+ * Copyright (C) 2013 Jonas Gorski <jonas.gorski@gmail.com>
+ * Copyright (C) 2013 Florian Fainelli <f.fainelli@gmail.com>
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* USBH control register offsets */
+enum usbh_regs {
+	USBH_BRT_CONTROL1 = 0,
+	USBH_BRT_CONTROL2,
+	USBH_BRT_STATUS1,
+	USBH_BRT_STATUS2,
+	USBH_UTMI_CONTROL1,
+#define   USBH_UC1_DEV_MODE_SEL		BIT(0)
+	USBH_TEST_PORT_CONTROL,
+	USBH_PLL_CONTROL1,
+#define   USBH_PLLC_REFCLKSEL_SHIFT	0
+#define   USBH_PLLC_REFCLKSEL_MASK	(0x3 << USBH_PLLC_REFCLKSEL_SHIFT)
+#define   USBH_PLLC_CLKSEL_SHIFT	2
+#define   USBH_PLLC_CLKSEL_MASK		(0x3 << USBH_PLLC_CLKSEL_MASK)
+#define   USBH_PLLC_XTAL_PWRDWNB	BIT(4)
+#define   USBH_PLLC_PLL_PWRDWNB		BIT(5)
+#define   USBH_PLLC_PLL_CALEN		BIT(6)
+#define   USBH_PLLC_PHYPLL_BYP		BIT(7)
+#define   USBH_PLLC_PLL_RESET		BIT(8)
+#define   USBH_PLLC_PLL_IDDQ_PWRDN	BIT(9)
+#define   USBH_PLLC_PLL_PWRDN_DELAY	BIT(10)
+#define   USBH_6318_PLLC_PLL_SUSPEND_EN	BIT(27)
+#define   USBH_6318_PLLC_PHYPLL_BYP	BIT(29)
+#define   USBH_6318_PLLC_PLL_RESET	BIT(30)
+#define   USBH_6318_PLLC_PLL_IDDQ_PWRDN	BIT(31)
+	USBH_SWAP_CONTROL,
+#define   USBH_SC_OHCI_DATA_SWAP	BIT(0)
+#define   USBH_SC_OHCI_ENDIAN_SWAP	BIT(1)
+#define   USBH_SC_OHCI_LOGICAL_ADDR_EN	BIT(2)
+#define   USBH_SC_EHCI_DATA_SWAP	BIT(3)
+#define   USBH_SC_EHCI_ENDIAN_SWAP	BIT(4)
+#define   USBH_SC_EHCI_LOGICAL_ADDR_EN	BIT(5)
+#define   USBH_SC_USB_DEVICE_SEL	BIT(6)
+	USBH_GENERIC_CONTROL,
+#define   USBH_GC_PLL_SUSPEND_EN	BIT(1)
+	USBH_FRAME_ADJUST_VALUE,
+	USBH_SETUP,
+#define   USBH_S_IOC			BIT(4)
+#define   USBH_S_IPP			BIT(5)
+	USBH_MDIO,
+	USBH_MDIO32,
+	USBH_USB_SIM_CONTROL,
+#define   USBH_USC_LADDR_SEL		BIT(5)
+
+	__USBH_ENUM_SIZE
+};
+
+struct bcm63xx_usbh_phy_variant {
+	/* Registers */
+	long regs[__USBH_ENUM_SIZE];
+
+	/* PLLC bits to set/clear for power on */
+	u32 power_pllc_clr;
+	u32 power_pllc_set;
+
+	/* Setup bits to set/clear for power on */
+	u32 setup_clr;
+	u32 setup_set;
+
+	/* Swap Control bits to set */
+	u32 swapctl_dev_set;
+
+	/* Test Port Control value to set if non-zero */
+	u32 tpc_val;
+
+	/* USB Sim Control bits to set */
+	u32 usc_set;
+
+	/* UTMI Control 1 bits to set */
+	u32 utmictl1_dev_set;
+};
+
+struct bcm63xx_usbh_phy {
+	void __iomem *base;
+	struct clk *usbh_clk;
+	struct clk *usb_ref_clk;
+	struct reset_control *reset;
+	const struct bcm63xx_usbh_phy_variant *variant;
+	bool device_mode;
+};
+
+static const struct bcm63xx_usbh_phy_variant usbh_bcm6318 = {
+	.regs = {
+		[USBH_BRT_CONTROL1] = -1,
+		[USBH_BRT_CONTROL2] = -1,
+		[USBH_BRT_STATUS1] = -1,
+		[USBH_BRT_STATUS2] = -1,
+		[USBH_UTMI_CONTROL1] = 0x2c,
+		[USBH_TEST_PORT_CONTROL] = 0x1c,
+		[USBH_PLL_CONTROL1] = 0x04,
+		[USBH_SWAP_CONTROL] = 0x0c,
+		[USBH_GENERIC_CONTROL] = -1,
+		[USBH_FRAME_ADJUST_VALUE] = 0x08,
+		[USBH_SETUP] = 0x00,
+		[USBH_MDIO] = 0x14,
+		[USBH_MDIO32] = 0x18,
+		[USBH_USB_SIM_CONTROL] = 0x20,
+	},
+	.power_pllc_clr = USBH_6318_PLLC_PLL_IDDQ_PWRDN,
+	.power_pllc_set = USBH_6318_PLLC_PLL_SUSPEND_EN,
+	.setup_set = USBH_S_IOC,
+	.swapctl_dev_set = USBH_SC_USB_DEVICE_SEL,
+	.usc_set = USBH_USC_LADDR_SEL,
+	.utmictl1_dev_set = USBH_UC1_DEV_MODE_SEL,
+};
+
+static const struct bcm63xx_usbh_phy_variant usbh_bcm6328 = {
+	.regs = {
+		[USBH_BRT_CONTROL1] = 0x00,
+		[USBH_BRT_CONTROL2] = 0x04,
+		[USBH_BRT_STATUS1] = 0x08,
+		[USBH_BRT_STATUS2] = 0x0c,
+		[USBH_UTMI_CONTROL1] = 0x10,
+		[USBH_TEST_PORT_CONTROL] = 0x14,
+		[USBH_PLL_CONTROL1] = 0x18,
+		[USBH_SWAP_CONTROL] = 0x1c,
+		[USBH_GENERIC_CONTROL] = 0x20,
+		[USBH_FRAME_ADJUST_VALUE] = 0x24,
+		[USBH_SETUP] = 0x28,
+		[USBH_MDIO] = 0x2c,
+		[USBH_MDIO32] = 0x30,
+		[USBH_USB_SIM_CONTROL] = 0x34,
+	},
+	.setup_set = USBH_S_IOC,
+	.swapctl_dev_set = USBH_SC_USB_DEVICE_SEL,
+	.utmictl1_dev_set = USBH_UC1_DEV_MODE_SEL,
+};
+
+static const struct bcm63xx_usbh_phy_variant usbh_bcm6358 = {
+	.regs = {
+		[USBH_BRT_CONTROL1] = -1,
+		[USBH_BRT_CONTROL2] = -1,
+		[USBH_BRT_STATUS1] = -1,
+		[USBH_BRT_STATUS2] = -1,
+		[USBH_UTMI_CONTROL1] = -1,
+		[USBH_TEST_PORT_CONTROL] = 0x24,
+		[USBH_PLL_CONTROL1] = -1,
+		[USBH_SWAP_CONTROL] = 0x00,
+		[USBH_GENERIC_CONTROL] = -1,
+		[USBH_FRAME_ADJUST_VALUE] = -1,
+		[USBH_SETUP] = -1,
+		[USBH_MDIO] = -1,
+		[USBH_MDIO32] = -1,
+		[USBH_USB_SIM_CONTROL] = -1,
+	},
+	/*
+	 * The magic value comes for the original vendor BSP
+	 * and is needed for USB to work. Datasheet does not
+	 * help, so the magic value is used as-is.
+	 */
+	.tpc_val = 0x1c0020,
+};
+
+static const struct bcm63xx_usbh_phy_variant usbh_bcm6368 = {
+	.regs = {
+		[USBH_BRT_CONTROL1] = 0x00,
+		[USBH_BRT_CONTROL2] = 0x04,
+		[USBH_BRT_STATUS1] = 0x08,
+		[USBH_BRT_STATUS2] = 0x0c,
+		[USBH_UTMI_CONTROL1] = 0x10,
+		[USBH_TEST_PORT_CONTROL] = 0x14,
+		[USBH_PLL_CONTROL1] = 0x18,
+		[USBH_SWAP_CONTROL] = 0x1c,
+		[USBH_GENERIC_CONTROL] = -1,
+		[USBH_FRAME_ADJUST_VALUE] = 0x24,
+		[USBH_SETUP] = 0x28,
+		[USBH_MDIO] = 0x2c,
+		[USBH_MDIO32] = 0x30,
+		[USBH_USB_SIM_CONTROL] = 0x34,
+	},
+	.power_pllc_clr = USBH_PLLC_PLL_IDDQ_PWRDN | USBH_PLLC_PLL_PWRDN_DELAY,
+	.setup_set = USBH_S_IOC,
+	.swapctl_dev_set = USBH_SC_USB_DEVICE_SEL,
+	.utmictl1_dev_set = USBH_UC1_DEV_MODE_SEL,
+};
+
+static const struct bcm63xx_usbh_phy_variant usbh_bcm63268 = {
+	.regs = {
+		[USBH_BRT_CONTROL1] = 0x00,
+		[USBH_BRT_CONTROL2] = 0x04,
+		[USBH_BRT_STATUS1] = 0x08,
+		[USBH_BRT_STATUS2] = 0x0c,
+		[USBH_UTMI_CONTROL1] = 0x10,
+		[USBH_TEST_PORT_CONTROL] = 0x14,
+		[USBH_PLL_CONTROL1] = 0x18,
+		[USBH_SWAP_CONTROL] = 0x1c,
+		[USBH_GENERIC_CONTROL] = 0x20,
+		[USBH_FRAME_ADJUST_VALUE] = 0x24,
+		[USBH_SETUP] = 0x28,
+		[USBH_MDIO] = 0x2c,
+		[USBH_MDIO32] = 0x30,
+		[USBH_USB_SIM_CONTROL] = 0x34,
+	},
+	.power_pllc_clr = USBH_PLLC_PLL_IDDQ_PWRDN | USBH_PLLC_PLL_PWRDN_DELAY,
+	.setup_clr = USBH_S_IPP,
+	.setup_set = USBH_S_IOC,
+	.swapctl_dev_set = USBH_SC_USB_DEVICE_SEL,
+	.utmictl1_dev_set = USBH_UC1_DEV_MODE_SEL,
+};
+
+static inline bool usbh_has_reg(struct bcm63xx_usbh_phy *usbh, int reg)
+{
+	return (usbh->variant->regs[reg] >= 0);
+}
+
+static inline u32 usbh_readl(struct bcm63xx_usbh_phy *usbh, int reg)
+{
+	return __raw_readl(usbh->base + usbh->variant->regs[reg]);
+}
+
+static inline void usbh_writel(struct bcm63xx_usbh_phy *usbh, int reg,
+			       u32 value)
+{
+	__raw_writel(value, usbh->base + usbh->variant->regs[reg]);
+}
+
+static int bcm63xx_usbh_phy_init(struct phy *phy)
+{
+	struct bcm63xx_usbh_phy *usbh = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(usbh->usbh_clk);
+	if (ret) {
+		dev_err(&phy->dev, "unable to enable usbh clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(usbh->usb_ref_clk);
+	if (ret) {
+		dev_err(&phy->dev, "unable to enable usb_ref clock: %d\n", ret);
+		clk_disable_unprepare(usbh->usbh_clk);
+		return ret;
+	}
+
+	ret = reset_control_reset(usbh->reset);
+	if (ret) {
+		dev_err(&phy->dev, "unable to reset device: %d\n", ret);
+		clk_disable_unprepare(usbh->usb_ref_clk);
+		clk_disable_unprepare(usbh->usbh_clk);
+		return ret;
+	}
+
+	/* Configure to work in native CPU endian */
+	if (usbh_has_reg(usbh, USBH_SWAP_CONTROL)) {
+		u32 val = usbh_readl(usbh, USBH_SWAP_CONTROL);
+
+		val |= USBH_SC_EHCI_DATA_SWAP;
+		val &= ~USBH_SC_EHCI_ENDIAN_SWAP;
+
+		val |= USBH_SC_OHCI_DATA_SWAP;
+		val &= ~USBH_SC_OHCI_ENDIAN_SWAP;
+
+		if (usbh->device_mode && usbh->variant->swapctl_dev_set)
+			val |= usbh->variant->swapctl_dev_set;
+
+		usbh_writel(usbh, USBH_SWAP_CONTROL, val);
+	}
+
+	if (usbh_has_reg(usbh, USBH_SETUP)) {
+		u32 val = usbh_readl(usbh, USBH_SETUP);
+
+		val |= usbh->variant->setup_set;
+		val &= ~usbh->variant->setup_clr;
+
+		usbh_writel(usbh, USBH_SETUP, val);
+	}
+
+	if (usbh_has_reg(usbh, USBH_USB_SIM_CONTROL)) {
+		u32 val = usbh_readl(usbh, USBH_USB_SIM_CONTROL);
+
+		val |= usbh->variant->usc_set;
+
+		usbh_writel(usbh, USBH_USB_SIM_CONTROL, val);
+	}
+
+	if (usbh->variant->tpc_val &&
+	    usbh_has_reg(usbh, USBH_TEST_PORT_CONTROL))
+		usbh_writel(usbh, USBH_TEST_PORT_CONTROL,
+			    usbh->variant->tpc_val);
+
+	if (usbh->device_mode &&
+	    usbh_has_reg(usbh, USBH_UTMI_CONTROL1) &&
+	    usbh->variant->utmictl1_dev_set) {
+		u32 val = usbh_readl(usbh, USBH_UTMI_CONTROL1);
+
+		val |= usbh->variant->utmictl1_dev_set;
+
+		usbh_writel(usbh, USBH_UTMI_CONTROL1, val);
+	}
+
+	return 0;
+}
+
+static int bcm63xx_usbh_phy_power_on(struct phy *phy)
+{
+	struct bcm63xx_usbh_phy *usbh = phy_get_drvdata(phy);
+
+	if (usbh_has_reg(usbh, USBH_PLL_CONTROL1)) {
+		u32 val = usbh_readl(usbh, USBH_PLL_CONTROL1);
+
+		val |= usbh->variant->power_pllc_set;
+		val &= ~usbh->variant->power_pllc_clr;
+
+		usbh_writel(usbh, USBH_PLL_CONTROL1, val);
+	}
+
+	return 0;
+}
+
+static int bcm63xx_usbh_phy_power_off(struct phy *phy)
+{
+	struct bcm63xx_usbh_phy *usbh = phy_get_drvdata(phy);
+
+	if (usbh_has_reg(usbh, USBH_PLL_CONTROL1)) {
+		u32 val = usbh_readl(usbh, USBH_PLL_CONTROL1);
+
+		val &= ~usbh->variant->power_pllc_set;
+		val |= usbh->variant->power_pllc_clr;
+
+		usbh_writel(usbh, USBH_PLL_CONTROL1, val);
+	}
+
+	return 0;
+}
+
+static int bcm63xx_usbh_phy_exit(struct phy *phy)
+{
+	struct bcm63xx_usbh_phy *usbh = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(usbh->usbh_clk);
+	clk_disable_unprepare(usbh->usb_ref_clk);
+
+	return 0;
+}
+
+static const struct phy_ops bcm63xx_usbh_phy_ops = {
+	.exit = bcm63xx_usbh_phy_exit,
+	.init = bcm63xx_usbh_phy_init,
+	.power_off = bcm63xx_usbh_phy_power_off,
+	.power_on = bcm63xx_usbh_phy_power_on,
+	.owner = THIS_MODULE,
+};
+
+static struct phy *bcm63xx_usbh_phy_xlate(struct device *dev,
+					  struct of_phandle_args *args)
+{
+	struct bcm63xx_usbh_phy *usbh = dev_get_drvdata(dev);
+
+	usbh->device_mode = !!args->args[0];
+
+	return of_phy_simple_xlate(dev, args);
+}
+
+static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm63xx_usbh_phy	*usbh;
+	const struct bcm63xx_usbh_phy_variant *variant;
+	struct phy *phy;
+	struct phy_provider *phy_provider;
+
+	usbh = devm_kzalloc(dev, sizeof(*usbh), GFP_KERNEL);
+	if (!usbh)
+		return -ENOMEM;
+
+	variant = device_get_match_data(dev);
+	if (!variant)
+		return -EINVAL;
+	usbh->variant = variant;
+
+	usbh->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(usbh->base))
+		return PTR_ERR(usbh->base);
+
+	usbh->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(usbh->reset)) {
+		if (PTR_ERR(usbh->reset) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(usbh->reset);
+	}
+
+	usbh->usbh_clk = devm_clk_get_optional(dev, "usbh");
+	if (IS_ERR(usbh->usbh_clk))
+		return PTR_ERR(usbh->usbh_clk);
+
+	usbh->usb_ref_clk = devm_clk_get_optional(dev, "usb_ref");
+	if (IS_ERR(usbh->usb_ref_clk))
+		return PTR_ERR(usbh->usb_ref_clk);
+
+	phy = devm_phy_create(dev, NULL, &bcm63xx_usbh_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	platform_set_drvdata(pdev, usbh);
+	phy_set_drvdata(phy, usbh);
+
+	phy_provider = devm_of_phy_provider_register(dev,
+						     bcm63xx_usbh_phy_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	dev_dbg(dev, "Registered BCM63xx USB PHY driver\n");
+
+	return 0;
+}
+
+static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
+	{ .compatible = "brcm,bcm6318-usbh-phy", .data = &usbh_bcm6318 },
+	{ .compatible = "brcm,bcm6328-usbh-phy", .data = &usbh_bcm6328 },
+	{ .compatible = "brcm,bcm6358-usbh-phy", .data = &usbh_bcm6358 },
+	{ .compatible = "brcm,bcm6362-usbh-phy", .data = &usbh_bcm6368 },
+	{ .compatible = "brcm,bcm6368-usbh-phy", .data = &usbh_bcm6368 },
+	{ .compatible = "brcm,bcm63268-usbh-phy", .data = &usbh_bcm63268 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_usbh_phy_ids);
+
+static struct platform_driver bcm63xx_usbh_phy_driver __refdata = {
+	.driver	= {
+		.name = "bcm63xx-usbh-phy",
+		.of_match_table = bcm63xx_usbh_phy_ids,
+	},
+	.probe	= bcm63xx_usbh_phy_probe,
+};
+module_platform_driver(bcm63xx_usbh_phy_driver);
+
+MODULE_DESCRIPTION("BCM63xx USBH PHY driver");
+MODULE_AUTHOR("Álvaro Fernández Rojas <noltari@gmail.com>");
+MODULE_AUTHOR("Simon Arlott");
+MODULE_LICENSE("GPL");
-- 
2.27.0

