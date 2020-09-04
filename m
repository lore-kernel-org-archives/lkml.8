Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB27C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B4020791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215042;
	bh=Yw08YHmku4/vzFPd7/maIhyRgwd1kmnlbBptyUii8dE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=WNUZdxEjWXM/9aJltfQq0AyHeCpfH+21kht2V8UwH22OyAf84YZ1d/GaBhpI/fumO
	 05fFxSCA1VTQKLhpPitT3M2QWRjcMi33fs5d34aCTCa+5oO42SM3ySvhFtNevlZiPB
	 EaEUxckQY0ghl6I+N0cOyq4XPXvDJJ9yaWFF9E4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgIDKX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIDKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:36 -0400
Received: from mail.kernel.org (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B9920791;
        Fri,  4 Sep 2020 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215016;
        bh=Yw08YHmku4/vzFPd7/maIhyRgwd1kmnlbBptyUii8dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpyFweBuqTOoO4JAKuwMM2ZyFrrwyWQPmqJbwplXirAhA16Y9tqZGPZDM40/2edry
         Hdd4/+LtIeE0zt7Oc2dEMfOX86QST9b6mbfxaw2aO7loYhCFG48vSn5g4ViACA6KXL
         YxKzvXM55bV/2i3iym3m52VhD7lGzzhg51av5Lfw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kE8sX-005Sv8-NZ; Fri, 04 Sep 2020 12:23:33 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC 02/10] phy: hisilicon: phy-hi3670-usb3: fix some issues at the init code
Date:   Fri,  4 Sep 2020 12:23:24 +0200
Message-Id: <2388056218678d2409e904a385678e832fdd7150.1599214329.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599214329.git.mchehab+huawei@kernel.org>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

There are some problems at the initialization part of this phy.
Solve them.

Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/phy/hisilicon/phy-hi3670-usb3.c | 70 +++++++++++--------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-usb3.c b/drivers/phy/hisilicon/phy-hi3670-usb3.c
index 4e04ac97728d..1d4caf7a2aaf 100644
--- a/drivers/phy/hisilicon/phy-hi3670-usb3.c
+++ b/drivers/phy/hisilicon/phy-hi3670-usb3.c
@@ -63,6 +63,7 @@
 #define TCA_INTR_STS			(0x208)
 #define TCA_GCFG			(0x210)
 #define TCA_TCPC			(0x214)
+#define TCA_SYSMODE_CFG			(0x218)
 #define TCA_VBUS_CTRL			(0x240)
 
 #define CTRL0_USB3_VBUSVLD		BIT(7)
@@ -109,12 +110,16 @@
 #define CLK_RST_SUSPEND_CLK_EN		BIT(0)
 
 #define GCFG_ROLE_HSTDEV		BIT(4)
+#define GCFG_OP_MODE			(3 << 0)
+#define GCFG_OP_MODE_CTRL_SYNC_MODE	BIT(0)
 
 #define TCPC_VALID			BIT(4)
 #define TCPC_LOW_POWER_EN		BIT(3)
 #define TCPC_MUX_CONTROL_MASK		(3 << 0)
 #define TCPC_MUX_CONTROL_USB31		(1 << 0)
 
+#define SYSMODE_CFG_TYPEC_DISABLE	BIT(3)
+
 #define VBUS_CTRL_POWERPRESENT_OVERRD	(3 << 2)
 #define VBUS_CTRL_VBUSVALID_OVERRD	(3 << 0)
 
@@ -363,6 +368,11 @@ static int kirin970_config_phy_clock(struct kirin970_priv *priv)
 		if (ret)
 			goto out;
 
