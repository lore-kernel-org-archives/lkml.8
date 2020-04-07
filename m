Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09370C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC22B20801
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky1BQGs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDGBQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgDGBQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=Ky1BQGs41UTd5SwOZ1YP5u356yOqPMlnnuE7x43IfIZ6gwvU6VEC062AOpg25D5YqwnUG0
        H+JK3U0Tn29SZ7FWB6WQ2/pjARjwa1nXPn5gygtPyE+gSuIF5xtzVXaOkJKlOJ39m+Xj8L
        2ImDS9Y3ECwi0+BwQM7ZYytCNJPQMts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-ZKhvwFX4Mti7Q7qovLnVKw-1; Mon, 06 Apr 2020 21:16:55 -0400
X-MC-Unique: ZKhvwFX4Mti7Q7qovLnVKw-1
Received: by mail-wm1-f69.google.com with SMTP id f8so16330wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=hNTRHCTLu4j2XF62eKbp9G3RqREwX3VtOmUVEhRt4SohlBOMdRprZNQ2gN/yxlmvva
         zYTmG5N7kXpgwNxcqhFoTAry8wRYb1fhURX7xOuAOVBWPao0pADsObf0H4vyv0zFyYdy
         NHiWBFJ7DgsS37WzlnPkzEoLVqARyOU4ojq5qFpakettsiPYnWa0PHqGVeYKLZPyGort
         KkBoAy/iTsbyhcUiy8zq23ORyHZSfTEU09WUyRM17gJP/iWYYN9one7QuDVqClc7Tty+
         sbgbS0yhPYepKg2fJc+kDI5y6nqPPUKonsgHpO57NpYuBYtQ/wYzCbZJaUed6nBAN8ah
         y6pQ==
X-Gm-Message-State: AGi0PuaxXouiqE1bq8zdMRSADDcMd2/aJWfxKHmIsZhhjW33JrpgYfvt
        X3EhIAdIKU74Ppqd+MCAHNsw6dvZXU6UzPgC0MVjSxHVfO+WJJ6PTDNFz87u2ph2v0zMkrV8cvh
        XRZfkX1v62SZV3QrkXsVCDWXT
X-Received: by 2002:a7b:c631:: with SMTP id p17mr1726585wmk.11.1586222214537;
        Mon, 06 Apr 2020 18:16:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjIhFyH07bUYywqhGNaJX5Wtx+enu7S0NAc2uNHsSy+3qxl0vkfgSGoPEyUjwqcIMOmjfStQ==
X-Received: by 2002:a7b:c631:: with SMTP id p17mr1726567wmk.11.1586222214298;
        Mon, 06 Apr 2020 18:16:54 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id q187sm89265wma.41.2020.04.06.18.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 12/19] virtio_ring: switch to virtio_legacy_init/size
Message-ID: <20200407011612.478226-13-mst@redhat.com>
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

These are used for legacy ring format, switch to APIs
that make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..2a2b12449bac 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -867,8 +867,10 @@ static struct virtqueue *vring_create_virtqueue_split(
 	}
 
 	/* TODO: allocate each queue chunk individually */
-	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+	for (; num && vring_legacy_size(num, vring_align) > PAGE_SIZE;
+	     num /= 2) {
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
@@ -882,14 +884,15 @@ static struct virtqueue *vring_create_virtqueue_split(
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+		queue = vring_alloc_queue(vdev,
+					  vring_legacy_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
 		return NULL;
 
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	queue_size_in_bytes = vring_legacy_size(num, vring_align);
+	vring_legacy_init(&vring, num, queue, vring_align);
 
 	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				   notify, callback, name);
@@ -2169,7 +2172,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
 
-	vring_init(&vring, num, pages, vring_align);
+	vring_legacy_init(&vring, num, pages, vring_align);
 	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
 				     notify, callback, name);
 }
-- 
MST

