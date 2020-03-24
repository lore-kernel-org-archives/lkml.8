Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07DC54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF695208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UXNAKlUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCXKUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:20:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36200 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgCXKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so14663383wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8WnUqvvgv0bNfMxu+Z5YIurl03M0THSbpRLL/FtCLA=;
        b=UXNAKlUji6QXYFoez6B97lqRSxFp/2RaSBUajI/Aedr8apB3h4H0VwDndhYnZ2JzEl
         FC197RxKDT6g/K2nCZytul9HfEymSllr9Q7w8zycHJglWhsQvd/NnmacjzPdNUBypmt+
         pzWLOVwh9eThhAXlJ/IiU6V2xCVyHEGaXEhTuDW424ORmOq1zl1s7l5kUtEBZ8UXzeL2
         gIhBPC98CkroePDhRzoUlLvWf+FoMyRr4mTfYyIvtFrB7qqZOwBjI09mbxypMANFLNe6
         n02vnUzOyT0hgD8l1+y9xrFd9+BgY8fWZKVgprNxLMdl5wwlveVsxKCarHVkZ6krz6P4
         7pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8WnUqvvgv0bNfMxu+Z5YIurl03M0THSbpRLL/FtCLA=;
        b=YiklX9G+JUJY1X24Gk9Jt/yzh0w+nEwninkD1hgbaL0292VlTAEENpCGq9bewDCDCF
         iOsQTLLlytEk5I7aAmfHPNN6vb5Fqg251KPlvX7KiB6J99nWeSDM+NAN6uQbmqpku5Cq
         9BkBBz+RydA9sVa0q1sDZT5P6DqZ13/sSf2xjlu6E4g8a1VNf1bprKNOicjo5B4wSe11
         kf1chNT76GoPyeiPdLspA+bsLluskY9v4U9qxdfaV+jrkSPFPq/cEBt961TwbktDV7Bh
         1ImocoiJ+HbU7ETpoK7q53C/2Dtxk7U71o15Uq84SO/bTUo9QprP9O86vz2+nr+kyi8P
         bg7g==
X-Gm-Message-State: ANhLgQ3nmDPNJcKiNaLwjYVJN8kqZOhaC53SINW2fIPxu/1+V1M0Vtu7
        +gLIdTQB+xFZlz3t9Sht/mmVBhFD7NhxFg==
X-Google-Smtp-Source: ADFU+vt4c9bVq+V9ThHlYHhvr0dTYvJh1OeYeXaukx1RGe0MyWTMfPzs2/OuGR+x8sfuT/D6tEHg4w==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr15183815wrp.23.1585045248510;
        Tue, 24 Mar 2020 03:20:48 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
Date:   Tue, 24 Mar 2020 11:20:25 +0100
Message-Id: <20200324102030.31000-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to add support for the Amlogic GXL/GXM USB Glue, this adds
the corresponding :
- PHY names
- clock names
- USB2 PHY init and mode set
- regmap setup

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 102 ++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 04ef70661711..0eae5945e82e 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -101,6 +101,11 @@
 #define PHY_COUNT						3
 #define USB2_OTG_PHY						1
 
+static struct clk_bulk_data meson_gxl_clocks[] = {
+	{ .id = "usb_ctrl" },
+	{ .id = "ddr" },
+};
+
 static struct clk_bulk_data meson_g12a_clocks[] = {
 	{ .id = NULL },
 };
@@ -111,6 +116,10 @@ static struct clk_bulk_data meson_a1_clocks[] = {
 	{ .id = "xtal_usb_ctrl" },
 };
 
+static const char *meson_gxm_phy_names[] = {
+	"usb2-phy0", "usb2-phy1", "usb2-phy2",
+};
+
 static const char *meson_g12a_phy_names[] = {
 	"usb2-phy0", "usb2-phy1", "usb3-phy0",
 };
@@ -137,16 +146,53 @@ struct dwc3_meson_g12a_drvdata {
 	int (*usb_post_init)(struct dwc3_meson_g12a *priv);
 };
 
+static int dwc3_meson_gxl_setup_regmaps(struct dwc3_meson_g12a *priv,
+					void __iomem *base);
 static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 					 void __iomem *base);
 
 static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
-					  enum phy_mode mode);
+					 enum phy_mode mode);
+static int dwc3_meson_gxl_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
+					enum phy_mode mode);
 
 static int dwc3_meson_g12a_set_phy_mode(struct dwc3_meson_g12a *priv,
 					int i, enum phy_mode mode);
+static int dwc3_meson_gxl_set_phy_mode(struct dwc3_meson_g12a *priv,
+				       int i, enum phy_mode mode);
 
 static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv);
