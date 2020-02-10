Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20478C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F1521927
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lAH+8G2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBJINC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:13:02 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18259 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgBJINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:13:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41107d0001>; Mon, 10 Feb 2020 00:12:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:59 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:59 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:59 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110880001>; Mon, 10 Feb 2020 00:12:58 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 10/21] usb: gadget: tegra-xudc: Add usb-phy support
Date:   Mon, 10 Feb 2020 13:41:36 +0530
Message-ID: <1581322307-11140-11-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322365; bh=fM3ZAjPUPkY9CGZ1xeMcfY9eoH1/576Ng/4psDfAtjk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=lAH+8G2cLInkZY2vGi41FsrbwhCtv57O8Jbx2lGWXMjWg5PfYsbFmEMXZYAtKpG6+
         gB9R/8bac+UXihE1KyvfyKWXr1WiNs4J+lDf7pn+uGQ/xpZPsGD8HYepoPAQDMiiFX
         48i8mGZ3P/DYw8aoqQOtzP5zXS8FhEUMhG45ca/Ydfx+05Al+JbwIj6H/xafomwh8Q
         hnk2abgpIVXF/a4sxD1cul0sraBMphYQ6Ju4Pg5sG894FGSs/A8JaEoTsaIPlsHo0G
         9AoCKQ5PK/f0ikNo6eWS5SjehozLF6NsdV9eLsK/BvfJ9lgEk0GVjzIYF0jgrI0GC0
         eNOm7Uwihxr6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb-phy is used to get notified on the USB role changes. Get usb-phy from
the UTMI PHY.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V5:
 - No changes.
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

