Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBEC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843162084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/TW+lXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBZIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43653 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgBZIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so914321pgb.10;
        Wed, 26 Feb 2020 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2c6a2wUIf1607PZkN1rZk+L4ET6oyW/A+dmD8ze92gI=;
        b=l/TW+lXATIXM17aGIZ9zrNTKWKrYbTiLzzjCckt2sYGCNOgBJIAM/09gAYIyO8Ix1n
         UHbe88pAp1n0plvmre5V5bbjfK092LKIqAYUkzsgoJS7/2xUSMZgE5o2q6j40HA9jjre
         FF8uZvB+fx7B6YmX6nxlrWe2JsyENeFsB23HdsKTAR2dEJOG0eVZaT0pJNwkmq0+XMJC
         c9jFO1zsFW7hO9kM7570YJrU/mpImzvlnR4RWJMtjUx3BXAFto3xHr0udkFVc1dm8Tg0
         Ip4cwJcKanfhov2dNsyjvshdovNKgTGIdSWpGBGikwWBexhz01R0zL94DTwVMPuTLhGV
         /+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2c6a2wUIf1607PZkN1rZk+L4ET6oyW/A+dmD8ze92gI=;
        b=YNZXHIl88Wv6NaFDu4VbpF18A7YtAaVOTC3vnTNsTZueCSC2YkGuIcosgAplu6PsW7
         jgVOMZ4/6MGks066tWbGpsVHCjToKihmJ19OvlNb+eRVYRLR+BFr90qipg7QYxFS9RBP
         MUHMovRea4qvZJ5FesuiEWlKqbmMTuFEQ7/vyx65Uh7l/qPOTrGzqafNM9sCQcAp5ch0
         MrBk0Zo5k4nzR0JvNeYiF1FJcs+oRnwte4RCndMG4MFTerdh1jo94wXhDju5B71/GZJK
         Ja1i59LVYZvfRDhNVWdl7qbHiK3mdLFShwevUbJ/qWEqAXIFZc6OxUGkPeJ5+XkX0JQ7
         OcHA==
X-Gm-Message-State: APjAAAWMrRzy2EGuB6iS/gz6vn1yWxTuXclwevne0qUhOGJ+BYTaNO+P
        HnmNiRMfcxU3ZtV4LEqC6YU=
X-Google-Smtp-Source: APXvYqy00/8d+Wer4Z0MFSOy0sPlhrq7zbo/TdsWVeXFTKfHPPar8rV+DBjhxAWH91y4lWNMO4S3Pw==
X-Received: by 2002:a63:ec0c:: with SMTP id j12mr2609426pgh.78.1582704647920;
        Wed, 26 Feb 2020 00:10:47 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:47 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 5/6] drm/panel: simple: Add NewEast Optoelectronics CO., LTD WJFH116008A panel support
Date:   Wed, 26 Feb 2020 00:10:10 -0800
Message-Id: <20200226081011.1347245-6-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the NewEast Optoelectronics CO., LTD
WJFH116008A 11.6" 1920x1080 TFT LCD panel.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac62b5..4292e3e3a461 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2224,6 +2224,51 @@ static const struct panel_desc netron_dy_e231732 = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode neweast_wjfh116008a_modes[] = {
+	{
+		.clock = 138500,
+		.hdisplay = 1920,
+		.hsync_start = 1920 + 48,
+		.hsync_end = 1920 + 48 + 32,
+		.htotal = 1920 + 48 + 32 + 80,
+		.vdisplay = 1080,
+		.vsync_start = 1080 + 3,
+		.vsync_end = 1080 + 3 + 5,
+		.vtotal = 1080 + 3 + 5 + 23,
+		.vrefresh = 60,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	}, {
+		.clock = 110920,
+		.hdisplay = 1920,
+		.hsync_start = 1920 + 48,
+		.hsync_end = 1920 + 48 + 32,
+		.htotal = 1920 + 48 + 32 + 80,
+		.vdisplay = 1080,
+		.vsync_start = 1080 + 3,
+		.vsync_end = 1080 + 3 + 5,
+		.vtotal = 1080 + 3 + 5 + 23,
+		.vrefresh = 48,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	}
+};
+
+static const struct panel_desc neweast_wjfh116008a = {
+	.modes = neweast_wjfh116008a_modes,
+	.num_modes = 2,
+	.bpc = 6,
+	.size = {
+		.width = 260,
+		.height = 150,
+	},
+	.delay = {
+		.prepare = 110,
+		.enable = 20,
+		.unprepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode newhaven_nhd_43_480272ef_atxl_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3399,6 +3444,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "netron-dy,e231732",
 		.data = &netron_dy_e231732,
+	}, {
+		.compatible = "neweast,wjfh116008a",
+		.data = &neweast_wjfh116008a,
 	}, {
 		.compatible = "newhaven,nhd-4.3-480272ef-atxl",
 		.data = &newhaven_nhd_43_480272ef_atxl,
-- 
2.25.0

