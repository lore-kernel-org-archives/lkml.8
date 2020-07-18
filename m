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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED91FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0072076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuQsA+QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGRUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:03:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0829C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so4010800wrh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9LVKzcKKE6KucRCr2Robwz6yGdDbDVXBxug85I0dco=;
        b=JuQsA+QXDag3MJEgFG3rsFkOpM4Bhb/3DNCULylpWsANJwn4NA6dd3s147xo7s3ey4
         CFhsKGGd5G2FRuoiud12C7dQrOZ72rJ6oovlAyT9etUiHZ0OWXOmaueNe9+4npveWsrT
         moweQEz4L/kRQlpYWt6FNBL5LkEeEs6AbuiyGpUYVnm6+MsVxv60FIrQjZ2YhdEpi/eQ
         OUrBITlGULUJPme1h5xXXxpilsCgsnJGyaw0zwjmGMT2Bfdrsrk/zGuVNLXGuh+4kl3H
         El3o8cv9EgC9eaE//1JJDwfdQt66/Q0L7cJRi5d3RvMIKlV1Qds+r253cIdnHBLLZUQP
         dkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e9LVKzcKKE6KucRCr2Robwz6yGdDbDVXBxug85I0dco=;
        b=jEUIDoZ9yaNRbjGOKFY4K43SC2vl0iygXg4Zk6gBTcv6F73AO9lsTEskHugEe1oaPg
         LAmIQDYGfGvYS7z0veIuwdmyUUEEPGQIapCO0y/BCjoIgU1AqhpJJn36T2uiTeWmLEXA
         Hw9NOT06tiBrMTXFAQlgYBpGyML8UEY4UridrwygCpncYbK+loR57H/QZr021dOtul8N
         TCjVR7GH63uEOKZcICnLGyjJs0hq7DjmyWcc19aDkIwgDtWgw3osmgZ0erQjREOysdmc
         Z0o/y8Xzo0yxIoezOwVV/fGLhV1JhvlJykMhlNuF+GHzHzY/nTaBDfMm5Z0UqYab6kXG
         5nsg==
X-Gm-Message-State: AOAM533MOLvDpGwNN3VgoRa27O/kLr0rr/RnaYkm5wfgVDo0k+fpUT/8
        71WTo8M017pyDbrlO5QxzA==
X-Google-Smtp-Source: ABdhPJy3upfHRf43wWELUIEzg31WQ4xhbjXcEWGM7mHkoHhDeFXRX0C4Y41yOPT/ghAcnDRL/vL+UQ==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr16157748wrn.185.1595102625416;
        Sat, 18 Jul 2020 13:03:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id l15sm21073826wro.33.2020.07.18.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:03:44 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm: rockchip: add scaling for RK3036 win1
Date:   Sat, 18 Jul 2020 22:03:19 +0200
Message-Id: <20200718200323.3559-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718200323.3559-1-knaerzche@gmail.com>
References: <20200718200323.3559-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds register definitions needed to make scaling work on
RK3036's win1.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 80053d91a301..b046910129fb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -77,15 +77,20 @@ static const uint64_t format_modifiers_win_lite[] = {
 	DRM_FORMAT_MOD_INVALID,
 };
 
-static const struct vop_scl_regs rk3036_win_scl = {
+static const struct vop_scl_regs rk3036_win0_scl = {
 	.scale_yrgb_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 0x0),
 	.scale_yrgb_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_YRGB, 0xffff, 16),
 	.scale_cbcr_x = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 0x0),
 	.scale_cbcr_y = VOP_REG(RK3036_WIN0_SCL_FACTOR_CBR, 0xffff, 16),
 };
 
+static const struct vop_scl_regs rk3036_win1_scl = {
+	.scale_yrgb_x = VOP_REG(RK3036_WIN1_SCL_FACTOR_YRGB, 0xffff, 0x0),
+	.scale_yrgb_y = VOP_REG(RK3036_WIN1_SCL_FACTOR_YRGB, 0xffff, 16),
+};
+
 static const struct vop_win_phy rk3036_win0_data = {
-	.scl = &rk3036_win_scl,
+	.scl = &rk3036_win0_scl,
 	.data_formats = formats_win_full,
 	.nformats = ARRAY_SIZE(formats_win_full),
 	.format_modifiers = format_modifiers_win_full,
@@ -102,6 +107,7 @@ static const struct vop_win_phy rk3036_win0_data = {
 };
 
 static const struct vop_win_phy rk3036_win1_data = {
+	.scl = &rk3036_win1_scl,
 	.data_formats = formats_win_lite,
 	.nformats = ARRAY_SIZE(formats_win_lite),
 	.format_modifiers = format_modifiers_win_lite,
-- 
2.17.1

