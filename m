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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D2C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E39A20717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZspbZnDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGRUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGRUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:04:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40BC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:04:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so4011043wrh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0T7Z0qYf9WUlRISQUZHhs4GcxCldWcEZuU3vNtYbek=;
        b=ZspbZnDizms9ElKXoiKKK5esxckOlsZE3C41L5ngf9htqd6fgAKb36noxHKmg5tB/c
         kElI64UCe6YUXG0tdG/YrPWsVnxJZM4MoUvHu3zrhT+Qz+F6vSjb/EKF75MB8scSIKIf
         fEYsgXPE+T3pT4lyd7+25nq7r480mVXS+BHKVr6WXzFvVp6menCcMvodBcD5KFZNnFTv
         /uk3MdlEphS1RlOixET0xsjPWbkL+Gs+RXNqDJYGdn+i/Ysn2mhN35H9MdlNjmpj+9jB
         QVU4HNok4nRFt+hqmotpFZqeah+WuOpfQnqxbvWRUMSlOgCTN3RrEnl6pTaqFoxEGLlj
         VMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0T7Z0qYf9WUlRISQUZHhs4GcxCldWcEZuU3vNtYbek=;
        b=IHRjc4nvMD9joCSfTXm3MGSYbB73LlJI8DxhV/pC1OVoSAf+SFZOnW7vhSRmqTlRYR
         hVHwP4TktY+W/JWsU0a9SUDibg0QglQ7ocOZU4Q3NotmVDmobKVTSnLvHGclQHSw3d4x
         rlHNvdHEK9gNOFt0ict585Hw7wdjl4Q1k9IlIhkTgduezDoEZEh8wAe0/T0H4w2gKYGU
         ec631m0PEmWf0cFg7GtFPK8P1DvPYe+IbDUUKAfF8HWtG01crwYyeTi7xLB6/YT2ViZF
         VNhx5XcbyZY72Yys4UsEtz6THdVMOFjAMGAnHUgcf18NroVWwxPe6FaCodCyInKfuf5I
         VFNA==
X-Gm-Message-State: AOAM530OPMz8QDXoGN3Qsqk6jsSHFm5yetGcikMESR3FHuKgGvqQul7L
        pqGk40ZvnbEYo34l4mYC1w==
X-Google-Smtp-Source: ABdhPJwTTkdbteurLJf8bTe6KQBo79DMHcPS1mzHuaTUrXsKp7gfNu8uVCge2iQB7FqFmqAViyAykw==
X-Received: by 2002:adf:8091:: with SMTP id 17mr15006619wrl.13.1595102639229;
        Sat, 18 Jul 2020 13:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id l15sm21073826wro.33.2020.07.18.13.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 13:03:58 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner=20?= <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm: rockchip: set alpha_en to 0 if it is not used
Date:   Sat, 18 Jul 2020 22:03:22 +0200
Message-Id: <20200718200323.3559-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200718200323.3559-1-knaerzche@gmail.com>
References: <20200718200323.3559-1-knaerzche@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alpha_en should be set to 0 if it is not used, i.e. to disable alpha
blending if it was enabled before and should be disabled now.

fixes: 2aae8ed1f390 ("drm/rockchip: Add per-pixel alpha support for the PX30 VOP")

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index c80f7d9fd13f..0f23144491e4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1013,6 +1013,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 		VOP_WIN_SET(vop, win, alpha_en, 1);
 	} else {
 		VOP_WIN_SET(vop, win, src_alpha_ctl, SRC_ALPHA_EN(0));
+		VOP_WIN_SET(vop, win, alpha_en, 0);
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
-- 
2.17.1

