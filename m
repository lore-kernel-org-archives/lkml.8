Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F51C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951F22080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YZiedpkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBJIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:12:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18242 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgBJIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4110790000>; Mon, 10 Feb 2020 00:12:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:56 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:55 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110840000>; Mon, 10 Feb 2020 00:12:54 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 09/21] usb: gadget: tegra-xudc: Remove usb-role-switch support
Date:   Mon, 10 Feb 2020 13:41:35 +0530
Message-ID: <1581322307-11140-10-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322362; bh=F9vQgzsrM3kGG03RRSDPm8098j3JFB30K8kaLkDTeHc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YZiedpkZcKA69wJDQVtNn2rXNEmYFzH9sD92Gc6RoIxUTHIXcnafXG11TkuwchMTq
         rwPE0yPvyNnpW1YqtF3YQqwWdOpcwD61Jd9d5eVIGJ3lwD0aWwVnGk9Yr00Yj/4ZdD
         AGkyh7q/RxXSXn2/Sjgf7/bVWHRoIpAYVu+Exi6OI27uGsiD8uiR/sQvJPAuHl5XsM
         D+crI/qFhCO4vgx4GyoU93MbHmh37EDH9GmWshJ+khmC5mnwIfMwd3PhVRoOsWAYuD
         30RYxdhSju1A/LipVBeCdy4MRTlregg9wvMtdsAstwbyauOIIkD70lArSLSHBByTWw
         kgrm4aAA3Hlzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padctl driver will act as a central driver to receive USB role changes via
usb-role-switch. This is updated to corresponding host, device drivers.
Hence remove usb-role-switch from XUDC driver.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V5:
 - Removed select USB_ROLE_SWITCH from Kconfig.
---
V4
 - Updated device_mode variable with usb_role and remove role variable.
 - Removed debug log related to always on.
---
V2-V3:
 - No changes in this version
---
 drivers/usb/gadget/udc/tegra-xudc.c | 58 +++++--------------------------------
 2 files changed, 7 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 797d6ac..ae70ce2 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -445,7 +445,6 @@ config USB_TEGRA_XUDC
 	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PHY_TEGRA_XUSB
-	select USB_ROLE_SWITCH
 	help
 	 Enables NVIDIA Tegra USB 3.0 device mode controller driver.
 
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 634c2c1..acecdcf 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -477,8 +477,7 @@ struct tegra_xudc {
 
 	struct clk_bulk_data *clks;
 
-	enum usb_role device_mode;
-	struct usb_role_switch *usb_role_sw;
+	bool device_mode;
 	struct work_struct usb_role_sw_work;
 
 	struct phy *usb3_phy;
@@ -609,8 +608,6 @@ static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
 	dev_dbg(xudc->dev, "device mode on\n");
 
 	tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
-
-	xudc->device_mode = USB_ROLE_DEVICE;
 }
 
 static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
@@ -643,8 +640,6 @@ static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
 		xudc_writel(xudc, val, PORTSC);
 	}
 
-	xudc->device_mode = USB_ROLE_NONE;
-
 	/* Wait for disconnect event. */
 	if (connected)
 		wait_for_completion(&xudc->disconnect_complete);
@@ -668,29 +663,10 @@ static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
 	struct tegra_xudc *xudc = container_of(work, struct tegra_xudc,
 					       usb_role_sw_work);
 
-	if (!xudc->usb_role_sw ||
-		usb_role_switch_get_role(xudc->usb_role_sw) == USB_ROLE_DEVICE)
+	if (xudc->device_mode)
 		tegra_xudc_device_mode_on(xudc);
 	else
 		tegra_xudc_device_mode_off(xudc);
-
-}
-
-static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_role role)
-{
-	struct tegra_xudc *xudc = dev_get_drvdata(dev);
-	unsigned long flags;
-
-	dev_dbg(dev, "%s role is %d\n", __func__, role);
-
-	spin_lock_irqsave(&xudc->lock, flags);
-
-	if (!xudc->suspended)
-		schedule_work(&xudc->usb_role_sw_work);
-
-	spin_unlock_irqrestore(&xudc->lock, flags);
-
-	return 0;
 }
 
 static void tegra_xudc_plc_reset_work(struct work_struct *work)
@@ -729,8 +705,7 @@ static void tegra_xudc_port_reset_war_work(struct work_struct *work)
 
 	spin_lock_irqsave(&xudc->lock, flags);
 
-	if ((xudc->device_mode == USB_ROLE_DEVICE)
-			      && xudc->wait_for_sec_prc) {
+	if (xudc->device_mode && xudc->wait_for_sec_prc) {
 		pls = (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
 			PORTSC_PLS_SHIFT;
 		dev_dbg(xudc->dev, "pls = %x\n", pls);
@@ -3457,7 +3432,6 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 {
 	struct tegra_xudc *xudc;
 	struct resource *res;
-	struct usb_role_switch_desc role_sx_desc = { 0 };
 	unsigned int i;
 	int err;
 
@@ -3587,23 +3561,9 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
 				tegra_xudc_port_reset_war_work);
 
-	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
-		role_sx_desc.set = tegra_xudc_usb_role_sw_set;
-		role_sx_desc.fwnode = dev_fwnode(xudc->dev);
-
-		xudc->usb_role_sw = usb_role_switch_register(xudc->dev,
-							&role_sx_desc);
-		if (IS_ERR(xudc->usb_role_sw)) {
-			err = PTR_ERR(xudc->usb_role_sw);
-			dev_err(xudc->dev, "Failed to register USB role SW: %d",
-					   err);
-			goto free_eps;
-		}
-	} else {
-		/* Set the mode as device mode and this keeps phy always ON */
-		dev_info(xudc->dev, "Set usb role to device mode always");
-		schedule_work(&xudc->usb_role_sw_work);
-	}
+	/* Set the mode as device mode and this keeps phy always ON */
+	xudc->device_mode = true;
+	schedule_work(&xudc->usb_role_sw_work);
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -3643,11 +3603,7 @@ static int tegra_xudc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(xudc->dev);
 
 	cancel_delayed_work(&xudc->plc_reset_work);
-
-	if (xudc->usb_role_sw) {
-		usb_role_switch_unregister(xudc->usb_role_sw);
-		cancel_work_sync(&xudc->usb_role_sw_work);
-	}
+	cancel_work_sync(&xudc->usb_role_sw_work);
 
 	usb_del_gadget_udc(&xudc->gadget);
 
-- 
2.7.4