+		/* enable usb_tcxo_en */
+		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
+				USB_TCXO_EN |
+				(USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START));
+
 		/* select usbphy clk from abb */
 		mask = SC_CLK_USB3PHY_3MUX1_SEL;
 		ret = regmap_update_bits(priv->pctrl,
@@ -437,7 +447,13 @@ static int kirin970_config_tca(struct kirin970_priv *priv)
 		goto out;
 
 	ret = regmap_update_bits(priv->usb31misc, TCA_GCFG,
-			GCFG_ROLE_HSTDEV, GCFG_ROLE_HSTDEV);
+			GCFG_ROLE_HSTDEV | GCFG_OP_MODE,
+			GCFG_ROLE_HSTDEV | GCFG_OP_MODE_CTRL_SYNC_MODE);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(priv->usb31misc, TCA_SYSMODE_CFG,
+			SYSMODE_CFG_TYPEC_DISABLE, 0);
 	if (ret)
 		goto out;
 
@@ -461,18 +477,15 @@ static int kirin970_config_tca(struct kirin970_priv *priv)
 	return ret;
 }
 
-static int kirin970_phy_exit(struct phy *phy);
-
 static int kirin970_phy_init(struct phy *phy)
 {
 	struct kirin970_priv *priv = phy_get_drvdata(phy);
 	u32 val;
 	int ret;
 
-	kirin970_phy_exit(phy);
-	dev_info(priv->dev, "%s in\n", __func__);
 	/* assert controller */
-	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
+	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET |
+		CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, 0);
 	if (ret)
 		goto out;
@@ -493,6 +506,14 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
+	/* Deassert phy */
+	val = CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
+	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
+	if (ret)
+		goto out;
+
+	udelay(100);
+
 	/* Tell the PHY power is stable */
 	val = CFG54_USB3_PHY0_ANA_PWR_EN | CFG54_PHY0_PCS_PWR_STABLE |
 		CFG54_PHY0_PMA_PWR_STABLE;
@@ -512,14 +533,6 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	/* Deassert phy */
-	val = CFGA0_USB3PHY_RESET | CFGA0_USB2PHY_POR;
-	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
-	if (ret)
-		goto out;
-
-	udelay(100);
-
 	/* Deassert controller */
 	val = CFGA0_VAUX_RESET | CFGA0_USB31C_RESET;
 	ret = regmap_update_bits(priv->usb31misc, USB_MISC_CFGA0, val, val);
@@ -545,29 +558,6 @@ static int kirin970_phy_init(struct phy *phy)
 	if (ret)
 		goto out;
 
-	{
-		ret = regmap_read(priv->peri_crg, 0x4c,
-				&val);
-		if (!ret)
-			dev_info(priv->dev, "peri_crg 0x4c %x\n", val);
-		ret = regmap_read(priv->peri_crg, 0x404,
-				&val);
-		if (!ret)
-			dev_info(priv->dev, "peri_crg 0x404 %x\n", val);
-		ret = regmap_read(priv->peri_crg, 0xc,
-				&val);
-		if (!ret)
-			dev_info(priv->dev, "peri_crg 0xc %x\n", val);
-		ret = regmap_read(priv->peri_crg, 0xac,
-				&val);
-		if (!ret)
-			dev_info(priv->dev, "peri_crg 0xac %x\n", val);
-		ret = regmap_read(priv->pctrl, 0x10,
-				&val);
-		if (!ret)
-			dev_info(priv->dev, "pctrl 0x10 %x\n", val);
-	}
-
 	return 0;
 out:
 	dev_err(priv->dev, "failed to init phy ret: %d\n", ret);
@@ -586,7 +576,11 @@ static int kirin970_phy_exit(struct phy *phy)
 	if (ret)
 		goto out;
 
-	if (!kirin970_is_abbclk_seleted(priv)) {
+	if (kirin970_is_abbclk_seleted(priv)) {
+		/* disable usb_tcxo_en */
+		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
+				USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
+	} else {
 		ret = regmap_write(priv->peri_crg, PERI_CRG_PERDIS6,
 				GT_CLK_USB2PHY_REF);
 		if (ret)
-- 
2.26.2

