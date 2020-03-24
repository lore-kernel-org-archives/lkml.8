Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C200C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD68208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Vf5b/eP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCXKUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:20:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45999 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgCXKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so15999740wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqFV/Ox/BRZ4f3eHx7delLB0ZMteuuzmsxgA9es7nk8=;
        b=Vf5b/eP6Jzmy8E5i0TmwFbOvTVvjFr2T9hCwvh3ueh3g9UPQLRF7vB9gDJRP2ctw3a
         hRvFUJxsyNuD4bzacs5IEIpZFGLIC7shYLcSE0sMR4CFOKMdoFHQRl6cDZ9RTx2jkVy3
         SkEvaLirwajF0HNUVmWXlBWZRnEBmOgLVDZ4nZYTQ8cllpmc9UCwmfAum5+gnqvBdcZU
         gLW93/v2TCO639tNtRO64FFSny4T/nhVZyYJZTPm2H0u5uFrjUB/0++CUFZsGkKLD9AV
         OjDp5SLGDoSBwh2A2WQnBpG/5xdY++i0N3M/rHghvVQTskQ+LEiVtm06vdr3r2JjwGKk
         Bx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqFV/Ox/BRZ4f3eHx7delLB0ZMteuuzmsxgA9es7nk8=;
        b=RJ+HHVjmyDi4x2kwaMxwuYy2qy28y3u/FEQ59FiMl16M2L6hBjohmZMTtGvWlOuVW7
         gKXb0rzCFpBIQT1parGHsig7RASXDcPhefnrhZlsGU/hWskLwwVMmdaqm+aF/WMjK8FI
         cNIw/mh3a7Y7qlJE6MiJTtL4SkT22ySEYNzTHu3OUCHeipWQD/YPdLXPfwaINOGOeTIb
         aHd7GCZpCGH05qC8NMbylf3znJGnoZR+pFktaAw4zjd9iSBkKosnjISfS2bPEjr8eVvM
         cbaaRiOyRsVJfdiKJw9o2ZU2vIg2EhYyXgOwGDcCgakYmI51Fd7KVcWRekF4y2oUbylQ
         yXrw==
X-Gm-Message-State: ANhLgQ0smfW9PvnilM9OlY3Exmk5ETOLyhdq7VuWf058GwDEIuEdatzm
        DsnFID4l+wxEowA3TNH48wXCWQ==
X-Google-Smtp-Source: ADFU+vsZTNC4zuNEPh1igfc4MkKdwuOtPzEQsgzG9qjiIjsXIu8aiIbj6Gl+3YGdfOAFkkSrTdNKbQ==
X-Received: by 2002:adf:a285:: with SMTP id s5mr37381539wra.118.1585045246064;
        Tue, 24 Mar 2020 03:20:46 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] usb: dwc3: meson-g12a: refactor usb init
Date:   Tue, 24 Mar 2020 11:20:23 +0100
Message-Id: <20200324102030.31000-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the USB init code patch to handle the Amlogic GXL/GXM needing
to initialize the OTG port as Peripheral mode for the DWC2 IP to probe
correctly.

A secondary, post_init callback is added to setup the OTG PHY mode after
the sub-nodes probe.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 46 +++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 74d07ded8a7e..65c220b577d0 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -132,6 +132,8 @@ struct dwc3_meson_g12a_drvdata {
 			     enum phy_mode mode);
 	int (*set_phy_mode)(struct dwc3_meson_g12a *priv, int i,
 			    enum phy_mode mode);
+	int (*usb_init)(struct dwc3_meson_g12a *priv);
+	int (*usb_post_init)(struct dwc3_meson_g12a *priv);
 };
 
 static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
@@ -143,6 +145,8 @@ static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
 static int dwc3_meson_g12a_set_phy_mode(struct dwc3_meson_g12a *priv,
 					int i, enum phy_mode mode);
 
+static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv);
+
 static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.otg_switch_supported = true,
 	.clks = meson_g12a_clocks,
@@ -152,6 +156,7 @@ static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.setup_regmaps = dwc3_meson_g12a_setup_regmaps,
 	.usb2_init_phy = dwc3_meson_g12a_usb2_init_phy,
 	.set_phy_mode = dwc3_meson_g12a_set_phy_mode,
