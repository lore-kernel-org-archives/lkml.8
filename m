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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE1C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E138246C0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2+YQvtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgBMUTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:19:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33771 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgBMUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:19:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so5219945lfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3x8LznwfIOHEzFKzlxdqFwRCUCKp/X5F3uTKb+5kO8=;
        b=r2+YQvtLkH+6NOSpbgQnCewgfpF7LBPvBzm4isPF4njR+V4ekkCMBOvimCgWdEJffi
         wJYESGzRKbWgVhV3UPYtOVHHXDkgoPceXxjjS1FRH/+Ujwr1yeMyy0oRJqL1PQ/igMUW
         AKUcQ+IwYPU8uxwfVNZiu4VRR2EMTdxfOZyBtkBjBNkoq1UzSuuVJGnqD5bO0Um+RV+a
         smuEe1miOcWDkOBreXV214HcTvoSQpkKpmHDzC2FTLTl0oM7Yccp0qJ9/O/RHK0HHXj1
         dho2ybH4FqndggvgmNC9UBwRuoAyIMtDKa7MvhWofmUuda84bN1hqJJNKxJQqvbfkQ8Q
         G3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3x8LznwfIOHEzFKzlxdqFwRCUCKp/X5F3uTKb+5kO8=;
        b=JI5tnQTl/3HfBDu3aQW/7XT5jOKBQ+0UqRuZku/y0kkt+8PrR1v2GQ3B7yv2u1R7oC
         Wc4ZM59uHmB/mgJwYAZqq6Hpxdj6k1KAnD0IcQQ1B6SG3wSjqBvP/YMIdCiyl5x/i1wy
         MRXjcpCrvAwRd6g0p9w8bbygui4AgbgH1VPMen6/cv412E4MXdNigkkVawuMGfJuwG5i
         6dZjQDr5f7CwcDgSi/tizz8L0Duvg9FAIDtnj1gvzy0DTC0cxD1mmmyxoydHjiFeGuEG
         1IE1DRahE8IkjgqtsWGu+SuY6jfe0B7RTlavlYfYYE+JvpGPkhdhqLX1JVcd+L1LSo9b
         Q11w==
X-Gm-Message-State: APjAAAWeS9hlXy8ytxm6YRO8DgnTpyM9+7ivqPANfcURBFYiO9bzzARN
        3/R2b/U8mQzQXqZ3mwI27WU=
X-Google-Smtp-Source: APXvYqwaV3CvaxrlgCrOBOI9930fkISOFChEKsVF5+xwRyqJo9wJcYQPvXTiNMesnavqYkViTuhz5A==
X-Received: by 2002:a19:ee1a:: with SMTP id g26mr10058246lfb.147.1581625187334;
        Thu, 13 Feb 2020 12:19:47 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id s22sm2209470ljm.41.2020.02.13.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:19:46 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH v3 2/3] drm/sun4i: tcon: Support LVDS output on Allwinner A20
Date:   Thu, 13 Feb 2020 22:18:55 +0200
Message-Id: <20200213201854.810-2-andrey.lebedev@gmail.com>
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

A20 SoC (found in Cubieboard 2 among others) requires different LVDS set
up procedure than A33. Timing controller (tcon) driver only implements
sun6i-style procedure, that doesn't work on A20 (sun7i).

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 11 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index cc6b05ca2c69..800a9bd86112 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -114,6 +114,30 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 	}
 }
 
+static void sun4i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
+				      const struct drm_encoder *encoder)
+{
+	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+		     SUN4I_TCON0_LVDS_ANA0_CK_EN |
+		     SUN4I_TCON0_LVDS_ANA0_REG_V |
+		     SUN4I_TCON0_LVDS_ANA0_REG_C |
+		     SUN4I_TCON0_LVDS_ANA0_EN_MB |
+		     SUN4I_TCON0_LVDS_ANA0_PD |
+		     SUN4I_TCON0_LVDS_ANA0_DCHS);
+
+	udelay(2); /* delay at least 1200 ns */
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
+			   SUN4I_TCON0_LVDS_ANA1_INIT,
+			   SUN4I_TCON0_LVDS_ANA1_INIT);
+	udelay(1); /* delay at least 120 ns */
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
+			   SUN4I_TCON0_LVDS_ANA1_UPDATE,
+			   SUN4I_TCON0_LVDS_ANA1_UPDATE);
+	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
+			   SUN4I_TCON0_LVDS_ANA0_EN_MB,
+			   SUN4I_TCON0_LVDS_ANA0_EN_MB);
+}
+
 static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
 				      const struct drm_encoder *encoder)
 {
@@ -1456,11 +1480,13 @@ static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
 };
 
 static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
+	.supports_lvds		= true,
 	.has_channel_0		= true,
 	.has_channel_1		= true,
 	.dclk_min_div		= 4,
 	/* Same display pipeline structure as A10 */
 	.set_mux		= sun4i_a10_tcon_set_mux,
+	.setup_lvds_phy		= sun4i_tcon_setup_lvds_phy,
 };
 
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 2974e59ef9f2..cfbf4e6c1679 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -193,6 +193,13 @@
 #define SUN4I_TCON_MUX_CTRL_REG			0x200
 
 #define SUN4I_TCON0_LVDS_ANA0_REG		0x220
+#define SUN4I_TCON0_LVDS_ANA0_DCHS			BIT(16)
+#define SUN4I_TCON0_LVDS_ANA0_PD			(BIT(20) | BIT(21))
+#define SUN4I_TCON0_LVDS_ANA0_EN_MB			BIT(22)
+#define SUN4I_TCON0_LVDS_ANA0_REG_C			(BIT(24) | BIT(25))
+#define SUN4I_TCON0_LVDS_ANA0_REG_V			(BIT(26) | BIT(27))
+#define SUN4I_TCON0_LVDS_ANA0_CK_EN			(BIT(29) | BIT(28))
+
 #define SUN6I_TCON0_LVDS_ANA0_EN_MB			BIT(31)
 #define SUN6I_TCON0_LVDS_ANA0_EN_LDO			BIT(30)
 #define SUN6I_TCON0_LVDS_ANA0_EN_DRVC			BIT(24)
@@ -201,6 +208,10 @@
 #define SUN6I_TCON0_LVDS_ANA0_V(x)			(((x) & 3) << 8)
 #define SUN6I_TCON0_LVDS_ANA0_PD(x)			(((x) & 3) << 4)
 
+#define SUN4I_TCON0_LVDS_ANA1_REG		0x224
+#define SUN4I_TCON0_LVDS_ANA1_INIT			(0x1f << 26 | 0x1f << 10)
+#define SUN4I_TCON0_LVDS_ANA1_UPDATE			(0x1f << 16 | 0x1f << 00)
+
 #define SUN4I_TCON1_FILL_CTL_REG		0x300
 #define SUN4I_TCON1_FILL_BEG0_REG		0x304
 #define SUN4I_TCON1_FILL_END0_REG		0x308
-- 
2.20.1

