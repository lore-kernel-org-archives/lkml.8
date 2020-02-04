Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A032CC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149120730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YI3byhpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBDLTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:19:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19233 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBDLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:19:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e39532b0000>; Tue, 04 Feb 2020 03:19:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:19:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Feb 2020 03:19:30 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:19:30 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:30 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e39533e0000>; Tue, 04 Feb 2020 03:19:29 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 10/19] usb: gadget: tegra-xudc: Add usb-phy support
Date:   Tue, 4 Feb 2020 16:46:56 +0530
Message-ID: <1580815025-10915-11-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815147; bh=InQ01fPLFKZBRgvNbHsD+HXLg38WLTKQBAv4KDeU7qo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YI3byhpuvTjqRFH7/VBoVpkcU0PUS93oIybs69p5HMRMKMXinyC08LkYkusFrwsVX
         DF8uIr0vNJFR20PB8FTO9R+BxcygntMlIabj6cL1+rrWaG4jDNmST2ZFPnZOCMMpY+
         6W42uGyx/L7yJgmQP0x6VfbsXnOmB0mc81e1kWrY5F1r8CuutzR9a0HfOsF0P6OhaK
         47/i368JskwFxGKeiGotYST1aZdpFPj0bVVKOhUfiC61gfQ5jjtyVQ+CaMfcvcUDRV
         R1EzQj9rXJmKu9Fl07NKsa7w2DeYid3gzxv3ewYBBh+lvAXKIzc2UbEBmo23eHarrq
         zwJpUOLi9MyuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-phy is used to get notified on the USB role changes. Get usb-phy from
the UTMI PHY.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V4:
 - Addressed nit comments from Thierry.
 - usb_phy_event is used to detect device mode instead of usb_role.
---
V2-V3:
 - No changes in this version
---
 drivers/usb/gadget/udc/tegra-xudc.c | 48 ++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index acecdcf..7411dd15 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -26,7 +26,9 @@
 #include <linux/reset.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include <linux/usb/role.h>
+#include <linux/usb/phy.h>
 #include <linux/workqueue.h>
 
 /* XUSB_DEV registers */
@@ -487,6 +489,9 @@ struct tegra_xudc {
 	bool suspended;
 	bool powergated;
 
+	struct usb_phy *usbphy;
+	struct notifier_block vbus_nb;
+
 	struct completion disconnect_complete;
 
 	bool selfpowered;
@@ -669,6 +674,31 @@ static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
 		tegra_xudc_device_mode_off(xudc);
 }
 
+static int tegra_xudc_vbus_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct tegra_xudc *xudc = container_of(nb, struct tegra_xudc,
+					       vbus_nb);
+	struct usb_phy *usbphy = (struct usb_phy *)data;
+
+	dev_dbg(xudc->dev, "%s(): event is %d\n", __func__, usbphy->last_event);
+
+	if ((xudc->device_mode && usbphy->last_event == USB_EVENT_VBUS) ||
+	    (!xudc->device_mode && usbphy->last_event != USB_EVENT_VBUS)) {
+		dev_dbg(xudc->dev, "Same role(%d) received. Ignore",
+			xudc->device_mode);
+		return NOTIFY_OK;
+	}
+
+	xudc->device_mode = (usbphy->last_event == USB_EVENT_VBUS) ? true :
+								     false;
+
+	if (!xudc->suspended)
+		schedule_work(&xudc->usb_role_sw_work);
+
+	return NOTIFY_OK;
+}
+
 static void tegra_xudc_plc_reset_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -1937,6 +1967,9 @@ static int tegra_xudc_gadget_start(struct usb_gadget *gadget,
 		xudc_writel(xudc, val, CTRL);
 	}
 
+	if (xudc->usbphy)
+		otg_set_peripheral(xudc->usbphy->otg, gadget);
+
 	xudc->driver = driver;
 unlock:
 	dev_dbg(xudc->dev, "%s: ret value is %d", __func__, ret);
@@ -1957,6 +1990,9 @@ static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
 
 	spin_lock_irqsave(&xudc->lock, flags);
 
+	if (xudc->usbphy)
+		otg_set_peripheral(xudc->usbphy->otg, NULL);
+
 	val = xudc_readl(xudc, CTRL);
 	val &= ~(CTRL_IE | CTRL_ENABLE);
 	xudc_writel(xudc, val, CTRL);
@@ -3561,9 +3597,15 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
 				tegra_xudc_port_reset_war_work);
 
-	/* Set the mode as device mode and this keeps phy always ON */
-	xudc->device_mode = true;
-	schedule_work(&xudc->usb_role_sw_work);
+	xudc->vbus_nb.notifier_call = tegra_xudc_vbus_notify;
+	xudc->usbphy = devm_usb_get_phy_by_node(xudc->dev,
+						xudc->utmi_phy->dev.of_node,
+						&xudc->vbus_nb);
+	if (IS_ERR(xudc->usbphy)) {
+		err = PTR_ERR(xudc->usbphy);
+		dev_err(xudc->dev, "failed to get USB PHY: %d\n", err);
+		goto free_eps;
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.7.4

