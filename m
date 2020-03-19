Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79179C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CF22071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCSKEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:04:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgCSKEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:04:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 391C8ACD6;
        Thu, 19 Mar 2020 10:04:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     kraxel@redhat.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Gurchetan Singh <gurchetansingh@chromium.org>
Subject: [PATCH] drm/virtio: fix OOB in virtio_gpu_object_create
Date:   Thu, 19 Mar 2020 11:04:21 +0100
Message-Id: <20200319100421.16267-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f651c8b05542, virtio_gpu_create_object allocates too small
space to fit everything in. It is because it allocates struct
virtio_gpu_object, but should allocate a newly added struct
virtio_gpu_object_shmem which has 2 more members.

So fix that by using correct type in virtio_gpu_create_object.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 2bfb13d1932e..d9039bb7c5e3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -123,15 +123,17 @@ bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo)
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 						size_t size)
 {
-	struct virtio_gpu_object *bo;
+	struct virtio_gpu_object_shmem *shmem;
+	struct drm_gem_shmem_object *dshmem;
 
-	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
-	if (!bo)
+	shmem = kzalloc(sizeof(*shmem), GFP_KERNEL);
+	if (!shmem)
 		return NULL;
 
-	bo->base.base.funcs = &virtio_gpu_shmem_funcs;
-	bo->base.map_cached = true;
-	return &bo->base.base;
+	dshmem = &shmem->base.base;
+	dshmem->base.funcs = &virtio_gpu_shmem_funcs;
+	dshmem->map_cached = true;
+	return &dshmem->base;
 }
 
 static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
-- 
2.25.1

