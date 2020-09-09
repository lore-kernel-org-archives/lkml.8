Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6CD208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N9vIkaOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgIIILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:11:04 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11995 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbgIIIKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:10:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588e000000>; Wed, 09 Sep 2020 01:10:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:10:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 01:10:53 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:10:52 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:10:52 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e0a0000>; Wed, 09 Sep 2020 01:10:51 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 03/15] phy: tegra: xusb: Move usb3 port init for Tegra210
Date:   Wed, 9 Sep 2020 16:10:29 +0800
Message-ID: <20200909081041.3190157-4-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599639040; bh=NH2yldvP9EV+zOB0WP3iOWti/6NaVlNaFSW/uFhh5Rs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=N9vIkaOYXGAoPJm8xmhiachpWIxjHQQA5Z2G9t+78s0JiWmr831MsgfD7havJE3pK
         hwwY9RyXaKuNy9WDnP3ZjO2AvJZUxnZalKHBN5yGp+uyjMyrI0BblOQ6yH4wkbqflF
         nQrfzDBbbcvxVKafEy8KTPpuyeG8SsDrHoXknEv2mpsjiiMuy10MtE08uzkwbqi/Cq
         hqYQ2xUlOJk6yP62Nv+s5/5QZg+1hVmK4gVuus6jf+PT0dy0RX4dj6FgMk3C6jnhvH
         q5nPsN0gEiXpQIszUfhNGWJn4uCP+tq2c1willZyJNSM/KIvQyAlu7ngw1d7v1y5wO
         QtWtieRR7ajSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The programming sequence in tegra210_usb3_port_enable() is required
for both cold boot and SC7 exit, and must be performed only after
PEX/SATA UPHY is initialized. Therefore, this commit moves the
programming sequence to tegra210_usb3_phy_power_on(). PCIE/SATA phy
.power_on() stub will invoke tegra210_usb3_phy_power_on() if the lane
is assigned for XUSB super-speed.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v3:
   new, was a part of "phy: tegra: xusb: Rearrange UPHY init on Tegra210"

 drivers/phy/tegra/xusb-tegra210.c | 298 +++++++++++++++++-------------
 drivers/phy/tegra/xusb.c          |   2 +-
 drivers/phy/tegra/xusb.h          |   2 +
 3 files changed, 174 insertions(+), 128 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index 66bd4613835b..f06e7bc7a51b 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -256,6 +256,32 @@ to_tegra210_xusb_padctl(struct tegra_xusb_padctl *padc=
tl)
 	return container_of(padctl, struct tegra210_xusb_padctl, base);
 }
=20
+static const struct tegra_xusb_lane_map tegra210_usb3_map[] =3D {
+	{ 0, "pcie", 6 },
+	{ 1, "pcie", 5 },
+	{ 2, "pcie", 0 },
+	{ 2, "pcie", 3 },
+	{ 3, "pcie", 4 },
+	{ 3, "sata", 0 },
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
+			dev_dbg(lane->pad->padctl->dev, "lane =3D %s map to port =3D usb3-%d\n"=
,
+				lane->pad->soc->lanes[lane->index].name, map->port);
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
@@ -1599,6 +1625,128 @@ static const struct tegra_xusb_lane_soc tegra210_pc=
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
@@ -1656,7 +1804,7 @@ static int tegra210_pcie_phy_power_on(struct phy *phy=
)
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
 	u32 value;
-	int err;
+	int err =3D 0;
=20
 	mutex_lock(&padctl->lock);
=20
@@ -1668,6 +1816,9 @@ static int tegra210_pcie_phy_power_on(struct phy *phy=
)
 	value |=3D XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(lane->index);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
=20
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_on(phy);
+
 unlock:
 	mutex_unlock(&padctl->lock);
 	return err;
@@ -1677,15 +1828,22 @@ static int tegra210_pcie_phy_power_off(struct phy *=
phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int err =3D 0;
 	u32 value;
=20
+	mutex_lock(&padctl->lock);
+
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
 	value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(lane->index);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
=20
 	tegra210_pex_uphy_disable(padctl);
=20
-	return 0;
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_off(phy);
+
+	mutex_unlock(&padctl->lock);
+	return err;
 }
=20
 static const struct phy_ops tegra210_pcie_phy_ops =3D {
@@ -1839,6 +1997,9 @@ static int tegra210_sata_phy_power_on(struct phy *phy=
)
 	value |=3D XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(lane->index);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
=20
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_on(phy);
+
 unlock:
 	mutex_unlock(&padctl->lock);
 	return err;
@@ -1848,15 +2009,22 @@ static int tegra210_sata_phy_power_off(struct phy *=
phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int err =3D 0;
 	u32 value;
=20
+	mutex_lock(&padctl->lock);
+
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
 	value &=3D ~XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(lane->index);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
=20
 	tegra210_sata_uphy_disable(lane->pad->padctl);
=20
-	return 0;
+	if (tegra_xusb_lane_check(lane, "usb3-ss"))
+		err =3D tegra210_usb3_phy_power_off(phy);
+
+	mutex_unlock(&padctl->lock);
+	return err;
 }
=20
 static const struct phy_ops tegra210_sata_phy_ops =3D {
@@ -1984,137 +2152,13 @@ static const struct tegra_xusb_port_ops tegra210_h=
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
index ea35af747066..c232febc02f1 100644
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
--=20
2.25.1

