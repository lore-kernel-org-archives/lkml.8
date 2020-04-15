Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC9FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9441320775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F08F4ONV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894598AbgDOI3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:29:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11492 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894445AbgDOI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:27:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96c4f50000>; Wed, 15 Apr 2020 01:25:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 01:25:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 01:25:37 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 08:25:37 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Apr 2020 08:25:37 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e96c4fd0004>; Wed, 15 Apr 2020 01:25:36 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V2 5/8] phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
Date:   Wed, 15 Apr 2020 13:55:05 +0530
Message-ID: <1586939108-10075-6-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586939125; bh=3LNQ0SN38gsYKuB1+QCeNLaIcQ/aDK75/NBFEtXfl6c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=F08F4ONVTSzuzGJ5URMWePIEZ4XfIr0iRQAi+srQ5ZyO1x/dbacH43yjqebx6MMzQ
         4dTEShih+e7mj8YTnt54ZnGhFwWgzzj/0PvjAPX8M7nF9nN0U8I9HToJ5oUQN0LCm2
         gx/RdWUQCEDqHltW8ltNeIdtJgubDACoMtHiW2Y8LLMm8Nu/OtBcc0P06O1Z1930O1
         Y0PIrbagh4z1RBxMzxdM3LrxHCtp1GjjyO3lvBPh7W5qqxcOiGvlx2aHSQ3oCvv5b1
         DP5Ax/OC1lbPG+Hcvx8A9gnd85iSB2ThBkQ2lJRCTAPxWM+oPnUuXqdJE2Iif8N78Z
         HgZFnZVeCkclw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB charger is enabled, UTMI PAD needs to be protected according
to the direction and current level. Add support for the same on Tegra210
and Tegra186.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Commit message coorected.
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra186.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c | 31 ++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h          | 13 +++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index f862254..03bdb5b 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -68,6 +68,13 @@
 #define   PORTX_SPEED_SUPPORT_MASK		(0x3)
 #define     PORT_SPEED_SUPPORT_GEN1		(0x0)
 
+#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)       (0x84 + (x) * 0x40)
+#define  PD_VREG                                (1 << 6)
+#define  VREG_LEV(x)                            (((x) & 0x3) << 7)
+#define  VREG_DIR(x)                            (((x) & 0x3) << 11)
+#define  VREG_DIR_IN                            VREG_DIR(1)
+#define  VREG_DIR_OUT                           VREG_DIR(2)
+
 #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
 #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
 #define  TERM_SEL				BIT(25)
@@ -289,6 +296,37 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 	usb2->powered_on = false;
 }
 
+static void tegra186_xusb_padctl_utmi_pad_set_protection_level(
+				struct tegra_xusb_port *port, int level,
+				enum tegra_vbus_dir dir)
+{
+	u32 value;
+	struct tegra_xusb_padctl *padctl = port->padctl;
+	unsigned int index = port->index;
+
+	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
+
+	if (level < 0) {
+		/* disable pad protection */
+		value |= PD_VREG;
+		value &= ~VREG_LEV(~0);
+		value &= ~VREG_DIR(~0);
+	} else {
+		if (dir == TEGRA_VBUS_SOURCE)
+			value |= VREG_DIR_OUT;
+		else if (dir == TEGRA_VBUS_SINK)
+			value |= VREG_DIR_IN;
+
+		value &= ~PD_VREG;
+		value &= ~VREG_DIR(~0);
+		value &= ~VREG_LEV(~0);
+		value |= VREG_LEV(level);
+	}
+
+	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
+}
+
+
 static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
 					       bool status)
 {
@@ -935,6 +973,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.vbus_override = tegra186_xusb_padctl_vbus_override,
 	.utmi_pad_power_on = tegra_phy_xusb_utmi_pad_power_on,
 	.utmi_pad_power_down = tegra_phy_xusb_utmi_pad_power_down,
+	.utmi_pad_set_protection_level =
+			tegra186_xusb_padctl_utmi_pad_set_protection_level,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index caf0890..7d84f1a 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -74,6 +74,8 @@
 #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_MASK 0x3
 #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_VAL 0x1
 #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18 (1 << 6)
+#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(x) (((x) & 0x3) << 7)
+#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(x) (((x) & 0x3) << 11)
 
 #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x) (0x088 + (x) * 0x40)
 #define XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD_ZI (1 << 29)
@@ -1116,6 +1118,33 @@ void tegra210_usb2_pad_power_down(struct phy *phy)
 	usb2->powered_on = false;
 }
 
+static void tegra210_xusb_padctl_utmi_pad_set_protection_level(
+				struct tegra_xusb_port *port, int level,
+				enum tegra_vbus_dir dir)
+{
+	u32 value;
+	struct tegra_xusb_padctl *padctl = port->padctl;
+	unsigned int index = port->index;
+
+	value = padctl_readl(padctl,
+			     XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
+
+	if (level < 0) {
+		/* disable pad protection */
+		value |= XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
+		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
+		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
+	} else {
+		value &= ~XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
+		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
+		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
+		value |= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(level);
+	}
+
+	padctl_writel(padctl, value,
+		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
+}
+
 static int tegra210_usb2_phy_set_mode(struct phy *phy, enum phy_mode mode,
 				      int submode)
 {
@@ -2291,6 +2320,8 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
 	.utmi_port_reset = tegra210_utmi_port_reset,
 	.utmi_pad_power_on = tegra210_usb2_pad_power_on,
 	.utmi_pad_power_down = tegra210_usb2_pad_power_down,
+	.utmi_pad_set_protection_level =
+			tegra210_xusb_padctl_utmi_pad_set_protection_level,
 };
 
 static const char * const tegra210_xusb_padctl_supply_names[] = {
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 6995fc4..79e96b0 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -259,6 +259,17 @@ to_sata_pad(struct tegra_xusb_pad *pad)
  */
 struct tegra_xusb_port_ops;
 
+/*
+ * Tegra OTG port VBUS direction:
+ * default (based on port capability) or
+ * as source or sink
+ */
+enum tegra_vbus_dir {
+	TEGRA_VBUS_DEFAULT,
+	TEGRA_VBUS_SOURCE,
+	TEGRA_VBUS_SINK
+};
+
 struct tegra_xusb_port {
 	struct tegra_xusb_padctl *padctl;
 	struct tegra_xusb_lane *lane;
@@ -398,6 +409,8 @@ struct tegra_xusb_padctl_ops {
 	int (*utmi_port_reset)(struct phy *phy);
 	void (*utmi_pad_power_on)(struct phy *phy);
 	void (*utmi_pad_power_down)(struct phy *phy);
+	void (*utmi_pad_set_protection_level)(struct tegra_xusb_port *port,
+					int max_ua, enum tegra_vbus_dir dir);
 };
 
 struct tegra_xusb_padctl_soc {
-- 
2.7.4

