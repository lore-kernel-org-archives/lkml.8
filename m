Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F66C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E03206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lrvSCM3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635535AbgDPMWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635261AbgDPMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:19:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD931C03C1A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:19:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so4351437wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZcSlgg353LajR7zMDfYkV7be68AlVwenv5Lg46D/qo=;
        b=lrvSCM3YnqpwxmjWfgNiTZc4qJuxtPbIrkSDVdgwC7z+FUCOZnV4wID9RLmQTcr3um
         6QX7PfzocPTyBfGEdFr78wYyP5DA34wv9f79M7Na1uLWAtxX0/nI57u8gHv8i2XuVtbx
         swZm0DURVdqAW2KFpfBu9GY7JMotE9pIm1wDhM9/gDOzJkepkYYA1t69erXciZyvJhBb
         dMhbZvo7AH0Glsun3clOT4NwMwejy9sHc/BW2llvZw+85KBc+aQLJGJ8eWiBxCg6qQf2
         ri+i4gtbEPvoYLfX5/daGTNTC3uGaYqv/AJTMoMveDb0N9LB1o/bAeJvTfOnWQ0AT97s
         OdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZcSlgg353LajR7zMDfYkV7be68AlVwenv5Lg46D/qo=;
        b=OhobLAez6mNY2Pq4wa0RouPK5tcLesGQNd3DBQ9d70SDedDyS5W6Kmce+sDVJO03J+
         qXnWMFbUET1/vy6ARINjOmiG3NQK9VoKGYYbNDmrpYzfdWwhXTP49Eiby++enb5JhEkO
         AoZItPHLbKLJAZXFi9jH/obhp78AWG5FSRsC5IfdN6Vj9qdc1vTkHPp0+mSs0BUc0wBE
         YsrQTapf3cbd/SQhvFLCli/KWWBqbSR4BmM7nG4v1Ni4Yb8ME8JRlQ4giLYP4csCR8+C
         4ebed3xJwbTM2iz2jICrpaBN+I/5ddlOmajVSD0qptXkuXmpnRzDA53UhI/KDLV4TrJ4
         ivnw==
X-Gm-Message-State: AGi0PuZDzSwJpyR6LFEAxbuot9aNZPCEN0xDYvwJ7OOokohmdNXH03RI
        iNxjvZi/us3eha5XC9Mo2sY6wg==
X-Google-Smtp-Source: APiQypKQT1DUgq3Kq2lfPKLc8C7IAbCXliG8RO8XPli0CLlx/EuucBvI2894V3GAKF2Q9nznPpM0rQ==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr4412345wml.7.1587039560147;
        Thu, 16 Apr 2020 05:19:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i13sm22035602wro.50.2020.04.16.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:19:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
Date:   Thu, 16 Apr 2020 14:19:05 +0200
Message-Id: <20200416121910.12723-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416121910.12723-1-narmstrong@baylibre.com>
References: <20200416121910.12723-1-narmstrong@baylibre.com>
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
index cc0b8a253932..61507abb0ff7 100644
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
@@ -145,16 +154,25 @@ struct dwc3_meson_g12a_drvdata {
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
 
 /*
  * For GXL and GXM SoCs:
@@ -169,6 +187,34 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv);
  * reset to recover usage of the port.
  */
 
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
+
 static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.otg_switch_supported = true,
 	.clks = meson_g12a_clocks,
@@ -209,6 +255,21 @@ struct dwc3_meson_g12a {
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
@@ -558,6 +619,18 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
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
@@ -598,6 +671,25 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
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
+	dwc3_meson_g12a_usb_otg_apply_mode(priv, priv->otg_phy_mode);
+
+	return 0;
+}
+
 static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 {
 	struct dwc3_meson_g12a	*priv;
@@ -829,6 +921,14 @@ static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
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