+	.usb_init = dwc3_meson_g12a_usb_init,
 };
 
 static struct dwc3_meson_g12a_drvdata a1_drvdata = {
@@ -163,6 +168,7 @@ static struct dwc3_meson_g12a_drvdata a1_drvdata = {
 	.setup_regmaps = dwc3_meson_g12a_setup_regmaps,
 	.usb2_init_phy = dwc3_meson_g12a_usb2_init_phy,
 	.set_phy_mode = dwc3_meson_g12a_set_phy_mode,
+	.usb_init = dwc3_meson_g12a_usb_init,
 };
 
 struct dwc3_meson_g12a {
@@ -223,15 +229,11 @@ static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
 	return 0;
 }
 
-static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
+static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv,
+				     enum phy_mode mode)
 {
 	int i, ret;
 
-	if (priv->otg_mode == USB_DR_MODE_PERIPHERAL)
-		priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
-	else
-		priv->otg_phy_mode = PHY_MODE_USB_HOST;
-
 	for (i = 0; i < priv->drvdata->num_phys; ++i) {
 		if (!priv->phys[i])
 			continue;
@@ -276,9 +278,10 @@ static void dwc3_meson_g12a_usb3_init(struct dwc3_meson_g12a *priv)
 			FIELD_PREP(USB_R1_P30_PCS_TX_SWING_FULL_MASK, 127));
 }
 
-static void dwc3_meson_g12a_usb_otg_apply_mode(struct dwc3_meson_g12a *priv)
+static void dwc3_meson_g12a_usb_otg_apply_mode(struct dwc3_meson_g12a *priv,
+					       enum phy_mode mode)
 {
-	if (priv->otg_phy_mode == PHY_MODE_USB_DEVICE) {
+	if (mode == PHY_MODE_USB_DEVICE) {
 		regmap_update_bits(priv->usb_glue_regmap, USB_R0,
 				USB_R0_U2D_ACT, USB_R0_U2D_ACT);
 		regmap_update_bits(priv->usb_glue_regmap, USB_R0,
@@ -293,11 +296,12 @@ static void dwc3_meson_g12a_usb_otg_apply_mode(struct dwc3_meson_g12a *priv)
 	}
 }
 
-static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
+static int dwc3_meson_g12a_usb_init_glue(struct dwc3_meson_g12a *priv,
+					 enum phy_mode mode)
 {
 	int ret;
 
-	ret = dwc3_meson_g12a_usb2_init(priv);
+	ret = dwc3_meson_g12a_usb2_init(priv, mode);
 	if (ret)
 		return ret;
 
@@ -319,7 +323,7 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
 	if (priv->usb3_ports)
 		dwc3_meson_g12a_usb3_init(priv);
 
-	dwc3_meson_g12a_usb_otg_apply_mode(priv);
+	dwc3_meson_g12a_usb_otg_apply_mode(priv, mode);
 
 	return 0;
 }
@@ -398,7 +402,7 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
 	if (ret)
 		return ret;
 
-	dwc3_meson_g12a_usb_otg_apply_mode(priv);
+	dwc3_meson_g12a_usb_otg_apply_mode(priv, mode);
 
 	return 0;
 }
@@ -545,6 +549,11 @@ static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 	return 0;
 }
 
+static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
+{
+	return dwc3_meson_g12a_usb_init_glue(priv, priv->otg_phy_mode);
+}
+
 static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 {
 	struct dwc3_meson_g12a	*priv;
@@ -612,7 +621,12 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	/* Get dr_mode */
 	priv->otg_mode = usb_get_dr_mode(dev);
 
-	ret = dwc3_meson_g12a_usb_init(priv);
+	if (priv->otg_mode == USB_DR_MODE_PERIPHERAL)
+		priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
+	else
+		priv->otg_phy_mode = PHY_MODE_USB_HOST;
+
+	ret = priv->drvdata->usb_init(priv);
 	if (ret)
 		goto err_disable_clks;
 
@@ -634,6 +648,12 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_phys_power;
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			goto err_phys_power;
+	}
+
 	ret = dwc3_meson_g12a_otg_init(pdev, priv);
 	if (ret)
 		goto err_phys_power;
-- 
2.22.0

