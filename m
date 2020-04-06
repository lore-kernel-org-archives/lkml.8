Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED01C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952D520768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDIawn9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDFVfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbgDFVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=CDIawn9T/QdRblC8h14xykuDTPnHMRn2WQULd2QcWEsaE1CPpWj6AvjeaWCxQloyO8BpbQ
        BF2+KQyhtcP+oiCgPYlVjW6JopCfvj67vB5taEBdF35A2c7x0dTvae9NztmLnc30QOZ0Lc
        p4S7yIn2kNqvwoivRvBjJ/ryvkxQLZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-aFqlcnA1M3KvHpGwAq0udQ-1; Mon, 06 Apr 2020 17:35:12 -0400
X-MC-Unique: aFqlcnA1M3KvHpGwAq0udQ-1
Received: by mail-wr1-f72.google.com with SMTP id j12so565133wrr.18
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ULp/a+ohh8j4o+miqnJW1p9vX21ZhvTitDNwFW0Sn2M=;
        b=EUrEIhHA1FoJwyOLY4pjeLHHKotz7ivL+6v1WRcZEm4nhA2RT2iI/FfXYZc4xVd7La
         8L8sPWLfJURoSCMtgGMFiOn7AHI2sVVLkD9+3HjqQgQRBlVMZlBsxcIANEwfHvan4lpa
         00IIUfpZuFXP8xrbNJPjNLa7p4zASKvFdXKCfwAMSqh3ra9Qm6ZewM+Be96Eeu1ncLK0
         BfUPHd3y8voVcQnqgy0ZL+4XlJLQEcjkOMZaTYgzXOYpIIoghaDmHmk+X/Q0G/Uie7W5
         ktH78CCGBZh1Zjs23h6QYeWcgvqw9MlzXTanm39JZdokUiMf0OnZUemfsQ3qRtYy1tRp
         DGKw==
X-Gm-Message-State: AGi0PubtGrrlHOi8cSSwGe9bKHaxnOMvhDAuzMskkM1r0lt2rHl+4UgO
        NkIV/x7TAlW0/RBl1zJgKBcD+/ZtKheYlVuP1sc7CG9JCiuuGxz+yag5H0vy6rbk0HLW7VUxm7s
        Jh3YHYaJ8CTxm9mgPP+IlK97n
X-Received: by 2002:adf:ce07:: with SMTP id p7mr1246801wrn.261.1586208911500;
        Mon, 06 Apr 2020 14:35:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbkdgDZgNMY0iAAa/Eyi8WiLVhpONpbKtk9vD8/d2+UPKCWImbmOi+Byoh1R/61B6Ivp7n1w==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr1246786wrn.261.1586208911331;
        Mon, 06 Apr 2020 14:35:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id v186sm1072155wme.24.2020.04.06.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:10 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v5 08/12] virtio_ring: switch to virtio_legacy_init/size
Message-ID: <20200406213314.248038-9-mst@redhat.com>
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

