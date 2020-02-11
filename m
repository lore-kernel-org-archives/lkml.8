Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2691DC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E4120714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5Hu8ndv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgBKNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:50:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727916AbgBKNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581429057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=S+mwJdJVy8UUeEbXPovOpoMig4tdZvTNhvh0a+GkyOI=;
        b=e5Hu8ndvdrhGe8NLgTqwnF80H//ZdHXHvfX+jefvg/aJuqGZOfCa5sXRrmamja33cUo+kN
        Yqs9XfUqOxLAGopVWrQLY/mYwKb4eNX19zxmKgMjyHb0Bw/PGNmr07HgDJ7PkFfUlNV3s4
        EovTnal0483ehK5qTqRjWH+vTDz+Iu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-u1_3pVzhMP65uv71nLedkg-1; Tue, 11 Feb 2020 08:50:53 -0500
X-MC-Unique: u1_3pVzhMP65uv71nLedkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E7418CA241;
        Tue, 11 Feb 2020 13:50:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C11EE5C1D6;
        Tue, 11 Feb 2020 13:50:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0856717448; Tue, 11 Feb 2020 14:50:48 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/virtio: fix virtio_gpu_execbuffer_ioctl locking
Date:   Tue, 11 Feb 2020 14:50:46 +0100
Message-Id: <20200211135047.22261-2-kraxel@redhat.com>
In-Reply-To: <20200211135047.22261-1-kraxel@redhat.com>
References: <20200211135047.22261-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep says we can't call vmemdup() while having objects reserved
because it needs the mmap semaphore.  So reorder the calls reserve
the objects later.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 205ec4abae2b..0477d1250f2d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -126,22 +126,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		bo_handles = NULL;
 	}
 
-	if (buflist) {
-		ret = virtio_gpu_array_lock_resv(buflist);
-		if (ret)
-			goto out_unused_fd;
-	}
-
 	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
-		goto out_unresv;
+		goto out_unused_fd;
+	}
+
+	if (buflist) {
+		ret = virtio_gpu_array_lock_resv(buflist);
+		if (ret)
+			goto out_memdup;
 	}
 
 	out_fence = virtio_gpu_fence_alloc(vgdev);
 	if(!out_fence) {
 		ret = -ENOMEM;
-		goto out_memdup;
+		goto out_unresv;
 	}
 
 	if (out_fence_fd >= 0) {
@@ -160,11 +160,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 			      vfpriv->ctx_id, buflist, out_fence);
 	return 0;
 
-out_memdup:
-	kvfree(buf);
 out_unresv:
 	if (buflist)
 		virtio_gpu_array_unlock_resv(buflist);
+out_memdup:
+	kvfree(buf);
 out_unused_fd:
 	kvfree(bo_handles);
 	if (buflist)
-- 
2.18.2

