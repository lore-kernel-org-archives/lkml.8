Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E734C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63F420719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8QApNe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDGBIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:08:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48020 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbgDGBID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M9T/d7F7GNQ12ZgHWGcHvn2ujMc8mdiW+Qm6YeUJhk=;
        b=L8QApNe00Qw6xB1SNpZm2M7bfkf3dbk+ySBM+1cXkM9U220NeS8P+DFlp1vwYH5OQUH4dS
        ry2gcRZzMva3RGD60lV5jzidi3ddgoOQ49njKKVtzqQtVlTQ8fR9IITcGqJC5yO/IZ9/Jj
        31cJ2WSCKGgRQr+dNQFmL+KHCmdFSmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-cwBctd2yOQuB0gx-suKHKg-1; Mon, 06 Apr 2020 21:08:00 -0400
X-MC-Unique: cwBctd2yOQuB0gx-suKHKg-1
Received: by mail-wm1-f70.google.com with SMTP id l13so7290wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/M9T/d7F7GNQ12ZgHWGcHvn2ujMc8mdiW+Qm6YeUJhk=;
        b=MCBdrg7hSWugtHQ9qntpLc6JyWxAMKa2Py25Hfixtjmtkhm7b77G3ZqDXZ0QoFec+n
         5myBrEvSTsZiUJCf4Mv6qgnWINobaR5WBVTrdrj1KXWP/VFZ9tABmsWEKRrlSW2pGH8+
         7ZuZq3TuiQPXxWy+LL2XLHjss6QwIch8uBk3eE6ZN9S9/J/chnzQUmJSLo2qH+OIFuhG
         L93Ts0uLHIqMhat1s5Tuzb+gRBaibKKRgVID3MMgpMFw3RsHB9surelf9OQuVLoxSooC
         zBjQa6bVian6s3Pn+h9Z5RTVma38AKIUUK9EFF/QJeTZDwtllXlAkroLmN4qpQ5bEo0O
         YZag==
X-Gm-Message-State: AGi0PubNacFdwxBbsgAKQXonPsib9zG0bKmLEujm0ZP0dMx5Dm0V48om
        VAM0iQr5q0rPDDL6VtQLRPPsi7OQMv0bc+MMiLWV7GuD8ZN7TsPorI0UANuo83REPDaDF6awuFU
        Ka7HGKmvHb77Z7a4MElmkqsW1
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr1859595wme.56.1586221678151;
        Mon, 06 Apr 2020 18:07:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcPTB/8YZslvf852PatGi7YE39/8BDpyMgxRBk/2sE3K+Zn2tD6JMpJeCeEPQb89wAPdRBzg==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr1859584wme.56.1586221677915;
        Mon, 06 Apr 2020 18:07:57 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id y189sm90107wmb.26.2020.04.06.18.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:57 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v7 14/19] vop: switch to virtio_legacy_init/size
Message-ID: <20200407010700.446571-15-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
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

