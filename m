Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA82C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3285D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hy4l05Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH1QAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgH1QAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:00:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C2C061234
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:00:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so699321pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbYexE+YeO82ly0FE/zoT/BNz1A0lzD35YNwGzIzVsk=;
        b=hy4l05DsPLpSJW+l89Chi5ub1DjyDJzR+qRlR2IAHcVnaR72U5lE5bCmmkXZpgsXpQ
         1Xh5M59WyQwRpd3r4x2G6+7x+AyVIx/8OE7W4bfJsRaTaOCwsKx1MoDIY28DFdOdyn4F
         CnnDvS4XIZHkU7R3pk74YzfO7F49HRHhBGvd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbYexE+YeO82ly0FE/zoT/BNz1A0lzD35YNwGzIzVsk=;
        b=JPhFcbjqH6FwEoKIcm/PcWMJb+9gHLAKtp630Wob3BAxC96hJ/YUthXqcl1Eut3cfw
         HkF23lyfhi99qb6Sli59zgoPby83naN3NRRPY6l4nhu9uToK92kyspZ+oh+4T2shGqbE
         TIHR1qFNiL6LpXpvLsi+hVjsBq7Sf+XFUzW7Q4DKeIDKwnG3YfpFrpcB9C85nOPB6Ic/
         arqmmY9ltdv5mu+jz8nHMyXb5JRGr3hwPZ4clVNrChwVypq09lc6OuU8/J4fGYmr33h6
         r6tKZFRLhZ8As5dCIvx3tjEo0WcYEQ35mm9ThwQ87bn60xLO2eUbHyzkxcBgTQVP+aCQ
         t5fQ==
X-Gm-Message-State: AOAM532ycIaAnA2a5SDewMCrYeQyHEM89WgGjho+6Aw61TEEbaG7vqhx
        qzF19kxPZb8SK75qiAcSkAfGHQ==
X-Google-Smtp-Source: ABdhPJyUJZm0XVHjwyYxk2tVHNOq6dtmyiZbFYgdzVsyHHd/Nrqh9K35iKvUnQRhhp69kMczmZWtyg==
X-Received: by 2002:a17:90a:15c8:: with SMTP id w8mr1837572pjd.179.1598630402968;
        Fri, 28 Aug 2020 09:00:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:8ce8:955b:ae1b:d6ef])
        by smtp.gmail.com with ESMTPSA id x13sm2195691pfr.69.2020.08.28.08.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 09:00:02 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] drm: panel: simple: Add AM-1280800N3TZQW-T00H
Date:   Fri, 28 Aug 2020 21:29:38 +0530
Message-Id: <20200828155938.328982-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828155938.328982-1-jagan@amarulasolutions.com>
References: <20200828155938.328982-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ampire, AM-1280800N3TZQW-T00H 10.1" TFT LCD panel timings.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b6ecd1552132..c988fe8094f8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -592,6 +592,31 @@ static void panel_simple_shutdown(struct device *dev)
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
+	.vrefresh = 60,
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
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+};
+
 static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3637,6 +3662,9 @@ static const struct panel_desc arm_rtsm = {
 
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

