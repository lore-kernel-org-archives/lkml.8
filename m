Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF2C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E4620CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BidS1jBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDGBHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgDGBHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9Mom4OhtTxtDHxzUnnXxvRU3zaONixqwgs5hBxczCA=;
        b=BidS1jBIpd+5Cg0iQZqflYOERPVIFORW1fQk1ajjsQG2CQgHUdPM/lXtkxzKDmYyaZIijS
        /+cQ+aluZ29i8a5r5QuJ8ddcWvYcryKbenW5QZU9fdiM5Fhxr5TFwaIHtEsPeKle6hb3ww
        sbHlsMpQB25Vl0pFvGfRC+6M6EnpZbo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-oFtJHYQQMSCjRAyfmG3PUQ-1; Mon, 06 Apr 2020 21:07:49 -0400
X-MC-Unique: oFtJHYQQMSCjRAyfmG3PUQ-1
Received: by mail-wr1-f69.google.com with SMTP id 91so864850wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9Mom4OhtTxtDHxzUnnXxvRU3zaONixqwgs5hBxczCA=;
        b=e2njS7yM+oKsS3jGm0LVNHrRgDZZsJp/I/aNwJtL2C+6PkvvHb9L7RxO0T2U7hAe+o
         2tv7q5sVAjjt92Of6cSDtUYEdiyHtHQUQRoE96ua2EEFNxWzRvPmcVYVxDa6tzaHxUM3
         VTE8GWU/QAexdCGEo1GzsNgezRAcGOwK5WL+XsrbzuKxX6+0pm2O6RhdB/JiO4U0eIxN
         0BGQBezF3Ae6M3gpU5PCPk3PjewjPZMyEcUgTbFXC1uLtKUNL2rHVxaJsNQmZ24hbIWl
         P/hxEruvdBodoAJtCmYBiuFHf21OfDRaRA4rMoXNrTc9RLQQIxH2jJqGtX5qY05vZUmT
         M3PQ==
X-Gm-Message-State: AGi0PuZIp8BP5e/TiIS2eB/+wJhdcJjFQtEvtyMy6NIQkFsOFtjbLruL
        7zczimnf86twvVrJgsPBWhuKpSjafnjzfD96SUOm2mXT38znVkmb0I4ZcMC4c1jBBDHbh/5Wn0c
        awqAauPAII4sCiPO05BPk7/lB
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr2011211wmf.5.1586221667501;
        Mon, 06 Apr 2020 18:07:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2kbXjpwa81pslGC91wSJV93qqpn7rHzCxCLN6d5M/mFdqTlYs1aMMNlbk/4ocXf6OPo/tow==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr2011192wmf.5.1586221667224;
        Mon, 06 Apr 2020 18:07:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id l185sm66782wml.44.2020.04.06.18.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:46 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v7 09/19] virtio: stop using legacy struct vring in kernel
Message-ID: <20200407010700.446571-10-mst@redhat.com>
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

struct vring (in the uapi directory) and supporting APIs are kept
around to solely avoid breaking old userspace builds.
It's not actually part of the UAPI - it was kept in the UAPI
header by mistake, and using it in kernel isn't necessary
and prevents us from making changes safely.
In particular, the APIs actually assume the legacy layout.

Add an internal kernel-only struct vring and
switch everyone to use that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c       |  1 +
 include/linux/virtio.h           |  1 -
 include/linux/virtio_ring.h      | 10 ++++++++++
 include/linux/vringh.h           |  1 +
 include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0736248999b0..dd5732dc4b07 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -15,6 +15,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
+#include <uapi/linux/virtio_ring.h>
 
 #define PART_BITS 4
 #define VQ_NAME_LEN 16
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 15f906e4a748..a493eac08393 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,7 +9,6 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
-#include <linux/vringh.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 3dc70adfe5f5..11680e74761a 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -60,6 +60,16 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 9e2763d7c159..d71b3710f58e 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -11,6 +11,7 @@
 #ifndef _LINUX_VRINGH_H
 #define _LINUX_VRINGH_H
 #include <uapi/linux/virtio_ring.h>
+#include <linux/virtio_ring.h>
 #include <linux/virtio_byteorder.h>
 #include <linux/uio.h>
 #include <linux/slab.h>
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 9223c3a5c46a..8961a4adda5c 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -118,16 +118,6 @@ struct vring_used {
 	struct vring_used_elem ring[];
 };
 
-struct vring {
-	unsigned int num;
-
-	struct vring_desc *desc;
-
-	struct vring_avail *avail;
-
-	struct vring_used *used;
-};
-
 /* Alignment requirements for vring elements.
  * When using pre-virtio 1.0 layout, these fall out naturally.
  */
@@ -166,6 +156,21 @@ struct vring {
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
 #define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
+#ifndef __KERNEL__
+/*
+ * The following definitions have been put in the UAPI header by mistake. We
+ * keep them around to avoid breaking old userspace builds.
+ */
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
 {
@@ -182,6 +187,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
+#endif
 
 #endif /* VIRTIO_RING_NO_LEGACY */
 
-- 
MST