+static int dwc3_meson_gxl_usb_init(struct dwc3_meson_g12a *priv);
+
+static int dwc3_meson_gxl_usb_post_init(struct dwc3_meson_g12a *priv);
+
+static struct dwc3_meson_g12a_drvdata gxl_drvdata = {
+	.otg_switch_supported = true,
+	.otg_phy_host_port_disable = true,
+	.clks = meson_gxl_clocks,
+	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
+	.phy_names = meson_a1_phy_names,
+	.num_phys = ARRAY_SIZE(meson_a1_phy_names),
+	.setup_regmaps = dwc3_meson_gxl_setup_regmaps,
+	.usb2_init_phy = dwc3_meson_gxl_usb2_init_phy,
+	.set_phy_mode = dwc3_meson_gxl_set_phy_mode,
+	.usb_init = dwc3_meson_gxl_usb_init,
+	.usb_post_init = dwc3_meson_gxl_usb_post_init,
+};
+
+static struct dwc3_meson_g12a_drvdata gxm_drvdata = {
+	.otg_switch_supported = true,
+	.otg_phy_host_port_disable = true,
+	.clks = meson_gxl_clocks,
+	.num_clks = ARRAY_SIZE(meson_g12a_clocks),
+	.phy_names = meson_gxm_phy_names,
+	.num_phys = ARRAY_SIZE(meson_gxm_phy_names),
+	.setup_regmaps = dwc3_meson_gxl_setup_regmaps,
+	.usb2_init_phy = dwc3_meson_gxl_usb2_init_phy,
+	.set_phy_mode = dwc3_meson_gxl_set_phy_mode,
+	.usb_init = dwc3_meson_gxl_usb_init,
+	.usb_post_init = dwc3_meson_gxl_usb_post_init,
+};
 
 /*
  * For GXL and GXM SoCs:
@@ -201,6 +247,21 @@ struct dwc3_meson_g12a {
 	const struct dwc3_meson_g12a_drvdata *drvdata;
 };
 
+static int dwc3_meson_gxl_set_phy_mode(struct dwc3_meson_g12a *priv,
+					 int i, enum phy_mode mode)
+{
+	return phy_set_mode(priv->phys[i], mode);
+}
+
+static int dwc3_meson_gxl_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
+					enum phy_mode mode)
+{
+	/* On GXL PHY must be started in device mode for DWC2 init */
+	return priv->drvdata->set_phy_mode(priv, i,
+				(i == USB2_OTG_PHY) ? PHY_MODE_USB_DEVICE
+						    : PHY_MODE_USB_HOST);
+}
+
 static int dwc3_meson_g12a_set_phy_mode(struct dwc3_meson_g12a *priv,
 					 int i, enum phy_mode mode)
 {
@@ -548,6 +609,18 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dwc3_meson_gxl_setup_regmaps(struct dwc3_meson_g12a *priv,
+					void __iomem *base)
+{
+	/* GXL controls the PHY mode in the PHY registers unlike G12A */
+	priv->usb_glue_regmap = devm_regmap_init_mmio(priv->dev, base,
+					&phy_meson_g12a_usb_glue_regmap_conf);
+	if (IS_ERR(priv->usb_glue_regmap))
+		return PTR_ERR(priv->usb_glue_regmap);
+
+	return 0;
+}
+
 static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 					 void __iomem *base)
 {
@@ -588,6 +661,25 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
 	return dwc3_meson_g12a_usb_init_glue(priv, priv->otg_phy_mode);
 }
 
+static int dwc3_meson_gxl_usb_init(struct dwc3_meson_g12a *priv)
+{
+	return dwc3_meson_g12a_usb_init_glue(priv, PHY_MODE_USB_DEVICE);
+}
+
+static int dwc3_meson_gxl_usb_post_init(struct dwc3_meson_g12a *priv)
+{
+	int ret;
+
+	ret = priv->drvdata->set_phy_mode(priv, USB2_OTG_PHY,
+					  priv->otg_phy_mode);
+	if (ret)
+		return ret;
+
+	dwc3_meson_g12a_usb_otg_apply_mode(priv,  priv->otg_phy_mode);
+
+	return 0;
+}
+
 static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 {
 	struct dwc3_meson_g12a	*priv;
@@ -817,6 +909,14 @@ static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
 };
 
 static const struct of_device_id dwc3_meson_g12a_match[] = {
+	{
+		.compatible = "amlogic,meson-gxl-usb-ctrl",
+		.data = &gxl_drvdata,
+	},
+	{
+		.compatible = "amlogic,meson-gxm-usb-ctrl",
+		.data = &gxm_drvdata,
+	},
 	{
 		.compatible = "amlogic,meson-g12a-usb-ctrl",
 		.data = &g12a_drvdata,
-- 
2.22.0

