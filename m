Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38081C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAFB22C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icVDBPfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHGK7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:59:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726159AbgHGKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596797681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=SebiSFSvaUNdq26nIA+KqtCZ23a0eXZDimZTww2A8Sg=;
        b=icVDBPfFAvVjpV74uWIirjyLnWicOM0ZOB8DnfrFDWgGECdYlpO2j+XbewZAbDQ4waonX8
        LOSLT1WeNHRQGxcAxi7copxuRE8WHZXKlZRY18I59PHC8lF2PSzS2tqh6PQHF6QkCyBQ5x
        jF14oz96ea7HN4n1qh97TdeHJRcP0e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-UU5rZ_o5N1-B9dA0K-2Xzw-1; Fri, 07 Aug 2020 06:54:37 -0400
X-MC-Unique: UU5rZ_o5N1-B9dA0K-2Xzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A2998005B0;
        Fri,  7 Aug 2020 10:54:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2F661176;
        Fri,  7 Aug 2020 10:54:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5A1689CBC; Fri,  7 Aug 2020 12:54:29 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, 1882851@bugs.launchpad.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: fix unblank
Date:   Fri,  7 Aug 2020 12:54:29 +0200
Message-Id: <20200807105429.24208-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When going through a disable/enable cycle without changing the
framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
skip set_scanout if framebuffer didn't change") causes the screen stay
blank.  Add a bool to force an update to fix that.

Cc: 1882851@bugs.launchpad.net
Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
 drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9ff9f4ac0522..7b0c319f23c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -138,6 +138,7 @@ struct virtio_gpu_output {
 	int cur_x;
 	int cur_y;
 	bool enabled;
+	bool need_update;
 };
 #define drm_crtc_to_virtio_gpu_output(x) \
 	container_of(x, struct virtio_gpu_output, crtc)
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index cc7fd957a307..378be5956b30 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
 
 	output->enabled = true;
+	output->need_update = true;
 }
 
 static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 52d24179bcec..5948031a9ce8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	    plane->state->src_w != old_state->src_w ||
 	    plane->state->src_h != old_state->src_h ||
 	    plane->state->src_x != old_state->src_x ||
-	    plane->state->src_y != old_state->src_y) {
+	    plane->state->src_y != old_state->src_y ||
+	    output->need_update) {
 		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
 			  bo->hw_res_handle,
 			  plane->state->crtc_w, plane->state->crtc_h,
@@ -178,6 +179,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 					   plane->state->src_h >> 16,
 					   plane->state->src_x >> 16,
 					   plane->state->src_y >> 16);
+		output->need_update = false;
 	}
 
 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
-- 
2.18.4

