Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24640C2BC0E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACF7206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GQhnO+Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHaEll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9152 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgHaEk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7f3d0002>; Sun, 30 Aug 2020 21:40:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 30 Aug 2020 21:40:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:39 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:39 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f440007>; Sun, 30 Aug 2020 21:40:38 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 03/12] phy: tegra: xusb: t210: rearrange UPHY init
Date:   Mon, 31 Aug 2020 12:40:34 +0800
Message-ID: <20200831044043.1561074-4-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848829; bh=SbPcZHGRrpE1MJENt35PnADf34qhDAwdMO8m9S9O5oI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=GQhnO+Fmg4L6sA4KdC5NHNrJLZxcD32jrHIDLBHbDs/7HPTdpIC3I+8c5PvAmLKA4
         v0jlng5CadeTXmMm0Bxr1975vVOIxksfvpU2wT7QJTNBlKMKbf0iBr1PiYQyICgL9E
         KgfpE2T/SwsIUjVVKyPHvJv+ZsTf52EJEUGNNo9spBEkDba+6CvnGr3WPzBnPuwJW6
         rYRw4T8Fs+ME4sUVEK/Q73OAXAFpi2jC7EcPWkdECmjzFKaDARjttJWV3tkoZlo7z3
         AxPvsR+c6RuxJDHvAKXhUR5rFT2DzD0AqI5Kqt6JOV8+0nj8pfSGPE4GdZsjzEurL2
         EsqavuE+gu/1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is a preparation for enabling XUSB SC7 support.
It rearranges Tegra210 XUSB PADCTL UPHY initialization sequence,
for the following reasons:

1. PLLE hardware power sequencer has to be enabled only after both
   PEX UPHY PLL and SATA UPHY PLL are initialized.
   tegra210_uphy_init() -> tegra210_pex_uphy_enable()
                        -> tegra210_sata_uphy_enable()
                        -> tegra210_plle_hw_sequence_start()
                        -> tegra210_aux_mux_lp0_clamp_disable()

2. Once UPHY PLL hardware power sequencer is enabled, do not assert
   reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be
   broken.
   reset_control_assert(pcie->rst) and reset_control_assert(sata->rst)
   are removed from PEX/SATA UPHY disable procedure.

3. At cold boot and SC7 exit, the following bits must be cleared after
   PEX/SATA lanes are out of IDDQ (IDDQ_DISABLE=3D1).
   a. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN,
   b. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN_EARLY
   c. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN

   tegra210_pex_uphy_enable() and tegra210_sata_uphy_enable() are in
   charge of bringing lanes out of IDDQ, and then AUX_MUX_LP0_* bits
   will be cleared by tegra210_aux_mux_lp0_clamp_disable().

4. The programming sequence in tegra210_usb3_port_enable() is required
   for both cold boot and SC7 exit, and must be performed only after
   PEX/SATA UPHY is initialized. Therefore, this commit moves the
   programming sequence to .power_on() stub which is invoked after
   .init(). PEX/SATA UPHY is initialzied in .init().

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 495 ++++++++++++++++--------------
 drivers/phy/tegra/xusb.c          |   2 +-
 drivers/phy/tegra/xusb.h          |   6 +-
 3 files changed, 270 insertions(+), 233 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index 66bd4613835b..3a2d9797fb9f 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -256,23 +256,52 @@ to_tegra210_xusb_padctl(struct tegra_xusb_padctl *pad=
ctl)
 	return container_of(padctl, struct tegra210_xusb_padctl, base);
 }
