Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8A1206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIQdkNq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgDFVfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39547 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726860AbgDFVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nyoiGemXvXpEt4ED7nhnG2yhASqK8hx21hXdXEJe9tU=;
        b=BIQdkNq/m46RSkJpZ+jt22ToJ8ZIC36vaCc5m37RjAQrjWrNjkxIi6sAM/1su8pJoqlW8h
        sTkOeLO7SRASxceMDXwCuyQBRquRLVY68X4bOfDJrFxUwWvnGuVmcDTjk3JvGsPt716Aak
        Y0GQdtpF3+viVE10MQsXibEnFElAesU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-XvWcyVBzOZG0xObg28Lclg-1; Mon, 06 Apr 2020 17:35:16 -0400
X-MC-Unique: XvWcyVBzOZG0xObg28Lclg-1
Received: by mail-wm1-f71.google.com with SMTP id y1so79302wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nyoiGemXvXpEt4ED7nhnG2yhASqK8hx21hXdXEJe9tU=;
        b=lg/qHP173U/iM7UZpAfTC8R7CEell5m6aC0mGemyOM5gh3R6aTFlwkKT772iGqJXKc
         HP9p71XA23OdaGNsBnzD6hJCtpxiKR9pRNep1VGx5ov+wsndn2grrueYw/3BYU0bqhkb
         OstZjeILJGPmrBqr0L/hrqef+s4v5GTvc8AInZEiS3/zVNdi4jC66o8Nb2BmiLyIqnJ+
         4lIRoTGCBFJ+UwlA153h36NKfAlNParT116YJEEw+aL8Zxqyq8IBEintvbBzpbmyiBWO
         Kze0DswRYdcXsYww2wgboAHyTtLugW6A5Ja99wRDn04CGe1A6oEu16qqmEPViQGKBxb+
         OefA==
X-Gm-Message-State: AGi0PubrgxD1Mzi4qxvuvogp30jcrzEBRupufJvxgHeU1jTCYQKgrlUu
        HN1c4qnqWmSxg8FPScomgijTe+JRKz7XUeC4PUX5QwFz/Q3gKnM3hexq/NBiKHRNBuGTTptoHPF
        TBsZTrWgt0eW51MLxZbqq1kVw
X-Received: by 2002:a1c:7415:: with SMTP id p21mr1024833wmc.93.1586208915664;
        Mon, 06 Apr 2020 14:35:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4GuRrYUwJciJb7p5n4u82sqER064jqytOfazTBkvkOPnUWpHqTGZuhx/QeD+k2BSUgy/iiQ==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr1024820wmc.93.1586208915483;
        Mon, 06 Apr 2020 14:35:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id q187sm980306wma.41.2020.04.06.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 10/12] vop: switch to virtio_legacy_init/size
Message-ID: <20200406213314.248038-11-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
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

maintainers, pls ack merging this through virtio tree due to dependency
on previous patches in the patchset.

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

