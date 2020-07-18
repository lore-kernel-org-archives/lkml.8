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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15405C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F9720717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQ66ff1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgGRUDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:03:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so18781512wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WoXFd0SV1/eqOnBq17jLxZ1E6FRJYzbrzrT0wsL/bTc=;
        b=tQ66ff1lLYZag32k5qkE2SZoAAjv8UkJZhytRTvdENmozmF4WUkJST6u9iOJRFzB5l
         hKTV/0yMr2gZih9mnWD3dr7Q/LVzCjNL7XbDrDaHRfsorJ8ZMCTamOuJZpKdAtYOEfSA
         prMlYUX1w7bm+OUaFr6Fl1jIl723J6oaLAqNWeLps9co51ppFzFX8Tsd9GiXOGf8h2CV
         Yg2hEImkW+NAqLMjXqBt1sqW06ttBcizxlYPWwMCZdQfrNccniGxAJ9UPlbONXpkH/bo
         HQSh2SZxsIPk7my30BMf41vfoHdZZA+DBNd1klWLCXI+8rq1Qd/BXmW2MeYuvkv0qfCM
         htxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WoXFd0SV1/eqOnBq17jLxZ1E6FRJYzbrzrT0wsL/bTc=;
        b=tSc8MtHe8ukEo/YOVv+IcmfQDddWC1HPMDzwR3I8GZoSytiCJCOpjg5mOR9HyXQUDH
         fIGmRIsl23lAqUBvtGPvvZFxksgSjeGjFA0x4Az7u/lVGVLJ5EM6xpZvlviRLKv+qf/t
         O5/ciukIpQwqeNOEWPpKP7Briiqr3ag4ydkBG99OP9IdOLbhNwXJYz2jgDX/Q6Ijll/K
         ruqvoN/LDe/LqMhYtaeWayYbqV7Jw7pPRv4bXpGGHikTt7Lde3F9gHNTBLwYnwvlDIRy
         W1VwEpi1oOCeYN2qTvzRQX9axtbshedjNCbV9eDL741D9/yllOo4Zcao9PPXkA/yvrgV
         7tgA==
X-Gm-Message-State: AOAM533RyKImC48FDgD1HpnvcUFMQHszCLBH7bmQITcKfcIaPsUmFs+t
        FPkWNNGfWQilVmvhDPxadA==
X-Google-Smtp-Source: ABdhPJxsgMlbapRvQL6kbwNdmqeoS3ATi3VifOxmbtRfh2u4yxlMDxYRuBI3wpfEHIRgQ6BxT3goSw==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr15109002wmk.149.1595102631460;
        Sat, 18 Jul 2020 13:03:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id l15sm21073826wro.33.2020.07.18.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:03:51 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm: rockchip: add missing registers for RK3188
Date:   Sat, 18 Jul 2020 22:03:20 +0200
Message-Id: <20200718200323.3559-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718200323.3559-1-knaerzche@gmail.com>
References: <20200718200323.3559-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dither_up, dsp_lut_en, data_blank and dsp_data_swap
registers to enable their respective functionality for RK3188's VOP.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b046910129fb..971a6bda7458 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -512,6 +512,10 @@ static const struct vop_common rk3188_common = {
 	.dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
 	.dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
 	.dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
+	.dither_up = VOP_REG(RK3188_DSP_CTRL0, 0x1, 9),
+	.dsp_lut_en = VOP_REG(RK3188_SYS_CTRL, 0x1, 28),
+	.data_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 25),
+	.dsp_data_swap = VOP_REG(RK3188_DSP_CTRL1, 0x1f, 26),
 };
 
 static const struct vop_win_data rk3188_vop_win_data[] = {
-- 
2.17.1

