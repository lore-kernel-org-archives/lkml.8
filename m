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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE57CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF25D2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FrXmRmKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHaElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:11 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9210 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgHaEk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7f4c0000>; Sun, 30 Aug 2020 21:40:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 30 Aug 2020 21:40:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:53 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:53 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f530000>; Sun, 30 Aug 2020 21:40:52 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 09/12] phy: tegra: xusb: t186: support wake and sleepwalk
Date:   Mon, 31 Aug 2020 12:40:40 +0800
Message-ID: <20200831044043.1561074-10-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848844; bh=7HR5Mf8CHzqteNzyJNjOXNidoq+LVT9dlnIe7QmIhd0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=FrXmRmKsPMDCxSM478gTxSmuWEh/5f1H1LrSeA61U3XEooinw7lvKPjX7uGgWbBHQ
         Rlb64DUNNFy3D3Dk+wruWMrRwqhlbSuipi3XADnk3nGPmPGUoYdL3pS7zKOQtOChlE
         t/4JkJsUNnPzpc49tqM7S7q6Ini8rYNUveXeL2sObAkcwsvyPNSouoExYYSxEbCEQO
         V+rSVJWGmJ8j1cfxcdCMYW3lsJrO1QGx/ymx5hFaVBXJ9cRakKe9SiRbBQ4LLDdbZV
         m8pNBKPnEZAykhAHqiU1gowFTYQd8Qj+O1wCw43g6iudlUZIaHHmdLMul94dTOpaj7
         e2K7SJzPg2kDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements Tegra186/Tegra194 XUSB PADCTL/AO wake and
sleepwalk operations.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 656 ++++++++++++++++++++++++++++++
 1 file changed, 656 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-teg=
ra186.c
index 5d64f69b39a9..ffa6bfb1e1ee 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -113,6 +113,117 @@
 #define  ID_OVERRIDE_FLOATING			ID_OVERRIDE(8)
 #define  ID_OVERRIDE_GROUNDED			ID_OVERRIDE(0)
