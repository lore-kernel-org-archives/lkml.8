Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E48520730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JiCO87Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBDLTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:19:07 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14221 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgBDLTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:19:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3952f00000>; Tue, 04 Feb 2020 03:18:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:19:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 03:19:04 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:19:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:03 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3953240004>; Tue, 04 Feb 2020 03:19:03 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 03/19] phy: tegra: xusb: Add usb-role-switch support
Date:   Tue, 4 Feb 2020 16:46:49 +0530
Message-ID: <1580815025-10915-4-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815088; bh=1OfvPYR9hYh1Ivz7BSmZrZRI0tjZeK+qA72ykblKOQc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JiCO87Rp8XnINWLuuawmn56wsYBYQk6GDkU+eK975BM9GEIr/EBPF5ucmvbRCVymf
         arejFMs4LfwJp4TdnkM4WOksYsylgE2n55kE4aKZKdlNcU56fUA2DfY/cqd6I1FA2j
         L4e2C4+wVIJrJKg9MozXnuDbBC3AqZqbMbMiyIh7WSRBGeTku2Oz9It5syiTtjZjLt
         sWfp+NYsEt+Z8/06HxV5ujBCGFi+Q2McJogZZGb2Mdw2JSa8U6dlvniEggo2IiLtqq
         26KQFnd+i99gE8JxIYnmQlx8b4z27qXelhtRWD4sEBqe2cvVXgIwbeSE1grh7w0MOB
         67oUx8wgIizog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usb-role-switch property is present in USB 2 port, register
usb-role-switch to receive usb role changes.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V4:
 - Updated function name in debug messages as suggested by Thierry.
 - Added owner info to port->dev during USB role switch registration.
---
V3:
 - Driver aborts if usb-role-switch is not added in dt forotg/peripheral
   roles.
 - Added role name strings instead of enum values in debug prints.
 - Updated arguments and variable allignments as per Thierry inputs.
---
V2:
 - Removed dev_set_drvdata for port->dev.
 - Added of_platform_depopulate during error handling and driver removal.
---
 drivers/phy/tegra/Kconfig |  1 +
 drivers/phy/tegra/xusb.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h  |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index f9817c3..df07c4d 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -2,6 +2,7 @@
 config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
 	depends on ARCH_TEGRA
+	select USB_CONN_GPIO
 	help
 	  Choose this option if you have an NVIDIA Tegra SoC.
 
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index f98ec39..0fdbaa2 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -541,6 +541,11 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 {
+	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
+		of_platform_depopulate(&port->dev);
+		usb_role_switch_unregister(port->usb_role_sw);
+	}
+
 	device_unregister(&port->dev);
 }
 
@@ -551,11 +556,59 @@ static const char *const modes[] = {
 	[USB_DR_MODE_OTG] = "otg",
 };
 
+static const char * const usb_roles[] = {
+	[USB_ROLE_NONE]		= "none",
+	[USB_ROLE_HOST]		= "host",
+	[USB_ROLE_DEVICE]	= "device",
+};
+
+static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
+{
+	dev_dbg(dev, "%s(): role %s\n", __func__, usb_roles[role]);
+
+	return 0;
+}
+
+static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
+{
+	struct usb_role_switch_desc role_sx_desc = {
+		.fwnode = dev_fwnode(&port->dev),
+		.set = tegra_xusb_role_sw_set,
+	};
+	int err = 0;
+
+	/*
+	 * USB role switch driver needs parent driver owner info. This is a
+	 * suboptimal solution. TODO: Need to revisit this in a follow-up patch
+	 * where an optimal solution is possible with changes to USB role
+	 * switch driver.
+	 */
+	port->dev.driver = devm_kzalloc(&port->dev,
+					sizeof(struct device_driver),
+					GFP_KERNEL);
+	port->dev.driver->owner	 = THIS_MODULE;
+
+	port->usb_role_sw = usb_role_switch_register(&port->dev,
+						     &role_sx_desc);
+	if (IS_ERR(port->usb_role_sw)) {
+		err = PTR_ERR(port->usb_role_sw);
+		dev_err(&port->dev, "failed to register USB role switch: %d",
+			err);
+		return err;
+	}
+
+	/* populate connector entry */
+	of_platform_populate(port->dev.of_node, NULL, NULL, &port->dev);
+
+	return err;
+}
+
 static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 {
 	struct tegra_xusb_port *port = &usb2->base;
 	struct device_node *np = port->dev.of_node;
 	const char *mode;
+	int err;
 
 	usb2->internal = of_property_read_bool(np, "nvidia,internal");
 
@@ -572,6 +625,20 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 		usb2->mode = USB_DR_MODE_HOST;
 	}
 
+	/* usb-role-switch property is mandatory for OTG/Peripheral modes */
+	if (usb2->mode == USB_DR_MODE_PERIPHERAL ||
+	    usb2->mode == USB_DR_MODE_OTG) {
+		if (of_property_read_bool(np, "usb-role-switch")) {
+			err = tegra_xusb_setup_usb_role_switch(port);
+			if (err < 0)
+				return err;
+		} else {
+			dev_err(&port->dev, "usb-role-switch not found for %s mode",
+				modes[usb2->mode]);
+			return -EINVAL;
+		}
+	}
+
 	usb2->supply = devm_regulator_get(&port->dev, "vbus");
 	return PTR_ERR_OR_ZERO(usb2->supply);
 }
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index da94fcc..9f27899 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -12,6 +12,7 @@
 #include <linux/workqueue.h>
 
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 
 /* legacy entry points for backwards-compatibility */
 int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
@@ -266,6 +267,8 @@ struct tegra_xusb_port {
 	struct list_head list;
 	struct device dev;
 
+	struct usb_role_switch *usb_role_sw;
+
 	const struct tegra_xusb_port_ops *ops;
 };
 
-- 
2.7.4

