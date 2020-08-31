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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F4C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3126D206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CeHqVduu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHaElI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:08 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18362 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgHaEky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:54 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7f280000>; Sun, 30 Aug 2020 21:40:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 30 Aug 2020 21:40:53 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:50 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f500002>; Sun, 30 Aug 2020 21:40:50 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 08/12] phy: tegra: xusb: t210: support wake and sleepwalk
Date:   Mon, 31 Aug 2020 12:40:39 +0800
Message-ID: <20200831044043.1561074-9-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848808; bh=mEfULxPcF6D320LeMby9oTHQfyo2DFMZ0KaGeJJqiBA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=CeHqVduuee5V3xM5j1eouGfun3RunsJxLooxo2f0JthHr6Ewr4ljd7JZnIz5lXDWg
         HCUvgLYmLPgGNhPPL0r5w6dN5k1NWfmIA233079jumOkvxsMFnNpj5i0/Y232+pXsj
         8gLxBE86EHWaNJcZNkPSDov/5jn+iAiiROxmHWnwrtZ1xnFitsqLafaFVmZ9uHQzpl
         YK2eqGnCaQpDtnRZMbj2cIpBz1j989vcMjgZ+zF2kN6FeA5fAkcRQ8uUX5baiuFrHy
         oRpitGxNSn+d2oz1vhPeLdK5PvRkqZkw/1ktGh2p3W6Z/TW7772cC6f7GW7cOjFw9P
         2G2I56cJERCyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements Tegra210 XUSB PADCTL wake and sleepwalk
routines. Sleepwalk logic is in PMC (always-on) hardware block.
PMC driver provides managed access to the sleepwalk registers
via regmap framework.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 1094 ++++++++++++++++++++++++++++-
 1 file changed, 1079 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index fe1ab440424d..1c03f4ec4b59 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -16,6 +16,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/of_platform.h>
=20
 #include <soc/tegra/fuse.h>
=20
@@ -52,6 +54,20 @@
 #define XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(x, v) (((v) & 0x7) << ((x) * 5))
 #define XUSB_PADCTL_SS_PORT_MAP_PORT_DISABLED 0x7
=20
+#define XUSB_PADCTL_ELPG_PROGRAM_0 0x20
+#define   USB2_PORT_WAKE_INTERRUPT_ENABLE(x)      BIT((x))
+#define   USB2_PORT_WAKEUP_EVENT(x)               BIT((x) + 7)
+#define   SS_PORT_WAKE_INTERRUPT_ENABLE(x)        BIT((x) + 14)
+#define   SS_PORT_WAKEUP_EVENT(x)                 BIT((x) + 21)
+#define   USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(x) BIT((x) + 28)
+#define   USB2_HSIC_PORT_WAKEUP_EVENT(x)          BIT((x) + 30)
+#define   ALL_WAKE_EVENTS ( \
+		USB2_PORT_WAKEUP_EVENT(0) | USB2_PORT_WAKEUP_EVENT(1) | \
+		USB2_PORT_WAKEUP_EVENT(2) | USB2_PORT_WAKEUP_EVENT(3) | \
+		SS_PORT_WAKEUP_EVENT(0) | SS_PORT_WAKEUP_EVENT(1) | \
+		SS_PORT_WAKEUP_EVENT(2) | SS_PORT_WAKEUP_EVENT(3) | \
+		USB2_HSIC_PORT_WAKEUP_EVENT(0))
+
 #define XUSB_PADCTL_ELPG_PROGRAM1 0x024
 #define XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN (1 << 31)
 #define XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN_EARLY (1 << 30)
@@ -90,6 +106,8 @@
 #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR (1 << 2)
 #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DISC_OVRD (1 << 1)
 #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_CHRP_OVRD (1 << 0)
+#define   RPD_CTRL(x)                      (((x) & 0x1f) << 26)
+#define   RPD_CTRL_VALUE(x)                (((x) >> 26) & 0x1f)
=20
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0 0x284
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD (1 << 11)
@@ -108,6 +126,8 @@
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT 12
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK 0x7f
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_VAL 0x1e
+#define   TCTRL_VALUE(x)                (((x) & 0x3f) >> 0)
+#define   PCTRL_VALUE(x)                (((x) >> 6) & 0x3f)
=20
 #define XUSB_PADCTL_HSIC_PADX_CTL0(x) (0x300 + (x) * 0x20)
 #define XUSB_PADCTL_HSIC_PAD_CTL0_RPU_STROBE (1 << 18)
@@ -251,16 +271,161 @@
 #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING 8
 #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_GROUNDED 0
