Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B53C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910920719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP5DBAUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDGBH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgDGBHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=cP5DBAUfDxJsQEhZLnsCuqEkLoF87FCJMsTj9ZnNe69SAmXv1+GFY03QecXxnrCJj0nEHu
        kdxbnI8gRAsQNJ7O7jD8jPsqWJBRLuLm0M5zBbaWlfAlfRq8TfDxjDljT7qddHY+FrkxZ4
        L/Y342d8GJECdkRvBIjVhxX2r85FisU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_DvJqagdN1ikvosNB2z84Q-1; Mon, 06 Apr 2020 21:07:53 -0400
X-MC-Unique: _DvJqagdN1ikvosNB2z84Q-1
Received: by mail-wm1-f71.google.com with SMTP id v8so6742wml.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=HKgN9vm+MVKehRRRUbMX2HUzOY0nOeUukuaCnFGTxF5DVphOlNrX0UDFML0WWRDEO+
         ewi4rUgwDWzVMAEP+LisNrTEJyCPTDKs90ehrcv0+gmDAlRogvOat3qRo80C3xTclwZ3
         s29v2qN1KX0gH6NmkKqg+HdXvGH9mG08xnUFazkqc47Lgbl7CVWC2wQ4RqWry3qER1WZ
         cWKTADRgQHg0xD047/asYR2hwArJJBVZkCs8+Uhy/d8zuE+UP9Poz/xCh96di9uZHX1D
         XwBZNBlh8Lkj/4gGbfU9IwIp1eZcna2DAauxY18xz4fnJ5M3C7W7i0UkaUdpKPBlk214
         CXtg==
X-Gm-Message-State: AGi0PuaCuB7so/AZrzfOQBojZ3Dp0v6joLmjCXP8FAqPlInoiIj33WK/
        JjYsZY8NHIrG11I8r+AVoPlwQjPXvCZywhMjHmo9ZWaKadkRwFyOpEGAtSFFhU67YfDggd+3bGt
        4Sbb15X0173u466CYGvqKq3Zo
X-Received: by 2002:a1c:4409:: with SMTP id r9mr2094024wma.165.1586221671781;
        Mon, 06 Apr 2020 18:07:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypKN9CYrbHE2jjD2afGiujtBXVlhpdUl35y5TmBdV4Epk5CAHj0sa2E4dFkJIJ5/QNzH6ShPow==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr2094010wma.165.1586221671557;
        Mon, 06 Apr 2020 18:07:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id a145sm97034wmd.20.2020.04.06.18.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 11/19] virtio: add legacy init/size APIs
Message-ID: <20200407010700.446571-12-mst@redhat.com>
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

