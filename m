Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6504522BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SA7PZ/M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH0M5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:57:38 -0400
Received: from crapouillou.net ([89.234.176.41]:42734 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgH0Mnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598532197; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0ZtwP1c/sJ4SdbZpKm+NV8oKuu6my90hUTCqZcK5Zw=;
        b=SA7PZ/M9ll9qPxYzdGB92o6d3yUokaC42ro+k1uQk9KQfLQHFOuF4r8vlpy6goDKJrA2bk
        +sdpEyCcF0I/7NZ38Jlk4GugnXVU0AzwlOcxsdLlYrd24CjMrMKNMWwHgkbjBrDkx4Ga7n
        Qi2nj5M1KoAlyFD9e7F+jOaDpJSfyYE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?q?=E5=91=A8=E6=AD=A3?= <sernia.zhou@foxmail.com>,
        =?UTF-8?q?=E6=BC=86=E9=B9=8F=E6=8C=AF?= <aric.pzqi@ingenic.com>
Cc:     od@zcrc.me, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written to HW register
Date:   Thu, 27 Aug 2020 14:43:08 +0200
Message-Id: <20200827124308.71963-2-paul@crapouillou.net>
In-Reply-To: <20200827124308.71963-1-paul@crapouillou.net>
References: <20200827124308.71963-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reg' value was written to a hardware register in
ingenic_usb_phy_init(), while not being initialized anywhere.

Fixes: 2a6c0b82e651 ("USB: PHY: JZ4770: Add support for new Ingenic SoCs.")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/phy/phy-jz4770.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/phy/phy-jz4770.c b/drivers/usb/phy/phy-jz4770.c
index d4ee3cb721ea..58771a8688f2 100644
--- a/drivers/usb/phy/phy-jz4770.c
+++ b/drivers/usb/phy/phy-jz4770.c
@@ -97,7 +97,7 @@ enum ingenic_usb_phy_version {
 struct ingenic_soc_info {
 	enum ingenic_usb_phy_version version;
 
-	void (*usb_phy_init)(struct usb_phy *phy);
+	u32 (*usb_phy_init)(struct usb_phy *phy);
 };
 
 struct jz4770_phy {
@@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct usb_phy *phy)
 		return err;
 	}
 
-	priv->soc_info->usb_phy_init(phy);
+	reg = priv->soc_info->usb_phy_init(phy);
+	writel(reg, priv->base + REG_USBPCR_OFFSET);
 
 	/* Wait for PHY to reset */
 	usleep_range(30, 300);
@@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void *phy)
 	usb_remove_phy(phy);
 }
 
-static void jz4770_usb_phy_init(struct usb_phy *phy)
+static u32 jz4770_usb_phy_init(struct usb_phy *phy)
 {
-	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
-	u32 reg;
-
-	reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
+	return USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
 		USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT | USBPCR_SQRXTUNE_DFT |
 		USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT | USBPCR_TXVREFTUNE_DFT |
 		USBPCR_POR;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
 }
 
-static void jz4780_usb_phy_init(struct usb_phy *phy)
+static u32 jz4780_usb_phy_init(struct usb_phy *phy)
 {
 	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
 	u32 reg;
@@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct usb_phy *phy)
 		USBPCR1_WORD_IF_16BIT;
 	writel(reg, priv->base + REG_USBPCR1_OFFSET);
 
-	reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
+	return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
 }
 
-static void x1000_usb_phy_init(struct usb_phy *phy)
+static u32 x1000_usb_phy_init(struct usb_phy *phy)
 {
 	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
 	u32 reg;
@@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct usb_phy *phy)
 	reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_WORD_IF_16BIT;
 	writel(reg, priv->base + REG_USBPCR1_OFFSET);
 
-	reg = USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
+	return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
 		USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
 		USBPCR_COMMONONN | USBPCR_POR;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
 }
 
-static void x1830_usb_phy_init(struct usb_phy *phy)
+static u32 x1830_usb_phy_init(struct usb_phy *phy)
 {
 	struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
 	u32 reg;
@@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy *phy)
 		USBPCR1_DMPD | USBPCR1_DPPD;
 	writel(reg, priv->base + REG_USBPCR1_OFFSET);
 
-	reg = USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |	USBPCR_TXPREEMPHTUNE |
+	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT | USBPCR_TXPREEMPHTUNE |
 		USBPCR_COMMONONN | USBPCR_POR;
-	writel(reg, priv->base + REG_USBPCR_OFFSET);
 }
 
 static const struct ingenic_soc_info jz4770_soc_info = {
-- 
2.28.0