=20
+/* USB2 SLEEPWALK registers */
+#define UTMIP(_port, _offset1, _offset2) \
+		(((_port) <=3D 2) ? (_offset1) : (_offset2))
+
+#define PMC_UTMIP_UHSIC_SLEEP_CFG(x)	UTMIP(x, 0x1fc, 0x4d0)
+#define   UTMIP_MASTER_ENABLE(x)		UTMIP(x, BIT(8 * (x)), BIT(0))
+#define   UTMIP_FSLS_USE_PMC(x)			UTMIP(x, BIT(8 * (x) + 1), \
+							BIT(1))
+#define   UTMIP_PCTRL_USE_PMC(x)		UTMIP(x, BIT(8 * (x) + 2), \
+							BIT(2))
+#define   UTMIP_TCTRL_USE_PMC(x)		UTMIP(x, BIT(8 * (x) + 3), \
+							BIT(3))
+#define   UTMIP_WAKE_VAL(_port, _value)		(((_value) & 0xf) << \
+					(UTMIP(_port, 8 * (_port) + 4, 4)))
+#define   UTMIP_WAKE_VAL_NONE(_port)		UTMIP_WAKE_VAL(_port, 12)
+#define   UTMIP_WAKE_VAL_ANY(_port)		UTMIP_WAKE_VAL(_port, 15)
+
+#define PMC_UTMIP_UHSIC_SLEEP_CFG1	(0x4d0)
+#define   UTMIP_RPU_SWITC_LOW_USE_PMC_PX(x)	BIT((x) + 8)
+#define   UTMIP_RPD_CTRL_USE_PMC_PX(x)		BIT((x) + 16)
+
+#define PMC_UTMIP_MASTER_CONFIG		(0x274)
+#define   UTMIP_PWR(x)				UTMIP(x, BIT(x), BIT(4))
+#define   UHSIC_PWR(x)				BIT(3)
+
+#define PMC_USB_DEBOUNCE_DEL		(0xec)
+#define   DEBOUNCE_VAL(x)			(((x) & 0xffff) << 0)
+#define   UTMIP_LINE_DEB_CNT(x)			(((x) & 0xf) << 16)
+#define   UHSIC_LINE_DEB_CNT(x)			(((x) & 0xf) << 20)
+
+#define PMC_UTMIP_UHSIC_FAKE(x)		UTMIP(x, 0x218, 0x294)
+#define   UTMIP_FAKE_USBOP_VAL(x)		UTMIP(x, BIT(4 * (x)), BIT(8))
+#define   UTMIP_FAKE_USBON_VAL(x)		UTMIP(x, BIT(4 * (x) + 1), \
+							BIT(9))
+#define   UTMIP_FAKE_USBOP_EN(x)		UTMIP(x, BIT(4 * (x) + 2), \
+							BIT(10))
+#define   UTMIP_FAKE_USBON_EN(x)		UTMIP(x, BIT(4 * (x) + 3), \
+							BIT(11))
+
+#define PMC_UTMIP_UHSIC_SLEEPWALK_CFG(x)	UTMIP(x, 0x200, 0x288)
+#define   UTMIP_LINEVAL_WALK_EN(x)		UTMIP(x, BIT(8 * (x) + 7), \
+							BIT(15))
+
+#define PMC_USB_AO			(0xf0)
+#define   USBOP_VAL_PD(x)			UTMIP(x, BIT(4 * (x)), BIT(20))
+#define   USBON_VAL_PD(x)			UTMIP(x, BIT(4 * (x) + 1), \
+							BIT(21))
+#define   STROBE_VAL_PD(x)			BIT(12)
+#define   DATA0_VAL_PD(x)			BIT(13)
+#define   DATA1_VAL_PD				BIT(24)
+
+#define PMC_UTMIP_UHSIC_SAVED_STATE(x)	UTMIP(x, 0x1f0, 0x280)
+#define   SPEED(_port, _value)			(((_value) & 0x3) << \
+						(UTMIP(_port, 8 * (_port), 8)))
+#define   UTMI_HS(_port)			SPEED(_port, 0)
+#define   UTMI_FS(_port)			SPEED(_port, 1)
+#define   UTMI_LS(_port)			SPEED(_port, 2)
+#define   UTMI_RST(_port)			SPEED(_port, 3)
+
+#define PMC_UTMIP_UHSIC_TRIGGERS		(0x1ec)
+#define   UTMIP_CLR_WALK_PTR(x)			UTMIP(x, BIT(x), BIT(16))
+#define   UTMIP_CAP_CFG(x)			UTMIP(x, BIT((x) + 4), BIT(17))
+#define   UTMIP_CLR_WAKE_ALARM(x)		UTMIP(x, BIT((x) + 12), \
+							BIT(19))
+#define   UHSIC_CLR_WALK_PTR			BIT(3)
+#define   UHSIC_CLR_WAKE_ALARM			BIT(15)
+
+#define PMC_UTMIP_SLEEPWALK_PX(x)	UTMIP(x, 0x204 + (4 * (x)), \
+							0x4e0)
+/* phase A */
+#define   UTMIP_USBOP_RPD_A			BIT(0)
+#define   UTMIP_USBON_RPD_A			BIT(1)
+#define   UTMIP_AP_A				BIT(4)
+#define   UTMIP_AN_A				BIT(5)
+#define   UTMIP_HIGHZ_A				BIT(6)
+/* phase B */
+#define   UTMIP_USBOP_RPD_B			BIT(8)
+#define   UTMIP_USBON_RPD_B			BIT(9)
+#define   UTMIP_AP_B				BIT(12)
+#define   UTMIP_AN_B				BIT(13)
+#define   UTMIP_HIGHZ_B				BIT(14)
+/* phase C */
+#define   UTMIP_USBOP_RPD_C			BIT(16)
+#define   UTMIP_USBON_RPD_C			BIT(17)
+#define   UTMIP_AP_C				BIT(20)
+#define   UTMIP_AN_C				BIT(21)
+#define   UTMIP_HIGHZ_C				BIT(22)
+/* phase D */
+#define   UTMIP_USBOP_RPD_D			BIT(24)
+#define   UTMIP_USBON_RPD_D			BIT(25)
+#define   UTMIP_AP_D				BIT(28)
+#define   UTMIP_AN_D				BIT(29)
+#define   UTMIP_HIGHZ_D				BIT(30)
+
+#define PMC_UTMIP_UHSIC_LINE_WAKEUP	(0x26c)
+#define   UTMIP_LINE_WAKEUP_EN(x)		UTMIP(x, BIT(x), BIT(4))
+#define   UHSIC_LINE_WAKEUP_EN			BIT(3)
+
+#define PMC_UTMIP_TERM_PAD_CFG		(0x1f8)
+#define   PCTRL_VAL(x)				(((x) & 0x3f) << 1)
+#define   TCTRL_VAL(x)				(((x) & 0x3f) << 7)
+
+#define PMC_UTMIP_PAD_CFGX(x)		(0x4c0 + (4 * (x)))
+#define   RPD_CTRL_PX(x)			(((x) & 0x1f) << 22)
+
+#define PMC_UHSIC_SLEEP_CFG	PMC_UTMIP_UHSIC_SLEEP_CFG(0)
+#define   UHSIC_MASTER_ENABLE			BIT(24)
+#define   UHSIC_WAKE_VAL(_value)		(((_value) & 0xf) << 28)
+#define   UHSIC_WAKE_VAL_SD10			UHSIC_WAKE_VAL(2)
+#define   UHSIC_WAKE_VAL_NONE			UHSIC_WAKE_VAL(12)
+
+#define PMC_UHSIC_FAKE			PMC_UTMIP_UHSIC_FAKE(0)
+#define   UHSIC_FAKE_STROBE_VAL			BIT(12)
+#define   UHSIC_FAKE_DATA_VAL			BIT(13)
+#define   UHSIC_FAKE_STROBE_EN			BIT(14)
+#define   UHSIC_FAKE_DATA_EN			BIT(15)
+
+#define PMC_UHSIC_SAVED_STATE		PMC_UTMIP_UHSIC_SAVED_STATE(0)
+#define   UHSIC_MODE(_value)			(((_value) & 0x1) << 24)
+#define   UHSIC_HS				UHSIC_MODE(0)
+#define   UHSIC_RST				UHSIC_MODE(1)
+
+#define PMC_UHSIC_SLEEPWALK_CFG		PMC_UTMIP_UHSIC_SLEEPWALK_CFG(0)
+#define   UHSIC_WAKE_WALK_EN			BIT(30)
+#define   UHSIC_LINEVAL_WALK_EN			BIT(31)
+
+#define PMC_UHSIC_SLEEPWALK_P0		(0x210)
+#define   UHSIC_DATA0_RPD_A			BIT(1)
+#define   UHSIC_DATA0_RPU_B			BIT(11)
+#define   UHSIC_DATA0_RPU_C			BIT(19)
+#define   UHSIC_DATA0_RPU_D			BIT(27)
+#define   UHSIC_STROBE_RPU_A			BIT(2)
+#define   UHSIC_STROBE_RPD_B			BIT(8)
+#define   UHSIC_STROBE_RPD_C			BIT(16)
+#define   UHSIC_STROBE_RPD_D			BIT(24)
+
 struct tegra210_xusb_fuse_calibration {
 	u32 hs_curr_level[4];
 	u32 hs_term_range_adj;
 	u32 rpd_ctrl;
 };