=20
+/* XUSB AO registers */
+#define XUSB_AO_USB_DEBOUNCE_DEL		(0x4)
+#define   UHSIC_LINE_DEB_CNT(x)			(((x) & 0xf) << 4)
+#define   UTMIP_LINE_DEB_CNT(x)			((x) & 0xf)
+
+#define XUSB_AO_UTMIP_TRIGGERS(x)		(0x40 + (x) * 4)
+#define   CLR_WALK_PTR				(1 << 0)
+#define   CAP_CFG				(1 << 1)
+#define   CLR_WAKE_ALARM			(1 << 3)
+
+#define XUSB_AO_UHSIC_TRIGGERS(x)		(0x60 + (x) * 4)
+#define   HSIC_CLR_WALK_PTR			(1 << 0)
+#define   HSIC_CLR_WAKE_ALARM			(1 << 3)
+#define   HSIC_CAP_CFG				(1 << 4)
+
+#define XUSB_AO_UTMIP_SAVED_STATE(x)		(0x70 + (x) * 4)
+#define   SPEED(x)				((x) & 0x3)
+#define     UTMI_HS				SPEED(0)
+#define     UTMI_FS				SPEED(1)
+#define     UTMI_LS				SPEED(2)
+#define     UTMI_RST				SPEED(3)
+
+#define XUSB_AO_UHSIC_SAVED_STATE(x)		(0x90 + (x) * 4)
+#define   MODE(x)				((x) & 0x1)
+#define   MODE_HS				MODE(0)
+#define   MODE_RST				MODE(1)
+
+#define XUSB_AO_UTMIP_SLEEPWALK_CFG(x)		(0xd0 + (x) * 4)
+#define XUSB_AO_UHSIC_SLEEPWALK_CFG(x)		(0xf0 + (x) * 4)
+#define   FAKE_USBOP_VAL			(1 << 0)
+#define   FAKE_USBON_VAL			(1 << 1)
+#define   FAKE_USBOP_EN				(1 << 2)
+#define   FAKE_USBON_EN				(1 << 3)
+#define   FAKE_STROBE_VAL			(1 << 0)
+#define   FAKE_DATA_VAL				(1 << 1)
+#define   FAKE_STROBE_EN			(1 << 2)
+#define   FAKE_DATA_EN				(1 << 3)
+#define   WAKE_WALK_EN				(1 << 14)
+#define   MASTER_ENABLE				(1 << 15)
+#define   LINEVAL_WALK_EN			(1 << 16)
+#define   WAKE_VAL(x)				(((x) & 0xf) << 17)
+#define     WAKE_VAL_NONE			WAKE_VAL(12)
+#define     WAKE_VAL_ANY			WAKE_VAL(15)
+#define     WAKE_VAL_DS10			WAKE_VAL(2)
+#define   LINE_WAKEUP_EN			(1 << 21)
+#define   MASTER_CFG_SEL			(1 << 22)
+
+#define XUSB_AO_UTMIP_SLEEPWALK(x)		(0x100 + (x) * 4)
+/* phase A */
+#define   USBOP_RPD_A				(1 << 0)
+#define   USBON_RPD_A				(1 << 1)
+#define   AP_A					(1 << 4)
+#define   AN_A					(1 << 5)
+#define   HIGHZ_A				(1 << 6)
+/* phase B */
+#define   USBOP_RPD_B				(1 << 8)
+#define   USBON_RPD_B				(1 << 9)
+#define   AP_B					(1 << 12)
+#define   AN_B					(1 << 13)
+#define   HIGHZ_B				(1 << 14)
+/* phase C */
+#define   USBOP_RPD_C				(1 << 16)
+#define   USBON_RPD_C				(1 << 17)
+#define   AP_C					(1 << 20)
+#define   AN_C					(1 << 21)
+#define   HIGHZ_C				(1 << 22)
+/* phase D */
+#define   USBOP_RPD_D				(1 << 24)
+#define   USBON_RPD_D				(1 << 25)
+#define   AP_D					(1 << 28)
+#define   AN_D					(1 << 29)
+#define   HIGHZ_D				(1 << 30)
+
+#define XUSB_AO_UHSIC_SLEEPWALK(x)		(0x120 + (x) * 4)
+/* phase A */
+#define   RPD_STROBE_A				(1 << 0)
+#define   RPD_DATA0_A				(1 << 1)
+#define   RPU_STROBE_A				(1 << 2)
+#define   RPU_DATA0_A				(1 << 3)
+/* phase B */
+#define   RPD_STROBE_B				(1 << 8)
+#define   RPD_DATA0_B				(1 << 9)
+#define   RPU_STROBE_B				(1 << 10)
+#define   RPU_DATA0_B				(1 << 11)
+/* phase C */
+#define   RPD_STROBE_C				(1 << 16)
+#define   RPD_DATA0_C				(1 << 17)
+#define   RPU_STROBE_C				(1 << 18)
+#define   RPU_DATA0_C				(1 << 19)
+/* phase D */
+#define   RPD_STROBE_D				(1 << 24)
+#define   RPD_DATA0_D				(1 << 25)
+#define   RPU_STROBE_D				(1 << 26)
+#define   RPU_DATA0_D				(1 << 27)
+
+#define XUSB_AO_UTMIP_PAD_CFG(x)		(0x130 + (x) * 4)
+#define   FSLS_USE_XUSB_AO			(1 << 3)
+#define   TRK_CTRL_USE_XUSB_AO			(1 << 4)
+#define   RPD_CTRL_USE_XUSB_AO			(1 << 5)
+#define   RPU_USE_XUSB_AO			(1 << 6)
+#define   VREG_USE_XUSB_AO			(1 << 7)
+#define   USBOP_VAL_PD				(1 << 8)
+#define   USBON_VAL_PD				(1 << 9)
+#define   E_DPD_OVRD_EN				(1 << 10)
+#define   E_DPD_OVRD_VAL			(1 << 11)
+
+#define XUSB_AO_UHSIC_PAD_CFG(x)		(0x150 + (x) * 4)
+#define   STROBE_VAL_PD				(1 << 0)
+#define   DATA0_VAL_PD				(1 << 1)
+#define   USE_XUSB_AO				(1 << 4)
+
 #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
 	{								\
 		.name =3D _name,						\
@@ -130,16 +241,43 @@ struct tegra_xusb_fuse_calibration {
 	u32 rpd_ctrl;
 };
=20
+struct tegra186_xusb_padctl_context {
+	u32 vbus_id;
+	u32 usb2_pad_mux;
+	u32 usb2_port_cap;
+	u32 ss_port_cap;
+};
+
 struct tegra186_xusb_padctl {
 	struct tegra_xusb_padctl base;
+	void __iomem *ao_regs;
=20
 	struct tegra_xusb_fuse_calibration calib;
=20
 	/* UTMI bias and tracking */
 	struct clk *usb2_trk_clk;
 	unsigned int bias_pad_enable;
+
+	/* padctl context */
+	struct tegra186_xusb_padctl_context context;
 };
=20
+static inline void ao_writel(struct tegra186_xusb_padctl *priv, u32 value,
+			     unsigned long offset)
+{
+	dev_dbg(priv->base.dev, "ao %08lx < %08x\n", offset, value);
+	writel(value, priv->ao_regs + offset);
+}
+
+static inline u32 ao_readl(struct tegra186_xusb_padctl *priv,
+			   unsigned long offset)
+{
+	u32 value =3D readl(priv->ao_regs + offset);
+
+	dev_dbg(priv->base.dev, "ao %08lx > %08x\n", offset, value);
+	return value;
+}
+
 static inline struct tegra186_xusb_padctl *
 to_tegra186_xusb_padctl(struct tegra_xusb_padctl *padctl)
 {
@@ -475,6 +613,238 @@ static int tegra186_utmi_phy_power_off(struct phy *ph=
y)
 	return 0;
 }
=20
+static int tegra186_utmi_phy_enable_sleepwalk(struct phy *phy,
+					      enum usb_device_speed speed)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable sleepwalk UTMI %d speed %d\n", index, speed);
+
+	mutex_lock(&padctl->lock);
+
+	/* ensure sleepwalk logic is disabled */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~MASTER_ENABLE;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* ensure sleepwalk logics are in low power mode */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value |=3D MASTER_CFG_SEL;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* set debounce time */
+	value =3D ao_readl(priv, XUSB_AO_USB_DEBOUNCE_DEL);
+	value &=3D ~UTMIP_LINE_DEB_CNT(~0);
+	value |=3D UTMIP_LINE_DEB_CNT(1);
+	ao_writel(priv, value, XUSB_AO_USB_DEBOUNCE_DEL);
+
+	/* ensure fake events of sleepwalk logic are desiabled */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~(FAKE_USBOP_VAL | FAKE_USBON_VAL |
+		FAKE_USBOP_EN | FAKE_USBON_EN);
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* ensure wake events of sleepwalk logic are not latched */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~LINE_WAKEUP_EN;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* disable wake event triggers of sleepwalk logic */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~WAKE_VAL(~0);
+	value |=3D WAKE_VAL_NONE;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* power down the line state detectors of the pad */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
+	value |=3D (USBOP_VAL_PD | USBON_VAL_PD);
+	ao_writel(priv, value, XUSB_AO_UTMIP_PAD_CFG(index));
+
+	/* save state per speed */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SAVED_STATE(index));
+	value &=3D ~SPEED(~0);
+	if (speed =3D=3D USB_SPEED_HIGH)
+		value |=3D UTMI_HS;
+	else if (speed =3D=3D USB_SPEED_FULL)
+		value |=3D UTMI_FS;
+	else if (speed =3D=3D USB_SPEED_LOW)
+		value |=3D UTMI_LS;
+	else
+		value |=3D UTMI_RST;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SAVED_STATE(index));
+
+	/* enable the trigger of the sleepwalk logic */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value |=3D LINEVAL_WALK_EN;
+	value &=3D ~WAKE_WALK_EN;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
+	 * as well as capture the configuration of the USB2.0 pad
+	 */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_TRIGGERS(index));
+	value |=3D (CLR_WALK_PTR | CLR_WAKE_ALARM | CAP_CFG);
+	ao_writel(priv, value, XUSB_AO_UTMIP_TRIGGERS(index));
+
+	/* setup the pull-ups and pull-downs of the signals during the four
+	 * stages of sleepwalk.
+	 * if device is connected, program sleepwalk logic to maintain a J and
+	 * keep driving K upon seeing remote wake.
+	 */
+	value =3D (USBOP_RPD_A | USBOP_RPD_B | USBOP_RPD_C | USBOP_RPD_D);
+	value |=3D (USBON_RPD_A | USBON_RPD_B | USBON_RPD_C | USBON_RPD_D);
+	if (speed =3D=3D USB_SPEED_UNKNOWN) {
+		value |=3D (HIGHZ_A | HIGHZ_B | HIGHZ_C | HIGHZ_D);
+	} else if ((speed =3D=3D USB_SPEED_HIGH) || (speed =3D=3D USB_SPEED_FULL)=
) {
+		/* J state: D+/D- =3D high/low, K state: D+/D- =3D low/high */
+		value |=3D HIGHZ_A;
+		value |=3D (AP_A);
+		value |=3D (AN_B | AN_C | AN_D);
+	} else if (speed =3D=3D USB_SPEED_LOW) {
+		/* J state: D+/D- =3D low/high, K state: D+/D- =3D high/low */
+		value |=3D HIGHZ_A;
+		value |=3D AN_A;
+		value |=3D (AP_B | AP_C | AP_D);
+	}
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK(index));
+
+	/* power up the line state detectors of the pad */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
+	value &=3D ~(USBOP_VAL_PD | USBON_VAL_PD);
+	ao_writel(priv, value, XUSB_AO_UTMIP_PAD_CFG(index));
+
+	usleep_range(150, 200);
+
+	/* switch the electric control of the USB2.0 pad to XUSB_AO */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
+	value |=3D (FSLS_USE_XUSB_AO | TRK_CTRL_USE_XUSB_AO |
+		RPD_CTRL_USE_XUSB_AO | RPU_USE_XUSB_AO | VREG_USE_XUSB_AO);
+	ao_writel(priv, value, XUSB_AO_UTMIP_PAD_CFG(index));
+
+	/* set the wake signaling trigger events */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~WAKE_VAL(~0);
+	value |=3D WAKE_VAL_ANY;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* enable the wake detection */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value |=3D (MASTER_ENABLE | LINE_WAKEUP_EN);
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_utmi_phy_disable_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable sleepwalk UTMI %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	/* disable the wake detection */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~(MASTER_ENABLE | LINE_WAKEUP_EN);
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* switch the electric control of the USB2.0 pad to XUSB vcore logic */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
+	value &=3D ~(FSLS_USE_XUSB_AO | TRK_CTRL_USE_XUSB_AO |
+		RPD_CTRL_USE_XUSB_AO | RPU_USE_XUSB_AO | VREG_USE_XUSB_AO);
+	ao_writel(priv, value, XUSB_AO_UTMIP_PAD_CFG(index));
+
+	/* disable wake event triggers of sleepwalk logic */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+	value &=3D ~WAKE_VAL(~0);
+	value |=3D WAKE_VAL_NONE;
+	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
+
+	/* power down the line state detectors of the port */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_PAD_CFG(index));
+	value |=3D (USBOP_VAL_PD | USBON_VAL_PD);
+	ao_writel(priv, value, XUSB_AO_UTMIP_PAD_CFG(index));
+
+	/* clear alarm of the sleepwalk logic */
+	value =3D ao_readl(priv, XUSB_AO_UTMIP_TRIGGERS(index));
+	value |=3D CLR_WAKE_ALARM;
+	ao_writel(priv, value, XUSB_AO_UTMIP_TRIGGERS(index));
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_utmi_phy_enable_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable wake UTMI %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_utmi_phy_disable_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable wake UTMI %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value &=3D ~USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D USB2_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
 static int tegra186_utmi_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
