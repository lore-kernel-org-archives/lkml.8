Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793AC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8756D23126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l0Q6aaZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbgELWY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731982AbgELWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9647C061A0C;
        Tue, 12 May 2020 15:24:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so18023249wrn.6;
        Tue, 12 May 2020 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHVRsCOT9MyMisZFgSTwlSLvLYQeGqXXf2R8XWiMUgQ=;
        b=l0Q6aaZMyvU10IB4ybnWRKE3f63txu5zwml68AOPUfCKi3ap27AmbKA2je7xoYYPYX
         HXgjZdpYg+hbCSgdJKfruqF6k5Lm1VCHZIgR5EJ3KIXSCpY/8ioJwWuAb3OTli6eXFac
         Y8Aw79TNWRjuNNhDbhMjA7Qmuo3f4RHVaiwY777BVjJfetkNXmOKjCXrBKpaWdaIHYvH
         l4JyKVPQ9E1veTLB9ocMA30dlNfmUCk2JxRPs6L5E+e7vU6S09OoSz4SN/1133K+exaO
         2x3KAiOPgffuEmcEo9Q1yrFlXM+YdaDIc5E1qZQqL65z5oE8Dtmc9sZKCiHpkdi89AZe
         Y9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHVRsCOT9MyMisZFgSTwlSLvLYQeGqXXf2R8XWiMUgQ=;
        b=Xk6T0jxZwsI/IC1k8NHVfU6i9WI7BlufEnYMVEO3jpvuPvbRc75F3QiQvkq2wgtGL0
         mmq+SMufjE7H3ei9NH7K++ddx8Tm/d2g1AvfgULrlsAr1f9A2VwuiRHYeCIohi360tmZ
         46ynxiDJ1sTJeakY0Y4rgqEp9Z3ITIoonR/C1lWTWH6w34yl7VP38D63qkszOVztcx+b
         MfyISFXWMQJPSE9sgayVMWwQ7iZrZI/jJOzbR3lvJBg1QM6/E6IUOD9wHzwgeq5CbJRO
         +PLTi0ABhbjifaM85Y/0IGSM5yCrjWVQpAFLKpdN+AiI3JnZ0ZdkDYmFlo0f0y2s8y6G
         fiVA==
X-Gm-Message-State: AGi0PubBk2FVdZ+37eAE4gHS2TRivp1u21LADhkwqRArMOxgQanJbtFm
        VJPwci9wp2mK4kKbfu86vww=
X-Google-Smtp-Source: APiQypLlX7OBgWwJ5Mrl6AtPKJWwIkazZXuqTvjrOxW56YG+AWsf3arrFPANxHmM2ma91CACjvd0yA==
X-Received: by 2002:adf:c38c:: with SMTP id p12mr28947458wrf.357.1589322278537;
        Tue, 12 May 2020 15:24:38 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: [PATCH v2 4/6] phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
Date:   Wed, 13 May 2020 00:24:22 +0200
Message-Id: <20200512222424.549351-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
References: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip setting REG_ADP_BC_ACA_ENABLE on Meson8 SoCs and polling for the
REG_ADP_BC_ACA_PIN_FLOAT bit. The vendor also skips this part on Meson8
SoCs.
This fixes initialization of the host-only USB PHY on Meson8 which would
otherwise fail with "USB ID detect failed!".

Fixes: 4a3449d1a0a10c ("phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs")
Reported-by: Thomas Graichen <thomas.graichen@gmail.com>
Tested-by: Thomas Graichen <thomas.graichen@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 48 ++++++++++++++++++++------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 86824cc21f11..7236b8885f07 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/phy/phy.h>
@@ -105,12 +106,17 @@
 #define RESET_COMPLETE_TIME				500
 #define ACA_ENABLE_COMPLETE_TIME			50
 
+struct phy_meson8b_usb2_match_data {
+	bool			host_enable_aca;
+};
+
 struct phy_meson8b_usb2_priv {
-	struct regmap		*regmap;
-	enum usb_dr_mode	dr_mode;
-	struct clk		*clk_usb_general;
-	struct clk		*clk_usb;
-	struct reset_control	*reset;
+	struct regmap					*regmap;
+	enum usb_dr_mode				dr_mode;
+	struct clk					*clk_usb_general;
+	struct clk					*clk_usb;
+	struct reset_control				*reset;
+	const struct phy_meson8b_usb2_match_data	*match;
 };
 
 static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
@@ -166,7 +172,8 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
 			   REG_CTRL_SOF_TOGGLE_OUT);
 
-	if (priv->dr_mode == USB_DR_MODE_HOST) {
+	if (priv->dr_mode == USB_DR_MODE_HOST &&
+	    priv->match->host_enable_aca) {
 		regmap_update_bits(priv->regmap, REG_ADP_BC,
 				   REG_ADP_BC_ACA_ENABLE,
 				   REG_ADP_BC_ACA_ENABLE);
@@ -216,6 +223,10 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	priv->match = device_get_match_data(&pdev->dev);
+	if (!priv->match)
+		return -ENODEV;
+
 	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &phy_meson8b_usb2_regmap_conf);
 	if (IS_ERR(priv->regmap))
@@ -254,11 +265,28 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct phy_meson8b_usb2_match_data phy_meson8_usb2_match_data = {
+	.host_enable_aca = false,
+};
+
+static const struct phy_meson8b_usb2_match_data phy_meson8b_usb2_match_data = {
+	.host_enable_aca = true,
+};
+
 static const struct of_device_id phy_meson8b_usb2_of_match[] = {
-	{ .compatible = "amlogic,meson8-usb2-phy", },
-	{ .compatible = "amlogic,meson8b-usb2-phy", },
-	{ .compatible = "amlogic,meson-gxbb-usb2-phy", },
-	{ },
+	{
+		.compatible = "amlogic,meson8-usb2-phy",
+		.data = &phy_meson8_usb2_match_data
+	},
+	{
+		.compatible = "amlogic,meson8b-usb2-phy",
+		.data = &phy_meson8b_usb2_match_data
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-usb2-phy",
+		.data = &phy_meson8b_usb2_match_data
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, phy_meson8b_usb2_of_match);
 
-- 
2.26.2

