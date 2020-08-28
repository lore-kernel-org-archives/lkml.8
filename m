Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E1C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2F1208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kIWG0Lik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgH1BMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9903 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgH1BME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:12:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4859690000>; Thu, 27 Aug 2020 18:10:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 18:12:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 18:12:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 01:12:02 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 01:12:02 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4859e00000>; Thu, 27 Aug 2020 18:12:01 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 04/12] phy: tegra: xusb: t210: add lane_iddq operations
Date:   Fri, 28 Aug 2020 09:10:48 +0800
Message-ID: <20200828011056.1067559-5-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828011056.1067559-1-jckuo@nvidia.com>
References: <20200828011056.1067559-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598577001; bh=F4URxIm7hAp3xls6554zWF/g3WCHX59U8xOrhdagm6U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=kIWG0LikYKkCwWWg4w0oS+8W3F0btqO3HsyCUH+5p9U23edIyD7xn8rUvPDU2j5ty
         vVpsCeywVJ2o81xUSB4CAWpBT8FIfB2uRnlPy6aapk6tf2rcWkMz9KD/JTayxNG+Of
         WBShdoLalzSQSCpSKEVM8MQB+C8rzlmgDIetxr96AqVpXN6vxetGB2z1f9/8wDMAmL
         NffxFpoWcBK0EMmyVYN7Ij8DYY8R7PaucBserWb6LY+qrIob214wCe0vFw82cmb1Yg
         XNcwTLe0fz+Pk24YHBKez8HD3aFG3MZ6uSALyqIi0tq3BCMZc/aCs6PKDjKbAB64Ud
         FVHsPDaDmhEzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Tegra210 TRM, before changing lane assignments, driver should
keep lanes in IDDQ and sleep state; after changing lane assignments,
driver should bring lanes out of IDDQ.
This commit implements the required operations.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 94 +++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c          |  6 ++
 drivers/phy/tegra/xusb.h          |  4 +-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index 3a2d9797fb9f..fe1ab440424d 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -198,6 +198,18 @@
 #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_TERM_EN BIT(18)
 #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_MODE_OVRD BIT(13)
=20
+#define XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(x) (0x464 + (x) * 0x40)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ BIT(0)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD BIT(1)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK (0x3 << 4)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL (0x3 << 4)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD BIT(24)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ BIT(8)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD BIT(9)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK (0x3 << 12)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL (0x3 << 12)
+#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD BIT(25)
+
 #define XUSB_PADCTL_UPHY_PLL_S0_CTL1 0x860
=20
 #define XUSB_PADCTL_UPHY_PLL_S0_CTL2 0x864
@@ -209,6 +221,7 @@
 #define XUSB_PADCTL_UPHY_PLL_S0_CTL8 0x87c
=20
 #define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL1 0x960
+#define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2 0x964
=20
 #define XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(x) (0xa60 + (x) * 0x40)
 #define XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT 16
@@ -1636,6 +1649,63 @@ static const struct tegra_xusb_pad_soc tegra210_hsic=
_pad =3D {
 	.ops =3D &tegra210_hsic_ops,
 };
=20
+static void
+tegra210_uphy_lane_iddq_enable(struct tegra_xusb_padctl *padctl, unsigned =
lane)
+{
+	u32 val, offset;
+
+	if (lane <=3D 6)
+		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
+	else if (lane =3D=3D 7)
+		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
+	else {
+		WARN(true, "invalid lane %u\n", lane);
+		return;
+	}
+
+	val =3D padctl_readl(padctl, offset);
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
+	padctl_writel(padctl, val, offset);
+}
+
+static void
+tegra210_uphy_lane_iddq_disable(struct tegra_xusb_padctl *padctl, unsigned=
 lane)
