Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C2CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FAC206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv1J9e+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDFW1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:27:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbgDFW0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586212007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=Dv1J9e+czWIsgabkMJoaCTnDN7NM5h7+16DURfL9bFd/s4JRYhTDW3/7jHkX/hdcjGNIZc
        I1xksEFoaCFRkAWgWNRkUA/Ki0dlfuGjg7vLQxCSr4crLAhlzE9KYm1ydBJaMIM3jFoN5L
        YN6iUgeyxJDD4Yk9xbgDmhU3SfpFEZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-BNdqZsG0NmqhMBxQXv1xZQ-1; Mon, 06 Apr 2020 18:26:45 -0400
X-MC-Unique: BNdqZsG0NmqhMBxQXv1xZQ-1
Received: by mail-wr1-f69.google.com with SMTP id y6so631717wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxsCmO2anPyq8x1F5Rc9demQ45Mib3q8zcUy7zKxbTE=;
        b=X9GWIqwkCxr41Ya5e0cPj0gTKwRhppaXGvs5GHzGx0LHPFDEEWCprooCJuuNeGt/Lx
         HERYGwiT80n1jKkZhGuytY2XzvTkPp9oNrGQ3YBcSjbQSnSgEXN29oK6eC3tjmOg0YR6
         arYJ/LLf/DcW+UL41iqrkTglb7CsrLCxMp8Hf6vlhieJa2wJApKn6YBKN7JxXUiFoKk7
         HZB1vM6925hLBebe8Y7TxYBR8iPUmSqRsO3tLAr+SIaV+K/Xml5gWcyCaVhm/Pa2HOtD
         yj34khaVayaApxMBtUXkR9xV8z2n4HTeTLkiRMyDgSjVDgPUkDVX9ULRK1s1uiuyzfsT
         SJ3Q==
X-Gm-Message-State: AGi0PubZrDNPqCxIPvW5XnZaxOk4Bu25lkpHhpNoS0VCCvYVBrVOGs7f
        1iz4fJ3EjoZc//ZMP2L6MHhMplY1rYIPBOSd3oF3snxJHnWonrs9FMOw+Sofne9i949BMEtQhfX
        EjvecUvqEujJs1pm0BC5uL8fC
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr1232803wmj.22.1586212004354;
        Mon, 06 Apr 2020 15:26:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQ/45f7zuFQT9DjcuwOy3vnB/1khCwWFcukcPvRmpb8ILrNbQyCkNjC9BaPVmYB4AatJDrmw==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr1232793wmj.22.1586212004174;
        Mon, 06 Apr 2020 15:26:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id d6sm28346200wrw.10.2020.04.06.15.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 07/12] virtio: add legacy init/size APIs
Message-ID: <20200406222507.281867-8-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
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

