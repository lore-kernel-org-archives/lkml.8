Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C249C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CF821739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fmB8vTIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBJIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:12:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18218 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgBJIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:12:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4110720000>; Mon, 10 Feb 2020 00:12:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:12:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Feb 2020 00:12:48 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:12:47 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:12:47 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e41107c0001>; Mon, 10 Feb 2020 00:12:47 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 07/21] phy: tegra: xusb: Add set_mode support for UTMI phy on Tegra186
Date:   Mon, 10 Feb 2020 13:41:33 +0530
Message-ID: <1581322307-11140-8-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322354; bh=Y389Vbo0qSoZ7bEjswVj6WBVgDKXBxnfWfVQytx9TXQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fmB8vTIV47+KexiFUE1IeSs6EU1t97acpRtjWo2P4aej61nVuGGnicbbC2YoompI0
         TZCr9Y4Z381rx4X3u11EYZ6NcWAwZEXN06AsckYrDOCf0Dy+WPD3e5spXEt50bQsf0
         msxRoBqijJSi8ze58GVIwAacinr+TDueVOg3COFkLiPOIFWO4C3nxAuLvRfpj8NT6A
         btP6afPG6EBcJBZDeOFaHrWe8xbDyPuuZ2KwSMBkAhwWItB0+GoOrjHlfAoOHuc2vO
         LeG+ouGH9i9SNTvsrlok68JMhjKGo02UrjGlYGo98Z4syC+hVbOSRtXDT8AioXPVC2
         XduJNL+wKPD1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for set_mode on UTMI phy. This allow XUSB host/device mode
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
 drivers/phy/tegra/xusb-tegra186.c | 114 ++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 84c2739..ea62251 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -301,6 +301,97 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 	tegra186_utmi_bias_pad_power_off(padctl);
 }
 
+static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
+					       bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, USB2_VBUS_ID);
+
+	if (status) {
+		value |= VBUS_OVERRIDE;
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_FLOATING;
+	} else {
+		value &= ~VBUS_OVERRIDE;
+	}
+
+	padctl_writel(padctl, value, USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
+					    bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, USB2_VBUS_ID);
+
+	if (status) {
+		if (value & VBUS_OVERRIDE) {
+			value &= ~VBUS_OVERRIDE;
+			padctl_writel(padctl, value, USB2_VBUS_ID);
+			usleep_range(1000, 2000);
+
+			value = padctl_readl(padctl, USB2_VBUS_ID);
+		}
+
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_GROUNDED;
+	} else {
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_FLOATING;
+	}
+
+	padctl_writel(padctl, value, USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra186_utmi_phy_set_mode(struct phy *phy, enum phy_mode mode,
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
+			tegra186_xusb_padctl_id_override(padctl, true);
+
+			err = regulator_enable(port->supply);
+		} else if (submode == USB_ROLE_DEVICE) {
+			tegra186_xusb_padctl_vbus_override(padctl, true);
+		} else if (submode == USB_ROLE_NONE) {
+			/*
+			 * When port is peripheral only or role transitions to
+			 * USB_ROLE_NONE from USB_ROLE_DEVICE, regulator is not
+			 * enabled.
+			 */
+			if (regulator_is_enabled(port->supply))
+				regulator_disable(port->supply);
+
+			tegra186_xusb_padctl_id_override(padctl, false);
+			tegra186_xusb_padctl_vbus_override(padctl, false);
+		}
+	}
+
+	mutex_unlock(&padctl->lock);
+
+	return err;
+}
+
 static int tegra186_utmi_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
@@ -439,6 +530,7 @@ static const struct phy_ops utmi_phy_ops = {
 	.exit = tegra186_utmi_phy_exit,
 	.power_on = tegra186_utmi_phy_power_on,
 	.power_off = tegra186_utmi_phy_power_off,
+	.set_mode = tegra186_utmi_phy_set_mode,
 	.owner = THIS_MODULE,
 };
 
@@ -857,28 +949,6 @@ static void tegra186_xusb_padctl_remove(struct tegra_xusb_padctl *padctl)
 {
 }
 
-static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
-					       bool status)
-{
-	u32 value;
-
-	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
-
-	value = padctl_readl(padctl, USB2_VBUS_ID);
-
-	if (status) {
-		value |= VBUS_OVERRIDE;
-		value &= ~ID_OVERRIDE(~0);
-		value |= ID_OVERRIDE_FLOATING;
-	} else {
-		value &= ~VBUS_OVERRIDE;
-	}
-
-	padctl_writel(padctl, value, USB2_VBUS_ID);
-
-	return 0;
-}
-
 static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.probe = tegra186_xusb_padctl_probe,
 	.remove = tegra186_xusb_padctl_remove,
-- 
2.7.4

