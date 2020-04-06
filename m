Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0320787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOwGKxqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDFVCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34644 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbgDFVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8xaBUZcNVWW1ObGlu3v9yKYMY7OCX5Z43TKgR5akQo=;
        b=JOwGKxqmmoWyqbNcGPnSVGiol5cN5aB63BIeLBW8DwxdbFfXDxv1ikDSKlOnxa2w+overB
        0AR4JMrf2/sQabzwpVeGu0hQ4uEZr/80zahD0vjWVDjyRA6Kp7dkVsSvm0TD0+iPUdyG8U
        DKeWRXIoZpimmakqY/tUluxz+Fbl834=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-AmnmBkYMMoiZUTARhWnkcg-1; Mon, 06 Apr 2020 17:02:05 -0400
X-MC-Unique: AmnmBkYMMoiZUTARhWnkcg-1
Received: by mail-wr1-f72.google.com with SMTP id g6so528506wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8xaBUZcNVWW1ObGlu3v9yKYMY7OCX5Z43TKgR5akQo=;
        b=gw9bDJ4C5Hxy5NEfAaT6PkNIRL3C4WSNjeAszfVXh7EUpemad78Rz+X3vnx63odgYJ
         H2ZcaZqZENHqURgiMc6Zy+lBH/cDHPXRbvMLEGptGrjB8GQLO25aIC4s9HlJKSZHba5N
         7TAkY1OqVwflZO0BUNpgicEZKMoaXP+KkeAcLTQqECbO1NFauy8ip2fW6djLPou/V6hw
         0+JVZPLLj6cML8PpEFAwfFXdHswj7dp/Tr6gW6PxPUmzgjfq+AExYIQkklV/YtgkU8LZ
         j2xTgqiQCj0yj30zDCdC3UC2L4n07ib0nj32mlGjDhFX1z5xpdKFEX33yQiQB8ILJBkR
         wxQA==
X-Gm-Message-State: AGi0PuYQQsk+IfIxNkmIWKW2uHAu4m3bSn65wNJrmACl5Ggw5v2xOETT
        tcT8+lN86QPibCSdZ+EEOgUlLQ5wGd7hLUbU4SovvL1gXZJjoPAFMjF7uMUUJJZBeWQ7EW7an6w
        k/wTyuazGcwRcqYzzYas9Sptb
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr1328394wml.189.1586206923909;
        Mon, 06 Apr 2020 14:02:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLsVSfZRz+UvRmoZ1UzwjGyUzpgtewvck4mS2IT+AvQSbVhloxcLRFVWZLlFerlNSa1G3ycBg==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr1328371wml.189.1586206923655;
        Mon, 06 Apr 2020 14:02:03 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id c12sm25048604wrw.90.2020.04.06.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:03 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 05/12] virtio: stop using legacy struct vring in kernel
Message-ID: <20200406210108.148131-6-mst@redhat.com>
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
 include/linux/virtio_ring.h      | 10 ++++++++++
 include/linux/vringh.h           |  1 +
 include/uapi/linux/virtio_ring.h | 26 ++++++++++++++++----------
 3 files changed, 27 insertions(+), 10 deletions(-)

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