+{
+	u32 val, offset;
+
+	if (lane <=3D 6)
+		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
+	else if (lane =3D=3D 7)
+		offset =3D XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
+	else {
+		WARN(true, "invalid lane %d\n", lane);
+		return;
+	}
+
+	val =3D padctl_readl(padctl, offset);
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
+	val &=3D ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
+	val |=3D XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
+	padctl_writel(padctl, val, offset);
+}
+
+
 static const char *tegra210_pcie_functions[] =3D {
 	"pcie-x1",
 	"usb3-ss",
@@ -1808,9 +1878,21 @@ static void tegra210_pcie_lane_remove(struct tegra_x=
usb_lane *lane)
 	kfree(pcie);
 }
=20
+static void tegra210_pcie_lane_iddq_enable(struct tegra_xusb_lane *lane)
+{
+	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index);
+}
+
+static void tegra210_pcie_lane_iddq_disable(struct tegra_xusb_lane *lane)
+{
+	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index);
+}
+
 static const struct tegra_xusb_lane_ops tegra210_pcie_lane_ops =3D {
 	.probe =3D tegra210_pcie_lane_probe,
 	.remove =3D tegra210_pcie_lane_remove,
+	.iddq_enable =3D tegra210_pcie_lane_iddq_enable,
+	.iddq_disable =3D tegra210_pcie_lane_iddq_disable,
 };
=20
 static int tegra210_pcie_phy_init(struct phy *phy)
@@ -1971,9 +2053,21 @@ static void tegra210_sata_lane_remove(struct tegra_x=
usb_lane *lane)
 	kfree(sata);
 }
=20
+static void tegra210_sata_lane_iddq_enable(struct tegra_xusb_lane *lane)
+{
+	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index + 7);
+}
+
+static void tegra210_sata_lane_iddq_disable(struct tegra_xusb_lane *lane)
+{
+	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index + 7);
+}
+
 static const struct tegra_xusb_lane_ops tegra210_sata_lane_ops =3D {
 	.probe =3D tegra210_sata_lane_probe,
 	.remove =3D tegra210_sata_lane_remove,
+	.iddq_enable =3D tegra210_sata_lane_iddq_enable,
+	.iddq_disable =3D tegra210_sata_lane_iddq_disable,
 };
=20
 static int tegra210_sata_phy_init(struct phy *phy)
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index b48b590aa0c1..74abd67e3a31 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -321,11 +321,17 @@ static void tegra_xusb_lane_program(struct tegra_xusb=
_lane *lane)
 	if (soc->num_funcs < 2)
 		return;
=20
+	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
+		lane->pad->ops->iddq_enable(lane);
+
 	/* choose function */
 	value =3D padctl_readl(padctl, soc->offset);
 	value &=3D ~(soc->mask << soc->shift);
 	value |=3D lane->function << soc->shift;
 	padctl_writel(padctl, value, soc->offset);
+
+	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
+		lane->pad->ops->iddq_disable(lane);
 }
=20
 static void tegra_xusb_pad_program(struct tegra_xusb_pad *pad)
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 0c828694cf2d..485b692a3b15 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -22,6 +22,7 @@ struct phy;
 struct phy_provider;
 struct platform_device;
 struct regulator;
+struct tegra_xusb_padctl;
=20
 /*
  * lanes
@@ -126,6 +127,8 @@ struct tegra_xusb_lane_ops {
 					 struct device_node *np,
 					 unsigned int index);
 	void (*remove)(struct tegra_xusb_lane *lane);
+	void (*iddq_enable)(struct tegra_xusb_lane *lane);
+	void (*iddq_disable)(struct tegra_xusb_lane *lane);
 };
=20
 bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane, const char *funct=
ion);
@@ -134,7 +137,6 @@ bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane=
, const char *function);
  * pads
  */
 struct tegra_xusb_pad_soc;
-struct tegra_xusb_padctl;
=20
 struct tegra_xusb_pad_ops {
 	struct tegra_xusb_pad *(*probe)(struct tegra_xusb_padctl *padctl,
--=20
2.25.1

