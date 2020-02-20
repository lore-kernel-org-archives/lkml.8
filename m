Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FAC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB7624672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVRLDXHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgBTIgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36718 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so1280975plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/c4HnHL8fMAg6Wo4pqS2IgOW97h7pKxh9Qxew+UstU=;
        b=jVRLDXHVy8oHPRXfBedHbTNAtkdvnd1bwk1Yk+NWpCm/JqBBDPwJ9SwMP2gddlZHrj
         eiH61428+Mx0koFTtoxOq/ed6ErAnMpwyX7WLDs6BsLZWPf8+L676n0n1mW0E5emvZfg
         F5+aCZiyNd8sYg4PTwDKiHu1mijlAYUvJpQz8nfG+2V/L6IjmvnzJCAi1B4rQjr4h4ez
         r/SovY9JQefHPaXoUPLbLifoW/vfy8NtG2zCQMpExwlSLys2m17/ALM8umf1gXJFw2Fv
         XFKAnroF69zdiP1fKBrCMTnf3hFwupOuxRSAJXIh8RaLVOk97vdz7/LqzngPSP3SZPVA
         uHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/c4HnHL8fMAg6Wo4pqS2IgOW97h7pKxh9Qxew+UstU=;
        b=FWJZx89St8/Guq21jTqY1pM2p7FvWsQUT+udoeVqyk0NJzziMdEmd/JyHQsIdDc0oe
         D1vDjcEm+35OV6HMusjUYYlUdOXcZ/TLVgRtakTBQyxda/Xe2cMxqrfPn/GzrrSZP3tD
         7DJK7yDv/nANuOZRfZHcc9NDWlWHTIEYBnzOCBVRnAaOYR51NCtiRZRnGaCBKODr2J6G
         Nglh9p4R9vUVLOpxr/g+NsdDuV2DPAsej2QXTWvcpz0qYVC0ZmnG8qAvTggkSFy15FPm
         RalInIxjWDc+NRgmwlTWvEOTbLGaWYk9VyFcQrn3hdcxhcUQFGajLCy5Px4sEBG95Hz7
         dHmg==
X-Gm-Message-State: APjAAAVRk7rtT8oM2GNyp1qyUnNjXuAUwrDId3vXX/WN7tiCYOiswPMr
        PU81IYoGpcV6CTtq+CowYz8=
X-Google-Smtp-Source: APXvYqyYpW3EXASVj7XV5DEOPQswxo7hRbJnjHbgKCDrhVP4i9xGeNsgJjGu3JKIdyetfAZGHkiGCg==
X-Received: by 2002:a17:90a:a48c:: with SMTP id z12mr2330695pjp.38.1582187758576;
        Thu, 20 Feb 2020 00:35:58 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:58 -0800 (PST)
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
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 5/6] drm/panel: simple: Add NewEast Optoelectronics CO., LTD WJFH116008A panel support
Date:   Thu, 20 Feb 2020 00:35:07 -0800
Message-Id: <20200220083508.792071-6-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
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
 drivers/gpu/drm/panel/panel-simple.c | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac62b5..aa04afaf3d26 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2224,6 +2224,50 @@ static const struct panel_desc netron_dy_e231732 = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode neweast_wjfh116008a_modes[] = {
+{
+	.clock = 138500,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 48,
+	.hsync_end = 1920 + 48 + 32,
+	.htotal = 1920 + 48 + 32 + 80,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 5,
+	.vtotal = 1080 + 3 + 5 + 23,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+}, {
+	.clock = 110920,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 48,
+	.hsync_end = 1920 + 48 + 32,
+	.htotal = 1920 + 48 + 32 + 80,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 5,
+	.vtotal = 1080 + 3 + 5 + 23,
+	.vrefresh = 48,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+} };
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
@@ -3399,6 +3443,9 @@ static const struct of_device_id platform_of_match[] = {
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