=20
+static const struct tegra_xusb_lane_map tegra210_usb3_map[] =3D {
+	{ 0, "pcie", 6 },
+	{ 1, "pcie", 5 },
+	{ 2, "pcie", 0 },
+	{ 2, "pcie", 3 },
+	{ 3, "pcie", 4 },
+	{ 3, "pcie", 4 },
+	{ 0, NULL,   0 }
+};
+
+static int tegra210_usb3_lane_map(struct tegra_xusb_lane *lane)
+{
+	const struct tegra_xusb_lane_map *map;
+
+	for (map =3D tegra210_usb3_map; map->type; map++) {
+		if (map->index =3D=3D lane->index &&
+		    strcmp(map->type, lane->pad->soc->name) =3D=3D 0) {
+			dev_dbg(lane->pad->padctl->dev,
+				"lane =3D %s map to port =3D usb3-%d\n",
+				lane->pad->soc->lanes[lane->index].name,
+				map->port);
+			return map->port;
+		}
+	}
+
+	return -EINVAL;
+}
+
 /* must be called under padctl->lock */
 static int tegra210_pex_uphy_enable(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_pcie_pad *pcie =3D to_pcie_pad(padctl->pcie);
 	unsigned long timeout;
 	u32 value;
-	int err;
+	int err, i;
=20
-	if (pcie->enable > 0) {
-		pcie->enable++;
+	if (pcie->enable)
 		return 0;
-	}
=20
 	err =3D clk_prepare_enable(pcie->pll);
 	if (err < 0)
 		return err;
=20
+	if (tegra210_plle_hw_sequence_is_enabled())
+		goto skip_pll_init;
+
 	err =3D reset_control_deassert(pcie->rst);
 	if (err < 0)
 		goto disable;
@@ -455,7 +484,14 @@ static int tegra210_pex_uphy_enable(struct tegra_xusb_=
padctl *padctl)
=20
 	tegra210_xusb_pll_hw_sequence_start();
=20
-	pcie->enable++;
+skip_pll_init:
+	pcie->enable =3D true;
+
+	for (i =3D 0; i < padctl->pcie->soc->num_lanes; i++) {
+		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
+		value |=3D XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
+		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	}
=20
 	return 0;
=20
@@ -469,34 +505,42 @@ static int tegra210_pex_uphy_enable(struct tegra_xusb=
_padctl *padctl)
 static void tegra210_pex_uphy_disable(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_pcie_pad *pcie =3D to_pcie_pad(padctl->pcie);
+	u32 value;
+	int i;
=20
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(pcie->enable =3D=3D 0))
-		goto unlock;
+	if (WARN_ON(!pcie->enable))
+		return;
=20
-	if (--pcie->enable > 0)
-		goto unlock;
+	pcie->enable =3D false;
=20
-	reset_control_assert(pcie->rst);
+	for (i =3D 0; i < padctl->pcie->soc->num_lanes; i++) {
+		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
+		value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
+		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	}
 	clk_disable_unprepare(pcie->pll);
-
-unlock:
-	mutex_unlock(&padctl->lock);
 }
=20
 /* must be called under padctl->lock */
-static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl, boo=
l usb)
+static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_sata_pad *sata =3D to_sata_pad(padctl->sata);
+	struct tegra_xusb_lane *lane =3D tegra_xusb_find_lane(padctl, "sata", 0);
 	unsigned long timeout;
 	u32 value;
-	int err;
+	int err, i;
+	bool usb;
=20
-	if (sata->enable > 0) {
-		sata->enable++;
+	if (sata->enable)
 		return 0;
-	}
+
+	if (!lane)
+		return 0;
+
+	if (tegra210_plle_hw_sequence_is_enabled())
+		goto skip_pll_init;
+
+	usb =3D tegra_xusb_lane_check(lane, "usb3-ss");
=20
 	err =3D clk_prepare_enable(sata->pll);
 	if (err < 0)
@@ -697,7 +741,14 @@ static int tegra210_sata_uphy_enable(struct tegra_xusb=
_padctl *padctl, bool usb)
=20
 	tegra210_sata_pll_hw_sequence_start();
=20
-	sata->enable++;
+skip_pll_init:
+	sata->enable =3D true;
+
+	for (i =3D 0; i < padctl->sata->soc->num_lanes; i++) {
+		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
+		value |=3D XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
+		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	}
=20
 	return 0;
