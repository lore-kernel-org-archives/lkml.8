Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E890D207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ+lxwAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgGVSOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:14:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E3AC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so3275691eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+2yRql0PqZgjMLyfhyquRo9Q78YxnYMENZUh8aYO2bY=;
        b=MQ+lxwAOW3hhiw4GW1RPkyHjPo9/BRI+QBF7guB/qd5C5OnecF8OtmuxofFp16OQKy
         EMC7+3g2nf08aEbMghDQXRUvp0fzhowa/jIcH4uXJQcWIR+vhpTF7YBAWLdEqVTyRrxi
         nEhOKHX26y8VBaerO9+Gur87dZwtsRan/KUnWmIdLqMKDQ8IHg7GVLNx/MuIh/DBx4/i
         n+32kVouDv63jjHxIpv23Kk7as0nYKbP2vG5AJd9sjHS5i9a/4J9Xakc4RoidDus1kVc
         rMZAfP4oHMJ77Om9k45dDrjCZ9zAK2l+LCGC+Y+8IaIgcJpY13tGbBxu+8Xa1N+OB/Px
         rgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+2yRql0PqZgjMLyfhyquRo9Q78YxnYMENZUh8aYO2bY=;
        b=mdAKbQGtIywmuJZaWgcu9cTzWPqpNgnHlaDLGwbsrxTKikFWwsbBtermtzrQTZEs5A
         qH91coq+Mpn8P0zcxaX9K9xX8xAmdN5XHk5A8WJ3gQDcPBX7SOwyZjK7TgArXHp+z6wi
         62LxYOXuEcOSN5mhD5c70krS0Hzv2xCgynivPxI6ULkpiwDFZRLUdd/wsiV1pgsuSdE+
         kjLVPiTJOf4Dkw19Bm+cqXcq1WFci52ax0zJc54qCDu9Wlne4KBzPD75j5uF/O2YGR1K
         LcTzuD9gltL5bqYX+gWuXm3XQNcR9AfthdU3WBhmlFuyyHOBQLMu0cHvdjR9gL8b7roT
         O/dw==
X-Gm-Message-State: AOAM533g0fHOlMONdtCslFn6oOYpMeS3+M84OT49CwUW4KwDlec1o6du
        VfkdfRgo0pZdDehzjwDLxQ==
X-Google-Smtp-Source: ABdhPJydtGJH1Wsx4NdMMVNpjKYL+ExfG/m+mBecCKK9gKXGYtqpdmrFWa/WLjRkpoXM2dmiBGmovw==
X-Received: by 2002:a17:906:456:: with SMTP id e22mr811200eja.178.1595441639663;
        Wed, 22 Jul 2020 11:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id x64sm372954edc.95.2020.07.22.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:13:59 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm: rockchip: add scaling for RK3036 win1
Date:   Wed, 22 Jul 2020 20:13:28 +0200
Message-Id: <20200722181332.26995-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722181332.26995-1-knaerzche@gmail.com>
References: <20200722181332.26995-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers needed to make scaling work on RK3036's win1.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

Changes in v2:
- rephrase commit message

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

