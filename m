Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB08C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729152080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rEaAC2+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCXKUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:20:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37903 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgCXKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id l20so2792022wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vevMugysMeZ18EOmMAcbQ1H4E68kSGbbm2Ev/+c6lUw=;
        b=rEaAC2+Cy/ijpd7Vap0HEzeSfQwjvK1gYaAKrWDLtlEaS5nXJWcDYXj5JKHU809eNt
         ZECNK8P+m+WV3n64pvxlKNqbPnB+DdPWqc+ijN9p/WxhygbFunNLTjJdJjPT30CbGW4b
         VVQ4cL0J7cz0kFKonq4tCj+07l3f196VMI+mpvuRyZCL9TuVnBl8VC9WcsydEFaTgtgE
         0kmmcM4p+vXYFPYGlIeemEwsP3i9xL3B/aG3rY6nj/shLyUZwIWcIR8s9IXEc+7N93GT
         J46RTHadc+rt3sL+3piUE2dF+tYsOLOVj2ndAA2lm20xKEcXlpv5fR7SAtd3ZcUf7f4K
         btig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vevMugysMeZ18EOmMAcbQ1H4E68kSGbbm2Ev/+c6lUw=;
        b=jc3E07bIFrMFTRo6bOVxeEp3y9bqQiOEGDTO6Gevq4OSWk09MUBbScyqts+cbE9erF
         zlmU/4ycjAcDkDcJzA3tZfmBK5+UN4DKWh8Z8h88aFoSKpsogJYMu0Q/8rvYmszsyrkk
         m9Gp5Q28xmRYV3rPce3oIvp6F00HZnAdURXo9LOAHdaYPM6iT+09HyU0XvLKHtp1IU//
         8/0CvmFnJ//n3tFBh8520S8hwl42mraYEaLZ8CH1envy2lC0o8f4jIHLVs74MF975kBx
         XbmRDv0Be5pmbSw7YNkgN/sRBvZjuJt16dHWmv4UBJF7WltMT/m625ij/mX4rOOtzJZw
         9KhA==
X-Gm-Message-State: ANhLgQ11S717V9tq86wpkdtNW7xw/ocfF2kxWRZa1KYP7fAFeNL1DiaD
        oHR3BZRHfprzdyfkOSgbutinYw==
X-Google-Smtp-Source: ADFU+vvDJf2Avo97Xe5bVFATihkIhVjh0/x6nK0MsmtW3Bm46KvS5uiWic5eD6DBiajtLLmcLTZZoQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr4838622wmb.102.1585045240690;
        Tue, 24 Mar 2020 03:20:40 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] usb: dwc3: meson-g12a: specify phy names in soc data
Date:   Tue, 24 Mar 2020 11:20:19 +0100
Message-Id: <20200324102030.31000-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle the variable USB2 PHY counts on GXL and GXM SoCs, add the
possible PHY names for each SoC in the compatible match data.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 902553f39889..7ba5fb3d0e22 100644
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
@@ -117,22 +109,36 @@ static struct clk_bulk_data meson_a1_clocks[] = {
 	{ .id = "xtal_usb_ctrl" },
 };
 
+static const char *meson_g12a_phy_names[] = {
+	"usb2-phy0", "usb2-phy1", "usb3-phy0",
+};
+
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
@@ -171,10 +177,13 @@ static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
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
@@ -284,17 +293,19 @@ static const struct regmap_config phy_meson_g12a_usb3_regmap_conf = {
 
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