=20
@@ -711,31 +762,26 @@ static int tegra210_sata_uphy_enable(struct tegra_xus=
b_padctl *padctl, bool usb)
 static void tegra210_sata_uphy_disable(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_sata_pad *sata =3D to_sata_pad(padctl->sata);
+	u32 value;
+	int i;
=20
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(sata->enable =3D=3D 0))
-		goto unlock;
+	if (WARN_ON(!sata->enable))
+		return;
=20
-	if (--sata->enable > 0)
-		goto unlock;
+	sata->enable =3D false;
=20
-	reset_control_assert(sata->rst);
+	for (i =3D 0; i < padctl->sata->soc->num_lanes; i++) {
+		value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
+		value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
+		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	}
 	clk_disable_unprepare(sata->pll);
-
-unlock:
-	mutex_unlock(&padctl->lock);
 }
=20
-static int tegra210_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
+static void tegra210_aux_mux_lp0_clamp_disable(struct tegra_xusb_padctl *p=
adctl)
 {
 	u32 value;
=20
-	mutex_lock(&padctl->lock);
-
-	if (padctl->enable++ > 0)
-		goto out;
-
 	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
 	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
@@ -751,24 +797,12 @@ static int tegra210_xusb_padctl_enable(struct tegra_x=
usb_padctl *padctl)
 	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
 	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-out:
-	mutex_unlock(&padctl->lock);
-	return 0;
 }
=20
-static int tegra210_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
+static void tegra210_aux_mux_lp0_clamp_enable(struct tegra_xusb_padctl *pa=
dctl)
 {
 	u32 value;
=20
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(padctl->enable =3D=3D 0))
-		goto out;
-
-	if (--padctl->enable > 0)
-		goto out;
-
 	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
 	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
@@ -784,12 +818,36 @@ static int tegra210_xusb_padctl_disable(struct tegra_=
xusb_padctl *padctl)
 	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
 	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+}
+
+static int tegra210_uphy_init(struct tegra_xusb_padctl *padctl)
+{
+	if (padctl->pcie)
+		tegra210_pex_uphy_enable(padctl);
+	if (padctl->sata)
+		tegra210_sata_uphy_enable(padctl);
+
+	if (!tegra210_plle_hw_sequence_is_enabled())
+		tegra210_plle_hw_sequence_start();
+	else
+		dev_dbg(padctl->dev, "PLLE is already in HW control\n");
+
+	tegra210_aux_mux_lp0_clamp_disable(padctl);
=20
-out:
-	mutex_unlock(&padctl->lock);
 	return 0;
 }
=20
+static void __maybe_unused
+tegra210_uphy_deinit(struct tegra_xusb_padctl *padctl)
+{
+	tegra210_aux_mux_lp0_clamp_enable(padctl);
+
+	if (padctl->pcie)
+		tegra210_pex_uphy_disable(padctl);
+	if (padctl->sata)
+		tegra210_sata_uphy_disable(padctl);
+}
+
 static int tegra210_hsic_set_idle(struct tegra_xusb_padctl *padctl,
 				  unsigned int index, bool idle)
 {
@@ -926,14 +984,12 @@ static int tegra210_usb2_phy_init(struct phy *phy)
 		 XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PAD_MUX);
=20
-	return tegra210_xusb_padctl_enable(padctl);
+	return 0;
 }
=20
 static int tegra210_usb2_phy_exit(struct phy *phy)
 {
-	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
-
-	return tegra210_xusb_padctl_disable(lane->pad->padctl);
+	return 0;
 }
=20
 static int tegra210_xusb_padctl_vbus_override(struct tegra_xusb_padctl *pa=
dctl,
@@ -1391,14 +1447,12 @@ static int tegra210_hsic_phy_init(struct phy *phy)
 		 XUSB_PADCTL_USB2_PAD_MUX_HSIC_PAD_TRK_SHIFT;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PAD_MUX);
=20
-	return tegra210_xusb_padctl_enable(padctl);
+	return 0;
 }
=20
 static int tegra210_hsic_phy_exit(struct phy *phy)
 {
-	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
-
-	return tegra210_xusb_padctl_disable(lane->pad->padctl);
+	return 0;
 }
=20
 static int tegra210_hsic_phy_power_on(struct phy *phy)
