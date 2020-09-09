Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B172087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NraWnera"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIIILW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:11:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12051 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:11:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588e130000>; Wed, 09 Sep 2020 01:10:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:11:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 01:11:12 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:11:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:11:10 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e1c0000>; Wed, 09 Sep 2020 01:11:10 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 11/15] phy: tegra: xusb: Tegra210 host mode VBUS control
Date:   Wed, 9 Sep 2020 16:10:37 +0800
Message-ID: <20200909081041.3190157-12-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599639059; bh=/+v/a0mQbmIBDmSiEKNmWQwCJDJt9Umn01FVAlHSlRY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=NraWnerafSOF0RMo0CaDU4C/o0Obvdpjrj/sVYl3dvtYQYtaApYOlN7k2lKaqFvvz
         YR0JtUbXYexEDL1mG/9QkqFZ1Yf3pU9kIQxZykO2JrrPfgPZW9hAzp7oIEbEX53GtV
         6wzsPnNb35NyIbaecWoRY6jQWpwv9j2DEcQCfgd9EZjbEIoQg5U0K3trAgkHrPwe/u
         adsoyD1shx0V9H/2ah48/n2lCQVhPqLasL60QGxhrfmof8CQJmsAGk0MiJVkpkVn+e
         FE8wPWkNYKljDleOhglOxYbpX8sAxw7W253knaV1QCU4LI+mx9ty1g6JRBtlSeKe99
         sen7CZol/ue6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support XUSB host controller ELPG, this commit moves VBUS control
.phy_power_on()/.phy_power_off() to .phy_init()/.phy_exit().
When XUSB host controller enters ELPG, host driver invokes
.phy_power_off(), VBUS should remain ON so that USB devices will not
disconnect. VBUS can be turned OFF when host driver invokes
.phy_exit() which indicates disabling a USB port.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v3:
   new, was a part of "phy: tegra: xusb: Add wake/sleepwalk for Tegra210"

 drivers/phy/tegra/xusb-tegra210.c | 52 ++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-teg=
ra210.c
index 36949039e529..0cc6b6fd8474 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -1834,8 +1834,25 @@ static int tegra210_usb2_phy_init(struct phy *phy)
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
+	if (port->supply && port->mode =3D=3D USB_DR_MODE_HOST) {
+		err =3D regulator_enable(port->supply);
+		if (err)
+			return err;
+	}
+
+	mutex_lock(&padctl->lock);
+
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
 	value &=3D ~(XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_MASK <<
 		   XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT);
@@ -1843,11 +1860,30 @@ static int tegra210_usb2_phy_init(struct phy *phy)
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
+	struct tegra_xusb_usb2_port *port;
+	int err;
+
+	port =3D tegra_xusb_find_usb2_port(padctl, lane->index);
+	if (!port) {
+		dev_err(&phy->dev, "no port found for USB2 lane %u\n", lane->index);
+		return -ENODEV;
+	}
+
+	if (port->supply && port->mode =3D=3D USB_DR_MODE_HOST) {
+		err =3D regulator_disable(port->supply);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
=20
@@ -1968,6 +2004,8 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
)
=20
 	priv =3D to_tegra210_xusb_padctl(padctl);
=20
+	mutex_lock(&padctl->lock);
+
 	if (port->usb3_port_fake !=3D -1) {
 		value =3D padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
 		value &=3D ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(
@@ -2061,14 +2099,6 @@ static int tegra210_usb2_phy_power_on(struct phy *ph=
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
@@ -2077,7 +2107,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
)
=20
 	err =3D clk_prepare_enable(pad->clk);
 	if (err)
-		goto disable_regulator;
+		goto out;
=20
 	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value &=3D ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
@@ -2109,8 +2139,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy=
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
@@ -2169,7 +2198,6 @@ static int tegra210_usb2_phy_power_off(struct phy *ph=
y)
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
=20
 out:
-	regulator_disable(port->supply);
 	mutex_unlock(&padctl->lock);
 	return 0;
 }
--=20
2.25.1

