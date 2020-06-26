Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B390C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E461F2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qXWgwZFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgFZKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:21:53 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10189 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgFZKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:19:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef5cb950000>; Fri, 26 Jun 2020 03:19:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 03:19:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 03:19:48 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 10:19:39 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 10:19:39 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef5cbb90000>; Fri, 26 Jun 2020 03:19:39 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH V4 4/7] phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
Date:   Fri, 26 Jun 2020 15:48:59 +0530
Message-ID: <1593166742-23592-5-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
References: <1593166742-23592-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593166742; bh=zlJZl+lxWaoU57emOOrEG/UQwWmQ0TgTIvCUaz6ATjU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qXWgwZFcjwjd2sOHCMqGuemg/wHYcf/FXvrutQ1P6c91smBkpVRkcBPPONl9p1bgf
         ZsWQrDPCvqffYfZaSH+KPSWpu9XdwrwFs3kjg29k3L9r0BPlfnZzb0D6jj69QaTrFZ
         yWGWVb3+Oxk0pvM45YxxTed4Hif4rZpJqaEUzMeHZAa4dXjICv1oAI0vvzaJu9rCrq
         ekvyhH+Bj0O8XpLp0j5LpbMz9ZoYDnt1XL0fTj35cXWdH857tx+4KhrgtvwG5dn2kZ
         lSyF+USdRicmYQSlI3voC9/Lu26GXWNkYZ5S7kLG1I84yVa3Be/9v+IAH+JJk+g8tA
         Q5/Sgdya8AmpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB charger is enabled, UTMI PAD needs to be protected according
to the direction and current level. Add support for the same on Tegra210
and Tegra186.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
 - Added Acked-by updates to commit message.
---
V3:
 - Alligned function and its arguments.
 - Fixed other comments from Thierry.
---
V2:
 - Commit message coorected.
 - Patch re-based.
---
 drivers/phy/tegra/xusb-tegra186.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c | 32 +++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h          | 13 +++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index f862254..59b78a7 100644
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
 
+static void
+tegra186_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
+					     int level,
+					     enum tegra_vbus_dir dir)
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
 static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
 					       bool status)
 {
@@ -935,6 +973,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.vbus_override = tegra186_xusb_padctl_vbus_override,
 	.utmi_pad_power_on = tegra_phy_xusb_utmi_pad_power_on,
 	.utmi_pad_power_down = tegra_phy_xusb_utmi_pad_power_down,
+	.utmi_pad_set_protection =
+			tegra186_xusb_padctl_utmi_pad_set_protection,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index caf0890..80c4349 100644
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
@@ -1116,6 +1118,34 @@ void tegra210_usb2_pad_power_down(struct phy *phy)
 	usb2->powered_on = false;
 }
 
+static void
+tegra210_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
+					     int level,
+					     enum tegra_vbus_dir dir)
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
@@ -2291,6 +2321,8 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
 	.utmi_port_reset = tegra210_utmi_port_reset,
 	.utmi_pad_power_on = tegra210_usb2_pad_power_on,
 	.utmi_pad_power_down = tegra210_usb2_pad_power_down,
+	.utmi_pad_set_protection =
+			tegra210_xusb_padctl_utmi_pad_set_protection,
 };
 
 static const char * const tegra210_xusb_padctl_supply_names[] = {
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 6995fc4..475bcc6 100644
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
+	void (*utmi_pad_set_protection)(struct tegra_xusb_port *port,
+					int level, enum tegra_vbus_dir dir);
 };
 
 struct tegra_xusb_padctl_soc {
-- 
2.7.4

