Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B2DC3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412DF2465D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YPYSbhgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBJIMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:12:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18207 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBJIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41106e0001>; Mon, 10 Feb 2020 00:12:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:44 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110780001>; Mon, 10 Feb 2020 00:12:43 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 06/21] phy: tegra: xusb: Add set_mode support for USB 2 phy on Tegra210
Date:   Mon, 10 Feb 2020 13:41:32 +0530
Message-ID: <1581322307-11140-7-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322350; bh=XodaTLC2VSUtO4PzxYzekka/lD0xigZ8PFJGJP2uRos=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YPYSbhgZ51pqR3ZE43fV70bcNe56pUZCrgXIIbw1+xXCY/EizAQJ/7c9yFOL8CqzK
         r8Uoueq2tNR0t0gL6j1E3pC5uLn+QXsS1EXoLgmFVKzEXNKxx12spEMYy1KyWR8a23
         Io3olTF5LkFqvtk5to6YoieOi1aJT2CUF+BkNKXeS9LiAk4eWyxh/knS3bTUJSQ2BW
         ZH/cxE1ORtIQGzece6V5vIhbEvfjOHQipe2Fdu9pS8n4Blxb9/+qjvCfS5Y2mDX4rc
         MVte5RpmfhZGTqGUPUw6oEPO4XPnjlgazwgUGeeY9ynhBuEbnGOYSbCGImcTf6Qz0J
         RH6kuYiJgiS8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for set_mode on USB 2 phy. This allow XUSB host/device mode
drivers to configure the hardware to corresponding modes.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V5:
 - No changes.
---
V4:
 - Added comment for conditional regulator disable.
 - Added Acked-by info.
---
V2-V3:
 - No changes in this version
---
 drivers/phy/tegra/xusb-tegra210.c | 131 ++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 27 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 394913b..54d6826 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -236,6 +236,7 @@
 #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT 18
 #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_MASK 0xf
 #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING 8
+#define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_GROUNDED 0
 
 struct tegra210_xusb_fuse_calibration {
 	u32 hs_curr_level[4];
@@ -935,6 +936,103 @@ static int tegra210_usb2_phy_exit(struct phy *phy)
 	return tegra210_xusb_padctl_disable(lane->pad->padctl);
 }
 
+static int tegra210_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
+					      bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_VBUS_ID);
+
+	if (status) {
+		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON;
+		value &= ~(XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_MASK <<
+			   XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT);
+		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING <<
+			 XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT;
+	} else {
+		value &= ~XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON;
+	}
+
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra210_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
+					    bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_VBUS_ID);
+
+	if (status) {
+		if (value & XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON) {
+			value &= ~XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON;
+			padctl_writel(padctl, value, XUSB_PADCTL_USB2_VBUS_ID);
+			usleep_range(1000, 2000);
+
+			value = padctl_readl(padctl, XUSB_PADCTL_USB2_VBUS_ID);
+		}
+
+		value &= ~(XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_MASK <<
+			   XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT);
+		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_GROUNDED <<
+			 XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT;
+	} else {
+		value &= ~(XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_MASK <<
+			   XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT);
+		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING <<
+			 XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT;
+	}
+
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra210_usb2_phy_set_mode(struct phy *phy, enum phy_mode mode,
+				      int submode)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra_xusb_usb2_port *port = tegra_xusb_find_usb2_port(padctl,
+								lane->index);
+	int err = 0;
+
+	mutex_lock(&padctl->lock);
+
+	dev_dbg(&port->base.dev, "%s: mode %d", __func__, mode);
+
+	if (mode == PHY_MODE_USB_OTG) {
+		if (submode == USB_ROLE_HOST) {
+			tegra210_xusb_padctl_id_override(padctl, true);
+
+			err = regulator_enable(port->supply);
+		} else if (submode == USB_ROLE_DEVICE) {
+			tegra210_xusb_padctl_vbus_override(padctl, true);
+		} else if (submode == USB_ROLE_NONE) {
+			/*
+			 * When port is peripheral only or role transitions to
+			 * USB_ROLE_NONE from USB_ROLE_DEVICE, regulator is not
+			 * be enabled.
+			 */
+			if (regulator_is_enabled(port->supply))
+				regulator_disable(port->supply);
+
+			tegra210_xusb_padctl_id_override(padctl, false);
+			tegra210_xusb_padctl_vbus_override(padctl, false);
+		}
+	}
+
+	mutex_unlock(&padctl->lock);
+
+	return err;
+}
+
 static int tegra210_usb2_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
@@ -1048,9 +1146,11 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
 	padctl_writel(padctl, value,
 		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
 
-	err = regulator_enable(port->supply);
-	if (err)
-		return err;
+	if (port->supply && port->mode == USB_DR_MODE_HOST) {
+		err = regulator_enable(port->supply);
+		if (err)
+			return err;
+	}
 
 	mutex_lock(&padctl->lock);
 
@@ -1164,6 +1264,7 @@ static const struct phy_ops tegra210_usb2_phy_ops = {
 	.exit = tegra210_usb2_phy_exit,
 	.power_on = tegra210_usb2_phy_power_on,
 	.power_off = tegra210_usb2_phy_power_off,
+	.set_mode = tegra210_usb2_phy_set_mode,
 	.owner = THIS_MODULE,
 };
 
@@ -2023,30 +2124,6 @@ static const struct tegra_xusb_port_ops tegra210_usb3_port_ops = {
 	.map = tegra210_usb3_port_map,
 };
 
-static int tegra210_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
-					      bool status)
-{
-	u32 value;
-
-	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
-
-	value = padctl_readl(padctl, XUSB_PADCTL_USB2_VBUS_ID);
-
-	if (status) {
-		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON;
-		value &= ~(XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_MASK <<
-			   XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT);
-		value |= XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING <<
-			 XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_SHIFT;
-	} else {
-		value &= ~XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_VBUS_ON;
-	}
-
-	padctl_writel(padctl, value, XUSB_PADCTL_USB2_VBUS_ID);
-
-	return 0;
-}
-
 static int tegra210_utmi_port_reset(struct phy *phy)
 {
 	struct tegra_xusb_padctl *padctl;
-- 
2.7.4

