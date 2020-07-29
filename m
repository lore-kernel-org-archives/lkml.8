Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D59C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFAF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toFRN1Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgG2PWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:22:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:22:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so14414036pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F0+ed1oJcS1Y4n7YI4eB34N09Mdy/Fk5lreV7E+LSkA=;
        b=toFRN1OzgPcKqpPEh5n1U124L/PbACHYJfGidnXR1Uk/l6WFDBrS+x7/iqx4DM8IpP
         VGIeyIgXwSqimIBpkdcawCUcYfJ/tUtNI0jgZnB2/q5GWKkNcrfoK0JQMUHIfWaxAQeN
         dGujHGcpgt5nS6wtPR8amPzTuNp30MZMdRnEddu5IA9zYPdDdvdrN62/w7hlQCJ1z2Il
         ut6AYF2fNVq+i4B1MOa+gJ2Z4zySgtbLZRGgGcMY1nnW7essEdg0dFRX6eKmcNLVusOZ
         Ae2zJ2w/AhMGBzCFR2CpgFd4kk9buhQzHJolHCczURq8S0pQjcNXZG4HZs7aIvjB3upZ
         g0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F0+ed1oJcS1Y4n7YI4eB34N09Mdy/Fk5lreV7E+LSkA=;
        b=lwAYNwpKmLktpgelNl5ZzyzdAZwKsWONTTIgQenYm09yer6cqSKdT00YJcAbMLKCdO
         H/6BdJS+DLEC11Id3iOHJH2vJtxU9wW+e8s1wDJ7Wwt0XRlopBmbnlIxOt3yvOZ3F/Gu
         0X0O3AFeOPBJG7PIgv8osYAuqpxUo/J97HpA4XzQbowsd+q8S82Z7XBDcVkzg+81Alzy
         alHjhHJs9/L2nIbLmf+PzhXzyo5QfgjntGveZUmM+9S5XXR7Cug6zIw2Al109q9hC1eT
         sBtINUEtQQnwwD9kChKRZexODO2v2bCtGdNFBR6UH0YJ/ei4aWLkjC0GQXp/3s/oE/mp
         utcg==
X-Gm-Message-State: AOAM533nuGYK41yj/MrfndfDGp4NJjwCukktkXf0N01Q6mqg2Q3DCOJg
        7DHUlSzgCSvPvFpdw4iMYCs=
X-Google-Smtp-Source: ABdhPJyaMHwFbthy9/QrcY1w6412xzE25wYTcfRXrQy1w8hHm8w4vA5pMKgjffb1sB+e11l2mDSXIA==
X-Received: by 2002:a62:26c5:: with SMTP id m188mr370009pfm.23.1596036168675;
        Wed, 29 Jul 2020 08:22:48 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id b12sm2801172pga.87.2020.07.29.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:22:47 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel-usp@googlegroups.com
Subject: [PATCH] drm/vkms: modify sequence disable/plane/enable in commit_tail
Date:   Wed, 29 Jul 2020 15:22:31 +0000
Message-Id: <20200729152231.13249-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies function call sequence in commit tail. This is for
the problem that raised when kms_cursor_crc test is tested repeatedly.
In second test, there is an bug that crtc commit doesn't start vblank events.
Because there is some error about vblank's refcount. in commit_flush() that
called from commit_plane, drm_vblank_get() is called and vblank is enabled
in normal case. But in second test, vblank isn't enable for vblank->refcount
is already increased in previous test. Increased refcount will be decreased
in drm_atomic_helper_commit_modeset_enables() after commit_plane.
Therefore, commit_plane should be called after commit_modeset_enable.

In this situation, there is a warning raised in get_vblank_timestamp().
hrtimer.node.expires and vblank->time are zero for no vblank events before.
This patch returns current time when vblank is not enabled.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
 drivers/gpu/drm/vkms/vkms_drv.c  | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..09c012d54d58 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 
+	if (!READ_ONCE(vblank->enabled)) {
+		*vblank_time = ktime_get();
+		return true;
+	}
+
 	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 1e8b2169d834..c2c83a01d4a7 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -76,10 +76,10 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
-	drm_atomic_helper_commit_planes(dev, old_state, 0);
-
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
+	drm_atomic_helper_commit_planes(dev, old_state, 0);
+
 	drm_atomic_helper_fake_vblank(old_state);
 
 	drm_atomic_helper_commit_hw_done(old_state);
-- 
2.17.1

