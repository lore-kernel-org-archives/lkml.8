Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F530C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5148C207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QZJ5dKda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgH2Qdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgH2Qdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:33:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CFC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:33:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s2so924361pjr.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Apxjtlu8DYBDOF5mldDa/gPEeAR1t60BoMeYHKIoGuI=;
        b=QZJ5dKdac4Iext8grWZXs2y4cw4TLAIJ5uwUqWQbVwvaB0e4B2EsAdU1WMAEIaY5yN
         TkBdXfv0fRy2cNPT9oxVhO7lVKy0/J75cWH7rKQTNkFwPF+ocKMRuULK7ZFhaFD81+Gn
         x14+rHmYqf887takLFZxTv/h0bPlGQhVFhTS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Apxjtlu8DYBDOF5mldDa/gPEeAR1t60BoMeYHKIoGuI=;
        b=aJJ2dAhPskN+UWqlRdJIqWNSKbuMKau1u20RLhbVoywGq4Vwe8ZxcDcPPXox7/lFlw
         QMMzV5Qp47MQQOBEwXMMcr2EZVLSq9SjfncoGqKS3B6P/nOYTckaqus6Jg42ekDSippp
         6PUpClJ2H7nkehwPDFv9WvwjawbYJOXauKwwVv3HBKmS5l908CRfXOkXUftokYTO0BjN
         mTwyqyXZOWFX7CDPoTyFGMMtDcuLqZUvHcTSZ9twlYfgPIXcCOlLRhZxcSMHN81/wNFW
         KdpgOv3d3neXXY7KmYASBnRI6EJOmuuWV8X0FuRPLcjGHMhDucxsDekU04sEJMjPr+09
         d+QQ==
X-Gm-Message-State: AOAM5327xXAqVoFrXKOCSMfcvqS7l2xEXnAuQ59bqx3FrDqSbgHd7cTC
        8ZTWtrvciGiKFVWulEfu5IUZaw==
X-Google-Smtp-Source: ABdhPJwLaZtmSHF9YHYi8bPVvMaHNOSSExLBplTYuQJomtWyYkJ+P/fuI8rH8h/DDRreztBdRuphdg==
X-Received: by 2002:a17:902:7606:: with SMTP id k6mr3125530pll.171.1598718823329;
        Sat, 29 Aug 2020 09:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id o6sm2457934pju.25.2020.08.29.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 09:33:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] drm/panel: simple: Add AM-1280800N3TZQW-T00H
Date:   Sat, 29 Aug 2020 22:03:28 +0530
Message-Id: <20200829163328.249211-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829163328.249211-1-jagan@amarulasolutions.com>
References: <20200829163328.249211-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ampire, AM-1280800N3TZQW-T00H 10.1" TFT LCD panel timings.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- dropped vrefresh
- add bus_flags, connector_type

 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b6ecd1552132..b106142b11ca 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -592,6 +592,32 @@ static void panel_simple_shutdown(struct device *dev)
 	drm_panel_unprepare(&panel->base);
 }
 
+static const struct drm_display_mode ampire_am_1280800n3tzqw_t00h_mode = {
+	.clock = 71100,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 3,
+	.vsync_end = 800 + 3 + 10,
+	.vtotal = 800 + 3 + 10 + 10,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc ampire_am_1280800n3tzqw_t00h = {
+	.modes = &ampire_am_1280800n3tzqw_t00h_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3637,6 +3663,9 @@ static const struct panel_desc arm_rtsm = {
 
 static const struct of_device_id platform_of_match[] = {
 	{
+		.compatible = "ampire,am-1280800n3tzqw-t00h",
+		.data = &ampire_am_1280800n3tzqw_t00h,
+	}, {
 		.compatible = "ampire,am-480272h3tmqw-t01h",
 		.data = &ampire_am_480272h3tmqw_t01h,
 	}, {
-- 
2.25.1

