Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC595C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FA207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bt+3y6TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbgFXXVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:21:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388257AbgFXXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593040890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wi1znm31qzcMq6s+LEuReOxrOa/3crQuccyoaVP19ws=;
        b=Bt+3y6TGnWEG7LihD7DH18AHIQxf1UtBqv6yB663Nx5fN6GUq2OVEWmE+IH2ujbzq6eX8E
        FdgbdZRM8KM/IFOqLz2jXQsD6yzHnP/G2QwSya/AkCHp4BHBYFYWAJ9qEvpW1my7Y6ombn
        Q8fRxVv/Z/lW3/GE7K9xeHtmw0v9f9I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-I8LahbkNNEKNKpZVGaPNFA-1; Wed, 24 Jun 2020 19:21:28 -0400
X-MC-Unique: I8LahbkNNEKNKpZVGaPNFA-1
Received: by mail-wr1-f72.google.com with SMTP id z3so4776419wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wi1znm31qzcMq6s+LEuReOxrOa/3crQuccyoaVP19ws=;
        b=fxnCN8zu7o/poI0E3j1oIlwd7sezNmfL8RAk2rH8ehRwA85AcZP84jcSU8bl1g2ktc
         27wLMQXZEJgDVrD4Y0nsZM4e7DJXIQk/2Qu+4g5KVcR3YJBA7/vOT2rdFcd2K22Z9uZ5
         hZ9gN309X14aUnTwvbkYnHHlHIZAX/F068Plprm/bJqmCSey554RZ7NDMRHWKgURKUtp
         krt3CTVALh8NBXda4a9LGLxin2c2ngluDhC/BnptC/5dsJcWJmzNVEHQgUFX1jhRHa7R
         4uFxbvZGLIChpULotljSDu175dWtRBKzUaeQx4SW+30Rx5C5cyWDPjogC1Nr/Q0qDnBJ
         /1vg==
X-Gm-Message-State: AOAM532JdyPS7IPHtn+ZFbOpYHEcZy3SVeuLfpGLHA2AotXaG9ptiLy/
        E3RvQl2ei+vgpqQq04N5eUp0EJU6oC4CfXILZyPqWwqOk89MZp71i9ZGwJ3SoPxLA/0Vcqs0iI/
        LfrH3Q+TNjRS1Lwy3NWaFAGC0
X-Received: by 2002:adf:d1a9:: with SMTP id w9mr30827309wrc.344.1593040887203;
        Wed, 24 Jun 2020 16:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5ir4N9wbti9tYY2l2bny6BHZhcJVYIhD0t4MJ3ccxojugpKeIyFBm3DZYFEVnjAyCrm+GsQ==
X-Received: by 2002:adf:d1a9:: with SMTP id w9mr30827294wrc.344.1593040886954;
        Wed, 24 Jun 2020 16:21:26 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id e4sm2757194wrt.97.2020.06.24.16.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:21:26 -0700 (PDT)
Date:   Wed, 24 Jun 2020 19:21:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/2] virtio: virtio_has_iommu_quirk -> virtio_has_dma_quirk
Message-ID: <20200624232035.704217-3-mst@redhat.com>
References: <20200624232035.704217-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624232035.704217-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the corresponding feature bit has been renamed,
rename the quirk too - it's about special ways to
do DMA, not necessarily about the IOMMU.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c     | 4 ++--
 drivers/virtio/virtio_ring.c            | 2 +-
 include/linux/virtio_config.h           | 4 ++--
 tools/virtio/linux/virtio_config.h      | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6ccbd01cd888..e8799ab0c753 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -141,7 +141,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 					struct virtio_gpu_mem_entry **ents,
 					unsigned int *nents)
 {
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
+	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 	struct scatterlist *sg;
 	int si, ret;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9e663a5d9952..53af60d484a4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -599,7 +599,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_transfer_to_host_2d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
+	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
@@ -1015,7 +1015,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
-	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
+	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
 	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
 
 	if (use_dma_api)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a1a5c2a91426..34253cb69cb8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -240,7 +240,7 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
-	if (!virtio_has_iommu_quirk(vdev))
+	if (!virtio_has_dma_quirk(vdev))
 		return true;
 
 	/* Otherwise, we are left to guess. */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index f2cc2a0df174..3b4eae5ac5e3 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -162,10 +162,10 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 }
 
 /**
- * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
+ * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
  */
-static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
+static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 {
 	/*
 	 * Note the reverse polarity of the quirk feature (compared to most
diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index f99ae42668e0..f2640e505c4e 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -42,10 +42,10 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
 	(__virtio_test_bit((dev), feature))
 
 /**
- * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
+ * virtio_has_dma_quirk - determine whether this device has the DMA quirk
  * @vdev: the device
  */
-static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
+static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 {
 	/*
 	 * Note the reverse polarity of the quirk feature (compared to most
-- 
MST

