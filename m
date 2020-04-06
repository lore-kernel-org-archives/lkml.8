Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873220787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccr+r56p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDFVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50148 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgDFVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nc8RbvVvgv2yKY1eEmP+1rlxyJ2zYItr7kU6PYQuma4=;
        b=ccr+r56psUHTTCBw0NKIabwAuGgJwopt3mHADrG6OZoXX5tfZr/7Pbru2ttB9p2WasIHsO
        9+wcdS8bxteGraHmp28Y0tTEmTCpOo+y5866NXKm3E5CsLoTsmXe/RjUgQDVY0E3CfdA3z
        g9mPvAqRJcGqElRmvAaH4LcyNc8klCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-keJkaC2GNKG0XKGkKMPYIw-1; Mon, 06 Apr 2020 17:02:16 -0400
X-MC-Unique: keJkaC2GNKG0XKGkKMPYIw-1
Received: by mail-wm1-f70.google.com with SMTP id u6so372756wmm.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nc8RbvVvgv2yKY1eEmP+1rlxyJ2zYItr7kU6PYQuma4=;
        b=aeGmjOMNhN7bIl4dHgr8rfY8zRwqe2h4rKAIi41mADl8QAyRFEmi6wFAxxCvyfAuf+
         uIGdHUabG5NkWamtFXzBSMpqFHjTesEcL7ypesmgGrr9L6b1Rpq1x9GBo8xL0uNVdrlO
         yK4Q86ylB3JD1aS0OeqMOMdzQKAgGzUEXkbGOKZBxOK1/jF2ThpO6uu9HZa7ljBbQjOr
         XVJ6zNvk+kOVHoACmcOIgMYq4Rk82lqKjxXlJMN5FUIHbs1Mcn0OLl2Fv/8+HtG4sEqa
         BknlQBLioGg2z80FaiKsQ25lrIkmsD/juSRaj1Hw5oUSfuyck9kbjmzn7fpFqWDNJmZI
         5aEQ==
X-Gm-Message-State: AGi0PuZvCh23miQqCgoLvUdtvHveq6BS8Wi1tynoYuhXYRfb42fQZ5cQ
        rJXKqtvZkm6OOC8lQ0b/W9AAs8ztvTOzJKc+qJVkkzuh9o5hdkxqDM85Gj69YPyYmLejHOr4zai
        k58HhWzKApj030HQYj/UJLnn6
X-Received: by 2002:a1c:208c:: with SMTP id g134mr1200010wmg.96.1586206934803;
        Mon, 06 Apr 2020 14:02:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDt6lvfPSp2B/covZ6kV3i/MXc3uI7thoPElgsCaS1INy4tIkQxp8uhZBPXlikbk/3MR/NgQ==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr1199997wmg.96.1586206934601;
        Mon, 06 Apr 2020 14:02:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id d13sm751332wrg.21.2020.04.06.14.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:14 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 10/12] vop: switch to virtio_legacy_init/size
Message-ID: <20200406210108.148131-11-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/misc/mic/vop/vop_main.c   | 5 +++--
 drivers/misc/mic/vop/vop_vringh.c | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 85942f6717c5..829b3b14b1d7 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -283,7 +283,7 @@ static struct virtqueue *vop_new_virtqueue(unsigned int index,
 	bool weak_barriers = false;
 	struct vring vring;
 
-	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
+	vring_legacy_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
 	vring.used = used;
 
 	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
@@ -320,7 +320,8 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
 	/* First assign the vring's allocated in host memory */
 	vqconfig = _vop_vq_config(vdev->desc) + index;
 	memcpy_fromio(&config, vqconfig, sizeof(config));
-	_vr_size = vring_size(le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN);
+	_vr_size = vring_legacy_size(le16_to_cpu(config.num),
+				     MIC_VIRTIO_RING_ALIGN);
 	vr_size = PAGE_ALIGN(_vr_size + sizeof(struct _mic_vring_info));
 	va = vpdev->hw_ops->remap(vpdev, le64_to_cpu(config.address), vr_size);
 	if (!va)
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 30eac172f017..0535c02d637d 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -296,7 +296,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 
 		num = le16_to_cpu(vqconfig[i].num);
 		mutex_init(&vvr->vr_mutex);
-		vr_size = PAGE_ALIGN(vring_size(num, MIC_VIRTIO_RING_ALIGN) +
+		vr_size = PAGE_ALIGN(vring_legacy_size(num,
+						       MIC_VIRTIO_RING_ALIGN) +
 			sizeof(struct _mic_vring_info));
 		vr->va = (void *)
 			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
@@ -308,7 +309,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 			goto err;
 		}
 		vr->len = vr_size;
-		vr->info = vr->va + vring_size(num, MIC_VIRTIO_RING_ALIGN);
+		vr->info = vr->va + vring_legacy_size(num,
+						      MIC_VIRTIO_RING_ALIGN);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
 		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
 					 DMA_BIDIRECTIONAL);
@@ -321,7 +323,7 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		}
 		vqconfig[i].address = cpu_to_le64(vr_addr);
 
-		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
+		vring_legacy_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
 		ret = vringh_init_kern(&vvr->vrh,
 				       *(u32 *)mic_vq_features(vdev->dd),
 				       num, false, vr->vr.desc, vr->vr.avail,
-- 
MST

