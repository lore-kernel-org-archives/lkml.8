Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2343C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995462070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ovAuHFKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgENGXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:23:05 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17897 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgENGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:23:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebce37a0000>; Wed, 13 May 2020 23:21:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 23:23:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 May 2020 23:23:01 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 06:23:00 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 14 May 2020 06:23:00 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebce3c10001>; Wed, 13 May 2020 23:23:00 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V3 3/8] phy: tegra: xusb: Add support for UTMI pad power control
Date:   Thu, 14 May 2020 11:52:38 +0530
Message-ID: <1589437363-16727-4-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589437306; bh=pt1Z03Ax92LZtAPXWPgaCZNViEZJopyDIN0cKK5+IK0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ovAuHFKYxepNzcgmQhoK92UQ5kr+85HqyByIpGIprjUhR0YkOE3pYxKL1H5DMPYcT
         NbjcRikbCAYsVfWIAamUL6iedujOzw68nj2u7+GZLAAhMQrXIdRqTiABbCGILuShV3
         zkOHlGZgRR3BeGCiI5kci6vTUSYjGJRomCqgf93XaTBxqG3w0T5iq6/uyLSJcOlDPb
         UhMbqNdoIBSgfHQIr6GLJkixrxGlikj2odp5tiIS3RTHMQ7kz9b9ctmKpuK8kzZw9n
         wec+Yj1sZtsFx4NRTpUi6s+MldtbERttxJHZZY84DE7RcRHhij0ms7gMp8om6M0zlp
         TduNSjPjtdjYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for UTMI pad power on and off API's via soc ops. These API
can be used by operations like charger detect to power on and off UTMI
pad if needed. Update powered_on flag in the pad power control API's.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V3:
 - Added Acked-by updates to commit message.
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra186.c | 51 ++++++++++++++++++---------------------
 drivers/phy/tegra/xusb.h          |  2 ++
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 5d64f69..f862254 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -192,12 +192,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	u32 value;
 	int err;
 
-	mutex_lock(&padctl->lock);
-
-	if (priv->bias_pad_enable++ > 0) {
-		mutex_unlock(&padctl->lock);
+	if (priv->bias_pad_enable++ > 0)
 		return;
-	}
 
 	err = clk_prepare_enable(priv->usb2_trk_clk);
 	if (err < 0)
@@ -221,8 +217,6 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value &= ~USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
-
-	mutex_unlock(&padctl->lock);
 }
 
 static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
@@ -230,44 +224,29 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	u32 value;
 
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(priv->bias_pad_enable == 0)) {
-		mutex_unlock(&padctl->lock);
+	if (WARN_ON(priv->bias_pad_enable == 0))
 		return;
-	}
 
-	if (--priv->bias_pad_enable > 0) {
-		mutex_unlock(&padctl->lock);
+	if (--priv->bias_pad_enable > 0)
 		return;
-	}
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value |= USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
 	clk_disable_unprepare(priv->usb2_trk_clk);
-
-	mutex_unlock(&padctl->lock);
 }
 
 static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
-	struct tegra_xusb_usb2_port *port;
-	struct device *dev = padctl->dev;
+	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(lane);
 	unsigned int index = lane->index;
 	u32 value;
 
-	if (!phy)
-		return;
-
-	port = tegra_xusb_find_usb2_port(padctl, index);
-	if (!port) {
-		dev_err(dev, "no port found for USB2 lane %u\n", index);
+	if (!phy || usb2->powered_on)
 		return;
-	}
 
 	tegra186_utmi_bias_pad_power_on(padctl);
 
@@ -280,16 +259,19 @@ static void tegra_phy_xusb_utmi_pad_power_on(struct phy *phy)
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~USB2_OTG_PD_DR;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	usb2->powered_on = true;
 }
 
 static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(lane);
 	unsigned int index = lane->index;
 	u32 value;
 
-	if (!phy)
+	if (!phy || !usb2->powered_on)
 		return;
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
@@ -303,6 +285,8 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 	udelay(2);
 
 	tegra186_utmi_bias_pad_power_off(padctl);
+
+	usb2->powered_on = false;
 }
 
 static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
@@ -413,6 +397,8 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 		return -ENODEV;
 	}
 
+	mutex_lock(&padctl->lock);
+
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
 	value &= ~(USB2_PORT_MASK << USB2_PORT_SHIFT(index));
 	value |= (PORT_XUSB << USB2_PORT_SHIFT(index));
@@ -464,14 +450,23 @@ static int tegra186_utmi_phy_power_on(struct phy *phy)
 
 	/* TODO: pad power saving */
 	tegra_phy_xusb_utmi_pad_power_on(phy);
+
+	mutex_unlock(&padctl->lock);
 	return 0;
 }
 
 static int tegra186_utmi_phy_power_off(struct phy *phy)
 {
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+
+	mutex_lock(&padctl->lock);
+
 	/* TODO: pad power saving */
 	tegra_phy_xusb_utmi_pad_power_down(phy);
 
+	mutex_unlock(&padctl->lock);
+
 	return 0;
 }
 
@@ -938,6 +933,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.probe = tegra186_xusb_padctl_probe,
 	.remove = tegra186_xusb_padctl_remove,
 	.vbus_override = tegra186_xusb_padctl_vbus_override,
+	.utmi_pad_power_on = tegra_phy_xusb_utmi_pad_power_on,
+	.utmi_pad_power_down = tegra_phy_xusb_utmi_pad_power_down,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index ea35af7..6995fc4 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -396,6 +396,8 @@ struct tegra_xusb_padctl_ops {
 				    unsigned int index, bool enable);
 	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
 	int (*utmi_port_reset)(struct phy *phy);
+	void (*utmi_pad_power_on)(struct phy *phy);
+	void (*utmi_pad_power_down)(struct phy *phy);
 };
 
 struct tegra_xusb_padctl_soc {
-- 
2.7.4