=20
+struct tegra210_xusb_padctl_context {
+	u32 usb2_pad_mux;
+	u32 usb2_port_cap;
+	u32 ss_port_map;
+	u32 usb3_pad_mux;
+};
+
 struct tegra210_xusb_padctl {
 	struct tegra_xusb_padctl base;
=20
 	struct tegra210_xusb_fuse_calibration fuse;
+	struct tegra210_xusb_padctl_context context;
+	struct regmap *pmc_reg;
 };
=20
 static inline struct tegra210_xusb_padctl *
@@ -886,6 +1051,671 @@ static int tegra210_hsic_set_idle(struct tegra_xusb_=
padctl *padctl,
 	return 0;
 }
=20
+static int tegra210_usb3_enable_phy_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int port =3D tegra210_usb3_lane_map(lane);
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	if (port < 0) {
+		dev_err(dev, "invalid usb3 port number\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "phy enable sleepwalk usb3 %d\n", port);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value |=3D XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(250, 350);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_usb3_disable_phy_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int port =3D tegra210_usb3_lane_map(lane);
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	if (port < 0) {
+		dev_err(dev, "invalid usb3 port number\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "phy disable sleepwalk usb3 %d\n", port);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+	value &=3D ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_usb3_enable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int port =3D tegra210_usb3_lane_map(lane);
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	if (port < 0) {
+		dev_err(dev, "invalid usb3 port number\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "phy enable wake usb3 %d\n", port);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKEUP_EVENT(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKE_INTERRUPT_ENABLE(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_usb3_disable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	int port =3D tegra210_usb3_lane_map(lane);
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	if (port < 0) {
+		dev_err(dev, "invalid usb3 port number\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "phy disable wake usb3 %d\n", port);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value &=3D ~SS_PORT_WAKE_INTERRUPT_ENABLE(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKEUP_EVENT(port);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_utmi_enable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable wake on usb2 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_utmi_disable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable wake on usb2 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value &=3D ~USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_hsic_enable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable wake on hsic %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_HSIC_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_hsic_disable_phy_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable wake on hsic %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value &=3D ~USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_HSIC_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra210_usb3_phy_remote_wake_detected(
+			struct tegra_xusb_padctl *padctl, int port)
+{
+	u32 value;
+
+	if (port < 0) {
+		dev_err(padctl->dev, "invalid usb3 port number %d\n",
+					port);
+		return false;
+	}
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	if ((value & SS_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
+	    (value & SS_PORT_WAKEUP_EVENT(port)))
+		return true;
+	else
+		return false;
+}
+
+static int tegra210_utmi_phy_remote_wake_detected(
+			struct tegra_xusb_padctl *padctl, int port)
+{
+	u32 value;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	if ((value & USB2_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
+	    (value & USB2_PORT_WAKEUP_EVENT(port)))
+		return true;
+	else
+		return false;
+}
+
+static int tegra210_hsic_phy_remote_wake_detected(
+			struct tegra_xusb_padctl *padctl, int port)
+{
+	u32 value;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
+	if ((value & USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
+	    (value & USB2_HSIC_PORT_WAKEUP_EVENT(port)))
+		return true;
+	else
+		return false;
+}
+
+#define padctl_pmc_readl(_priv, _offset)			\
+({								\
+	int rc;							\
+	u32 val;						\
+	rc =3D regmap_read(_priv->pmc_reg, _offset, &val);	\
+	if (rc)							\
+		return rc;					\
+	val;							\
+})
+
+#define padctl_pmc_writel(_priv, _val, _offset)			\
+do {								\
+	int rc;							\
+	rc =3D regmap_write(_priv->pmc_reg, _offset, _val);	\
+	if (rc)							\
+		return rc;					\
+} while (0)
+
+/* T210 USB2 SLEEPWALK APIs */
+int tegra_pmc_utmi_enable_phy_sleepwalk(struct phy *phy,
+					enum usb_device_speed speed)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+	struct device *dev =3D padctl->dev;
+	unsigned int port =3D lane->index;
+	u32 val, tctrl, pctrl, rpd_ctrl;
+
+	if (speed > USB_SPEED_HIGH)
+		return -EINVAL;
+
+	dev_dbg(dev, "phy enable sleepwalk usb2 %d speed %d\n", port, speed);
+
+	val =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
+	tctrl =3D TCTRL_VALUE(val);
+	pctrl =3D PCTRL_VALUE(val);
+
+	val =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(port));
+	rpd_ctrl =3D RPD_CTRL_VALUE(val);
+
+	/* ensure sleepwalk logic is disabled */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	val &=3D ~UTMIP_MASTER_ENABLE(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	/* ensure sleepwalk logics are in low power mode */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_MASTER_CONFIG);
+	val |=3D UTMIP_PWR(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_MASTER_CONFIG);
+
+	/* set debounce time */
+	val =3D padctl_pmc_readl(priv, PMC_USB_DEBOUNCE_DEL);
+	val &=3D ~UTMIP_LINE_DEB_CNT(~0);
+	val |=3D UTMIP_LINE_DEB_CNT(0x1);
+	padctl_pmc_writel(priv, val, PMC_USB_DEBOUNCE_DEL);
+
+	/* ensure fake events of sleepwalk logic are desiabled */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_FAKE(port));
+	val &=3D ~(UTMIP_FAKE_USBOP_VAL(port) | UTMIP_FAKE_USBON_VAL(port) |
+			UTMIP_FAKE_USBOP_EN(port) | UTMIP_FAKE_USBON_EN(port));
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_FAKE(port));
+
+	/* ensure wake events of sleepwalk logic are not latched */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	val &=3D ~UTMIP_LINE_WAKEUP_EN(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	/* disable wake event triggers of sleepwalk logic */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	val &=3D ~UTMIP_WAKE_VAL(port, ~0);
+	val |=3D UTMIP_WAKE_VAL_NONE(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	/* power down the line state detectors of the pad */
+	val =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	val |=3D (USBOP_VAL_PD(port) | USBON_VAL_PD(port));
+	padctl_pmc_writel(priv, val, PMC_USB_AO);
+
+	/* save state per speed */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SAVED_STATE(port));
+	val &=3D ~SPEED(port, ~0);
+	if (speed =3D=3D USB_SPEED_HIGH)
+		val |=3D UTMI_HS(port);
+	else if (speed =3D=3D USB_SPEED_FULL)
+		val |=3D UTMI_FS(port);
+	else if (speed =3D=3D USB_SPEED_LOW)
+		val |=3D UTMI_LS(port);
+	else
+		val |=3D UTMI_RST(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SAVED_STATE(port));
+
+	/* enable the trigger of the sleepwalk logic */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEPWALK_CFG(port));
+	val |=3D UTMIP_LINEVAL_WALK_EN(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEPWALK_CFG(port));
+
+	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
+	 * as well as capture the configuration of the USB2.0 pad
+	 */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
+	val |=3D (UTMIP_CLR_WALK_PTR(port) | UTMIP_CLR_WAKE_ALARM(port) |
+		UTMIP_CAP_CFG(port));
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_TRIGGERS);
+
+	/* program electrical parameters read from XUSB PADCTL */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_TERM_PAD_CFG);
+	val &=3D ~(TCTRL_VAL(~0) | PCTRL_VAL(~0));
+	val |=3D (TCTRL_VAL(tctrl) | PCTRL_VAL(pctrl));
+	padctl_pmc_writel(priv, val, PMC_UTMIP_TERM_PAD_CFG);
+
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_PAD_CFGX(port));
+	val &=3D ~RPD_CTRL_PX(~0);
+	val |=3D RPD_CTRL_PX(rpd_ctrl);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_PAD_CFGX(port));
+
+	/* setup the pull-ups and pull-downs of the signals during the four
+	 * stages of sleepwalk.
+	 * if device is connected, program sleepwalk logic to maintain a J and
+	 * keep driving K upon seeing remote wake.
+	 */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_SLEEPWALK_PX(port));
+	val =3D (UTMIP_USBOP_RPD_A | UTMIP_USBOP_RPD_B | UTMIP_USBOP_RPD_C |
+		UTMIP_USBOP_RPD_D);
+	val |=3D (UTMIP_USBON_RPD_A | UTMIP_USBON_RPD_B | UTMIP_USBON_RPD_C |
+		UTMIP_USBON_RPD_D);
+	if (speed =3D=3D USB_SPEED_UNKNOWN) {
+		val |=3D (UTMIP_HIGHZ_A | UTMIP_HIGHZ_B | UTMIP_HIGHZ_C |
+			UTMIP_HIGHZ_D);
+	} else if ((speed =3D=3D USB_SPEED_HIGH) || (speed =3D=3D USB_SPEED_FULL)=
) {
+		/* J state: D+/D- =3D high/low, K state: D+/D- =3D low/high */
+		val |=3D UTMIP_HIGHZ_A;
+		val |=3D UTMIP_AP_A;
+		val |=3D (UTMIP_AN_B | UTMIP_AN_C | UTMIP_AN_D);
+	} else if (speed =3D=3D USB_SPEED_LOW) {
+		/* J state: D+/D- =3D low/high, K state: D+/D- =3D high/low */
+		val |=3D UTMIP_HIGHZ_A;
+		val |=3D UTMIP_AN_A;
+		val |=3D (UTMIP_AP_B | UTMIP_AP_C | UTMIP_AP_D);
+	}
+	padctl_pmc_writel(priv, val, PMC_UTMIP_SLEEPWALK_PX(port));
+
+	/* power up the line state detectors of the pad */
+	val =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	val &=3D ~(USBOP_VAL_PD(port) | USBON_VAL_PD(port));
+	padctl_pmc_writel(priv, val, PMC_USB_AO);
+
+	usleep_range(50, 100);
+
+	/* switch the electric control of the USB2.0 pad to PMC */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	val |=3D (UTMIP_FSLS_USE_PMC(port) | UTMIP_PCTRL_USE_PMC(port) |
+			UTMIP_TCTRL_USE_PMC(port));
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG1);
+	val |=3D (UTMIP_RPD_CTRL_USE_PMC_PX(port) |
+			UTMIP_RPU_SWITC_LOW_USE_PMC_PX(port));
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG1);
+
+	/* set the wake signaling trigger events */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	val &=3D ~UTMIP_WAKE_VAL(port, ~0);
+	val |=3D UTMIP_WAKE_VAL_ANY(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	/* enable the wake detection */
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	val |=3D UTMIP_MASTER_ENABLE(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	val =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	val |=3D UTMIP_LINE_WAKEUP_EN(port);
+	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	return 0;
+}
+
+int tegra_pmc_utmi_disable_phy_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+	struct device *dev =3D padctl->dev;
+	unsigned int port =3D lane->index;
+	u32 value;
+
+	dev_dbg(dev, "phy disable sleepwalk usb2 %d\n", port);
+
+	/* disable the wake detection */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	value &=3D ~UTMIP_MASTER_ENABLE(port);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	value &=3D ~UTMIP_LINE_WAKEUP_EN(port);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	/* switch the electric control of the USB2.0 pad to XUSB or USB2 */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	value &=3D ~(UTMIP_FSLS_USE_PMC(port) | UTMIP_PCTRL_USE_PMC(port) |
+			UTMIP_TCTRL_USE_PMC(port));
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG1);
+	value &=3D ~(UTMIP_RPD_CTRL_USE_PMC_PX(port) |
+			UTMIP_RPU_SWITC_LOW_USE_PMC_PX(port));
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG1);
+
+	/* disable wake event triggers of sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+	value &=3D ~UTMIP_WAKE_VAL(port, ~0);
+	value |=3D UTMIP_WAKE_VAL_NONE(port);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
+
+	/* power down the line state detectors of the port */
+	value =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	value |=3D (USBOP_VAL_PD(port) | USBON_VAL_PD(port));
+	padctl_pmc_writel(priv, value, PMC_USB_AO);
+
+	/* clear alarm of the sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
+	value |=3D UTMIP_CLR_WAKE_ALARM(port);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
+
+	return 0;
+}
+
+int tegra_pmc_hsic_enable_phy_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+	struct device *dev =3D padctl->dev;
+	unsigned int port =3D lane->index;
+	u32 value;
+
+	dev_dbg(dev, "phy enable sleepwalk hsic %d\n", port);
+
+	/* ensure sleepwalk logic is disabled */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value &=3D ~UHSIC_MASTER_ENABLE;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	/* ensure sleepwalk logics are in low power mode */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_MASTER_CONFIG);
+	value |=3D UHSIC_PWR(port);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_MASTER_CONFIG);
+
+	/* set debounce time */
+	value =3D padctl_pmc_readl(priv, PMC_USB_DEBOUNCE_DEL);
+	value &=3D ~UHSIC_LINE_DEB_CNT(~0);
+	value |=3D UHSIC_LINE_DEB_CNT(0x1);
+	padctl_pmc_writel(priv, value, PMC_USB_DEBOUNCE_DEL);
+
+	/* ensure fake events of sleepwalk logic are desiabled */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_FAKE);
+	value &=3D ~(UHSIC_FAKE_STROBE_VAL | UHSIC_FAKE_DATA_VAL |
+			UHSIC_FAKE_STROBE_EN | UHSIC_FAKE_DATA_EN);
+	padctl_pmc_writel(priv, value, PMC_UHSIC_FAKE);
+
+	/* ensure wake events of sleepwalk logic are not latched */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	value &=3D ~UHSIC_LINE_WAKEUP_EN;
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	/* disable wake event triggers of sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value &=3D ~UHSIC_WAKE_VAL(~0);
+	value |=3D UHSIC_WAKE_VAL_NONE;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	/* power down the line state detectors of the port */
+	value =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	value |=3D (STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
+	padctl_pmc_writel(priv, value, PMC_USB_AO);
+
+	/* save state, HSIC always comes up as HS */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SAVED_STATE);
+	value &=3D ~UHSIC_MODE(~0);
+	value |=3D UHSIC_HS;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SAVED_STATE);
+
+	/* enable the trigger of the sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEPWALK_CFG);
+	value |=3D (UHSIC_WAKE_WALK_EN | UHSIC_LINEVAL_WALK_EN);
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEPWALK_CFG);
+
+	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
+	 * as well as capture the configuration of the USB2.0 port
+	 */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
+	value |=3D (UHSIC_CLR_WALK_PTR | UHSIC_CLR_WAKE_ALARM);
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
+
+	/* setup the pull-ups and pull-downs of the signals during the four
+	 * stages of sleepwalk.
+	 * maintain a HSIC IDLE and keep driving HSIC RESUME upon remote wake
+	 */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEPWALK_P0);
+	value =3D (UHSIC_DATA0_RPD_A | UHSIC_DATA0_RPU_B | UHSIC_DATA0_RPU_C |
+		UHSIC_DATA0_RPU_D);
+	value |=3D (UHSIC_STROBE_RPU_A | UHSIC_STROBE_RPD_B | UHSIC_STROBE_RPD_C =
|
+		UHSIC_STROBE_RPD_D);
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEPWALK_P0);
+
+	/* power up the line state detectors of the port */
+	value =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	value &=3D ~(STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
+	padctl_pmc_writel(priv, value, PMC_USB_AO);
+
+	usleep_range(50, 100);
+
+	/* set the wake signaling trigger events */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value &=3D ~UHSIC_WAKE_VAL(~0);
+	value |=3D UHSIC_WAKE_VAL_SD10;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	/* enable the wake detection */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value |=3D UHSIC_MASTER_ENABLE;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	value |=3D UHSIC_LINE_WAKEUP_EN;
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	return 0;
+}
+
+int tegra_pmc_hsic_disable_phy_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+	struct device *dev =3D padctl->dev;
+	unsigned int port =3D lane->index;
+	u32 value;
+
+	dev_dbg(dev, "phy disable sleepwalk hsic %d\n", port);
+
+	/* disable the wake detection */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value &=3D ~UHSIC_MASTER_ENABLE;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+	value &=3D ~UHSIC_LINE_WAKEUP_EN;
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
+
+	/* disable wake event triggers of sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
+	value &=3D ~UHSIC_WAKE_VAL(~0);
+	value |=3D UHSIC_WAKE_VAL_NONE;
+	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
+
+	/* power down the line state detectors of the port */
+	value =3D padctl_pmc_readl(priv, PMC_USB_AO);
+	value |=3D (STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
+	padctl_pmc_writel(priv, value, PMC_USB_AO);
+
+	/* clear alarm of the sleepwalk logic */
+	value =3D padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
+	value |=3D UHSIC_CLR_WAKE_ALARM;
+	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
+
+	return 0;
+}
+
 static int tegra210_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
 					 unsigned int index, bool enable)
 {
@@ -988,8 +1818,23 @@ static int tegra210_usb2_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct tegra_xusb_usb2_port *port;
+	int err;
 	u32 value;
=20
+	port =3D tegra_xusb_find_usb2_port(padctl, index);
+	if (!port) {
+		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
+		return -ENODEV;
+	}
+
+	err =3D regulator_enable(port->supply);
+	if (err)
+		return err;
+
+	mutex_lock(&padctl->lock);
+
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
 	value &=3D ~(XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_MASK <<
 		   XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT);
@@ -997,11 +1842,29 @@ static int tegra210_usb2_phy_init(struct phy *phy)
 		 XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PAD_MUX);
