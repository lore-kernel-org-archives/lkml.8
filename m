Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695492075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2QSvo1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgHET2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbgHERL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6OJqxU8Sp5UYmolvKk955VfeDV9wjAzILoG6EGszAQ=;
        b=X2QSvo1knRCdrU+oVOHEcfYhlFGx6p/P4jjGjdNS2Kj5kaWnkV58U3TjUW8TcSB7B5k2Lq
        U8zkAYl+oPN3xCtgjwKkoRs2js6C6TgxNReqjgTeA0IIY1cBB5a6yCV3QZ8Y0vM6A2ULfU
        GOr/85HTNOkcTDHtGsYWIp53VL1NkBk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-5I6XDiUGNPy3F1r9jT2Dmg-1; Wed, 05 Aug 2020 09:44:52 -0400
X-MC-Unique: 5I6XDiUGNPy3F1r9jT2Dmg-1
Received: by mail-wr1-f70.google.com with SMTP id 89so13595366wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6OJqxU8Sp5UYmolvKk955VfeDV9wjAzILoG6EGszAQ=;
        b=Zbpp7UefLOICElj/8Lh9BjwLnNNetKE2QCN847X0Y/F1E+ppgaWxs1cWDp/f2k0his
         bHBn7rKliDfw0B5MC/hHHMOthtFbR6GvL1yl/vI3UzEOonxU602zFo27k5TaoEj+CEfD
         W35y2dMLzrjNQ4JRwmhfZZJ0HAwZZ8bOLQ4koHqMqAbWTyL9ATbYWfTMl+tpuB3j5Oix
         Hz4BsMdGsfzCRn6efkRxfeDIEaxjPBEgeC3EK7HxniCvL4UV25ykcaXcIW6QI3duOb+I
         bMq+3xch6z6sx4L8Vjyq2LHLhi7005Jag1jN217qyO94dy/BLRk216FCVyMdhfOvvkt2
         8cxA==
X-Gm-Message-State: AOAM530FxrAwW1R3x21Am26Te90Wz20tPz99AZZAoI8iAYB/UgsB7+NB
        wpQaJqC7HQyoDnHX5OGO8TcVBo2L4qvMdrBKDpHrpROWPrBxdVg05CdGybHwWdkRpLl5Q40fkSi
        eBlDS4OV40o3sdzYlYAHOhm1I
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr3637831wmj.128.1596635091102;
        Wed, 05 Aug 2020 06:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIP5APlUbJFDt9cc/+rC2+q+FdTyHsKg7qMGdbwa6FJ2pprZGU/KyCZL+3OX8oaPf4PHL5Hg==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr3637816wmj.128.1596635090938;
        Wed, 05 Aug 2020 06:44:50 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id x4sm3352368wru.81.2020.08.05.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:50 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 34/38] drm/virtio: convert to LE accessors
Message-ID: <20200805134226.1106164-35-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtgpu is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 0a5c8cf409fb..4d944a0dff3e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -39,8 +39,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 	u32 events_read, events_clear = 0;
 
 	/* read the config space */
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     events_read, &events_read);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			events_read, &events_read);
 	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
 		if (vgdev->has_edid)
 			virtio_gpu_cmd_get_edids(vgdev);
@@ -49,8 +49,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 		drm_helper_hpd_irq_event(vgdev->ddev);
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
-	virtio_cwrite(vgdev->vdev, struct virtio_gpu_config,
-		      events_clear, &events_clear);
+	virtio_cwrite_le(vgdev->vdev, struct virtio_gpu_config,
+			 events_clear, &events_clear);
 }
 
 static void virtio_gpu_init_vq(struct virtio_gpu_queue *vgvq,
@@ -165,8 +165,8 @@ int virtio_gpu_init(struct drm_device *dev)
 	}
 
 	/* get display info */
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     num_scanouts, &num_scanouts);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			num_scanouts, &num_scanouts);
 	vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
 				    VIRTIO_GPU_MAX_SCANOUTS);
 	if (!vgdev->num_scanouts) {
@@ -176,8 +176,8 @@ int virtio_gpu_init(struct drm_device *dev)
 	}
 	DRM_INFO("number of scanouts: %d\n", num_scanouts);
 
-	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
-		     num_capsets, &num_capsets);
+	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+			num_capsets, &num_capsets);
 	DRM_INFO("number of cap sets: %d\n", num_capsets);
 
 	virtio_gpu_modeset_init(vgdev);
-- 
MST

