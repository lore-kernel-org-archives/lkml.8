Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE121D79
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U21jwpDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgIHHHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:07:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728115AbgIHHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599548853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eYsGcUoiEvU+T2+5TumDUWl0H68AlLqE5jQUe9G2ZU=;
        b=U21jwpDiMCiu0lVVxJqZe62Gitl+FbQ7RKQY5tdxfeUDyNJv/KUrxkjhN+Ie1hZhMvbbQr
        fV6bMZi4iUMYwj8HhK+gnPrOxmtDt8jog059L9k2Pv+/KzCBAnUu5hWIXxmuoTZo2y/8LE
        aW5UQk5N8wBrb2NDvY1D3L6Jy9P3+XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-lWFDfZj7M-i8X0RP0S3-BA-1; Tue, 08 Sep 2020 03:07:29 -0400
X-MC-Unique: lWFDfZj7M-i8X0RP0S3-BA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D0DF1007466;
        Tue,  8 Sep 2020 07:07:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9973360C17;
        Tue,  8 Sep 2020 07:07:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D5EF51FCF5; Tue,  8 Sep 2020 09:07:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/virtio: add virtio_gpu_cmd_unref_resource error handling
Date:   Tue,  8 Sep 2020 09:07:23 +0200
Message-Id: <20200908070723.6394-4-kraxel@redhat.com>
In-Reply-To: <20200908070723.6394-1-kraxel@redhat.com>
References: <20200908070723.6394-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually we wait for the host to complete the unref request, then cleanup
the guest-side state of the object in the completion callback.  When
submitting the unref command failed the completion callback will not be
called though, so cleanup right away.

Fixes a WARN on stale mm entries on driver shutdown.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b1884e6e242c..4d2325bf4aed 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -536,6 +536,7 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_resource_unref *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
+	int ret;
 
 	cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
 					virtio_gpu_cmd_unref_cb);
@@ -545,7 +546,9 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 
 	vbuf->resp_cb_data = bo;
-	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	ret = virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
+	if (ret < 0)
+		virtio_gpu_cleanup_object(bo);
 }
 
 void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
-- 
2.27.0

