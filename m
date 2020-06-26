Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D21720EDD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jWTANmmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgFZKWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:22:01 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6124 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFZKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:19:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5cb630002>; Fri, 26 Jun 2020 03:18:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:19:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:19:46 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:19:36 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 10:19:36 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5cbb60000>; Fri, 26 Jun 2020 03:19:36 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V4 3/7] phy: tegra: xusb: Add USB2 pad power control support for Tegra210
Date:   Fri, 26 Jun 2020 15:48:58 +0530
Message-ID: <1593166742-23592-4-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
References: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593166691; bh=qcYXDQGYx54p7RNlEV6UUzbaDOLFDKbvPvSX/KwCTfw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jWTANmmPmzXYRkGpmq1jxgVyLsf42saSRsmudNst3Dtxp5wcJAJHMyopjL1LQxRz9
         Q7s8csf5mTa8mM0Y89925Tr+UoAXek8NoNTqOM+AerLIse7jvxMIJJ/zTWEDk5vjsx
         LPD06oIvlRKlNmnErAW6cTNvUefPRTVpEy8gIvy11NK1XW1Fd7mASFfP8Sxgm9LYjB
         L8/54Io4yskI9Yyb2Gj6vEA9ZTqTGUl3rVZr720km/UI10nmmp9i2+et8+h/DjmtNL
         vuB2DRb2A48YGqn9E2go0q1UIrzBJH4JOGy7CucNdPUfoifHgkeIWH1Mpjnb/Q6ZaG
         /BzCx5CJLSS5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB2 pad power on and off API's for TEgra210 and provide its control
via soc ops. It can be used by operations like charger detect to power on
and off USB2 pad if needed.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
 - No changes
---
V3:
 - Added Acked-by updates to commit message.
---
V2:
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra210.c | 190 ++++++++++++++++++++++++++------------
 1 file changed, 133 insertions(+), 57 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 66bd461..caf0890 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -994,6 +994,128 @@ static int tegra210_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
 	return 0;
 }
 
