Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CCAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E7120768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBqXwVNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDGBRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:17:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbgDGBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=YBqXwVNpzIiXlqBClVtfpU3So9bbSNmipojUi6feM8lUqG7wj40sKcj0ei2EAWmF/FRzLe
        +fCzrg+phc4krhppSNnyCDgGKLDAlYZ8uAR1tGH/csKU5PJJdXHmcCIug4cpt0E6OUsZtN
        IR0EaH/e4ZQXwYVKkhpH/uHHplbmusI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-26bLilYYMbyUD0T_fcCzew-1; Mon, 06 Apr 2020 21:16:54 -0400
X-MC-Unique: 26bLilYYMbyUD0T_fcCzew-1
Received: by mail-wr1-f72.google.com with SMTP id m15so880334wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=MuHOFWITNA7en3Fbs1nRucG5ORJ/Y4SqPbPSbxbr0v6UMcxHZT5sAIO6Tl9MY4yHmz
         GnwmEcy9/ZPeSIUaeEcbUI1Yb+J8+cKSPGSXT0p7D14zwU3K5eujDLKhYQFBVhYrHuVL
         /YfA71kS707xiOiuuSd4T6oJwyTgI5oKP75jww4xo/uU4EIiOB7UjwWDpLIELQRAIcWk
         jdY3+XyUsVuI9Nq200lR3nVYGHi/oawgR1+C06XuNSvy3onALTXlvk9+HR8K+e3ITIWq
         mXYQAWV/SKibSj/BCaEkx+bNjm8kW6FFrdXNU1CnySkDHN9fGRRaMN2pN/KMYs+R5Dmw
         /XUw==
X-Gm-Message-State: AGi0PuZnNBGdY/79Vjy+3sUbZlKOYqXPimr/SynfpmEWASEDDkZc/znw
        jjKlNKxXbBXCx5qlLKLKaZcvxplTA0UElZx3zGXOpnuKOy01EpH83nYnwWsYCVcP92fz/lUoQTE
        LB26aHaOvrR7LSDkgoIdr5atd
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr1771504wmc.170.1586222212483;
        Mon, 06 Apr 2020 18:16:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJzL/iLdswTbwfPuIEyAyp8RSCkFfA1Rco4f+oCEKC/uj6ezWN8xhsuv1T7W6chCyrFxBY3wg==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr1771496wmc.170.1586222212258;
        Mon, 06 Apr 2020 18:16:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id i5sm28052282wrr.12.2020.04.06.18.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 11/19] virtio: add legacy init/size APIs
Message-ID: <20200407011612.478226-12-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
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

