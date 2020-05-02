Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C7C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55AF2137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mQO1vAah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgEBLsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgEBLsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93185C061A0E;
        Sat,  2 May 2020 04:48:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so2865247wmb.4;
        Sat, 02 May 2020 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFrTvx+NxMxb/mwf/W0nW+oiG0vsywqTnE4GJN3UIxU=;
        b=mQO1vAah1awiL1cd9B9FKjUGKvTguiIo6ue62NQGEd/SAs/xmnzmR6H7yJ5jmQmXC8
         /lyyWRHwBccwKHjnXSW+EvnTCWBs754KrmhDJT+ZW+5RZ/0LMCRk00jU46T0PCIr/IMv
         nVmYZzHIF4FN672ObxrKtElXfJxAC+8YBRtN/sFuTcBnOxe78gtlv6m6gafZ3n7S49LL
         0JMCSIzmdsnDLC+6uv9/5fN301Dd2oPe2PkGd2vg+DR4hOoRGnMRDwELBkV0RrDv9SV6
         nej0IZDaze0QLtT95MJ7Ig3vCBHSt0IUM+CabziNLggQz720D1vhoTjsivmkzvhxoHzA
         OyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFrTvx+NxMxb/mwf/W0nW+oiG0vsywqTnE4GJN3UIxU=;
        b=qvAjPU1ZBSDCjSoXl5GHb7DCQu3kbEQ1ghCj9JeCgyH0NegFVFBsRKQSwZ2hmk3Xjn
         CmISEYZkR8nFXWe6+L63TMZ72TeRYNH+L6UCvCLRIhQVTHA6OcuFOGhEyp3TuHjSdbku
         7S/TVf2A9Ke1IpDMb0LQp1eWr1mjs6R1WlpiQbx20Nr/zrC4Vky6r9gW27EgsgLQbEOA
         l4lgSH4z0yXdQQn90f0YV9idOFztFcZQEMgUy5ZcNZDmgKlQfal6ISl8wNuEp/EQGGvE
         9D5vhz4dqSKORBEnfn7+Xp1AGL4HWqYm8tn+kIUEB2UjYuN2TULFOHD9i9sW5x+SHZxB
         Vl9A==
X-Gm-Message-State: AGi0PubCFsHQFaLLYZKyN5fqC61wBmeYUA46Ia2yau49wu4dWzfu9kpY
        HX6qRzXRhczHKb7wwGvEm/8=
X-Google-Smtp-Source: APiQypL7YhAiOxu75mfXAKcFXx1rybcRr5vEwmJtSmOCxWYmUtuTH4n+LfBfSaYFFNeL5ghXRFiPgQ==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr4681569wml.189.1588420112261;
        Sat, 02 May 2020 04:48:32 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/6] phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
Date:   Sat,  2 May 2020 13:47:51 +0200
Message-Id: <20200502114752.1048500-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
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