@@ -1599,6 +1653,128 @@ static const struct tegra_xusb_lane_soc tegra210_pc=
ie_lanes[] =3D {
 	TEGRA210_LANE("pcie-6", 0x028, 24, 0x3, pcie),
 };
=20
+static struct tegra_xusb_usb3_port *
+tegra210_lane_to_usb3_port(struct tegra_xusb_lane *lane)
+{
+	int port;
+
+	if (!lane || !lane->pad || !lane->pad->padctl)
+		return NULL;
+
+	port =3D tegra210_usb3_lane_map(lane);
+	if (port < 0)
+		return NULL;
+
+	return tegra_xusb_find_usb3_port(lane->pad->padctl, port);
+}
+
+static int tegra210_usb3_phy_power_on(struct phy *phy)
+{
+	struct device *dev =3D &phy->dev;
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra_xusb_usb3_port *usb3 =3D tegra210_lane_to_usb3_port(lane);
+	unsigned int index;
+	u32 value;
+
+	if (!usb3) {
+		dev_err(dev, "no USB3 port found for lane %u\n", lane->index);
+		return -ENODEV;
+	}
+
+	index =3D usb3->base.index;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+
+	if (!usb3->internal)
+		value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_INTERNAL(index);
+	else
+		value |=3D XUSB_PADCTL_SS_PORT_MAP_PORTX_INTERNAL(index);
+
+	value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(index);
+	value |=3D XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(index, usb3->port);
+	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(index));
+	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_MASK <<
+		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT);
+	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_VAL <<
+		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT;
+	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(index));
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL2(index));
+	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_MASK <<
+		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_SHIFT);
+	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_VAL <<
+		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_SHIFT;
+	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL2(index));
+
+	padctl_writel(padctl, XUSB_PADCTL_UPHY_USB3_PAD_ECTL3_RX_DFE_VAL,
+		      XUSB_PADCTL_UPHY_USB3_PADX_ECTL3(index));
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL4(index));
+	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_MASK <<
+		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_SHIFT);
+	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_VAL <<
+		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_SHIFT;
+	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL4(index));
+
+	padctl_writel(padctl, XUSB_PADCTL_UPHY_USB3_PAD_ECTL6_RX_EQ_CTRL_H_VAL,
+		      XUSB_PADCTL_UPHY_USB3_PADX_ECTL6(index));
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	return 0;
+}
+
+static int tegra210_usb3_phy_power_off(struct phy *phy)
+{
+	struct device *dev =3D &phy->dev;
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra_xusb_usb3_port *usb3 =3D tegra210_lane_to_usb3_port(lane);
+	unsigned int index;
+	u32 value;
+
+	if (!usb3) {
+		dev_err(dev, "no USB3 port found for lane %u\n", lane->index);
+		return -ENODEV;
+	}
+
+	index =3D usb3->base.index;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(250, 350);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	return 0;
+}
 static struct tegra_xusb_lane *
 tegra210_pcie_lane_probe(struct tegra_xusb_pad *pad, struct device_node *n=
p,
 			 unsigned int index)
@@ -1640,35 +1816,28 @@ static const struct tegra_xusb_lane_ops tegra210_pc=
ie_lane_ops =3D {
 static int tegra210_pcie_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
=20
-	return tegra210_xusb_padctl_enable(lane->pad->padctl);
-}
+	mutex_lock(&padctl->lock);
=20
-static int tegra210_pcie_phy_exit(struct phy *phy)
-{
-	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	tegra210_uphy_init(padctl);
=20
-	return tegra210_xusb_padctl_disable(lane->pad->padctl);
+	mutex_unlock(&padctl->lock);
+
+	return 0;
 }
=20
 static int tegra210_pcie_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
-	u32 value;
-	int err;
+	int err =3D 0;
=20
 	mutex_lock(&padctl->lock);
=20
-	err =3D tegra210_pex_uphy_enable(padctl);
-	if (err < 0)
-		goto unlock;
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
-	value |=3D XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(lane->index);
-	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_on(phy);
=20
-unlock:
 	mutex_unlock(&padctl->lock);
 	return err;
 }
