Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB3C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84131246A8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vyc3sRQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgBMUTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:19:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33019 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgBMUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:19:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so8121186lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwVZSFEq0W28DM18hDTvCj9e8HcEAgSZLjRA5gyrBFU=;
        b=Vyc3sRQ1QOwrox+evcccNRQBSMXSNzw3PVk3EXZdtOms1u9chLhvINkI9cUllcwCFT
         DPYjFaEUwuJajVUA0tq5EIDfLt97XP36OrNkXGsrbdqJqvIGkoxYifu40N8EXJT7qWrO
         64bRzYRBYqxe1FECL+BOJrtNLARWyDIaVTLt+OH53m3TMMVXiTIY9rNvY8DdyabgUnQW
         dsqIy8TFk0OLSt38yhjIz5KISZQsdbW3tb7XxanhUnc0asTbpI+G5YiMoSr9rZMH8d34
         vDab9/gn11rrz26yB5mw+myU2xNaKBgioPgvXrwdomzxEJ/2cqpdWhmFiTZQOZG6D9Wr
         xPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwVZSFEq0W28DM18hDTvCj9e8HcEAgSZLjRA5gyrBFU=;
        b=UpVTZEegJnXyLxiu9TCTZcqWr/IqQ4A9qeBk5j76xZdn093Y3FQ+sU+3P/nPQrAmBN
         LKjImtfpGfiCkSZXSFQNI7nCkk42s0MoVI0Gi+v34PwMGBIN9RQpz5V2U2EQjyorsRG0
         F99Q0DPTFK9BAf3HwjKRNt9qUALNF6k8rr3plAGXNaLIItOuoJE3VZGNXUUNagBEopC4
         0m0kFwYk5Y+DUs87FCNOc2/vdlTte3JFen+/jRuOjjN60yp5mgtfXOTxLAVnQ5K34s0l
         pRDKvK+7kHe5g4DRtSb+6Z+0euPbmYgDYPbvqa8Ravragw4G0HYKStMMlPDdU1qvsZEO
         u6kA==
X-Gm-Message-State: APjAAAWn85kvoOz+P/JmEAbgVS/4izThW5utllrn8d8x/AIDuV0yS0Y3
        4T0e1YLI90XRMkj4KeGCaEyyiI2lh/4dBQ==
X-Google-Smtp-Source: APXvYqx038IS+Ijfeh1//hkEoQpHVSqFBNIuH5C+1O568EPNKOQjnbiPQh7Uf1VmGHESUeIqO/HpLg==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr11552111ljj.206.1581625172663;
        Thu, 13 Feb 2020 12:19:32 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id s22sm2209470ljm.41.2020.02.13.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:19:32 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH v3 1/3] drm/sun4i: tcon: Introduce LVDS setup routine setting
Date:   Thu, 13 Feb 2020 22:18:53 +0200
Message-Id: <20200213201854.810-1-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210195633.GA21832@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Lebedev <andrey@lebedev.lt>

Different sunxi flavors require slightly different sequence for enabling
LVDS output. This allows to differentiate between them.

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 68 ++++++++++++++++--------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  3 ++
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c81cdce6ed55..cc6b05ca2c69 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -114,46 +114,48 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 	}
 }
 
+static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
+				      const struct drm_encoder *encoder)
+{
+	u8 val;
+
+	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+		     SUN6I_TCON0_LVDS_ANA0_C(2) |
+		     SUN6I_TCON0_LVDS_ANA0_V(3) |
+		     SUN6I_TCON0_LVDS_ANA0_PD(2) |
+		     SUN6I_TCON0_LVDS_ANA0_EN_LDO);
+	udelay(2);
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+			   SUN6I_TCON0_LVDS_ANA0_EN_MB,
+			   SUN6I_TCON0_LVDS_ANA0_EN_MB);
+	udelay(2);
+
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC,
+			   SUN6I_TCON0_LVDS_ANA0_EN_DRVC);
+
+	if (sun4i_tcon_get_pixel_depth(encoder) == 18)
+		val = 7;
+	else
+		val = 0xf;
+
+	regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
+			  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(val));
+
+}
+
 static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
 				       const struct drm_encoder *encoder,
 				       bool enabled)
 {
 	if (enabled) {
-		u8 val;
-
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
 				   SUN4I_TCON0_LVDS_IF_EN,
 				   SUN4I_TCON0_LVDS_IF_EN);
-
-		/*
-		 * As their name suggest, these values only apply to the A31
-		 * and later SoCs. We'll have to rework this when merging
-		 * support for the older SoCs.
-		 */
-		regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
-			     SUN6I_TCON0_LVDS_ANA0_C(2) |
-			     SUN6I_TCON0_LVDS_ANA0_V(3) |
-			     SUN6I_TCON0_LVDS_ANA0_PD(2) |
-			     SUN6I_TCON0_LVDS_ANA0_EN_LDO);
-		udelay(2);
-
-		regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
-				   SUN6I_TCON0_LVDS_ANA0_EN_MB,
-				   SUN6I_TCON0_LVDS_ANA0_EN_MB);
-		udelay(2);
-
-		regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
-				   SUN6I_TCON0_LVDS_ANA0_EN_DRVC,
-				   SUN6I_TCON0_LVDS_ANA0_EN_DRVC);
-
-		if (sun4i_tcon_get_pixel_depth(encoder) == 18)
-			val = 7;
-		else
-			val = 0xf;
-
-		regmap_write_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
-				  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(0xf),
-				  SUN6I_TCON0_LVDS_ANA0_EN_DRVD(val));
+		if (tcon->quirks->setup_lvds_phy)
+			tcon->quirks->setup_lvds_phy(tcon, encoder);
 	} else {
 		regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_IF_REG,
 				   SUN4I_TCON0_LVDS_IF_EN, 0);
@@ -1465,12 +1467,14 @@ static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.has_channel_0		= true,
 	.has_lvds_alt		= true,
 	.dclk_min_div		= 1,
+	.setup_lvds_phy		= sun6i_tcon_setup_lvds_phy,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
 	.supports_lvds		= true,
 	.has_channel_0		= true,
 	.dclk_min_div		= 1,
+	.setup_lvds_phy		= sun6i_tcon_setup_lvds_phy,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index a62ec826ae71..2974e59ef9f2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -228,6 +228,9 @@ struct sun4i_tcon_quirks {
 
 	/* callback to handle tcon muxing options */
 	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);
+	/* handler for LVDS setup routine */
+	void	(*setup_lvds_phy)(struct sun4i_tcon *tcon,
+				  const struct drm_encoder *encoder);
 };
 
 struct sun4i_tcon {
-- 
2.20.1

