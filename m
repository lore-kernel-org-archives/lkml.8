Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A264C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C412192A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNJ121F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgIHHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:07:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729169AbgIHHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599548853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/1j3RxNux/Jqkw1iBdsdegsHl40YIj7+vylXlys3FY=;
        b=UNJ121F9YPsi7vES8P39m3DKsc1RTyRmfwo6aSHXdhMomHsijt+LKNVcHKr/222+lm2wKV
        amW7eSK8N+RzxqvuwYcHklBMiIi5jcmCTlBYkzkTLXfJsQ/hI5TXN3Zl4i5sRzKnruV8nc
        JJhMsp76KcLKjNbC6fl1RKbcoSOwczY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-SB-rcyB7PtSmJxmCL1E-bA-1; Tue, 08 Sep 2020 03:07:29 -0400
X-MC-Unique: SB-rcyB7PtSmJxmCL1E-bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D03180EDA1;
        Tue,  8 Sep 2020 07:07:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7014360C15;
        Tue,  8 Sep 2020 07:07:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B6A021FCEE; Tue,  8 Sep 2020 09:07:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/virtio: return virtio_gpu_queue errors
Date:   Tue,  8 Sep 2020 09:07:22 +0200
Message-Id: <20200908070723.6394-3-kraxel@redhat.com>
In-Reply-To: <20200908070723.6394-1-kraxel@redhat.com>
References: <20200908070723.6394-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case queuing virtio commands fails (can happen when
the device got unplugged) pass up the error.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 36 +++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c93c2db35aaf..b1884e6e242c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -320,13 +320,13 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
 	return sgt;
 }
 
-static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
-				      struct virtio_gpu_vbuffer *vbuf,
-				      struct virtio_gpu_fence *fence,
-				      int elemcnt,
-				      struct scatterlist **sgs,
-				      int outcnt,
-				      int incnt)
+static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
+				     struct virtio_gpu_vbuffer *vbuf,
+				     struct virtio_gpu_fence *fence,
+				     int elemcnt,
+				     struct scatterlist **sgs,
+				     int outcnt,
+				     int incnt)
 {
 	struct virtqueue *vq = vgdev->ctrlq.vq;
 	int ret, idx;
@@ -335,7 +335,7 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		if (fence && vbuf->objs)
 			virtio_gpu_array_unlock_resv(vbuf->objs);
 		free_vbuf(vgdev, vbuf);
-		return;
+		return -1;
 	}
 
 	if (vgdev->has_indirect)
@@ -373,15 +373,16 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	spin_unlock(&vgdev->ctrlq.qlock);
 
 	drm_dev_exit(idx);
+	return 0;
 }
 
-static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
-						struct virtio_gpu_vbuffer *vbuf,
-						struct virtio_gpu_fence *fence)
+static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					       struct virtio_gpu_vbuffer *vbuf,
+					       struct virtio_gpu_fence *fence)
 {
 	struct scatterlist *sgs[3], vcmd, vout, vresp;
 	struct sg_table *sgt = NULL;
-	int elemcnt = 0, outcnt = 0, incnt = 0;
+	int elemcnt = 0, outcnt = 0, incnt = 0, ret;
 
 	/* set up vcmd */
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
@@ -398,7 +399,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
-				return;
+				return -1;
 			}
 
 			elemcnt += sg_ents;
@@ -419,13 +420,14 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		incnt++;
 	}
 
-	virtio_gpu_queue_ctrl_sgs(vgdev, vbuf, fence, elemcnt, sgs, outcnt,
-				  incnt);
+	ret = virtio_gpu_queue_ctrl_sgs(vgdev, vbuf, fence, elemcnt, sgs, outcnt,
+					incnt);
 
 	if (sgt) {
 		sg_free_table(sgt);
 		kfree(sgt);
 	}
+	return ret;
 }
 
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev)
@@ -444,10 +446,10 @@ void virtio_gpu_notify(struct virtio_gpu_device *vgdev)
 		virtqueue_notify(vgdev->ctrlq.vq);
 }
 
-static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					 struct virtio_gpu_vbuffer *vbuf)
 {
-	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL);
+	return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL);
 }
 
 static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
-- 
2.27.0