=20
+	mutex_unlock(&padctl->lock);
+
 	return 0;
 }
=20
 static int tegra210_usb2_phy_exit(struct phy *phy)
 {
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct tegra_xusb_usb2_port *port;
+	int err;
+
+	port =3D tegra_xusb_find_usb2_port(padctl, index);
+	if (!port) {
+		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
+		return -ENODEV;
+	}
+
+	err =3D regulator_disable(port->supply);
+	if (err)
+		return err;
+
 	return 0;
 }
=20
@@ -1122,6 +1985,8 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
)
=20
 	priv =3D to_tegra210_xusb_padctl(padctl);
=20
+	mutex_lock(&padctl->lock);
+
 	if (port->usb3_port_fake !=3D -1) {
 		value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
 		value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(
@@ -1215,14 +2080,6 @@ static int tegra210_usb2_phy_power_on(struct phy *ph=
y)
 	padctl_writel(padctl, value,
 		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
=20
-	if (port->supply && port->mode =3D=3D USB_DR_MODE_HOST) {
-		err =3D regulator_enable(port->supply);
-		if (err)
-			return err;
-	}
-
-	mutex_lock(&padctl->lock);
-
 	if (pad->enable > 0) {
 		pad->enable++;
 		mutex_unlock(&padctl->lock);
@@ -1231,7 +2088,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
)
=20
 	err =3D clk_prepare_enable(pad->clk);
 	if (err)
-		goto disable_regulator;
+		goto out;
=20
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value &=3D ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
@@ -1263,8 +2120,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
)
=20
 	return 0;
=20
-disable_regulator:
-	regulator_disable(port->supply);
+out:
 	mutex_unlock(&padctl->lock);
 	return err;
 }
@@ -1275,12 +2131,12 @@ static int tegra210_usb2_phy_power_off(struct phy *=
phy)
 	struct tegra_xusb_usb2_pad *pad =3D to_usb2_pad(lane->pad);
 	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
 	struct tegra_xusb_usb2_port *port;
+	unsigned int index =3D lane->index;
 	u32 value;
=20
-	port =3D tegra_xusb_find_usb2_port(padctl, lane->index);
+	port =3D tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
-		dev_err(&phy->dev, "no port found for USB2 lane %u\n",
-			lane->index);
+		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
 		return -ENODEV;
 	}
