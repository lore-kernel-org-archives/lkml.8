Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9329021508
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgFQEA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:00:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:49820 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQEAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:00:24 -0400
IronPort-SDR: T9Vb4VOorsbwwKnA3GUWamrQE9xMHUpWAi0ERVfVadeyp3PX63L6NJp9tF5HjY18y+62CSxAOU
 JyggeM/j57xw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 21:00:22 -0700
IronPort-SDR: IkpBTAHIR+tAcWb7LSZ34XURHoiyzPKiUAqbWPNjLadO3aEBZeq4vxz8BlmlVRAZQxvGtSyZhz
 oxsVyoh9MBeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,521,1583222400"; 
   d="scan'208";a="476703808"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2020 21:00:17 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, balbi@kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
Date:   Wed, 17 Jun 2020 11:58:18 +0800
Message-Id: <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for USB PHY on Intel LGM SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/usb/phy/Kconfig       |  11 ++
 drivers/usb/phy/Makefile      |   1 +
 drivers/usb/phy/phy-lgm-usb.c | 275 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/usb/phy/phy-lgm-usb.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 4b3fa78995cf..95f2e737d663 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -192,4 +192,15 @@ config JZ4770_PHY
 	  This driver provides PHY support for the USB controller found
 	  on the JZ4770 SoC from Ingenic.
 
+config USB_LGM_PHY
+	tristate "INTEL Lightning Mountain USB PHY Driver"
+	depends on USB_SUPPORT
+	select USB_PHY
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
+	help
+	  Enable this to support Intel DWC3 PHY USB phy. This driver provides
+	  interface to interact with USB GEN-II and USB 3.x PHY that is part
+	  of the Intel network SOC.
+
 endmenu
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b352bdbe8712..ef5345164e10 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
 obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
 obj-$(CONFIG_JZ4770_PHY)		+= phy-jz4770.o
+obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
diff --git a/drivers/usb/phy/phy-lgm-usb.c b/drivers/usb/phy/phy-lgm-usb.c
new file mode 100644
index 000000000000..3da772dfd736
--- /dev/null
+++ b/drivers/usb/phy/phy-lgm-usb.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel LGM USB PHY driver
+ *
+ * Copyright (C) 2020 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/usb/phy.h>
+#include <linux/workqueue.h>
+
+#define CTRL1_OFFSET		0x14
+#define SRAM_EXT_LD_DONE	BIT(25)
+#define SRAM_INIT_DONE		BIT(26)
+
+#define TCPC_OFFSET		0x1014
+#define TCPC_MUX_CTL		GENMASK(1, 0)
+#define MUX_NC			0
+#define MUX_USB			1
+#define MUX_DP			2
+#define MUX_USBDP		3
+#define TCPC_FLIPPED		BIT(2)
+#define TCPC_LOW_POWER_EN	BIT(3)
+#define TCPC_VALID		BIT(4)
+#define TCPC_DISCONN		\
+	(TCPC_VALID | FIELD_PREP(TCPC_MUX_CTL, MUX_NC) | TCPC_LOW_POWER_EN)
+
+static const char *const PHY_RESETS[] = { "phy31", "phy", };
+static const char *const CTL_RESETS[] = { "apb", "ctrl", };
+
+struct tca_apb {
+	struct reset_control *resets[ARRAY_SIZE(PHY_RESETS)];
+	struct regulator *vbus;
+	struct work_struct wk;
+	struct usb_phy phy;
+
+	bool phy_initialized;
+	bool connected;
+};
+
+static int get_flipped(struct tca_apb *ta, bool *flipped)
+{
+	union extcon_property_value property;
+	int ret;
+
+	ret = extcon_get_property(ta->phy.edev, EXTCON_USB_HOST,
+				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
+	if (ret) {
+		dev_err(ta->phy.dev, "no polarity property from extcon\n");
+		return ret;
+	}
+
+	*flipped = property.intval;
+
+	return ret;
+}
+
+static int phy_init(struct usb_phy *phy)
+{
+	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
+	void __iomem *ctrl1 = phy->io_priv + CTRL1_OFFSET;
+	int val, ret, i;
+
+	if (ta->phy_initialized)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
+		reset_control_deassert(ta->resets[i]);
+
+	ret = readl_poll_timeout(ctrl1, val, val & SRAM_INIT_DONE, 10, 10 * 1000);
+	if (ret) {
+		dev_err(ta->phy.dev, "SRAM init failed, 0x%x\n", val);
+		return ret;
+	}
+
+	writel(readl(ctrl1) | SRAM_EXT_LD_DONE, ctrl1);
+
+	ta->phy_initialized = true;
+	if (!ta->phy.edev)
+		return phy->set_vbus(phy, true);
+
+	schedule_work(&ta->wk);
+
+	return ret;
+}
+
+static void phy_shutdown(struct usb_phy *phy)
+{
+	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
+	int i;
+
+	if (!ta->phy_initialized)
+		return;
+
+	ta->phy_initialized = false;
+	flush_work(&ta->wk);
+	ta->phy.set_vbus(&ta->phy, false);
+	if (ta->connected) {
+		ta->connected = false;
+		writel(TCPC_DISCONN, ta->phy.io_priv + TCPC_OFFSET);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
+		reset_control_assert(ta->resets[i]);
+}
+
+static int phy_set_vbus(struct usb_phy *phy, int on)
+{
+	struct tca_apb *ta = container_of(phy, struct tca_apb, phy);
+	int ret;
+
+	if (on) {
+		ret = regulator_enable(ta->vbus);
+		if (ret)
+			dev_err(ta->phy.dev, "regulator not enabled\n");
+	} else {
+		ret = regulator_disable(ta->vbus);
+		if (ret)
+			dev_err(ta->phy.dev, "regulator not disabled\n");
+	}
+
+	return ret;
+}
+
+static void tca_work(struct work_struct *work)
+{
+	struct tca_apb *ta = container_of(work, struct tca_apb, wk);
+	bool connected;
+	bool flipped = false;
+	u32 val;
+	int ret;
+
+	ret = get_flipped(ta, &flipped);
+	connected = extcon_get_state(ta->phy.edev, EXTCON_USB_HOST) && !ret;
+	if (connected == ta->connected)
+		return;
+
+	ta->connected = connected;
+	if (connected) {
+		val = TCPC_VALID | FIELD_PREP(TCPC_MUX_CTL, MUX_USB);
+		if (flipped)
+			val |= TCPC_FLIPPED;
+		dev_info(ta->phy.dev, "connected%s\n", flipped ? " flipped" : "");
+	} else {
+		val = TCPC_DISCONN;
+		dev_info(ta->phy.dev, "disconnected\n");
+	}
+
+	writel(val, ta->phy.io_priv + TCPC_OFFSET);
+
+	ret = ta->phy.set_vbus(&ta->phy, connected);
+	if (ret)
+		dev_err(ta->phy.dev, "failed to set VBUS\n");
+}
+
+static int id_notifier(struct notifier_block *nb, unsigned long event, void *ptr)
+{
+	struct tca_apb *ta = container_of(nb, struct tca_apb, phy.id_nb);
+
+	if (ta->phy_initialized)
+		schedule_work(&ta->wk);
+
+	return NOTIFY_DONE;
+}
+
+static int vbus_notifier(struct notifier_block *nb, unsigned long evnt, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static int phy_probe(struct platform_device *pdev)
+{
+	struct reset_control *resets[ARRAY_SIZE(CTL_RESETS)];
+	struct device *dev = &pdev->dev;
+	struct usb_phy *phy;
+	struct tca_apb *ta;
+	int i;
+
+	ta = devm_kzalloc(dev, sizeof(*ta), GFP_KERNEL);
+	if (!ta)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ta);
+	INIT_WORK(&ta->wk, tca_work);
+
+	phy = &ta->phy;
+	phy->dev = dev;
+	phy->label = dev_name(dev);
+	phy->type = USB_PHY_TYPE_USB3;
+	phy->init = phy_init;
+	phy->shutdown = phy_shutdown;
+	phy->set_vbus = phy_set_vbus;
+	phy->id_nb.notifier_call = id_notifier;
+	phy->vbus_nb.notifier_call = vbus_notifier;
+
+	phy->io_priv = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(phy->io_priv))
+		return PTR_ERR(phy->io_priv);
+
+	ta->vbus = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(ta->vbus))
+		return PTR_ERR(ta->vbus);
+
+	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++) {
+		resets[i] = devm_reset_control_get_exclusive(dev, CTL_RESETS[i]);
+		if (IS_ERR(resets[i])) {
+			dev_err(dev, "%s reset not found\n", CTL_RESETS[i]);
+			return PTR_ERR(resets[i]);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++) {
+		ta->resets[i] = devm_reset_control_get_exclusive(dev, PHY_RESETS[i]);
+		if (IS_ERR(ta->resets[i])) {
+			dev_err(dev, "%s reset not found\n", PHY_RESETS[i]);
+			return PTR_ERR(ta->resets[i]);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
+		reset_control_assert(resets[i]);
+
+	for (i = 0; i < ARRAY_SIZE(PHY_RESETS); i++)
+		reset_control_assert(ta->resets[i]);
+	/*
+	 * Out-of-band reset of the controller after PHY reset will cause
+	 * controller malfunctioning, so we should use in-band controller
+	 * reset only and leave the controller de-asserted here.
+	 */
+	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
+		reset_control_deassert(resets[i]);
+
+	/* Need to wait at least 20us after de-assert the controller */
+	usleep_range(20, 100);
+
+	return usb_add_phy_dev(phy);
+}
+
+static int phy_remove(struct platform_device *pdev)
+{
+	struct tca_apb *ta = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&ta->phy);
+
+	return 0;
+}
+
+static const struct of_device_id intel_usb_phy_dt_ids[] = {
+	{ .compatible = "intel,lgm-usb-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, intel_usb_phy_dt_ids);
+
+static struct platform_driver lgm_phy_driver = {
+	.driver = {
+		.name = "lgm-usb-phy",
+		.of_match_table = intel_usb_phy_dt_ids,
+	},
+	.probe = phy_probe,
+	.remove = phy_remove,
+};
+
+module_platform_driver(lgm_phy_driver);
+
+MODULE_DESCRIPTION("Intel LGM USB PHY driver");
+MODULE_AUTHOR("Li Yin <yin1.li@intel.com>");
+MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

