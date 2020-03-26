Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCCFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753312076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oWILPA9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCZNqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:46:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40881 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgCZNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id u10so7848346wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9eFb8D2phR1YQNJRTJuZvG3GmqU7Jbt0/WyqKmz+bw=;
        b=oWILPA9p7zgoY1wf0zlh6GXe8ZRRFY/8EwWnOTVNji6p4fwPkPjwdQwSe4GxMkrUbM
         +GghmZZnkWrN9amFiQ14DTU0Nu5rreLb3ZddKS9HH2fe8M66EYpbMux/z7vai3lW/DKn
         TBQ0PQE6FMCLwLDtPvPz5JPQ1girW7B3m50WIBCdBoq/KYSYyszbVeuc3o1c2nuAoWFy
         AS7dYqMPVnRUC2M6bWUM1qlUqc6aFIjPj4lT8voW3zk0KAXbSfNj1JIciPwcIDDTHcYk
         qrhWxwz1pY6KIoKvdnQFcGAj3J5OEXI3b5kdxnhjeCx6FVahrrmpsZ4fA4xZBL+Xz7lR
         SIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9eFb8D2phR1YQNJRTJuZvG3GmqU7Jbt0/WyqKmz+bw=;
        b=r146taHWe02NJAHodKFWJA37saFbkI5SxNJ+hjjXEDbtAx4U4/m8OVSOlD3QzBmoaB
         lBdyZeCxi9YMjmuqH6V4PJEAFgD4YkwCd+ka3fDnPZAjnAT7vzapvURB5y+OQB7MxdrO
         kz8LoLpeG1jQlBRXglftcQsETn4mivF4Lvx8RTZ/DYLwlogrhIKiyBCsNMs/zncodlpP
         nWDEgO30AvoPrZGikLAUKA/Uz1NwR1KzfNkMhFb6eiDD0mdUnmNQjzF/dHEEq7gZgiBM
         BaCI/yWvno1+v0BD5Ev4jp17xOkkwJ571nn1HZR1DjZTiQ6YJJF9BVHMIJETr6VWxNCb
         Cttg==
X-Gm-Message-State: ANhLgQ3LdfabZz3rV03/XZvkceL5XeHRi/2nwqKvnxyMicctcxE704Bl
        HkGI7/njP42MqaMMvz9uraBhzQ==
X-Google-Smtp-Source: ADFU+vtM0R7NzPeN50a5ioxfIdmokzaZSGvJW1Jh6vLjUU1awtkchisbAhgq+T3/5PhaKBK5GWOieg==
X-Received: by 2002:adf:b35d:: with SMTP id k29mr9626299wrd.239.1585230312894;
        Thu, 26 Mar 2020 06:45:12 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjie Lin <hanjie.lin@amlogic.com>
Subject: [PATCH v2 02/14] usb: dwc3: meson-g12a: specify phy names in soc data
Date:   Thu, 26 Mar 2020 14:44:54 +0100
Message-Id: <20200326134507.4808-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle the variable USB2 PHY counts on GXL and GXM SoCs, add the
possible PHY names for each SoC in the compatible match data.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hanjie Lin <hanjie.lin@amlogic.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 47 +++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 902553f39889..d97ead5aee4e 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -96,16 +96,8 @@
 	#define USB_R5_ID_DIG_TH_MASK				GENMASK(15, 8)
 	#define USB_R5_ID_DIG_CNT_MASK				GENMASK(23, 16)
 
-enum {
-	USB2_HOST_PHY = 0,
-	USB2_OTG_PHY,
-	USB3_HOST_PHY,
-	PHY_COUNT,
-};
-
-static const char *phy_names[PHY_COUNT] = {
-	"usb2-phy0", "usb2-phy1", "usb3-phy0",
-};
+#define PHY_COUNT						3
+#define USB2_OTG_PHY						1
 
 static struct clk_bulk_data meson_g12a_clocks[] = {
 	{ .id = NULL },
@@ -117,22 +109,44 @@ static struct clk_bulk_data meson_a1_clocks[] = {
 	{ .id = "xtal_usb_ctrl" },
 };
 
+static const char *meson_g12a_phy_names[] = {
+	"usb2-phy0", "usb2-phy1", "usb3-phy0",
+};
+
+/*
+ * Amlogic A1 has a single physical PHY, in slot 1, but still has the
+ * two U2 PHY controls register blocks like G12A.
+ * Handling the first PHY on slot 1 would need a large amount of code
+ * changes, and the current management is generic enough to handle it
+ * correctly when only the "usb2-phy1" phy is specified on-par with the
+ * DT bindings.
+ */
+static const char *meson_a1_phy_names[] = {
+	"usb2-phy0", "usb2-phy1"
+};
+
 struct dwc3_meson_g12a_drvdata {
 	bool otg_switch_supported;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	const char **phy_names;
+	int num_phys;
 };
 
 static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.otg_switch_supported = true,
 	.clks = meson_g12a_clocks,
 	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
+	.phy_names = meson_g12a_phy_names,
+	.num_phys = ARRAY_SIZE(meson_g12a_phy_names),
 };
 
 static struct dwc3_meson_g12a_drvdata a1_drvdata = {
 	.otg_switch_supported = false,
 	.clks = meson_a1_clocks,
 	.num_clks = ARRAY_SIZE(meson_a1_clocks),
+	.phy_names = meson_a1_phy_names,
+	.num_phys = ARRAY_SIZE(meson_a1_phy_names),
 };
 
 struct dwc3_meson_g12a {
@@ -171,10 +185,13 @@ static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
 	else
 		priv->otg_phy_mode = PHY_MODE_USB_HOST;
 
-	for (i = 0 ; i < USB3_HOST_PHY ; ++i) {
+	for (i = 0; i < priv->drvdata->num_phys; ++i) {
 		if (!priv->phys[i])
 			continue;
 
+		if (!strstr(priv->drvdata->phy_names[i], "usb2"))
+			continue;
+
 		regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
 				   U2P_R0_POWER_ON_RESET,
 				   U2P_R0_POWER_ON_RESET);
@@ -284,17 +301,19 @@ static const struct regmap_config phy_meson_g12a_usb3_regmap_conf = {
 
 static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
 {
+	const char *phy_name;
 	int i;
 
-	for (i = 0 ; i < PHY_COUNT ; ++i) {
-		priv->phys[i] = devm_phy_optional_get(priv->dev, phy_names[i]);
+	for (i = 0 ; i < priv->drvdata->num_phys ; ++i) {
+		phy_name = priv->drvdata->phy_names[i];
+		priv->phys[i] = devm_phy_optional_get(priv->dev, phy_name);
 		if (!priv->phys[i])
 			continue;
 
 		if (IS_ERR(priv->phys[i]))
 			return PTR_ERR(priv->phys[i]);
 
-		if (i == USB3_HOST_PHY)
+		if (strstr(phy_name, "usb3"))
 			priv->usb3_ports++;
 		else
 			priv->usb2_ports++;
-- 
2.22.0