@@ -1677,20 +1846,19 @@ static int tegra210_pcie_phy_power_off(struct phy *=
phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
-	u32 value;
+	int err =3D 0;
=20
-	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
-	value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(lane->index);
-	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	mutex_lock(&padctl->lock);
=20
-	tegra210_pex_uphy_disable(padctl);
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_off(phy);
=20
-	return 0;
+	mutex_unlock(&padctl->lock);
+	return err;
 }
=20
 static const struct phy_ops tegra210_pcie_phy_ops =3D {
 	.init =3D tegra210_pcie_phy_init,
-	.exit =3D tegra210_pcie_phy_exit,
 	.power_on =3D tegra210_pcie_phy_power_on,
 	.power_off =3D tegra210_pcie_phy_power_off,
 	.owner =3D THIS_MODULE,
@@ -1811,35 +1979,27 @@ static const struct tegra_xusb_lane_ops tegra210_sa=
ta_lane_ops =3D {
 static int tegra210_sata_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
=20
-	return tegra210_xusb_padctl_enable(lane->pad->padctl);
-}
+	mutex_lock(&padctl->lock);
=20
-static int tegra210_sata_phy_exit(struct phy *phy)
-{
-	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	tegra210_uphy_init(padctl);
=20
-	return tegra210_xusb_padctl_disable(lane->pad->padctl);
+	mutex_unlock(&padctl->lock);
+	return 0;
 }
=20
 static int tegra210_sata_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
-	u32 value;
-	int err;
+	int err =3D 0;
=20
 	mutex_lock(&padctl->lock);
=20
-	err =3D tegra210_sata_uphy_enable(padctl, false);
-	if (err < 0)
-		goto unlock;
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
-	value |=3D XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(lane->index);
-	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_on(phy);
=20
-unlock:
 	mutex_unlock(&padctl->lock);
 	return err;
 }
@@ -1848,20 +2008,19 @@ static int tegra210_sata_phy_power_off(struct phy *=
phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
-	u32 value;
+	int err =3D 0;
=20
-	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
-	value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(lane->index);
-	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
+	mutex_lock(&padctl->lock);
=20
-	tegra210_sata_uphy_disable(lane->pad->padctl);
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_off(phy);
=20
-	return 0;
+	mutex_unlock(&padctl->lock);
+	return err;
 }
=20
 static const struct phy_ops tegra210_sata_phy_ops =3D {
 	.init =3D tegra210_sata_phy_init,
-	.exit =3D tegra210_sata_phy_exit,
 	.power_on =3D tegra210_sata_phy_power_on,
 	.power_off =3D tegra210_sata_phy_power_off,
 	.owner =3D THIS_MODULE,
@@ -1984,137 +2143,13 @@ static const struct tegra_xusb_port_ops tegra210_h=
sic_port_ops =3D {
=20
 static int tegra210_usb3_port_enable(struct tegra_xusb_port *port)
 {
-	struct tegra_xusb_usb3_port *usb3 =3D to_usb3_port(port);
-	struct tegra_xusb_padctl *padctl =3D port->padctl;
-	struct tegra_xusb_lane *lane =3D usb3->base.lane;
-	unsigned int index =3D port->index;
-	u32 value;
-	int err;
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
-
-	if (!usb3->internal)
-		value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_INTERNAL(index);
-	else
-		value |=3D XUSB_PADCTL_SS_PORT_MAP_PORTX_INTERNAL(index);
-
-	value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(index);
-	value |=3D XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(index, usb3->port);
-	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
-
-	/*
-	 * TODO: move this code into the PCIe/SATA PHY ->power_on() callbacks
-	 * and conditionalize based on mux function? This seems to work, but
-	 * might not be the exact proper sequence.
-	 */
-	err =3D regulator_enable(usb3->supply);
-	if (err < 0)
-		return err;
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(index));
-	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_MASK <<
-		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT);
-	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_VAL <<
-		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT;
-	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(index));
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL2(index));
-	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_MASK <<
-		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_SHIFT);
-	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_VAL <<
-		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL2_RX_CTLE_SHIFT;
-	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL2(index));
-
-	padctl_writel(padctl, XUSB_PADCTL_UPHY_USB3_PAD_ECTL3_RX_DFE_VAL,
-		      XUSB_PADCTL_UPHY_USB3_PADX_ECTL3(index));
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_UPHY_USB3_PADX_ECTL4(index));
-	value &=3D ~(XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_MASK <<
-		   XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_SHIFT);
-	value |=3D XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_VAL <<
-		 XUSB_PADCTL_UPHY_USB3_PAD_ECTL4_RX_CDR_CTRL_SHIFT;
-	padctl_writel(padctl, value, XUSB_PADCTL_UPHY_USB3_PADX_ECTL4(index));
-
-	padctl_writel(padctl, XUSB_PADCTL_UPHY_USB3_PAD_ECTL6_RX_EQ_CTRL_H_VAL,
-		      XUSB_PADCTL_UPHY_USB3_PADX_ECTL6(index));
-
-	if (lane->pad =3D=3D padctl->sata)
-		err =3D tegra210_sata_uphy_enable(padctl, true);
-	else
-		err =3D tegra210_pex_uphy_enable(padctl);
-
-	if (err) {
-		dev_err(&port->dev, "%s: failed to enable UPHY: %d\n",
-			__func__, err);
-		return err;
-	}
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-	usleep_range(100, 200);
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-	usleep_range(100, 200);
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
 	return 0;
 }
