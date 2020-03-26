Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284BEC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4DF206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FtpRIc5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgCZNp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so7026456wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4OQGeeefykddJTLyHhR+pmXKSb4WyyElXj03N7FWqg=;
        b=FtpRIc5lQGp8K83aq1yBJ9kHII2tvynMr9OZ1jinKDHRFhKu+pu1lRsB8/ypHmm0sB
         2rNd5Uf7wqk4JllPfjgUO4QdjbgiMucnOFVmi7JmOz7a5rEaxq+cwr+3OI1uMs7cZxS9
         V1xSKr5BaUH7tJA/Jaki3uukc35M2swP5S50gL7AQZFbitadAoEPF0HF4rSnQj09drKs
         Lw4xeykbulQmyPURhw+KjGVPnNniAoYdSZt9TQ/l0UFDnGdQ5FZyxqkvSMlbX+ybckzZ
         TlkvOdAxuQatyA/6VzLxIH1ChGhBZCnKbFceW3Y/6jZ0c67Ht4N0xzyGbnpfLEaI7vvj
         Oymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4OQGeeefykddJTLyHhR+pmXKSb4WyyElXj03N7FWqg=;
        b=YSsfyLg1+tg9JGYL5R75KkAtdg/zu/PsG8cpNAmh1SgYY5iV/OsvEXdglT6zDLCvNg
         Evy74/IeK6NTbEgL5DQCeUXPD5NMysreLC+UPiRVJl3mmHl49yk2TAyjRIKIteowbrju
         Xc1s2ELQxJCKxxFWuzcCjlgMjb02+cizkkCXG7jZV5M+L30gdCpO1o42V99RR0m/WMjh
         eSFyOuNaCyLjONn1inEhAzl3OqinDbPsKxgVIykcYp1gyZsvpMUWOlRE65ewg0V74xZs
         pdZ1b2SXQAOrQPeSvqhDX3Cd2NJzzvPmaYgFgu/POQ9ETuDKFhEOzTe6neshxWSgO5Nr
         Icxw==
X-Gm-Message-State: ANhLgQ2AGCTN+n8JQK0WxdGxLjDoMMClTsWe6iFiK2V2SA2RcpNxPahK
        uHsIeGQitBXI8P9Ite2y/JRL3Q==
X-Google-Smtp-Source: ADFU+vtNV2p2MdHTs3Aw9mAjq2g8w1y4nKcuV9ppnHa1G0n4fScralNm+HVi6ta7Q/aw94MiqSd2kA==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr2519wmc.171.1585230318771;
        Thu, 26 Mar 2020 06:45:18 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] usb: dwc3: meson-g12a: refactor usb2 phy init
Date:   Thu, 26 Mar 2020 14:44:58 +0100
Message-Id: <20200326134507.4808-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the USB2 PHY init code patch to handle the Amlogic GXL/GXM
not having the PHY mode control registers in the Glue but in the PHY
registers.

The Amlogic GXL/GXM will call phy_set_mode() instead of programming the
PHY mode control registers, thus add two new callbacks to the SoC match
data.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 74 +++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 69381c42a6d3..328e74def56f 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -136,11 +136,21 @@ struct dwc3_meson_g12a_drvdata {
 	const char **phy_names;
 	int num_phys;
 	int (*setup_regmaps)(struct dwc3_meson_g12a *priv, void __iomem *base);
+	int (*usb2_init_phy)(struct dwc3_meson_g12a *priv, int i,
+			     enum phy_mode mode);
+	int (*set_phy_mode)(struct dwc3_meson_g12a *priv, int i,
+			    enum phy_mode mode);
 };
 
 static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 					 void __iomem *base);
 
+static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
+					  enum phy_mode mode);
+
+static int dwc3_meson_g12a_set_phy_mode(struct dwc3_meson_g12a *priv,
+					int i, enum phy_mode mode);
+
 static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.otg_switch_supported = true,
 	.clks = meson_g12a_clocks,
