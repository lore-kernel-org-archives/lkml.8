Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5310EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2293D2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcTL7q1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHYV5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:57:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:57:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k20so170846qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWRVhAyQrMMbNCybKNpaTOkjxzgRbbU/WkM3Dt9pX54=;
        b=fcTL7q1gFc3oZ0ZWW6ITOvGLzyP26ghrzc9ma1/q3Derm5NBJOZwguT0X4p6uheACV
         uVVIQzNvB8KGcKFTpJo5tKZxLc9thz96kuXIo29pjk1ZNZkKNl8b8OfOHJLtaPiNbaUY
         7CwCpaIoA0O0CwL1VzmdXnKZkYd4ZWLbRYzhHWtimbk6krXb9E7L67tPAZJ6qtyR+9S+
         BfQFfmygj1UK6xTAM9En3S4vNuGyIq4S4Fcj1wFuh9bg7Vdv0yV7SVLXjWyeB4IjLzJ3
         8mOwUBdLrzcuoMvfNvOV9W3M1KnLAw7XMREVAjiwctxj0JRLrt4P42VToIqM9nSEUquW
         Pvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWRVhAyQrMMbNCybKNpaTOkjxzgRbbU/WkM3Dt9pX54=;
        b=Pg6W8K/JURin4khhNPiKnCMU9YjipRvjgDurbNY/Xlqt+1/A2eGU6GENJRQq7R/0eG
         xkdYvZYREnsCkjYe/xkmbGP5iqOaXfcxFMVJ1CNSLvHM7v2vuY/2ETc0mUuWGnUUD1UE
         nwWsVcEX8+SDom0NQDJdxNQaNYj67PF5pIrrBgBWQfJZRaWutnLCJMKxw3i8wvH9OaC1
         YJjVboykEHGFXw2JnsFHtGhHGWDt1YWvtEJOJWkpFmMOWsrsLdmXU60Sh4swW6alHsGC
         I1KJdqQNkqqmK/sw6TiGe+TyD0n1w1AowHmJ07+Im0IiIBqkEb/7OToagD3CX1kyS0m5
         qAWA==
X-Gm-Message-State: AOAM533hz8AFsm3o/7baPnZQ4g8AzUQHZC8a74EnTOvbhDLrzFHZAcmj
        Sz8RFq1fzztl6QXCajFpa20=
X-Google-Smtp-Source: ABdhPJwkJ91ZZA7Cq3/WkBuZ3vsYC6CZvy1AW1h0c+XAfq+Qj5c/LtYCXS036Taqiw9hcTxMPh+/Ew==
X-Received: by 2002:aed:3824:: with SMTP id j33mr3131055qte.374.1598392662216;
        Tue, 25 Aug 2020 14:57:42 -0700 (PDT)
Received: from localhost.localdomain ([189.7.69.189])
        by smtp.gmail.com with ESMTPSA id w28sm128308qkw.87.2020.08.25.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:57:41 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        1882851@bugs.launchpad.net, Jiri Slaby <jirislaby@kernel.org>,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] drm/virtio: fix unblank
Date:   Tue, 25 Aug 2020 18:56:46 -0300
Message-Id: <20200825215646.66853-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818072511.6745-1-kraxel@redhat.com>
References: <20200818072511.6745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Hoffmann <kraxel@redhat.com>

When going through a disable/enable cycle without changing the
framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
skip set_scanout if framebuffer didn't change") causes the screen stay
blank.  Add a bool to force an update to fix that.

v2: use drm_atomic_crtc_needs_modeset() (Daniel).

Cc: 1882851@bugs.launchpad.net
Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c   |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index af55b334be2f..35b5c80f5d85 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -123,6 +123,17 @@ static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
 static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
 					 struct drm_crtc_state *old_state)
 {
+	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
+
+	/*
+	 * virtio-gpu can't do modeset and plane update operations
+	 * independant from each other.  So the actual modeset happens
+	 * in the plane update callback, and here we just check
+	 * whenever we must force the modeset.
+	 */
+	if (drm_atomic_crtc_needs_modeset(crtc->state)) {
+		output->needs_modeset = true;
+	}
 }
 
 static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9ff9f4ac0522..4ab1b0ba2925 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -138,6 +138,7 @@ struct virtio_gpu_output {
 	int cur_x;
 	int cur_y;
 	bool enabled;
+	bool needs_modeset;
 };
 #define drm_crtc_to_virtio_gpu_output(x) \
 	container_of(x, struct virtio_gpu_output, crtc)
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 52d24179bcec..65757409d9ed 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -163,7 +163,9 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	    plane->state->src_w != old_state->src_w ||
 	    plane->state->src_h != old_state->src_h ||
 	    plane->state->src_x != old_state->src_x ||
-	    plane->state->src_y != old_state->src_y) {
+	    plane->state->src_y != old_state->src_y ||
+	    output->needs_modeset) {
+		output->needs_modeset = false;
 		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
 			  bo->hw_res_handle,
 			  plane->state->crtc_w, plane->state->crtc_h,
-- 
2.28.0

