Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1DC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B141206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+L0KOVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDFVeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDFVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=a+L0KOVSfqZJgoePiwLiea2vHrslAV83aYWABG/+he+pWFbHOiRsERZptR5Xm1vNxtynHT
        /2ibXBv5uLcCmwgdMNttCOICqBR1TYGFGOEPu/QZnabxwTkCQ6pimUxmpsCZhDoi+qNjh7
        T17lsC+lP1CXPMtX7Yl966uHeH9ofy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-no4UXRfPOzCSn_4odLZOOg-1; Mon, 06 Apr 2020 17:34:42 -0400
X-MC-Unique: no4UXRfPOzCSn_4odLZOOg-1
Received: by mail-wr1-f72.google.com with SMTP id o10so577275wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=FtamRpyKNqlhQzaCjfdvsBogI490VM4FgUuZ9OqqwUYsTbW+STAC9z6LDC54uW3e0l
         QvTllqfy4FtS80qLntaTjD5CVCJZZKnYT3liqj+OBvqkmaAtLaGDndGZ3oCiCI3eIHU9
         ItugTrXqdj4n+lBOqM+h8hUpDRjzhTOpunfLfWs+uWekqwR5S6oZdRMovHlvhVUIMjMG
         O/LLOcKGfEbpJcta9GMlxehu7TpsZI7f5K+sjq2lPkrfnNfE5l7g/iuYlINPlZ3t4J70
         l6LfNBJ7XeB4zhnUAAaVpOqPOhOaRWHtJfHI5Y2Y6LeL+jUfPRTXpuhR5raGYfY2LuWh
         3tCQ==
X-Gm-Message-State: AGi0PubRecD4ektCixs0cs5ULfS3+0UjG82KxEr9pkUaOoYSCaneWYhn
        nqXWXcyRU/T+4kk+znJbPVhLaPJnXw71460y40jRtuhvVnRxR+/JVSp3rmlWe3j6HoywQORzh7f
        LzCJKaJ1VqLz0l/bMpIgwXHlN
X-Received: by 2002:adf:82c5:: with SMTP id 63mr1278579wrc.312.1586208881558;
        Mon, 06 Apr 2020 14:34:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvQJhmwP93/iT6ip06xiPQv/iv6F3OoIKQOfqi1rQxvSh+ASmH0VZ0wEEhAJBcaQLMzXMjvw==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr1278564wrc.312.1586208881342;
        Mon, 06 Apr 2020 14:34:41 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id f16sm992424wmc.37.2020.04.06.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:40 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 07/12] virtio: add legacy init/size APIs
Message-ID: <20200406210108.148131-8-mst@redhat.com>
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
Message-ID: <20200406213439.UrPuD1ZpLtJnO72Sfp5yDZ2C51ttLIU9lh_irKIr3HE@z>

vring_init/vring_size (in the uapi directory) are kept
around to solely avoid breaking old userspace builds.
It's not actually part of the UAPI - it was kept in the UAPI
header by mistake, and using it in kernel isn't necessary
and prevents us from making changes safely.
In particular, the APIs actually assume the legacy layout.

Add an internal kernel-only vring_legacy_init/vring_legacy_size.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c3f9ca054250..766d70bca492 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -140,4 +140,22 @@ void vring_del_virtqueue(struct virtqueue *vq);
 void vring_transport_features(struct virtio_device *vdev);
 
 irqreturn_t vring_interrupt(int irq, void *_vq);
+
+static inline void vring_legacy_init(struct vring *vr, unsigned int num, void *p,
+				     unsigned long align)
+{
+	vr->num = num;
+	vr->desc = p;
+	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
+	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
+		+ align-1) & ~(align - 1));
+}
+
+static inline unsigned vring_legacy_size(unsigned int num, unsigned long align)
+{
+	return ((sizeof(struct vring_desc) * num + sizeof(__virtio16) * (3 + num)
+		 + align - 1) & ~(align - 1))
+		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
+}
+
 #endif /* _LINUX_VIRTIO_RING_H */
-- 
MST