@@ -148,6 +158,8 @@ static struct dwc3_meson_g12a_drvdata g12a_drvdata = {
 	.phy_names = meson_g12a_phy_names,
 	.num_phys = ARRAY_SIZE(meson_g12a_phy_names),
 	.setup_regmaps = dwc3_meson_g12a_setup_regmaps,
+	.usb2_init_phy = dwc3_meson_g12a_usb2_init_phy,
+	.set_phy_mode = dwc3_meson_g12a_set_phy_mode,
 };
 
 static struct dwc3_meson_g12a_drvdata a1_drvdata = {
@@ -157,6 +169,8 @@ static struct dwc3_meson_g12a_drvdata a1_drvdata = {
 	.phy_names = meson_a1_phy_names,
 	.num_phys = ARRAY_SIZE(meson_a1_phy_names),
 	.setup_regmaps = dwc3_meson_g12a_setup_regmaps,
+	.usb2_init_phy = dwc3_meson_g12a_usb2_init_phy,
+	.set_phy_mode = dwc3_meson_g12a_set_phy_mode,
 };
 
 struct dwc3_meson_g12a {
@@ -175,8 +189,8 @@ struct dwc3_meson_g12a {
 	const struct dwc3_meson_g12a_drvdata *drvdata;
 };
 
-static void dwc3_meson_g12a_usb2_set_mode(struct dwc3_meson_g12a *priv,
-					  int i, enum phy_mode mode)
+static int dwc3_meson_g12a_set_phy_mode(struct dwc3_meson_g12a *priv,
+					 int i, enum phy_mode mode)
 {
 	if (mode == PHY_MODE_USB_HOST)
 		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
@@ -185,11 +199,41 @@ static void dwc3_meson_g12a_usb2_set_mode(struct dwc3_meson_g12a *priv,
 	else
 		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
 				U2P_R0_HOST_DEVICE, 0);
+
+	return 0;
+}
+
+static int dwc3_meson_g12a_usb2_init_phy(struct dwc3_meson_g12a *priv, int i,
+					 enum phy_mode mode)
+{
+	int ret;
+
+	regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
+			U2P_R0_POWER_ON_RESET,
+			U2P_R0_POWER_ON_RESET);
+
+	if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
+		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
+				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
+				   U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
+
+		ret = priv->drvdata->set_phy_mode(priv, i, mode);
+	} else
+		ret = priv->drvdata->set_phy_mode(priv, i,
+						  PHY_MODE_USB_HOST);
+
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
+			U2P_R0_POWER_ON_RESET, 0);
+
+	return 0;
 }
 
 static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
 {
-	int i;
+	int i, ret;
 
 	if (priv->otg_mode == USB_DR_MODE_PERIPHERAL)
 		priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
@@ -203,23 +247,9 @@ static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
 		if (!strstr(priv->drvdata->phy_names[i], "usb2"))
 			continue;
 
-		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
-				   U2P_R0_POWER_ON_RESET,
-				   U2P_R0_POWER_ON_RESET);
-
-		if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
-			regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
-				U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
-				U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
-
-			dwc3_meson_g12a_usb2_set_mode(priv, i,
-						      priv->otg_phy_mode);
-		} else
-			dwc3_meson_g12a_usb2_set_mode(priv, i,
-						      PHY_MODE_USB_HOST);
-
-		regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
-				   U2P_R0_POWER_ON_RESET, 0);
+		ret = priv->drvdata->usb2_init_phy(priv, i, priv->otg_phy_mode);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -372,7 +402,9 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
 
 	priv->otg_phy_mode = mode;
 
-	dwc3_meson_g12a_usb2_set_mode(priv, USB2_OTG_PHY, mode);
+	ret = priv->drvdata->set_phy_mode(priv, USB2_OTG_PHY, mode);
+	if (ret)
+		return ret;
 
 	dwc3_meson_g12a_usb_otg_apply_mode(priv);
 
-- 
2.22.0

