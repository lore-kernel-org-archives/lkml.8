Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02CC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6B521741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P00VPpRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBGHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:46:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31203 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726136AbgBGHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581061606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BdkBv5/0TRWSpDs9BrTkTW1hCET7zpP+Fugca3yFB0g=;
        b=P00VPpREw7Zt+ggb1RlflT1WqkuXkTj1aNv5pil11NPSsJDxuAjYC15fGls0gp1CKv6o/V
        WwpI7aDe2vMYanl36M3v/rSjPAKhZ6UozmjY/7eurcIxr6YRPAiERRjLnScq5I8qjB2loz
        8bpr46xtuYGDV7XLmwRWSfv2xfx9p80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-HGFyYLufPUOtZP72T4XcvQ-1; Fri, 07 Feb 2020 02:46:44 -0500
X-MC-Unique: HGFyYLufPUOtZP72T4XcvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B1DB189F76D;
        Fri,  7 Feb 2020 07:46:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91CAF89F07;
        Fri,  7 Feb 2020 07:46:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E84AF31F5D; Fri,  7 Feb 2020 08:46:38 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, olvaffe@gmail.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] drm/virtio: move virtio_gpu_mem_entry initialization to new function
Date:   Fri,  7 Feb 2020 08:46:38 +0100
Message-Id: <20200207074638.26386-5-kraxel@redhat.com>
In-Reply-To: <20200207074638.26386-1-kraxel@redhat.com>
References: <20200207074638.26386-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new virtio_gpu_object_shmem_init() helper function which will
create the virtio_gpu_mem_entry array, containing the backing storage
information for the host.  For the most path this just moves code from
virtio_gpu_object_attach().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 +-
 drivers/gpu/drm/virtio/virtgpu_object.c | 55 ++++++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 51 ++---------------------
 3 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d37ddd7644f6..6c78c77a2afc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -71,6 +71,7 @@ struct virtio_gpu_object {
 
 	struct sg_table *pages;
 	uint32_t mapped;
+
 	bool dumb;
 	bool created;
 };
@@ -280,7 +281,8 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 				uint32_t x, uint32_t y);
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     struct virtio_gpu_fence *fence);
+			     struct virtio_gpu_mem_entry *ents,
+			     unsigned int nents);
 int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
 int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index bce2b3d843fe..8870ee23ff2b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -121,6 +121,51 @@ struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 	return &bo->base.base;
 }
 
+static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
+					struct virtio_gpu_object *bo,
+					struct virtio_gpu_mem_entry **ents,
+					unsigned int *nents)
+{
+	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
+	struct scatterlist *sg;
+	int si, ret;
+
+	ret = drm_gem_shmem_pin(&bo->base.base);
+	if (ret < 0)
+		return -EINVAL;
+
+	bo->pages = drm_gem_shmem_get_sg_table(&bo->base.base);
+	if (!bo->pages) {
+		drm_gem_shmem_unpin(&bo->base.base);
+		return -EINVAL;
+	}
+
+	if (use_dma_api) {
+		bo->mapped = dma_map_sg(vgdev->vdev->dev.parent,
+					bo->pages->sgl, bo->pages->nents,
+					DMA_TO_DEVICE);
+		*nents = bo->mapped;
+	} else {
+		*nents = bo->pages->nents;
+	}
+
+	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
+			      GFP_KERNEL);
+	if (!(*ents)) {
+		DRM_ERROR("failed to allocate ent list\n");
+		return -ENOMEM;
+	}
+
+	for_each_sg(bo->pages->sgl, sg, *nents, si) {
+		(*ents)[si].addr = cpu_to_le64(use_dma_api
+					       ? sg_dma_address(sg)
+					       : sg_phys(sg));
+		(*ents)[si].length = cpu_to_le32(sg->length);
+		(*ents)[si].padding = 0;
+	}
+	return 0;
+}
+
 int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object_params *params,
 			     struct virtio_gpu_object **bo_ptr,
@@ -129,6 +174,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object_array *objs = NULL;
 	struct drm_gem_shmem_object *shmem_obj;
 	struct virtio_gpu_object *bo;
+	struct virtio_gpu_mem_entry *ents;
+	unsigned int nents;
 	int ret;
 
 	*bo_ptr = NULL;
@@ -165,7 +212,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 					       objs, fence);
 	}
 
-	ret = virtio_gpu_object_attach(vgdev, bo, NULL);
+	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
+	if (ret != 0) {
+		virtio_gpu_free_object(&shmem_obj->base);
+		return ret;
+	}
+
+	ret = virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	if (ret != 0) {
 		virtio_gpu_free_object(&shmem_obj->base);
 		return ret;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 87c439156151..8360f7338209 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1086,56 +1086,11 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
 			     struct virtio_gpu_object *obj,
-			     struct virtio_gpu_fence *fence)
+			     struct virtio_gpu_mem_entry *ents,
+			     unsigned int nents)
 {
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
-	struct virtio_gpu_mem_entry *ents;
-	struct scatterlist *sg;
-	int si, nents, ret;
-
-	if (WARN_ON_ONCE(!obj->created))
-		return -EINVAL;
-	if (WARN_ON_ONCE(obj->pages))
-		return -EINVAL;
-
-	ret = drm_gem_shmem_pin(&obj->base.base);
-	if (ret < 0)
-		return -EINVAL;
-
-	obj->pages = drm_gem_shmem_get_sg_table(&obj->base.base);
-	if (obj->pages == NULL) {
-		drm_gem_shmem_unpin(&obj->base.base);
-		return -EINVAL;
-	}
-
-	if (use_dma_api) {
-		obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
-					 obj->pages->sgl, obj->pages->nents,
-					 DMA_TO_DEVICE);
-		nents = obj->mapped;
-	} else {
-		nents = obj->pages->nents;
-	}
-
-	/* gets freed when the ring has consumed it */
-	ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
-			     GFP_KERNEL);
-	if (!ents) {
-		DRM_ERROR("failed to allocate ent list\n");
-		return -ENOMEM;
-	}
-
-	for_each_sg(obj->pages->sgl, sg, nents, si) {
-		ents[si].addr = cpu_to_le64(use_dma_api
-					    ? sg_dma_address(sg)
-					    : sg_phys(sg));
-		ents[si].length = cpu_to_le32(sg->length);
-		ents[si].padding = 0;
-	}
-
 	virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
-					       ents, nents,
-					       fence);
+					       ents, nents, NULL);
 	return 0;
 }
 
-- 
2.18.1

