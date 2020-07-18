Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762E5C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6B72076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne7cdRDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGRUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:04:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD49C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:04:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so9264766wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3wmalXMf5RKdLRLN2Edh3BeBHa7ZnwIzM8k1DA3s8I=;
        b=ne7cdRDd09qgXdnFVUb/lT9/BuqLGPItDxnLgkv7cX0/mvBii4cFfQbmUZLzduYq/6
         7s1F2WyE0DfQdHL9LRQ3w+SXHJZHudNgSrNlzDzP6rNJVSjGmKzqkI0Okiuh1Y+MpAwj
         NOo2VKijv3w4EBiZs6GIergq/76K2S6aj4xlGGQB9eggoNxVZO+Y2caT2sDVd+7wGMiF
         jcqsOSGE9J4OynScE+4OO7H5XAMbqzrYH9KsFHsTBBu2zV4zWyV+kB3KnmwwKwGStaWL
         GGLgHQ3Cd92TSwOhiXTxdAPm3D9TlxnMdwux/3IzID6gVlKnkJ/GZIq5+HvTUbjxpHGm
         cUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3wmalXMf5RKdLRLN2Edh3BeBHa7ZnwIzM8k1DA3s8I=;
        b=eipG8mMt1FTiaLiEPwTotqitMtgHKCLAGcwMz3e+2RLyHiTGU3uKvmzQU8wBNkVZ8G
         kCR0Hk5eIg1Ne1+GYAwPpCwNgTfjfUtR3l77Pj8EwUDWBM+y2BD7LbG+ujg9jeDaowrt
         uS8xT4s4rLFPqt4vMYvuK4D3fIVlBY9Ht2cMudcn0ZoyDOdwp1LZbfnsaItw/Pwnsofs
         xDEBiscZ9chjXmorKi23hzK59e2S6jCM87TYCDl5kdzX5XAVDg8cKI7vgkuOQrPAAK4S
         4dDGLWktci8co9oDip1a09gqJakT0IMdMQDtdYvbXjHAKoRLoL/d/dYrHe7c+jKPVASv
         K59w==
X-Gm-Message-State: AOAM531flf9mMqLw8NTtv6QHu8OZJ73uWkBGjv5uCvxgbFkPngtZfdFs
        ovY7k7z0SzfAnRdO47nMZQ==
X-Google-Smtp-Source: ABdhPJwdcwx43GlqCWVegzP07sgYkGwTpgWjf7cAPhoMDjs2HHlSuCYvAXYz9Ut+qF6WP+Sx7f3KlQ==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr15709913wmc.106.1595102643612;
        Sat, 18 Jul 2020 13:04:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id l15sm21073826wro.33.2020.07.18.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:04:03 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm: rockchip: use overlay windows as such
Date:   Sat, 18 Jul 2020 22:03:23 +0200
Message-Id: <20200718200323.3559-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718200323.3559-1-knaerzche@gmail.com>
References: <20200718200323.3559-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the comment for rk3288_vop_win_data windows
that are supposed to be an overlay window are missused as HWC windows
due to the missing implementation of that window type in VOP driver.

This is also true for RK3036, RK3126, RK3188 and RK3228 VOPs which
all have at least one dedicated HWC window (which are currently not
definded in the driver).
Since all of the mentioned VOPs have only one overlay window and all
of them support alpha blending now it should be used as such, since
this gives a much wider usage-perspective for them.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index f2f9a9af39e3..756c580f206a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -131,7 +131,7 @@ static const struct vop_win_data rk3036_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3036_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3036_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const int rk3036_vop_intrs[] = {
@@ -200,7 +200,7 @@ static const struct vop_win_data rk3126_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3036_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3126_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const struct vop_data rk3126_vop = {
@@ -543,7 +543,7 @@ static const struct vop_win_data rk3188_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3188_win0_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x00, .phy = &rk3188_win1_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const int rk3188_vop_intrs[] = {
@@ -980,7 +980,7 @@ static const struct vop_win_data rk3228_vop_win_data[] = {
 	{ .base = 0x00, .phy = &rk3288_win01_data,
 	  .type = DRM_PLANE_TYPE_PRIMARY },
 	{ .base = 0x40, .phy = &rk3288_win01_data,
-	  .type = DRM_PLANE_TYPE_CURSOR },
+	  .type = DRM_PLANE_TYPE_OVERLAY },
 };
 
 static const struct vop_data rk3228_vop = {
-- 
2.17.1

