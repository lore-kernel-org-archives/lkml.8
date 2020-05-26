Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8EA20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgEZOvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:51:02 -0400
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:43666 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729141AbgEZOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:51:02 -0400
Received: from jax4mhob18.registeredsite.com (jax4mhob18.registeredsite.com [64.69.218.106])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 04QEow2W031301
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:50:58 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob18.registeredsite.com (8.14.4/8.14.4) with ESMTP id 04QEotek045137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:50:56 -0400
Received: (qmail 16270 invoked by uid 0); 26 May 2020 14:50:55 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 26 May 2020 14:50:55 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
Date:   Tue, 26 May 2020 16:50:51 +0200
Message-Id: <20200526145051.31520-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables support for VBUS on boards where the power is supplied
by a regulator. The regulator is enabled when the USB port enters
HOST mode.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../devicetree/bindings/usb/usb-nop-xceiv.txt |  3 ++
 drivers/usb/phy/phy-generic.c                 | 44 ++++++++++++++++++-
 drivers/usb/phy/phy-generic.h                 |  2 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
index 4dc6a8ee3071..775a19fdb613 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
@@ -16,6 +16,9 @@ Optional properties:
 
 - vcc-supply: phandle to the regulator that provides power to the PHY.
 
+- vbus-supply: phandle to the regulator that provides the VBUS power for when
+  the device is in HOST mode.
+
 - reset-gpios: Should specify the GPIO for reset.
 
 - vbus-detect-gpio: should specify the GPIO detecting a VBus insertion
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 661a229c105d..ebfb90764511 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -203,13 +203,43 @@ static int nop_set_host(struct usb_otg *otg, struct usb_bus *host)
 	return 0;
 }
 
+static int nop_set_vbus(struct usb_otg *otg, bool enabled)
+{
+	struct usb_phy_generic *nop;
+	int ret;
+
+	if (!otg)
+		return -ENODEV;
+
+	nop = container_of(otg->usb_phy, struct usb_phy_generic, phy);
+
+	if (!nop->vbus_reg)
+		return 0;
+
+	if (enabled) {
+		if (nop->vbus_reg_enabled)
+			return 0;
+		ret = regulator_enable(nop->vbus_reg);
+		if (ret < 0)
+			return ret;
+		nop->vbus_reg_enabled = true;
+	} else {
+		if (!nop->vbus_reg_enabled)
+			return 0;
+		ret = regulator_disable(nop->vbus_reg);
+		if (ret < 0)
+			return ret;
+		nop->vbus_reg_enabled = false;
+	}
+}
+
 int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 {
 	enum usb_phy_type type = USB_PHY_TYPE_USB2;
 	int err = 0;
 
 	u32 clk_rate = 0;
-	bool needs_vcc = false, needs_clk = false;
+	bool needs_vcc = false, needs_clk = false, needs_vbus = false;
 
 	if (dev->of_node) {
 		struct device_node *node = dev->of_node;
@@ -219,6 +249,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 
 		needs_vcc = of_property_read_bool(node, "vcc-supply");
 		needs_clk = of_property_read_bool(node, "clocks");
+		needs_vbus = of_property_read_bool(node, "vbus-supply");
 	}
 	nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
 						   GPIOD_ASIS);
@@ -268,6 +299,16 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 			return -EPROBE_DEFER;
 	}
 
+	nop->vbus_reg = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(nop->vbus_reg)) {
+		dev_dbg(dev, "Error getting vbus regulator: %ld\n",
+					PTR_ERR(nop->vbus_reg));
+		if (needs_vbus)
+			return -EPROBE_DEFER;
+
+		nop->vbus_reg = NULL;
+	}
+
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
@@ -278,6 +319,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 	nop->phy.otg->usb_phy		= &nop->phy;
 	nop->phy.otg->set_host		= nop_set_host;
 	nop->phy.otg->set_peripheral	= nop_set_peripheral;
+	nop->phy.otg->set_vbus		= nop_set_vbus;
 
 	return 0;
 }
diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-generic.h
index 7ee80211a688..a3663639ea1e 100644
--- a/drivers/usb/phy/phy-generic.h
+++ b/drivers/usb/phy/phy-generic.h
@@ -14,7 +14,9 @@ struct usb_phy_generic {
 	struct gpio_desc *gpiod_reset;
 	struct gpio_desc *gpiod_vbus;
 	struct regulator *vbus_draw;
+	struct regulator *vbus_reg;
 	bool vbus_draw_enabled;
+	bool vbus_reg_enabled;
 	unsigned long mA;
 	unsigned int vbus;
 };
-- 
2.17.1