=20
 static void tegra210_usb3_port_disable(struct tegra_xusb_port *port)
 {
-	struct tegra_xusb_usb3_port *usb3 =3D to_usb3_port(port);
-	struct tegra_xusb_padctl *padctl =3D port->padctl;
-	struct tegra_xusb_lane *lane =3D port->lane;
-	unsigned int index =3D port->index;
-	u32 value;
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-	usleep_range(100, 200);
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-	usleep_range(250, 350);
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
-	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(index);
-	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
-
-	if (lane->pad =3D=3D padctl->sata)
-		tegra210_sata_uphy_disable(padctl);
-	else
-		tegra210_pex_uphy_disable(padctl);
-
-	regulator_disable(usb3->supply);
-
-	value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
-	value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(index);
-	value |=3D XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(index, 0x7);
-	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
 }
=20
-static const struct tegra_xusb_lane_map tegra210_usb3_map[] =3D {
-	{ 0, "pcie", 6 },
-	{ 1, "pcie", 5 },
-	{ 2, "pcie", 0 },
-	{ 2, "pcie", 3 },
-	{ 3, "pcie", 4 },
-	{ 3, "pcie", 4 },
-	{ 0, NULL,   0 }
-};
-
 static struct tegra_xusb_lane *
 tegra210_usb3_port_map(struct tegra_xusb_port *port)
 {
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index de4a46fe1763..b48b590aa0c1 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -376,7 +376,7 @@ static int tegra_xusb_setup_pads(struct tegra_xusb_padc=
tl *padctl)
 	return 0;
 }
=20
-static bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane,
+bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane,
 				  const char *function)
 {
 	const char *func =3D lane->soc->funcs[lane->function];
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index ea35af747066..0c828694cf2d 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -128,6 +128,8 @@ struct tegra_xusb_lane_ops {
 	void (*remove)(struct tegra_xusb_lane *lane);
 };
=20
+bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane, const char *funct=
ion);
+
 /*
  * pads
  */
@@ -230,7 +232,7 @@ struct tegra_xusb_pcie_pad {
 	struct reset_control *rst;
 	struct clk *pll;
=20
-	unsigned int enable;
+	bool enable;
 };
=20
 static inline struct tegra_xusb_pcie_pad *
@@ -245,7 +247,7 @@ struct tegra_xusb_sata_pad {
 	struct reset_control *rst;
 	struct clk *pll;
=20
-	unsigned int enable;
+	bool enable;
 };
=20
 static inline struct tegra_xusb_sata_pad *
--=20
2.25.1

