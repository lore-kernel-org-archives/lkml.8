Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F73DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F307F2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="LH5FZK+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgGAKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:32:36 -0400
Received: from vps.xff.cz ([195.181.215.36]:42122 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbgGAKbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599490; bh=Uj/PtNKs3+mkjVbPW0e4D6UAtrtq8nzQPPh5UoRwNE8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LH5FZK+tpQsQPfnm5tzP1VPDvNeWOgCjJupWFDbt+uWCLrrNmy6qcU9v9i5u6T5Pd
         c7SVjOc3s373A4wyF7AMgn3kkpWnQFOiqTKs8aFke19jufaM1/Kdu9++ZGMSArGULJ
         gbdxbtWGVRDXBMvDwY2bHMkDQver/T6zAG+8cUho=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v6 04/13] drm/panel: rocktech-jh057n00900: Rename the driver to st7703
Date:   Wed,  1 Jul 2020 12:31:17 +0200
Message-Id: <20200701103126.1512615-5-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rename is done so that the driver matches the name of the
display controller and in preparation for adding support for more
panels to the driver.

This is just a basic file rename, with no code changes.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig                 | 26 +++++++++----------
 drivers/gpu/drm/panel/Makefile                |  2 +-
 ...-jh057n00900.c => panel-sitronix-st7703.c} |  0
 3 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/gpu/drm/panel/{panel-rocktech-jh057n00900.c => panel-sitronix-st7703.c} (100%)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 39055c1f0e2f..de2f2a452be5 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -283,19 +283,6 @@ config DRM_PANEL_RAYDIUM_RM68200
 	  Say Y here if you want to enable support for Raydium RM68200
 	  720x1280 DSI video mode panel.
 
-config DRM_PANEL_ROCKTECH_JH057N00900
-	tristate "Rocktech JH057N00900 MIPI touchscreen panel"
-	depends on OF
-	depends on DRM_MIPI_DSI
-	depends on BACKLIGHT_CLASS_DEVICE
-	help
-	  Say Y here if you want to enable support for Rocktech JH057N00900
-	  MIPI DSI panel as e.g. used in the Librem 5 devkit. It has a
-	  resolution of 720x1440 pixels, a built in backlight and touch
-	  controller.
-	  Touch input support is provided by the goodix driver and needs to be
-	  selected separately.
-
 config DRM_PANEL_RONBO_RB070D30
 	tristate "Ronbo Electronics RB070D30 panel"
 	depends on OF
@@ -395,6 +382,19 @@ config DRM_PANEL_SITRONIX_ST7701
 	  ST7701 controller for 480X864 LCD panels with MIPI/RGB/SPI
 	  system interfaces.
 
+config DRM_PANEL_SITRONIX_ST7703
+	tristate "Sitronix ST7703 based MIPI touchscreen panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for Sitronix ST7703 based
+	  panels, souch as Rocktech JH057N00900 MIPI DSI panel as e.g. used in
+	  the Librem 5 devkit. It has a resolution of 720x1440 pixels, a built
+	  in backlight and touch controller.
+	  Touch input support is provided by the goodix driver and needs to be
+	  selected separately.
+
 config DRM_PANEL_SITRONIX_ST7789V
 	tristate "Sitronix ST7789V panel"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index de74f282c433..e45ceac6286f 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
 obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
-obj-$(CONFIG_DRM_PANEL_ROCKTECH_JH057N00900) += panel-rocktech-jh057n00900.o
 obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
@@ -41,6 +40,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
+obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX424AKP) += panel-sony-acx424akp.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
similarity index 100%
rename from drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
rename to drivers/gpu/drm/panel/panel-sitronix-st7703.c
-- 
2.27.0