+static void tegra210_usb2_bias_pad_power_on(struct tegra_xusb_usb2_pad *pad)
+{
+	struct tegra_xusb_padctl *padctl = pad->base.padctl;
+	u32 value;
+
+	if (pad->enable++ > 0)
+		return;
+
+	dev_dbg(padctl->dev, "power on BIAS PAD & USB2 tracking\n");
+
+	if (clk_prepare_enable(pad->clk))
+		dev_warn(padctl->dev, "failed to enable BIAS PAD & USB2 tracking\n");
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
+	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
+		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
+		   (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_MASK <<
+		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT));
+	value |= (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_VAL <<
+		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
+		 (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_VAL <<
+		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT);
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
+	value &= ~XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
+
+	udelay(1);
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
+	value &= ~XUSB_PADCTL_USB2_BIAS_PAD_CTL1_PD_TRK;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
+
+	udelay(50);
+}
+
+static void tegra210_usb2_bias_pad_power_off(struct tegra_xusb_usb2_pad *pad)
+{
+	struct tegra_xusb_padctl *padctl = pad->base.padctl;
+	u32 value;
+
+	if (WARN_ON(pad->enable == 0))
+		return;
+
+	if (--pad->enable > 0)
+		return;
+
+	dev_dbg(padctl->dev, "power off USB2 tracking\n");
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
+	value |= XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
+
+	clk_disable_unprepare(pad->clk);
+}
+
+/* must be called under padctl->lock */
+void tegra210_usb2_pad_power_on(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(lane);
+	struct tegra_xusb_usb2_pad *pad = to_usb2_pad(lane->pad);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	unsigned int index = lane->index;
+	u32 value;
+
+	if (!phy)
+		return;
+
+	if (usb2->powered_on)
+		return;
+
+	dev_info(padctl->dev, "power on UTMI pads %d\n", index);
+
+	tegra210_usb2_bias_pad_power_on(pad);
+
+	udelay(2);
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+	value &= ~XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+	value &= ~XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	usb2->powered_on = true;
+}
+
+/* must be called under padctl->lock */
+void tegra210_usb2_pad_power_down(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(lane);
+	struct tegra_xusb_usb2_pad *pad = to_usb2_pad(lane->pad);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	unsigned int index = lane->index;
+	u32 value;
+
+	if (!phy)
+		return;
+
+	if (!usb2->powered_on)
+		return;
+
+	dev_info(padctl->dev, "power down UTMI pad %d\n", index);
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+	value |= XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+	value |= XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	udelay(2);
+
+	tegra210_usb2_bias_pad_power_off(pad);
+	usb2->powered_on = false;
+}
+
 static int tegra210_usb2_phy_set_mode(struct phy *phy, enum phy_mode mode,
 				      int submode)
 {
@@ -1037,7 +1159,6 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(lane);
-	struct tegra_xusb_usb2_pad *pad = to_usb2_pad(lane->pad);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
 	struct tegra210_xusb_padctl *priv;
 	struct tegra_xusb_usb2_port *port;
@@ -1053,6 +1174,8 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
 
 	priv = to_tegra210_xusb_padctl(padctl);
 
+	mutex_lock(&padctl->lock);
+
 	if (port->usb3_port_fake != -1) {
 		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
 		value &= ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(
@@ -1148,62 +1271,21 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
 
 	if (port->supply && port->mode == USB_DR_MODE_HOST) {
 		err = regulator_enable(port->supply);
-		if (err)
+		if (err) {
+			mutex_unlock(&padctl->lock);
 			return err;
+		}
 	}
 
-	mutex_lock(&padctl->lock);
-
-	if (pad->enable > 0) {
-		pad->enable++;
-		mutex_unlock(&padctl->lock);
-		return 0;
-	}
-
-	err = clk_prepare_enable(pad->clk);
-	if (err)
-		goto disable_regulator;
+	tegra210_usb2_pad_power_on(phy);
 
-	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
-	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
-		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
-		   (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_MASK <<
-		    XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT));
-	value |= (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_VAL <<
-		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT) |
-		 (XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_VAL <<
-		  XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_DONE_RESET_TIMER_SHIFT);
-	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
-
-	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
-	value &= ~XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
-	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
-
-	udelay(1);
-
-	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
-	value &= ~XUSB_PADCTL_USB2_BIAS_PAD_CTL1_PD_TRK;
-	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
-
-	udelay(50);
-
-	clk_disable_unprepare(pad->clk);
-
-	pad->enable++;
 	mutex_unlock(&padctl->lock);
-
 	return 0;
-
-disable_regulator:
-	regulator_disable(port->supply);
-	mutex_unlock(&padctl->lock);
-	return err;
 }
 
 static int tegra210_usb2_phy_power_off(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
-	struct tegra_xusb_usb2_pad *pad = to_usb2_pad(lane->pad);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
 	struct tegra_xusb_usb2_port *port;
 	u32 value;
@@ -1217,6 +1299,8 @@ static int tegra210_usb2_phy_power_off(struct phy *phy)
 
 	mutex_lock(&padctl->lock);
 
+	tegra210_usb2_pad_power_down(phy);
+
 	if (port->usb3_port_fake != -1) {
 		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
 		value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(
@@ -1243,18 +1327,8 @@ static int tegra210_usb2_phy_power_off(struct phy *phy)
 		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
 	}
 
-	if (WARN_ON(pad->enable == 0))
-		goto out;
-
-	if (--pad->enable > 0)
-		goto out;
-
-	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
-	value |= XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
-	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
-
-out:
 	regulator_disable(port->supply);
+
 	mutex_unlock(&padctl->lock);
 	return 0;
 }
@@ -2215,6 +2289,8 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
 	.hsic_set_idle = tegra210_hsic_set_idle,
 	.vbus_override = tegra210_xusb_padctl_vbus_override,
 	.utmi_port_reset = tegra210_utmi_port_reset,
+	.utmi_pad_power_on = tegra210_usb2_pad_power_on,
+	.utmi_pad_power_down = tegra210_usb2_pad_power_down,
 };
 
 static const char * const tegra210_xusb_padctl_supply_names[] = {
-- 
2.7.4