=20
@@ -1318,12 +2174,19 @@ static int tegra210_usb2_phy_power_off(struct phy *=
phy)
 	if (--pad->enable > 0)
 		goto out;
=20
+	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+	value |=3D XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+	value |=3D XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 	value |=3D XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
=20
 out:
-	regulator_disable(port->supply);
 	mutex_unlock(&padctl->lock);
 	return 0;
 }
@@ -2120,6 +2983,120 @@ static const struct phy_ops tegra210_sata_phy_ops =
=3D {
 	.owner =3D THIS_MODULE,
 };
=20
+static inline bool is_usb3_phy(struct phy *phy)
+{
+	return (phy->ops =3D=3D &tegra210_pcie_phy_ops ||
+		phy->ops =3D=3D &tegra210_sata_phy_ops);
+}
+
+static inline bool is_hsic_phy(struct phy *phy)
+{
+	return phy->ops =3D=3D &tegra210_hsic_phy_ops;
+}
+
+static inline bool is_utmi_phy(struct phy *phy)
+{
+	return phy->ops =3D=3D &tegra210_usb2_phy_ops;
+}
+
+static int
+tegra210_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl,
+				     struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra210_usb3_enable_phy_wake(phy);
+	else if (is_utmi_phy(phy))
+		return tegra210_utmi_enable_phy_wake(phy);
+	else if (is_hsic_phy(phy))
+		return tegra210_hsic_enable_phy_wake(phy);
+	else
+		return -EINVAL;
+}
+
+static int
+tegra210_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl,
+				      struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra210_usb3_disable_phy_wake(phy);
+	else if (is_utmi_phy(phy))
+		return tegra210_utmi_disable_phy_wake(phy);
+	else if (is_hsic_phy(phy))
+		return tegra210_hsic_disable_phy_wake(phy);
+	else
+		return -EINVAL;
+}
+
+int tegra210_xusb_padctl_remote_wake_detected(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+	struct tegra_xusb_padctl *padctl;
+
+	if (!phy)
+		return 0;
+
+	lane =3D phy_get_drvdata(phy);
+	padctl =3D lane->pad->padctl;
+
+	if (is_utmi_phy(phy))
+		return tegra210_utmi_phy_remote_wake_detected(padctl,
+					lane->index);
+	else if (is_hsic_phy(phy))
+		return tegra210_hsic_phy_remote_wake_detected(padctl,
+					lane->index);
+	else if (is_usb3_phy(phy))
+		return tegra210_usb3_phy_remote_wake_detected(padctl,
+					tegra210_usb3_lane_map(lane));
+
+	return -EINVAL;
+}
+
+static int
+tegra210_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl=
,
+					  struct phy *phy,
+					  enum usb_device_speed speed)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra210_usb3_enable_phy_sleepwalk(phy);
+	else if (is_utmi_phy(phy))
+		return tegra_pmc_utmi_enable_phy_sleepwalk(phy, speed);
+	else if (is_hsic_phy(phy))
+		return tegra_pmc_hsic_enable_phy_sleepwalk(phy);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+tegra210_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l,
+					   struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra210_usb3_disable_phy_sleepwalk(phy);
+	else if (is_utmi_phy(phy))
+		return tegra_pmc_utmi_disable_phy_sleepwalk(phy);
+	else if (is_hsic_phy(phy))
+		return tegra_pmc_hsic_disable_phy_sleepwalk(phy);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+
 static struct tegra_xusb_pad *
 tegra210_sata_pad_probe(struct tegra_xusb_padctl *padctl,
 			const struct tegra_xusb_pad_soc *soc,
@@ -2317,6 +3294,8 @@ tegra210_xusb_padctl_probe(struct device *dev,
 			   const struct tegra_xusb_padctl_soc *soc)
 {
 	struct tegra210_xusb_padctl *padctl;
+	struct device_node *node, *np =3D dev->of_node;
+	struct platform_device *pmc_dev;
 	int err;
=20
 	padctl =3D devm_kzalloc(dev, sizeof(*padctl), GFP_KERNEL);
@@ -2330,6 +3309,24 @@ tegra210_xusb_padctl_probe(struct device *dev,
 	if (err < 0)
 		return ERR_PTR(err);
=20
+	node =3D of_parse_phandle(np, "nvidia,pmc", 0);
+	if (!node) {
+		dev_err(dev, "nvidia,pmc property is missing\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	pmc_dev =3D of_find_device_by_node(node);
+	if (!pmc_dev) {
+		dev_err(dev, "pmc device is not available\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	padctl->pmc_reg =3D dev_get_regmap(&pmc_dev->dev, "usb_sleepwalk");
+	if (!padctl->pmc_reg) {
+		dev_err(dev, "pmc regmap is not available.\n");
+		return ERR_PTR(-ENODEV);
+	}
+
 	return &padctl->base;
 }
=20
@@ -2337,13 +3334,80 @@ static void tegra210_xusb_padctl_remove(struct tegr=
a_xusb_padctl *padctl)
 {
 }
=20
+static void tegra210_xusb_padctl_save(struct tegra_xusb_padctl *padctl)
+{
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+
+	priv->context.usb2_pad_mux =3D
+		padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
+	priv->context.usb2_port_cap =3D
+		padctl_readl(padctl, XUSB_PADCTL_USB2_PORT_CAP);
+	priv->context.ss_port_map =3D
+		padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+	priv->context.usb3_pad_mux =3D
+		padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
+}
+
+static void tegra210_xusb_padctl_restore(struct tegra_xusb_padctl *padctl)
+{
+	struct tegra210_xusb_padctl *priv =3D to_tegra210_xusb_padctl(padctl);
+	int i;
+
+	padctl_writel(padctl, priv->context.usb2_pad_mux,
+		XUSB_PADCTL_USB2_PAD_MUX);
+	padctl_writel(padctl, priv->context.usb2_port_cap,
+		XUSB_PADCTL_USB2_PORT_CAP);
+	padctl_writel(padctl, priv->context.ss_port_map,
+		XUSB_PADCTL_SS_PORT_MAP);
+
+	for (i =3D 0; i <=3D 7; i ++)
+		tegra210_uphy_lane_iddq_enable(padctl, i);
+
+	padctl_writel(padctl, priv->context.usb3_pad_mux,
+		XUSB_PADCTL_USB3_PAD_MUX);
+
+	for (i =3D 0; i <=3D 7; i ++)
+		tegra210_uphy_lane_iddq_disable(padctl, i);
+}
+
+static int tegra210_xusb_padctl_suspend_noirq(struct tegra_xusb_padctl *pa=
dctl)
+{
+	mutex_lock(&padctl->lock);
+
+	tegra210_uphy_deinit(padctl);
+
+	tegra210_xusb_padctl_save(padctl);
+
+	mutex_unlock(&padctl->lock);
+	return 0;
+}
+
+static int tegra210_xusb_padctl_resume_noirq(struct tegra_xusb_padctl *pad=
ctl)
+{
+	mutex_lock(&padctl->lock);
+
+	tegra210_xusb_padctl_restore(padctl);
+
+	tegra210_uphy_init(padctl);
+
+	mutex_unlock(&padctl->lock);
+	return 0;
+}
+
 static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops =3D {
 	.probe =3D tegra210_xusb_padctl_probe,
 	.remove =3D tegra210_xusb_padctl_remove,
+	.suspend_noirq =3D tegra210_xusb_padctl_suspend_noirq,
+	.resume_noirq =3D tegra210_xusb_padctl_resume_noirq,
 	.usb3_set_lfps_detect =3D tegra210_usb3_set_lfps_detect,
 	.hsic_set_idle =3D tegra210_hsic_set_idle,
 	.vbus_override =3D tegra210_xusb_padctl_vbus_override,
 	.utmi_port_reset =3D tegra210_utmi_port_reset,
+	.enable_phy_sleepwalk =3D tegra210_xusb_padctl_enable_phy_sleepwalk,
+	.disable_phy_sleepwalk =3D tegra210_xusb_padctl_disable_phy_sleepwalk,
+	.enable_phy_wake =3D tegra210_xusb_padctl_enable_phy_wake,
+	.disable_phy_wake =3D tegra210_xusb_padctl_disable_phy_wake,
+	.remote_wake_detected =3D tegra210_xusb_padctl_remote_wake_detected,
 };
=20
 static const char * const tegra210_xusb_padctl_supply_names[] =3D {
--=20
2.25.1

