Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3382084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZ0FhwZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDTV5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTV5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:57:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C62C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so4458558pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w13L/ezkU/9Ek4TJ2p0jEnyPwOgfgHGWvOSyt05WFh4=;
        b=oZ0FhwZrFu/bCQOIbzwgeJPvCd3z18uNL9IMxUc5390+CmpsieWN6M9GfLMcmp9QNc
         hIpdZwvOZ1p+F9Xj2TAGyXi/+QPTp5dYEwAMukJbTdCXHT5CYarTuVB9HPRpj+luMNFK
         eQIM/XcOg3M1dH5JelqR+QajIGIx3fDNhvZmtE0jx+CnxuDyII//e9eqbTU4+d16wjqq
         cPSAcZ46Tia7vU67ZPztwyA/lGQtGAFDOA8VSkd7jYnvGkpwAyfP0nAsWOY5aF1HxOZP
         g9f0p1HXyUESzdnFuV4UytqNfocvcjXoJjo+35PWxEoAhBpWw2TrWPTSIgobukiCj0oh
         j5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w13L/ezkU/9Ek4TJ2p0jEnyPwOgfgHGWvOSyt05WFh4=;
        b=oTzdMuvfWD/ughQd3lpCH8bxB59YfBdZRoJlMvMT5Z9UJWJs64tvqpGALP+aOtDn7E
         wIt1V2Ndocu4NdMtadx+eUMV6I19cIbMC8sUJGH5OhnlzYH487h8Ysk8ZD1437CPt8lO
         7kHyKD2pe+KaC982qFbouC/uQ+rcs34N2msK9oENI/EJR2nCjIWVzjn8IM1oX1tpKovq
         5BIA0cn3SREZ1aYr685lFL8teRlZq0gjM3qRO6F86FLDsfRDWTR/SGqB0WXkmhKaZElY
         ABYEiyrwcPrjA99l346YOGRaHlnw2sQOvQzRqo2P1Y/z2xJK79C3RaNF/5AFtpjvFWy/
         4ccw==
X-Gm-Message-State: AGi0PubE5dsepNf4S5mjxNf88YKHHr+b0R5YtgA1EkIXtOVoPqGlsrkq
        91X3AfUL61M8jWqmwcAHRH/4GA==
X-Google-Smtp-Source: APiQypJpihiwJRryjS/UJF2bkGHPXlLDYV0x3LSZKA7/I8+h9FiscMuwFCune3ypxmgcZprSovFQhA==
X-Received: by 2002:a17:90a:fa17:: with SMTP id cm23mr1795903pjb.121.1587419825533;
        Mon, 20 Apr 2020 14:57:05 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f30sm365863pje.29.2020.04.20.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:57:04 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] panel: simple: Add Ivo M133NWF4 R0
Date:   Mon, 20 Apr 2020 14:57:28 -0700
Message-Id: <20200420215728.1927434-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420215728.1927434-1-bjorn.andersson@linaro.org>
References: <20200420215728.1927434-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The InfoVision Optoelectronics M133NWF4 R0 panel is a 13.3" 1920x1080
eDP panel, add support for it in panel-simple.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Specified bus_format, bus_flags and connector_type

 drivers/gpu/drm/panel/panel-simple.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5b92583bccdf..50ee1b842748 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2010,6 +2010,37 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct drm_display_mode ivo_m133nwf4_r0_mode = {
+	.clock = 138778,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 24,
+	.hsync_end = 1920 + 24 + 48,
+	.htotal = 1920 + 24 + 48 + 88,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 12,
+	.vtotal = 1080 + 3 + 12 + 17,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc ivo_m133nwf4_r0 = {
+	.modes = &ivo_m133nwf4_r0_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 294,
+		.height = 165,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+		.unprepare = 500,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DATA_MSB_TO_LSB,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct display_timing koe_tx14d24vm1bpa_timing = {
 	.pixelclock = { 5580000, 5850000, 6200000 },
 	.hactive = { 320, 320, 320 },
@@ -3619,6 +3650,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
+	}, {
+		.compatible = "ivo,m133nwf4-r0",
+		.data = &ivo_m133nwf4_r0,
 	}, {
 		.compatible = "koe,tx14d24vm1bpa",
 		.data = &koe_tx14d24vm1bpa,
-- 
2.26.0

