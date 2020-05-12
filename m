Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44100C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB524927
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tC62i/6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgELWYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731988AbgELWYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FC9C061A0C;
        Tue, 12 May 2020 15:24:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so24092745wmj.3;
        Tue, 12 May 2020 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWp37uKUDpwomXWa/aIQXLmU2FLlzJyWeA81xl/sOwk=;
        b=tC62i/6xkzIkxqgPl9BJqQyxGIvTg5pd3zHGsIWyYc1BB2pk+poW0X33w5qgL8af3U
         MoQ2pX+pua0szFl29Qhlmsea5fayxALBOtqBV7+8GGbNLq6qKJzGOVtYKLk0LHzt8J1o
         svg9uEpuoNrqkCK0e7sH2caNhMztgiWR9sFgPXSPuVZY1LFm+hLsYzRRjnw1SBolXJ+W
         l9VuNS+WuUvSFJTBFFl6F65Z++OVIyl0EPTvNXmDLYeEMhJePd4JBBPThfQ8VRak/Ef9
         ytG6OOgWMbshtPdYywM1cc8tiH4sjPqCN0oLBzBID9TOqM1i2O1a45bV2YkXsHaCkB6P
         s0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWp37uKUDpwomXWa/aIQXLmU2FLlzJyWeA81xl/sOwk=;
        b=dvHcYuNhXKpcfBaBhMuo0DEZwmAuapW9isaCDrbNtYXdXM38KffNMkDUhxlZkRoDQ0
         xqQo7oFrvVJSGedWSg7BQoeF1zWSwbE4tvbHmnyNQmgCg9uuLlMYD/JR7aBUTwx4qoro
         ps1rM1YJ1PY6gLAlQhM8/8iveP3S/IHntEKPBMrn1+AUB1LGuai9eqAaPQaa9J/yPBO0
         J8hFag0vTIQRSuJ/I8dmVn2jekPQM9WQt1lzi8+NuenALOPpRZB4/y6ONG13l6d3Ydrr
         NyCSOKZgNWJ60CTfyklTJ4fVsHBLAa53mIailNjaVB8yfUVQcEYgv7LqQwxgKfejwHj1
         u21Q==
X-Gm-Message-State: AGi0PuapYcmcjxhkTRUF782x8WSRWNpqgfGaDHfhOCkIS68uBWrVo7vo
        D49CUTwzSFdOb5Pw9eLb9rw=
X-Google-Smtp-Source: APiQypI8HaPJS6tn/3p1+VJ3j0duckvAyujR9VAElNDzCa/9oefAMAjeT0RqFgb8MsChyKF/SDPM9g==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr39644193wma.32.1589322279649;
        Tue, 12 May 2020 15:24:39 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH v2 5/6] phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
Date:   Wed, 13 May 2020 00:24:23 +0200
Message-Id: <20200512222424.549351-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor driver unsets the set_iddig bit during power-on as well and
sets it when suspending the PHY. I did not notice this in the vendor
driver first, because it's part of the dwc_otg driver there (instead of
their PHY code). While here, also add all other REG_DBG_UART register
bit definitions.

Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 44 +++++++++++++++++++-------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 7236b8885f07..436dfa1a8a04 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -78,6 +78,17 @@
 	#define REG_ADP_BC_ACA_PIN_FLOAT		BIT(26)
 
 #define REG_DBG_UART					0x10
+	#define REG_DBG_UART_BYPASS_SEL			BIT(0)
+	#define REG_DBG_UART_BYPASS_DM_EN		BIT(1)
+	#define REG_DBG_UART_BYPASS_DP_EN		BIT(2)
+	#define REG_DBG_UART_BYPASS_DM_DATA		BIT(3)
+	#define REG_DBG_UART_BYPASS_DP_DATA		BIT(4)
+	#define REG_DBG_UART_FSV_MINUS			BIT(5)
+	#define REG_DBG_UART_FSV_PLUS			BIT(6)
+	#define REG_DBG_UART_FSV_BURN_IN_TEST		BIT(7)
+	#define REG_DBG_UART_LOOPBACK_EN_B		BIT(8)
+	#define REG_DBG_UART_SET_IDDQ			BIT(9)
+	#define REG_DBG_UART_ATE_RESET			BIT(10)
 
 #define REG_TEST					0x14
 	#define REG_TEST_DATA_IN_MASK			GENMASK(3, 0)
@@ -172,20 +183,24 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
 			   REG_CTRL_SOF_TOGGLE_OUT);
 
-	if (priv->dr_mode == USB_DR_MODE_HOST &&
-	    priv->match->host_enable_aca) {
-		regmap_update_bits(priv->regmap, REG_ADP_BC,
-				   REG_ADP_BC_ACA_ENABLE,
-				   REG_ADP_BC_ACA_ENABLE);
+	if (priv->dr_mode == USB_DR_MODE_HOST) {
+		regmap_update_bits(priv->regmap, REG_DBG_UART,
+				   REG_DBG_UART_SET_IDDQ, 0);
 
-		udelay(ACA_ENABLE_COMPLETE_TIME);
+		if (priv->match->host_enable_aca) {
+			regmap_update_bits(priv->regmap, REG_ADP_BC,
+					   REG_ADP_BC_ACA_ENABLE,
+					   REG_ADP_BC_ACA_ENABLE);
 
-		regmap_read(priv->regmap, REG_ADP_BC, &reg);
-		if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
-			dev_warn(&phy->dev, "USB ID detect failed!\n");
-			clk_disable_unprepare(priv->clk_usb);
-			clk_disable_unprepare(priv->clk_usb_general);
-			return -EINVAL;
+			udelay(ACA_ENABLE_COMPLETE_TIME);
+
+			regmap_read(priv->regmap, REG_ADP_BC, &reg);
+			if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
+				dev_warn(&phy->dev, "USB ID detect failed!\n");
+				clk_disable_unprepare(priv->clk_usb);
+				clk_disable_unprepare(priv->clk_usb_general);
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -196,6 +211,11 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
 
+	if (priv->dr_mode == USB_DR_MODE_HOST)
+		regmap_update_bits(priv->regmap, REG_DBG_UART,
+				   REG_DBG_UART_SET_IDDQ,
+				   REG_DBG_UART_SET_IDDQ);
+
 	clk_disable_unprepare(priv->clk_usb);
 	clk_disable_unprepare(priv->clk_usb_general);
 
-- 
2.26.2

