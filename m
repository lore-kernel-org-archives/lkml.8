Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0934C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151024677
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtVchtL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBSSKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41618 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBSSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so1346681ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwVZSFEq0W28DM18hDTvCj9e8HcEAgSZLjRA5gyrBFU=;
        b=QtVchtL/9CNa6r0223jyMYNh/PWgurYiZxsAUUmtGt1/2v8ziOxqSz9ztKW7UtdF6f
         4Ee5G+NSWfAs+MWRUFb+gR8xlyEbjJu5eNusMVNK3mb65uLWBMQ3T4u1GDZZ/SG2SCA0
         ED132ZbJmWiIGlEd3tmSBCPN2YSKlaizsSoNNi2wUiLAtOIA2u9+kLlc9Xz0yb1KvB7W
         6KcWyQZUcgha5gIquLzQ8XMighG9XdCwFgZjDr8i/3ebgcOziFXhIumdzJNBFg9zm9kA
         Wdexk/BiMyWccLWiLG7blXW3XMsgpUNBckRfZ9iS4moX/qNrNjCwaQlx6xZhVbpy9EBk
         2XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwVZSFEq0W28DM18hDTvCj9e8HcEAgSZLjRA5gyrBFU=;
        b=XKoBzj8uN8B4KSYp0AV4kEnda83A2MSKcA5g1RkZHejbZSXgzsefMtnAiEEqMserD0
         dAYDOkAb/QjRpPKxHxcj3HsImpzdDaZKaDsZ2Ei0Io8bgPhoj5m/1KUEXIYoix8JFh2H
         M71R/aISfyHlnBf1hq6J13leSgxxEChoRwELdmYrwNVrbsPCQY780cvCyLKRzoDuV6e/
         eym3fHQqnbjG/HEYq5psbIGNW4q3tUL9o/uRFhvIk6vH0qjm1UWWLhVu4shoh+zJguY7
         XgU2I3XSRqXWjKGezbv44hJK6Flzts08JwkXfoEUp4iSx5U4WXc7ZnuZKVt7JmUiwds3
         gG7w==
X-Gm-Message-State: APjAAAWvh1Z4f7pfZyuJszd+EEAZxc3qCUEQz8kEDY5p6lNfxCeU1EqL
        FDOc8qoEQAC5A4XeoTY26cI=
X-Google-Smtp-Source: APXvYqydV08tRFu0OfU6LEqWQW2vgQYiGMwoLKXox2Fx/uXq/7ZBu7hmRYFXopQpUkIZ3NHs276hZw==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr16464588ljj.31.1582135798567;
        Wed, 19 Feb 2020 10:09:58 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 14sm183942lfz.47.2020.02.19.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:09:57 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH 1/5] drm/sun4i: tcon: Introduce LVDS setup routine setting
Date:   Wed, 19 Feb 2020 20:08:54 +0200
Message-Id: <20200219180858.4806-2-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219180858.4806-1-andrey.lebedev@gmail.com>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
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

