Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A110AC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E69E20674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwX7utvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgBELAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:00:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgBELAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580900405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bqgElwRefjJ3EiFm371iu05T9EzEgrtJ/QBv+TdYAbM=;
        b=GwX7utvQnD1PiSu4n0v9dk/2O+MCHZhkKORgB+2rQLk1/8exCz1C+Wu0x7gilzsBuaVnIO
        Hiq/Y8WTeHaCYXMNqvQW9dfH0stum9lAVV5aJKT9OM9YAqalfNWgS2zZOsvPPz6gM6/N79
        P1uBPLx4aFXLt2dW6bd9jNtJoNhGDKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-UX-nIhLWO6OpXEtZYbzKDA-1; Wed, 05 Feb 2020 06:00:00 -0500
X-MC-Unique: UX-nIhLWO6OpXEtZYbzKDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45CD2DB61;
        Wed,  5 Feb 2020 10:59:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 431495D9E2;
        Wed,  5 Feb 2020 10:59:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8FDDE9C75; Wed,  5 Feb 2020 11:59:55 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, olvaffe@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/virtio: resource teardown tweaks
Date:   Wed,  5 Feb 2020 11:59:53 +0100
Message-Id: <20200205105955.28143-3-kraxel@redhat.com>
In-Reply-To: <20200205105955.28143-1-kraxel@redhat.com>
References: <20200205105955.28143-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new virtio_gpu_cleanup_object() helper function for object cleanup.
Wire up callback function for resource unref, do cleanup from callback
when we know the host stopped using the resource.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  3 ++-
 drivers/gpu/drm/virtio/virtgpu_object.c | 19 ++++++++++----
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 35 ++++++++++++++++++++++---
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7e69c06e168e..372dd248cf02 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -262,7 +262,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object_array *objs,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   uint32_t resource_id);
+				   struct virtio_gpu_object *bo);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					uint32_t width, uint32_t height,
@@ -355,6 +355,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 last_seq);
 
 /* virtio_gpu_object */
+void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo);
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 						size_t size);
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 017a9e0fc3bb..28a161af7503 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -61,6 +61,14 @@ static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t
 	}
 }
 
+void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
+{
+	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+
+	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
+	drm_gem_shmem_free_object(&bo->base.base);
+}
+
 static void virtio_gpu_free_object(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
@@ -68,11 +76,12 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
 
 	if (bo->pages)
 		virtio_gpu_object_detach(vgdev, bo);
-	if (bo->created)
-		virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
-	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
-
-	drm_gem_shmem_free_object(obj);
+	if (bo->created) {
+		virtio_gpu_cmd_unref_resource(vgdev, bo);
+		/* completion handler calls virtio_gpu_cleanup_object() */
+		return;
+	}
+	virtio_gpu_cleanup_object(bo);
 }
 
 static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6d6d55dc384e..6e8097e4c214 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -152,6 +152,15 @@ static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
 					 sizeof(struct virtio_gpu_ctrl_hdr), NULL);
 }
 
+static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
+				     struct virtio_gpu_vbuffer **vbuffer_p,
+				     int size,
+				     virtio_gpu_resp_cb cb)
+{
+	return virtio_gpu_alloc_cmd_resp(vgdev, cb, vbuffer_p, size,
+					 sizeof(struct virtio_gpu_ctrl_hdr), NULL);
+}
+
 static void free_vbuf(struct virtio_gpu_device *vgdev,
 		      struct virtio_gpu_vbuffer *vbuf)
 {
@@ -494,17 +503,37 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 	bo->created = true;
 }
 
+static void virtio_gpu_cmd_unref_cb(struct virtio_gpu_device *vgdev,
+				    struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_object *bo;
+
+	bo = gem_to_virtio_gpu_obj(vbuf->objs->objs[0]);
+	kfree(vbuf->objs);
+	vbuf->objs = NULL;
+
+	virtio_gpu_cleanup_object(bo);
+}
+
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
-				   uint32_t resource_id)
+				   struct virtio_gpu_object *bo)
 {
 	struct virtio_gpu_resource_unref *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
 
-	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
+	cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
+					virtio_gpu_cmd_unref_cb);
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNREF);
-	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
+
+	/*
+	 * We are in the release callback and do NOT want refcount
+	 * bo, so do NOT use virtio_gpu_array_add_obj().
+	 */
+	vbuf->objs = virtio_gpu_array_alloc(1);
+	vbuf->objs->objs[0] = &bo->base.base;
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
-- 
2.18.1

