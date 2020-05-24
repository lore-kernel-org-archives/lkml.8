Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FAE20735
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekXSkH+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgEXC0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388255AbgEXC0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 22:26:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A0C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:26:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k22so6010202pls.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q62HbLQF29AE0RBjNDiL0u701W1ygVc3UIAH2JHM1pI=;
        b=ekXSkH+e6TgJipaJVgrSFArO090SmCB6+zGXQQWZZTJu2Tu942uLeXi4qtkeROIdag
         Z4RswYGWFDXtAiNzA6eKzqLNKQfhJDPTCF3MrbcEPI0psPUdkwZ6byXw0gSBtDrVyO2r
         S1vtFTieT+sp1xAOk7miE3NB0cu9D7O5nR/stUmCoZdMiqnFSiHpbfA4tbsYLLk5uo6f
         9FIPBj6InOxBKVI78hq22WLcR0KnXykQtPpflGWvqCG5/MDNvBJbz+zcbB5tlVdBD35J
         5tDAM1RbB4cPPSdTgqLWnx/JrbllMhko7PgJh3bX9gbGSSvFNZWZgwFNgj3D5gkSuObq
         zAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q62HbLQF29AE0RBjNDiL0u701W1ygVc3UIAH2JHM1pI=;
        b=GiyDMZm4Hml8jJRzZAK5d7yeUxqHxrZ1p1584g+fOs+OY+e7Aq/qh/8z28yqbSZWPC
         c3ITX7KVTkW6exGRJXU0V30F6RWHltSq+THsPRCM3ULRZ6CAHiNIUqc23tJoZHZJnwBk
         5t6okhmQlQ9Yk5FmN3O2nR0oUti9PBnWUD8DG79jmlAVO4KOrbwhhvGKe+ER07ufJGil
         Xz+D9w/vnF+f7wwqzh4Grc8keK+b1YvQ1jMzmE/sT7hjviW/sBZ3UKT0IiHiz9U8vdMt
         ubsIX5U9PhiuqtifmynARWvUqsqhPitbFUoQY43QuHd524KeJduUPeaXgtGD7cRKNRkS
         PRJQ==
X-Gm-Message-State: AOAM533cQI207yVkZxN58FtK6OdfzRofKvCYOkk+Vycxtic/h19WOcoK
        Il/hD4Q4TenK97juo1yHLqU=
X-Google-Smtp-Source: ABdhPJxxVJURz9EbY7Cysd58vv2JDmpJaC7CJ6LeSeuDVcDHjylSZOTmsjVC4/updmz2VDgc38cF4A==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr12805713pja.163.1590287197890;
        Sat, 23 May 2020 19:26:37 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id r69sm10206598pfc.209.2020.05.23.19.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 19:26:37 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: Replace deprecated function in qxl_display
Date:   Sun, 24 May 2020 11:26:23 +0900
Message-Id: <20200524022624.10363-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave.

This is resended e-mail for your advice.

I'm a newbie interested in linux kernel and qxl module.
Please check this patch and give me advice for me.
Also I'll be glad if there is any task that you bothered.
Thanks.

Sidong.

Replace deprecated function drm_modeset_lock/unlock_all with
helper function DRM_MODESET_LOCK_ALL_BEGIN/END.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1082cd5d2fd4..07e164cee868 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -162,7 +162,8 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 {
 	struct drm_device *dev = &qdev->ddev;
-	int status, retries;
+	struct drm_modeset_acquire_ctx ctx;
+	int status, retries, ret;
 
 	for (retries = 0; retries < 10; retries++) {
 		status = qxl_display_copy_rom_client_monitors_config(qdev);
@@ -183,9 +184,9 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 		return;
 	}
 
-	drm_modeset_lock_all(dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 	qxl_update_offset_props(qdev);
-	drm_modeset_unlock_all(dev);
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 	if (!drm_helper_hpd_irq_event(dev)) {
 		/* notify that the monitor configuration changed, to
 		   adjust at the arbitrary resolution */
@@ -403,18 +404,17 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	struct qxl_device *qdev = to_qxl(fb->dev);
 	struct drm_clip_rect norect;
 	struct qxl_bo *qobj;
+	struct drm_modeset_acquire_ctx ctx;
 	bool is_primary;
-	int inc = 1;
+	int inc = 1, ret;
 
-	drm_modeset_lock_all(fb->dev);
+	DRM_MODESET_LOCK_ALL_BEGIN(fb->dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 
 	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
 	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
-	if (!is_primary) {
-		drm_modeset_unlock_all(fb->dev);
-		return 0;
-	}
+	if (!is_primary)
+		goto out_lock_end;
 
 	if (!num_clips) {
 		num_clips = 1;
@@ -430,7 +430,8 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
 			  clips, num_clips, inc, 0);
 
-	drm_modeset_unlock_all(fb->dev);
+out_lock_end:
+	DRM_MODESET_LOCK_ALL_END(ctx, ret);
 
 	return 0;
 }
-- 
2.17.1

