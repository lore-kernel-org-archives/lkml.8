Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83612C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBEE2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfV+SpGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHUPfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgHUPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:35:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:35:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ds1so975864pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soERAZs9Qqj0stxZ21kcyBQ2mrcQaIYycZ2RGXP4UCc=;
        b=OfV+SpGv14O8eiiPmbak3/VqcCOP9Svc+4+NW66iyBfeZw0VYn9jzvZx5zJ/Si9JoT
         ie98uM6X+4gO7ltkaWyLLJ/ZLfDpilz/pNVH+ptOfmPx16/pJ4DFURvLiqHs+sgbLep8
         BzoHATwNhB5btbStuIJQ9WkhhES9xSiuZ6+1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soERAZs9Qqj0stxZ21kcyBQ2mrcQaIYycZ2RGXP4UCc=;
        b=B7kjEuL3FJb35uJaeAp9hrKNvS38hSKyjQUzj22kVNmsaTDEoLLZ5xF+MTr1kkcKFX
         SFTywDUX9bxQu4luaj2rGuezCaJVXrY1p/OLpe7q0pdASfO7qUlzUglgonWsIKMGr2Lv
         fHzA5FHAFXKaHZAxpvvR6SUU/J7v7p8AF5+3iiy/f4zntIv4Mhgg/c1eOHnUttQBU/UP
         WXXsmsNysrFqjjSCKUaB///RWRkjW0T0i2En4+K9p6cyV2ncrLfsVvWk7TULM2mUs6x4
         UNyHi5OUjCYK15xMvKnzFgPiuPqXjMFlIveHyEJWJJmP13C5FvwGsSgrhS2uEyjinX3U
         o8lw==
X-Gm-Message-State: AOAM532FIkcJW6br7sPjpNtgCM9faisENYKnuy58wciFYp0onXTY66Yh
        k8QLPmwIx2cJfhf5o9n7oYc1N1R7hHxSfA==
X-Google-Smtp-Source: ABdhPJz5/8mxA1qiicGG2N+7IOeZNeMhwEcpWMGEM59KuhuEqOcUCsU/8VVBUQ8LHzl67/I3gKACyw==
X-Received: by 2002:a17:90a:de83:: with SMTP id n3mr2784787pjv.62.1598024136533;
        Fri, 21 Aug 2020 08:35:36 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id u8sm2200720pjy.35.2020.08.21.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:35:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: panel: simple: Add KD116N21-30NV-A010
Date:   Fri, 21 Aug 2020 08:35:15 -0700
Message-Id: <20200821083454.2.Idf25356dff4b36c62704188c3e3d39a2010d6f6a@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821083454.1.I61e6248813d797c9eeebfbb7019c713aa71c4419@changeid>
References: <20200821083454.1.I61e6248813d797c9eeebfbb7019c713aa71c4419@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Values come from the vendor and have been tested on hardware.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4eabfdd3be2d..f499de71ab3d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2341,6 +2341,34 @@ static const struct panel_desc ivo_m133nwf4_r0 = {
 	.connector_type = DRM_MODE_CONNECTOR_eDP,
 };
 
+static const struct drm_display_mode kingdisplay_kd116n21_30nv_a010_mode = {
+	.clock = 81000,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 32,
+	.htotal = 1366 + 40 + 32 + 62,
+	.vdisplay = 768,
+	.vsync_start = 768 + 5,
+	.vsync_end = 768 + 5 + 5,
+	.vtotal = 768 + 5 + 5 + 122,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc kingdisplay_kd116n21_30nv_a010 = {
+	.modes = &kingdisplay_kd116n21_30nv_a010_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 256,
+		.height = 144,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct display_timing koe_tx14d24vm1bpa_timing = {
 	.pixelclock = { 5580000, 5850000, 6200000 },
 	.hactive = { 320, 320, 320 },
@@ -4047,6 +4075,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ivo,m133nwf4-r0",
 		.data = &ivo_m133nwf4_r0,
+	}, {
+		.compatible = "kingdisplay,kd116n21-30nv-a010",
+		.data = &kingdisplay_kd116n21_30nv_a010,
 	}, {
 		.compatible = "koe,tx14d24vm1bpa",
 		.data = &koe_tx14d24vm1bpa,
-- 
2.28.0.297.g1956fa8f8d-goog