@@ -538,6 +908,11 @@ static const struct phy_ops utmi_phy_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
+static inline bool is_utmi_phy(struct phy *phy)
+{
+	return phy->ops =3D=3D &utmi_phy_ops;
+}
+
 static struct tegra_xusb_pad *
 tegra186_usb2_pad_probe(struct tegra_xusb_padctl *padctl,
 			const struct tegra_xusb_pad_soc *soc,
@@ -790,6 +1165,120 @@ static int tegra186_usb3_phy_power_off(struct phy *p=
hy)
 	return 0;
 }
=20
+static int tegra186_usb3_phy_enable_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable sleepwalk USB3 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
+	value |=3D SSPX_ELPG_CLAMP_EN_EARLY(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
+	value |=3D SSPX_ELPG_CLAMP_EN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
+
+	usleep_range(250, 350);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_usb3_phy_disable_sleepwalk(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable sleepwalk USB3 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
+	value &=3D ~SSPX_ELPG_CLAMP_EN_EARLY(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
+
+	usleep_range(100, 200);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
+	value &=3D ~SSPX_ELPG_CLAMP_EN(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_usb3_phy_enable_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy enable wake USB3 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
+static int tegra186_usb3_phy_disable_wake(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane =3D phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl =3D lane->pad->padctl;
+	unsigned int index =3D lane->index;
+	struct device *dev =3D padctl->dev;
+	u32 value;
+
+	dev_dbg(dev, "phy disable wake USB3 %d\n", index);
+
+	mutex_lock(&padctl->lock);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value &=3D ~SS_PORT_WAKE_INTERRUPT_ENABLE(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	usleep_range(10, 20);
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	value &=3D ~ALL_WAKE_EVENTS;
+	value |=3D SS_PORT_WAKEUP_EVENT(index);
+	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM);
+
+	mutex_unlock(&padctl->lock);
+
+	return 0;
+}
+
 static int tegra186_usb3_phy_init(struct phy *phy)
 {
 	return 0;
@@ -808,6 +1297,11 @@ static const struct phy_ops usb3_phy_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
+static inline bool is_usb3_phy(struct phy *phy)
+{
+	return phy->ops =3D=3D &usb3_phy_ops;
+}
+
 static struct tegra_xusb_pad *
 tegra186_usb3_pad_probe(struct tegra_xusb_padctl *padctl,
 			const struct tegra_xusb_pad_soc *soc,
@@ -913,7 +1407,9 @@ static struct tegra_xusb_padctl *
 tegra186_xusb_padctl_probe(struct device *dev,
 			   const struct tegra_xusb_padctl_soc *soc)
 {
+	struct platform_device *pdev =3D to_platform_device(dev);
 	struct tegra186_xusb_padctl *priv;
+	struct resource *res;
 	int err;
=20
 	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -923,6 +1419,11 @@ tegra186_xusb_padctl_probe(struct device *dev,
 	priv->base.dev =3D dev;
 	priv->base.soc =3D soc;
=20
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ao");
+	priv->ao_regs =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->ao_regs))
+		return priv->ao_regs;
+
 	err =3D tegra186_xusb_read_fuse_calibration(priv);
 	if (err < 0)
 		return ERR_PTR(err);
@@ -930,6 +1431,154 @@ tegra186_xusb_padctl_probe(struct device *dev,
 	return &priv->base;
 }
=20
+static void tegra186_xusb_padctl_save(struct tegra_xusb_padctl *padctl)
+{
+	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
+
+	priv->context.vbus_id =3D padctl_readl(padctl, USB2_VBUS_ID);
+	priv->context.usb2_pad_mux =3D
+				padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
+	priv->context.usb2_port_cap =3D
+				padctl_readl(padctl, XUSB_PADCTL_USB2_PORT_CAP);
+	priv->context.ss_port_cap =3D
+				padctl_readl(padctl, XUSB_PADCTL_SS_PORT_CAP);
+}
+
+static void tegra186_xusb_padctl_restore(struct tegra_xusb_padctl *padctl)
+{
+	struct tegra186_xusb_padctl *priv =3D to_tegra186_xusb_padctl(padctl);
+
+	padctl_writel(padctl, priv->context.usb2_pad_mux,
+			XUSB_PADCTL_USB2_PAD_MUX);
+	padctl_writel(padctl, priv->context.usb2_port_cap,
+			XUSB_PADCTL_USB2_PORT_CAP);
+	padctl_writel(padctl, priv->context.ss_port_cap,
+			XUSB_PADCTL_SS_PORT_CAP);
+	padctl_writel(padctl, priv->context.vbus_id, USB2_VBUS_ID);
+}
+
+static int tegra186_xusb_padctl_suspend_noirq(struct tegra_xusb_padctl *pa=
dctl)
+{
+	tegra186_xusb_padctl_save(padctl);
+
+	return 0;
+}
+
+static int tegra186_xusb_padctl_resume_noirq(struct tegra_xusb_padctl *pad=
ctl)
+{
+	tegra186_xusb_padctl_restore(padctl);
+
+	return 0;
+}
+
+static int
+tegra186_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl=
,
+					  struct phy *phy,
+					  enum usb_device_speed speed)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra186_usb3_phy_enable_sleepwalk(phy);
+	else if (is_utmi_phy(phy))
+		return tegra186_utmi_phy_enable_sleepwalk(phy, speed);
+	else
+		return -EINVAL;
+}
+
+static int
+tegra186_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l,
+					   struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra186_usb3_phy_disable_sleepwalk(phy);
+	else if (is_utmi_phy(phy))
+		return tegra186_utmi_phy_disable_sleepwalk(phy);
+	else
+		return -EINVAL;
+}
+
+static int
+tegra186_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl,
+				     struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra186_usb3_phy_enable_wake(phy);
+	else if (is_utmi_phy(phy))
+		return tegra186_utmi_phy_enable_wake(phy);
+	else
+		return -EINVAL;
+}
+
+static int
+tegra186_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl,
+				      struct phy *phy)
+{
+	if (!phy)
+		return 0;
+
+	if (is_usb3_phy(phy))
+		return tegra186_usb3_phy_disable_wake(phy);
+	else if (is_utmi_phy(phy))
+		return tegra186_utmi_phy_disable_wake(phy);
+	else
+		return -EINVAL;
+}
+
+static int tegra186_usb3_phy_remote_wake_detected(
+			struct tegra_xusb_padctl *padctl, int port)
+{
+	u32 value;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	if ((value & SS_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
+			(value & SS_PORT_WAKEUP_EVENT(port)))
+		return true;
+	else
+		return false;
+}
+
+static int tegra186_utmi_phy_remote_wake_detected(
+			struct tegra_xusb_padctl *padctl, int port)
+{
+	u32 value;
+
+	value =3D padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM);
+	if ((value & USB2_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
+			(value & USB2_PORT_WAKEUP_EVENT(port)))
+		return true;
+	else
+		return false;
+}
+
+int tegra186_xusb_padctl_remote_wake_detected(struct phy *phy)
+{
+	struct tegra_xusb_lane *lane;
+	struct tegra_xusb_padctl *padctl;
+	unsigned int index;
+
+	if (!phy)
+		return 0;
+
+	lane =3D phy_get_drvdata(phy);
+	padctl =3D lane->pad->padctl;
+	index =3D lane->index;
+
+	if (is_utmi_phy(phy))
+		return tegra186_utmi_phy_remote_wake_detected(padctl, index);
+	else if (is_usb3_phy(phy))
+		return tegra186_usb3_phy_remote_wake_detected(padctl, index);
+	else
+		return -EINVAL;
+}
+
 static void tegra186_xusb_padctl_remove(struct tegra_xusb_padctl *padctl)
 {
 }
@@ -937,7 +1586,14 @@ static void tegra186_xusb_padctl_remove(struct tegra_=
xusb_padctl *padctl)
 static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops =3D {
 	.probe =3D tegra186_xusb_padctl_probe,
 	.remove =3D tegra186_xusb_padctl_remove,
+	.suspend_noirq =3D tegra186_xusb_padctl_suspend_noirq,
+	.resume_noirq =3D tegra186_xusb_padctl_resume_noirq,
 	.vbus_override =3D tegra186_xusb_padctl_vbus_override,
+	.enable_phy_sleepwalk =3D tegra186_xusb_padctl_enable_phy_sleepwalk,
+	.disable_phy_sleepwalk =3D tegra186_xusb_padctl_disable_phy_sleepwalk,
+	.enable_phy_wake =3D tegra186_xusb_padctl_enable_phy_wake,
+	.disable_phy_wake =3D tegra186_xusb_padctl_disable_phy_wake,
+	.remote_wake_detected =3D tegra186_xusb_padctl_remote_wake_detected,
 };
=20
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
--=20
2.25.1

