Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCFD205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XHg0sa53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbgEMRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733008AbgEMRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:40:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48ACC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:40:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f23so68402pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jonk7T7t5Ncu8wp11LYJl0hUSoTwdIYfiEvWndcGPBw=;
        b=XHg0sa53jbkNskOMgrDGoZruvm9YrzCEO2FeGSbsv3gGC/mjpK+/mpFFZc38f9PTA4
         h0aEfipN2CNpAeyf6ds1dQ/64P0iTL6d8zpKUdSKzO9CYKfdmsIDqYLBJ9fHVOYxPQrA
         sAU+xS/hHNXro9Y7XeXVDcDnH6zdUSvah4RYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jonk7T7t5Ncu8wp11LYJl0hUSoTwdIYfiEvWndcGPBw=;
        b=SKvuLQ3CI/yMbB/W+ImFwmXn0Mvofg6dYOcBMLZIPRLA6w3OvEiMuBxAr/3qsvhi03
         is1qOiqJiyxAE5SARPCVjZFaPGfIasGGbBz+5uGJLV7M+Gs4s6IEsxwrkpQ/mo1HmGOC
         L2fqjKPbmn8E8C52JMWRZJ6exo5rBbZZNkX2Nwzu2RSB2KE1Gu2eihT8sXKbj3M7ygJU
         1b76P5Y86YVbN8JhH5Wtl8QEXOeu03aKLSfIXJVevQumLBVVw5ZOowGXazXypOQlS2wy
         4rz809VWnD1AgLt4sQA6ZDSNdWAKLspbA7iqBOq/hcK3nK1kplHJy+1bl2RV3fvA2aCN
         tnSw==
X-Gm-Message-State: AOAM532FJGNow1ivON4iJHL2W1AwGfrpfAMhsAPQn5IbRj1BcXmvnj8S
        GqHBNGMazeRQqJasQsFDHEW2yqbtQn8=
X-Google-Smtp-Source: ABdhPJzFcbg3OEanOgtpDxOooNhsWUAUbeQMJxNg0hu8kbrM65S8+kyFDuA1FzfS/fIQ1esPYzN8fA==
X-Received: by 2002:aa7:8042:: with SMTP id y2mr413352pfm.94.1589391602081;
        Wed, 13 May 2020 10:40:02 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o11sm251456pgp.62.2020.05.13.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 10:40:01 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] drivers: phy: sr-usb: do not use internal fsm for USB2 phy init
Date:   Wed, 13 May 2020 23:09:47 +0530
Message-Id: <20200513173947.10919-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Gooty <bharat.gooty@broadcom.com>

During different reboot cycles, USB PHY PLL may not always lock
during initialization and therefore can cause USB to be not usable.

Hence do not use internal FSM programming sequence for the USB
PHY initialization.

Fixes: 4dcddbb38b64 ("phy: sr-usb: Add Stingray USB PHY driver")
Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 55 +--------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index fe6c58910e4c..7c7862b4f41f 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -16,8 +16,6 @@ enum bcm_usb_phy_version {
 };
 
 enum bcm_usb_phy_reg {
-	PLL_NDIV_FRAC,
-	PLL_NDIV_INT,
 	PLL_CTRL,
 	PHY_CTRL,
 	PHY_PLL_CTRL,
@@ -31,18 +29,11 @@ static const u8 bcm_usb_combo_phy_ss[] = {
 };
 
 static const u8 bcm_usb_combo_phy_hs[] = {
-	[PLL_NDIV_FRAC]	= 0x04,
-	[PLL_NDIV_INT]	= 0x08,
 	[PLL_CTRL]	= 0x0c,
 	[PHY_CTRL]	= 0x10,
 };
 
-#define HSPLL_NDIV_INT_VAL	0x13
-#define HSPLL_NDIV_FRAC_VAL	0x1005
-
 static const u8 bcm_usb_hs_phy[] = {
-	[PLL_NDIV_FRAC]	= 0x0,
-	[PLL_NDIV_INT]	= 0x4,
 	[PLL_CTRL]	= 0x8,
 	[PHY_CTRL]	= 0xc,
 };
@@ -52,7 +43,6 @@ enum pll_ctrl_bits {
 	SSPLL_SUSPEND_EN,
 	PLL_SEQ_START,
 	PLL_LOCK,
-	PLL_PDIV,
 };
 
 static const u8 u3pll_ctrl[] = {
@@ -66,29 +56,17 @@ static const u8 u3pll_ctrl[] = {
 #define HSPLL_PDIV_VAL		0x1
 
 static const u8 u2pll_ctrl[] = {
-	[PLL_PDIV]	= 1,
 	[PLL_RESETB]	= 5,
 	[PLL_LOCK]	= 6,
 };
 
 enum bcm_usb_phy_ctrl_bits {
 	CORERDY,
-	AFE_LDO_PWRDWNB,
-	AFE_PLL_PWRDWNB,
-	AFE_BG_PWRDWNB,
-	PHY_ISO,
 	PHY_RESETB,
 	PHY_PCTL,
 };
 
 #define PHY_PCTL_MASK	0xffff
-/*
- * 0x0806 of PCTL_VAL has below bits set
- * BIT-8 : refclk divider 1
- * BIT-3:2: device mode; mode is not effect
- * BIT-1: soft reset active low
- */
-#define HSPHY_PCTL_VAL	0x0806
 #define SSPHY_PCTL_VAL	0x0006
 
 static const u8 u3phy_ctrl[] = {
@@ -98,10 +76,6 @@ static const u8 u3phy_ctrl[] = {
 
 static const u8 u2phy_ctrl[] = {
 	[CORERDY]		= 0,
-	[AFE_LDO_PWRDWNB]	= 1,
-	[AFE_PLL_PWRDWNB]	= 2,
-	[AFE_BG_PWRDWNB]	= 3,
-	[PHY_ISO]		= 4,
 	[PHY_RESETB]		= 5,
 	[PHY_PCTL]		= 6,
 };
@@ -186,38 +160,13 @@ static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
 	int ret = 0;
 	void __iomem *regs = phy_cfg->regs;
 	const u8 *offset;
-	u32 rd_data;
 
 	offset = phy_cfg->offset;
 
-	writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
-	writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
-
-	rd_data = readl(regs + offset[PLL_CTRL]);
-	rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
-	rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
-	writel(rd_data, regs + offset[PLL_CTRL]);
-
-	/* Set Core Ready high */
-	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
-			      BIT(u2phy_ctrl[CORERDY]));
-
-	/* Maximum timeout for Core Ready done */
-	msleep(30);
-
+	bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
+			      BIT(u2pll_ctrl[PLL_RESETB]));
 	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
 			      BIT(u2pll_ctrl[PLL_RESETB]));
-	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
-			      BIT(u2phy_ctrl[PHY_RESETB]));
-
-
-	rd_data = readl(regs + offset[PHY_CTRL]);
-	rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
-	rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
-	writel(rd_data, regs + offset[PHY_CTRL]);
-
-	/* Maximum timeout for PLL reset done */
-	msleep(30);
 
 	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
 				     BIT(u2pll_ctrl[PLL_LOCK]));
-- 
2.17.1

