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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB6C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCE3216FD
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d5CPJSeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEBLsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727862AbgEBLse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90189C061A0C;
        Sat,  2 May 2020 04:48:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so14930990wrm.13;
        Sat, 02 May 2020 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QpUpEujYS3y0hvmmOxoZ9pqLQStnivHijsveQ/+4bak=;
        b=d5CPJSeE3aFq5WtPqTb6wdqcCX9i7DU8YSqB5iEs959ykns7HVLaeyVkCO4mSqi6sE
         OZ04VLxDQuI9fe5s+73mLcQcR868KB+YDPc1ShQ718L5udF+JjVW6cbW367ebyNMWUYS
         Z4igW0VfMt28CEGrL25xRyA4DOYzgy4+pzRex1PkQ/s1IeAPgFF28VGNE3iZHiY5oSqM
         n3L9A2+Sjy87ran5QaMgfcj01DX9AvROhEro0r48FyaZBwR0hvjtdktjIHtdZQjr6Qsg
         nxz9DM4ot2CMpLSjy936cdLI9D2vWpfkPp/811I2uM7zLce764dCbHkgRGD+I2hw+9qD
         7XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpUpEujYS3y0hvmmOxoZ9pqLQStnivHijsveQ/+4bak=;
        b=WnHIkvXKlR0JFcytpeP9+XHgGNYQ0sPC96HkSMiJkDx2tBhsdE+S3+9Q8nAgH5VxbY
         fCsf/dbpmlJutM2w1iy8lIkapi5pEVWCGa5fXXsxVunK3zDXZMVczSslabckD0f0NkOw
         bSbRpeK3EwuAgJAfCBvKIUE+1kg5kWDCw8XJM65lkbv/TvH0pKiyDrSWJsbU6YXzkCya
         8S5xupVDhs1pgplOckZuc5Lw8vSnPEoqD5peytPaw+f8voUla4koR6xeAyMik5fm6rxP
         v0eNV4ln/AQEt9s4BEhmnSmhyhG51UHJ+HIQVDwCP3yr2pPj0wQz1y9/MKsb7qQff3nQ
         /v/g==
X-Gm-Message-State: AGi0PuZgjyN8vx4bSycMuM21h2yaLwrWth1dtsLxDAW5pgMijLz26Xue
        M3CPZLEuunFUlcZPFtjcCz4=
X-Google-Smtp-Source: APiQypLFmVcYXXF7loumlfnuG3OukAXkPJPXAtWSaBqPWtktFqwqCJZzKf9WGy/aDZCb8D/T/7kbeA==
X-Received: by 2002:adf:9564:: with SMTP id 91mr9301488wrs.246.1588420111297;
        Sat, 02 May 2020 04:48:31 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/6] phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
Date:   Sat,  2 May 2020 13:47:50 +0200
Message-Id: <20200502114752.1048500-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
References: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
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
Reported-by: hexdump <hexdump0815@googlemail.com>
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

